// Decompile MicroPython - a micropython .mpy file decompiler
// 'M',
// MPY_VERSION,
// MPY_FEATURE_ENCODE_FLAGS(MPY_FEATURE_FLAGS_DYNAMIC),

import { execSync } from "child_process";
import { exists, existsSync, mkdirSync, readFileSync, writeFileSync } from "fs";

const MP_BC_BASE_RESERVED = (0x00); // ----------------
const MP_BC_BASE_QSTR_O = (0x10); // LLLLLLSSSDDII---
const MP_BC_BASE_VINT_E = (0x20); // MMLLLLSSDDBBBBBB
const MP_BC_BASE_VINT_O = (0x30); // UUMMCCCC--------
const MP_BC_BASE_JUMP_E = (0x40); // J-JJJJJEEEEF----
const MP_BC_BASE_BYTE_O = (0x50); // LLLLSSDTTTTTEEFF
const MP_BC_BASE_BYTE_E = (0x60); // --BREEEYYI------
const MP_BC_LOAD_CONST_SMALL_INT_MULTI = (0x70); // LLLLLLLLLLLLLLLL
const MP_BC_LOAD_FAST_MULTI = (0xb0); // LLLLLLLLLLLLLLLL
const MP_BC_STORE_FAST_MULTI = (0xc0); // SSSSSSSSSSSSSSSS
const MP_BC_UNARY_OP_MULTI = (0xd0); // OOOOOOO
const MP_BC_BINARY_OP_MULTI = (0xd7); //        OOOOOOOOO
let importmap = {
  MP_BC_LOAD_CONST_FALSE: (MP_BC_BASE_BYTE_O + 0x00),
  MP_BC_LOAD_CONST_NONE: (MP_BC_BASE_BYTE_O + 0x01),
  MP_BC_LOAD_CONST_TRUE: (MP_BC_BASE_BYTE_O + 0x02),
  MP_BC_LOAD_CONST_SMALL_INT: (MP_BC_BASE_VINT_E + 0x02), // signed var-int
  MP_BC_LOAD_CONST_STRING: (MP_BC_BASE_QSTR_O + 0x00), // qstr
  MP_BC_LOAD_CONST_OBJ: (MP_BC_BASE_VINT_E + 0x03), // ptr
  MP_BC_LOAD_NULL: (MP_BC_BASE_BYTE_O + 0x03),
  MP_BC_LOAD_FAST_N: (MP_BC_BASE_VINT_E + 0x04), // uint
  MP_BC_LOAD_DEREF: (MP_BC_BASE_VINT_E + 0x05), // uint
  MP_BC_LOAD_NAME: (MP_BC_BASE_QSTR_O + 0x01), // qstr
  MP_BC_LOAD_GLOBAL: (MP_BC_BASE_QSTR_O + 0x02), // qstr
  MP_BC_LOAD_ATTR: (MP_BC_BASE_QSTR_O + 0x03), // qstr
  MP_BC_LOAD_METHOD: (MP_BC_BASE_QSTR_O + 0x04), // qstr
  MP_BC_LOAD_SUPER_METHOD: (MP_BC_BASE_QSTR_O + 0x05), // qstr
  MP_BC_LOAD_BUILD_CLASS: (MP_BC_BASE_BYTE_O + 0x04),
  MP_BC_LOAD_SUBSCR: (MP_BC_BASE_BYTE_O + 0x05),
  MP_BC_STORE_FAST_N: (MP_BC_BASE_VINT_E + 0x06), // uint
  MP_BC_STORE_DEREF: (MP_BC_BASE_VINT_E + 0x07), // uint
  MP_BC_STORE_NAME: (MP_BC_BASE_QSTR_O + 0x06), // qstr
  MP_BC_STORE_GLOBAL: (MP_BC_BASE_QSTR_O + 0x07), // qstr
  MP_BC_STORE_ATTR: (MP_BC_BASE_QSTR_O + 0x08), // qstr
  MP_BC_STORE_SUBSCR: (MP_BC_BASE_BYTE_O + 0x06),
  MP_BC_DELETE_FAST: (MP_BC_BASE_VINT_E + 0x08), // uint
  MP_BC_DELETE_DEREF: (MP_BC_BASE_VINT_E + 0x09), // uint
  MP_BC_DELETE_NAME: (MP_BC_BASE_QSTR_O + 0x09), // qstr
  MP_BC_DELETE_GLOBAL: (MP_BC_BASE_QSTR_O + 0x0a), // qstr
  MP_BC_DUP_TOP: (MP_BC_BASE_BYTE_O + 0x07),
  MP_BC_DUP_TOP_TWO: (MP_BC_BASE_BYTE_O + 0x08),
  MP_BC_POP_TOP: (MP_BC_BASE_BYTE_O + 0x09),
  MP_BC_ROT_TWO: (MP_BC_BASE_BYTE_O + 0x0a),
  MP_BC_ROT_THREE: (MP_BC_BASE_BYTE_O + 0x0b),
  MP_BC_JUMP: (MP_BC_BASE_JUMP_E + 0x02), // rel byte code offset, 16-bit signed, in excess
  MP_BC_POP_JUMP_IF_TRUE: (MP_BC_BASE_JUMP_E + 0x03), // rel byte code offset, 16-bit signed, in excess
  MP_BC_POP_JUMP_IF_FALSE: (MP_BC_BASE_JUMP_E + 0x04), // rel byte code offset, 16-bit signed, in excess
  MP_BC_JUMP_IF_TRUE_OR_POP: (MP_BC_BASE_JUMP_E + 0x05), // rel byte code offset, 16-bit signed, in excess
  MP_BC_JUMP_IF_FALSE_OR_POP: (MP_BC_BASE_JUMP_E + 0x06), // rel byte code offset, 16-bit signed, in excess
  MP_BC_UNWIND_JUMP: (MP_BC_BASE_JUMP_E + 0x00), // rel byte code offset, 16-bit signed, in excess; then a byte
  MP_BC_SETUP_WITH: (MP_BC_BASE_JUMP_E + 0x07), // rel byte code offset, 16-bit unsigned
  MP_BC_SETUP_EXCEPT: (MP_BC_BASE_JUMP_E + 0x08), // rel byte code offset, 16-bit unsigned
  MP_BC_SETUP_FINALLY: (MP_BC_BASE_JUMP_E + 0x09), // rel byte code offset, 16-bit unsigned
  MP_BC_POP_EXCEPT_JUMP: (MP_BC_BASE_JUMP_E + 0x0a), // rel byte code offset, 16-bit unsigned
  MP_BC_FOR_ITER: (MP_BC_BASE_JUMP_E + 0x0b), // rel byte code offset, 16-bit unsigned
  MP_BC_WITH_CLEANUP: (MP_BC_BASE_BYTE_O + 0x0c),
  MP_BC_END_FINALLY: (MP_BC_BASE_BYTE_O + 0x0d),
  MP_BC_GET_ITER: (MP_BC_BASE_BYTE_O + 0x0e),
  MP_BC_GET_ITER_STACK: (MP_BC_BASE_BYTE_O + 0x0f),
  MP_BC_BUILD_TUPLE: (MP_BC_BASE_VINT_E + 0x0a), // uint
  MP_BC_BUILD_LIST: (MP_BC_BASE_VINT_E + 0x0b), // uint
  MP_BC_BUILD_MAP: (MP_BC_BASE_VINT_E + 0x0c), // uint
  MP_BC_STORE_MAP: (MP_BC_BASE_BYTE_E + 0x02),
  MP_BC_BUILD_SET: (MP_BC_BASE_VINT_E + 0x0d), // uint
  MP_BC_BUILD_SLICE: (MP_BC_BASE_VINT_E + 0x0e), // uint
  MP_BC_STORE_COMP: (MP_BC_BASE_VINT_E + 0x0f), // uint
  MP_BC_UNPACK_SEQUENCE: (MP_BC_BASE_VINT_O + 0x00), // uint
  MP_BC_UNPACK_EX: (MP_BC_BASE_VINT_O + 0x01), // uint
  MP_BC_RETURN_VALUE: (MP_BC_BASE_BYTE_E + 0x03),
  MP_BC_RAISE_LAST: (MP_BC_BASE_BYTE_E + 0x04),
  MP_BC_RAISE_OBJ: (MP_BC_BASE_BYTE_E + 0x05),
  MP_BC_RAISE_FROM: (MP_BC_BASE_BYTE_E + 0x06),
  MP_BC_YIELD_VALUE: (MP_BC_BASE_BYTE_E + 0x07),
  MP_BC_YIELD_FROM: (MP_BC_BASE_BYTE_E + 0x08),
  MP_BC_MAKE_FUNCTION: (MP_BC_BASE_VINT_O + 0x02), // uint
  MP_BC_MAKE_FUNCTION_DEFARGS: (MP_BC_BASE_VINT_O + 0x03), // uint
  MP_BC_MAKE_CLOSURE: (MP_BC_BASE_VINT_E + 0x00), // uint; extra byte
  MP_BC_MAKE_CLOSURE_DEFARGS: (MP_BC_BASE_VINT_E + 0x01), // uint; extra byte
  MP_BC_CALL_FUNCTION: (MP_BC_BASE_VINT_O + 0x04), // uint
  MP_BC_CALL_FUNCTION_VAR_KW: (MP_BC_BASE_VINT_O + 0x05), // uint
  MP_BC_CALL_METHOD: (MP_BC_BASE_VINT_O + 0x06), // uint
  MP_BC_CALL_METHOD_VAR_KW: (MP_BC_BASE_VINT_O + 0x07), // uint
  MP_BC_IMPORT_NAME: (MP_BC_BASE_QSTR_O + 0x0b), // qstr
  MP_BC_IMPORT_FROM: (MP_BC_BASE_QSTR_O + 0x0c), // qstr
  MP_BC_IMPORT_STAR: (MP_BC_BASE_BYTE_E + 0x09),

  UNOP_POSITIVE: (0xd0),
  UNOP_NEGATIVE: (0xd1),
  UNOP_INVERT: (0xd2),
  UNOP_NOT: (0xd3),

  BINOP_LESS: 0xd7,
  BINOP_MORE: 0xd8,
  BINOP_EQUAL: 0xd9,
  BINOP_LESS_EQUAL: 0xda,
  BINOP_MORE_EQUAL: 0xdb,
  BINOP_NOT_EQUAL: 0xdc,
  BINOP_IN: 0xdd,
  BINOP_IS: 0xde,
  BINOP_EXCEPTION_MATCH: 0xdf,
  BINOP_INPLACE_OR: 0xe0,
  BINOP_INPLACE_XOR: 0xe1,
  BINOP_INPLACE_AND: 0xe2,
  BINOP_INPLACE_LSHIFT: 0xe3,
  BINOP_INPLACE_RSHIFT: 0xe4,
  BINOP_INPLACE_ADD: 0xe5,
  BINOP_INPLACE_SUBTRACT: 0xe6,
  BINOP_INPLACE_MULTIPLY: 0xe7,
  BINOP_INPLACE_MAT_MULTIPLY: 0xe8,
  BINOP_INPLACE_FLOOR_DIVIDE: 0xe9,
  BINOP_INPLACE_TRUE_DIVIDE: 0xea,
  BINOP_INPLACE_MODULO: 0xeb,
  BINOP_INPLACE_POWER: 0xec,
  BINOP_OR: 0xed,
  BINOP_XOR: 0xee,
  BINOP_AND: 0xef,
  BINOP_LSHIFT: 0xf0,
  BINOP_RSHIFT: 0xf1,
  BINOP_ADD: 0xf2,
  BINOP_SUBTRACT: 0xf3,
  BINOP_MULTIPLY: 0xf4,
  BINOP_MAT_MULTIPLY: 0xf5,
  BINOP_FLOOR_DIVIDE: 0xf6,
  BINOP_TRUE_DIVIDE: 0xf7,
  BINOP_MODULO: 0xf8,
  BINOP_POWER: 0xf9,
  BINOP_DIVMOD: 0xfa,
  BINOP_CONTAINS: 0xfb,
  BINOP_REVERSE_OR: 0xfc,
  BINOP_REVERSE_XOR: 0xfd,
  BINOP_REVERSE_AND: 0xfe,
  BINOP_REVERSE_LSHIFT: 0xff,
  BINOP_REVERSE_RSHIFT: 0x100,
  BINOP_REVERSE_ADD: 0x101,
  BINOP_REVERSE_SUBTRACT: 0x102,
  BINOP_REVERSE_MULTIPLY: 0x103,
  BINOP_REVERSE_MAT_MULTIPLY: 0x104,
  BINOP_REVERSE_FLOOR_DIVIDE: 0x105,
  BINOP_REVERSE_TRUE_DIVIDE: 0x106,
  BINOP_REVERSE_MODULO: 0x107,
  BINOP_REVERSE_POWER: 0x108,
};
let opsnm = {
  MP_BC_LOAD_CONST_FALSE: "false",
  MP_BC_LOAD_CONST_NONE: "none",
  MP_BC_LOAD_CONST_TRUE: "true",
  MP_BC_LOAD_CONST_SMALL_INT: "int",
  MP_BC_LOAD_CONST_STRING: "str",
  MP_BC_LOAD_CONST_OBJ: "constobj",
  MP_BC_LOAD_NULL: "null",
  MP_BC_LOAD_FAST_N: "MP_BC_LOAD_FAST_N",
  MP_BC_LOAD_DEREF: "deref",
  MP_BC_LOAD_NAME: "loadname",
  MP_BC_LOAD_GLOBAL: "glbl",
  MP_BC_LOAD_ATTR: "attr",
  MP_BC_LOAD_METHOD: "method",
  MP_BC_LOAD_SUPER_METHOD: "supermethod",
  MP_BC_LOAD_BUILD_CLASS: "buildclass",
  MP_BC_LOAD_SUBSCR: "MP_BC_LOAD_SUBSCR",
  MP_BC_STORE_FAST_N: "MP_BC_STORE_FAST_N",
  MP_BC_STORE_DEREF: "st.deref",
  MP_BC_STORE_NAME: "st.name",
  MP_BC_STORE_GLOBAL: "st.glbl",
  MP_BC_STORE_ATTR: "st.attr",
  MP_BC_STORE_SUBSCR: "MP_BC_STORE_SUBSCR",
  MP_BC_DELETE_FAST: "del.fast",
  MP_BC_DELETE_DEREF: "del.deref",
  MP_BC_DELETE_NAME: "del.name",
  MP_BC_DELETE_GLOBAL: "del.glbl",
  MP_BC_DUP_TOP: "dup",
  MP_BC_DUP_TOP_TWO: "dup2",
  MP_BC_POP_TOP: "pop",
  MP_BC_ROT_TWO: "rot",
  MP_BC_ROT_THREE: "rot3",
  MP_BC_JUMP: "jmp",
  MP_BC_POP_JUMP_IF_TRUE: "btrue",
  MP_BC_POP_JUMP_IF_FALSE: "bfalse",
  MP_BC_JUMP_IF_TRUE_OR_POP: "btrue.pop",
  MP_BC_JUMP_IF_FALSE_OR_POP: "bfalse.pop",
  MP_BC_UNWIND_JUMP: "jmp.unwind",
  MP_BC_SETUP_WITH: "with.setup",
  MP_BC_SETUP_EXCEPT: "except.setup",
  MP_BC_SETUP_FINALLY: "finally.setup",
  MP_BC_POP_EXCEPT_JUMP: "except.jump",
  MP_BC_FOR_ITER: "for.iter",
  MP_BC_WITH_CLEANUP: "with.chleanup",
  MP_BC_END_FINALLY: "finally.end",
  MP_BC_GET_ITER: "ld.iter",
  MP_BC_GET_ITER_STACK: "ld.iterstack",
  MP_BC_BUILD_TUPLE: "tuple",
  MP_BC_BUILD_LIST: "list",
  MP_BC_BUILD_MAP: "map",
  MP_BC_STORE_MAP: "st.map",
  MP_BC_BUILD_SET: "MP_BC_BUILD_SET",
  MP_BC_BUILD_SLICE: "slice",
  MP_BC_STORE_COMP: "MP_BC_STORE_COMP",
  MP_BC_UNPACK_SEQUENCE: "MP_BC_UNPACK_SEQUENCE",
  MP_BC_UNPACK_EX: "MP_BC_UNPACK_EX",
  MP_BC_RETURN_VALUE: "ret",
  MP_BC_RAISE_LAST: "rethrow",
  MP_BC_RAISE_OBJ: "raiseobj",
  MP_BC_RAISE_FROM: "throwfrom",
  MP_BC_YIELD_VALUE: "yield",
  MP_BC_YIELD_FROM: "yieldfrom",
  MP_BC_MAKE_FUNCTION: "mkfun",
  MP_BC_MAKE_FUNCTION_DEFARGS: "mkfun.defargs",
  MP_BC_MAKE_CLOSURE: "mkclosure",
  MP_BC_MAKE_CLOSURE_DEFARGS: "mkclosure.defargs",
  MP_BC_CALL_FUNCTION: "call",
  MP_BC_CALL_FUNCTION_VAR_KW: "call.kw",
  MP_BC_CALL_METHOD: "call.meth",
  MP_BC_CALL_METHOD_VAR_KW: "call.kvmeth",
  MP_BC_IMPORT_NAME: "import.nm",
  MP_BC_IMPORT_FROM: "import.from",
  MP_BC_IMPORT_STAR: "import.all",

  UNOP_POSITIVE: "assertint",
  UNOP_NEGATIVE: "neg",
  UNOP_INVERT: "invert",
  UNOP_NOT: "not",

  BINOP_LESS: "lt",
  BINOP_MORE: "qt",
  BINOP_EQUAL: "eq",
  BINOP_LESS_EQUAL: "le",
  BINOP_MORE_EQUAL: "qe",
  BINOP_NOT_EQUAL: "ne",
  BINOP_IN: "in",
  BINOP_IS: "is",
  BINOP_EXCEPTION_MATCH: "ematch",
  BINOP_INPLACE_OR: "or.in",
  BINOP_INPLACE_XOR: "xor.in",
  BINOP_INPLACE_AND: "and.in",
  BINOP_INPLACE_LSHIFT: "shl.in",
  BINOP_INPLACE_RSHIFT: "shr.in",
  BINOP_INPLACE_ADD: "add.in",
  BINOP_INPLACE_SUBTRACT: "sub.in",
  BINOP_INPLACE_MULTIPLY: "mul.in",
  BINOP_INPLACE_MAT_MULTIPLY: "matmul.in",
  BINOP_INPLACE_FLOOR_DIVIDE: "floordiv.in",
  BINOP_INPLACE_TRUE_DIVIDE: "div.in",
  BINOP_INPLACE_MODULO: "mod.in",
  BINOP_INPLACE_POWER: "pow.in",
  BINOP_OR: "or",
  BINOP_XOR: "xor",
  BINOP_AND: "and",
  BINOP_LSHIFT: "shl",
  BINOP_RSHIFT: "shr",
  BINOP_ADD: "add",
  BINOP_SUBTRACT: "sub",
  BINOP_MULTIPLY: "mul",
  BINOP_MAT_MULTIPLY: "matmul",
  BINOP_FLOOR_DIVIDE: "floordiv",
  BINOP_TRUE_DIVIDE: "truediv",
  BINOP_MODULO: "mod",
  BINOP_POWER: "pow",
  BINOP_DIVMOD: "divmod",
  BINOP_CONTAINS: "in",
  BINOP_REVERSE_OR: "or.rev",
  BINOP_REVERSE_XOR: "xor.rev",
  BINOP_REVERSE_AND: "and.rev",
  BINOP_REVERSE_LSHIFT: "shl.rev",
  BINOP_REVERSE_RSHIFT: "shr.rev",
  BINOP_REVERSE_ADD: "add.rev",
  BINOP_REVERSE_SUBTRACT: "sub.rev",
  BINOP_REVERSE_MULTIPLY: "mul.rev",
  BINOP_REVERSE_MAT_MULTIPLY: "matmul.rev",
  BINOP_REVERSE_FLOOR_DIVIDE: "floordiv.rev",
  BINOP_REVERSE_TRUE_DIVIDE: "truediv.rev",
  BINOP_REVERSE_MODULO: "mod.rev",
  BINOP_REVERSE_POWER: "pow.rev",
};
let optypes = {
  [importmap.MP_BC_LOAD_CONST_FALSE]: "MP_BC_LOAD_CONST_FALSE",
  [importmap.MP_BC_LOAD_CONST_NONE]: "MP_BC_LOAD_CONST_NONE",
  [importmap.MP_BC_LOAD_CONST_TRUE]: "MP_BC_LOAD_CONST_TRUE",
  [importmap.MP_BC_LOAD_CONST_SMALL_INT]: "MP_BC_LOAD_CONST_SMALL_INT",
  [importmap.MP_BC_LOAD_CONST_STRING]: "MP_BC_LOAD_CONST_STRING",
  [importmap.MP_BC_LOAD_CONST_OBJ]: "MP_BC_LOAD_CONST_OBJ",
  [importmap.MP_BC_LOAD_NULL]: "MP_BC_LOAD_NULL",
  [importmap.MP_BC_LOAD_FAST_N]: "MP_BC_LOAD_FAST_N",
  [importmap.MP_BC_LOAD_DEREF]: "MP_BC_LOAD_DEREF",
  [importmap.MP_BC_LOAD_NAME]: "MP_BC_LOAD_NAME",
  [importmap.MP_BC_LOAD_GLOBAL]: "MP_BC_LOAD_GLOBAL",
  [importmap.MP_BC_LOAD_ATTR]: "MP_BC_LOAD_ATTR",
  [importmap.MP_BC_LOAD_METHOD]: "MP_BC_LOAD_METHOD",
  [importmap.MP_BC_LOAD_SUPER_METHOD]: "MP_BC_LOAD_SUPER_METHOD",
  [importmap.MP_BC_LOAD_BUILD_CLASS]: "MP_BC_LOAD_BUILD_CLASS",
  [importmap.MP_BC_LOAD_SUBSCR]: "MP_BC_LOAD_SUBSCR",
  [importmap.MP_BC_STORE_FAST_N]: "MP_BC_STORE_FAST_N",
  [importmap.MP_BC_STORE_DEREF]: "MP_BC_STORE_DEREF",
  [importmap.MP_BC_STORE_NAME]: "MP_BC_STORE_NAME",
  [importmap.MP_BC_STORE_GLOBAL]: "MP_BC_STORE_GLOBAL",
  [importmap.MP_BC_STORE_ATTR]: "MP_BC_STORE_ATTR",
  [importmap.MP_BC_STORE_SUBSCR]: "MP_BC_STORE_SUBSCR",
  [importmap.MP_BC_DELETE_FAST]: "MP_BC_DELETE_FAST",
  [importmap.MP_BC_DELETE_DEREF]: "MP_BC_DELETE_DEREF",
  [importmap.MP_BC_DELETE_NAME]: "MP_BC_DELETE_NAME",
  [importmap.MP_BC_DELETE_GLOBAL]: "MP_BC_DELETE_GLOBAL",
  [importmap.MP_BC_DUP_TOP]: "MP_BC_DUP_TOP",
  [importmap.MP_BC_DUP_TOP_TWO]: "MP_BC_DUP_TOP_TWO",
  [importmap.MP_BC_POP_TOP]: "MP_BC_POP_TOP",
  [importmap.MP_BC_ROT_TWO]: "MP_BC_ROT_TWO",
  [importmap.MP_BC_ROT_THREE]: "MP_BC_ROT_THREE",
  [importmap.MP_BC_JUMP]: "MP_BC_JUMP",
  [importmap.MP_BC_POP_JUMP_IF_TRUE]: "MP_BC_POP_JUMP_IF_TRUE",
  [importmap.MP_BC_POP_JUMP_IF_FALSE]: "MP_BC_POP_JUMP_IF_FALSE",
  [importmap.MP_BC_JUMP_IF_TRUE_OR_POP]: "MP_BC_JUMP_IF_TRUE_OR_POP",
  [importmap.MP_BC_JUMP_IF_FALSE_OR_POP]: "MP_BC_JUMP_IF_FALSE_OR_POP",
  [importmap.MP_BC_UNWIND_JUMP]: "MP_BC_UNWIND_JUMP",
  [importmap.MP_BC_SETUP_WITH]: "MP_BC_SETUP_WITH",
  [importmap.MP_BC_SETUP_EXCEPT]: "MP_BC_SETUP_EXCEPT",
  [importmap.MP_BC_SETUP_FINALLY]: "MP_BC_SETUP_FINALLY",
  [importmap.MP_BC_POP_EXCEPT_JUMP]: "MP_BC_POP_EXCEPT_JUMP",
  [importmap.MP_BC_FOR_ITER]: "MP_BC_FOR_ITER",
  [importmap.MP_BC_WITH_CLEANUP]: "MP_BC_WITH_CLEANUP",
  [importmap.MP_BC_END_FINALLY]: "MP_BC_END_FINALLY",
  [importmap.MP_BC_GET_ITER]: "MP_BC_GET_ITER",
  [importmap.MP_BC_GET_ITER_STACK]: "MP_BC_GET_ITER_STACK",
  [importmap.MP_BC_BUILD_TUPLE]: "MP_BC_BUILD_TUPLE",
  [importmap.MP_BC_BUILD_LIST]: "MP_BC_BUILD_LIST",
  [importmap.MP_BC_BUILD_MAP]: "MP_BC_BUILD_MAP",
  [importmap.MP_BC_STORE_MAP]: "MP_BC_STORE_MAP",
  [importmap.MP_BC_BUILD_SET]: "MP_BC_BUILD_SET",
  [importmap.MP_BC_BUILD_SLICE]: "MP_BC_BUILD_SLICE",
  [importmap.MP_BC_STORE_COMP]: "MP_BC_STORE_COMP",
  [importmap.MP_BC_UNPACK_SEQUENCE]: "MP_BC_UNPACK_SEQUENCE",
  [importmap.MP_BC_UNPACK_EX]: "MP_BC_UNPACK_EX",
  [importmap.MP_BC_RETURN_VALUE]: "MP_BC_RETURN_VALUE",
  [importmap.MP_BC_RAISE_LAST]: "MP_BC_RAISE_LAST",
  [importmap.MP_BC_RAISE_OBJ]: "MP_BC_RAISE_OBJ",
  [importmap.MP_BC_RAISE_FROM]: "MP_BC_RAISE_FROM",
  [importmap.MP_BC_YIELD_VALUE]: "MP_BC_YIELD_VALUE",
  [importmap.MP_BC_YIELD_FROM]: "MP_BC_YIELD_FROM",
  [importmap.MP_BC_MAKE_FUNCTION]: "MP_BC_MAKE_FUNCTION",
  [importmap.MP_BC_MAKE_FUNCTION_DEFARGS]: "MP_BC_MAKE_FUNCTION_DEFARGS",
  [importmap.MP_BC_MAKE_CLOSURE]: "MP_BC_MAKE_CLOSURE",
  [importmap.MP_BC_MAKE_CLOSURE_DEFARGS]: "MP_BC_MAKE_CLOSURE_DEFARGS",
  [importmap.MP_BC_CALL_FUNCTION]: "MP_BC_CALL_FUNCTION",
  [importmap.MP_BC_CALL_FUNCTION_VAR_KW]: "MP_BC_CALL_FUNCTION_VAR_KW",
  [importmap.MP_BC_CALL_METHOD]: "MP_BC_CALL_METHOD",
  [importmap.MP_BC_CALL_METHOD_VAR_KW]: "MP_BC_CALL_METHOD_VAR_KW",
  [importmap.MP_BC_IMPORT_NAME]: "MP_BC_IMPORT_NAME",
  [importmap.MP_BC_IMPORT_FROM]: "MP_BC_IMPORT_FROM",
  [importmap.MP_BC_IMPORT_STAR]: "MP_BC_IMPORT_STAR",

  [importmap.UNOP_POSITIVE]: "UNOP_POSITIVE",
  [importmap.UNOP_NEGATIVE]: "UNOP_NEGATIVE",
  [importmap.UNOP_INVERT]: "UNOP_INVERT",
  [importmap.UNOP_NOT]: "UNOP_NOT",

  [importmap.BINOP_LESS]: "BINOP_LESS",
  [importmap.BINOP_MORE]: "BINOP_MORE",
  [importmap.BINOP_EQUAL]: "BINOP_EQUAL",
  [importmap.BINOP_LESS_EQUAL]: "BINOP_LESS_EQUAL",
  [importmap.BINOP_MORE_EQUAL]: "BINOP_MORE_EQUAL",
  [importmap.BINOP_NOT_EQUAL]: "BINOP_NOT_EQUAL",
  [importmap.BINOP_IN]: "BINOP_IN",
  [importmap.BINOP_IS]: "BINOP_IS",
  [importmap.BINOP_EXCEPTION_MATCH]: "BINOP_EXCEPTION_MATCH",
  [importmap.BINOP_INPLACE_OR]: "BINOP_INPLACE_OR",
  [importmap.BINOP_INPLACE_XOR]: "BINOP_INPLACE_XOR",
  [importmap.BINOP_INPLACE_AND]: "BINOP_INPLACE_AND",
  [importmap.BINOP_INPLACE_LSHIFT]: "BINOP_INPLACE_LSHIFT",
  [importmap.BINOP_INPLACE_RSHIFT]: "BINOP_INPLACE_RSHIFT",
  [importmap.BINOP_INPLACE_ADD]: "BINOP_INPLACE_ADD",
  [importmap.BINOP_INPLACE_SUBTRACT]: "BINOP_INPLACE_SUBTRACT",
  [importmap.BINOP_INPLACE_MULTIPLY]: "BINOP_INPLACE_MULTIPLY",
  [importmap.BINOP_INPLACE_MAT_MULTIPLY]: "BINOP_INPLACE_MAT_MULTIPLY",
  [importmap.BINOP_INPLACE_FLOOR_DIVIDE]: "BINOP_INPLACE_FLOOR_DIVIDE",
  [importmap.BINOP_INPLACE_TRUE_DIVIDE]: "BINOP_INPLACE_TRUE_DIVIDE",
  [importmap.BINOP_INPLACE_MODULO]: "BINOP_INPLACE_MODULO",
  [importmap.BINOP_INPLACE_POWER]: "BINOP_INPLACE_POWER",
  [importmap.BINOP_OR]: "BINOP_OR",
  [importmap.BINOP_XOR]: "BINOP_XOR",
  [importmap.BINOP_AND]: "BINOP_AND",
  [importmap.BINOP_LSHIFT]: "BINOP_LSHIFT",
  [importmap.BINOP_RSHIFT]: "BINOP_RSHIFT",
  [importmap.BINOP_ADD]: "BINOP_ADD",
  [importmap.BINOP_SUBTRACT]: "BINOP_SUBTRACT",
  [importmap.BINOP_MULTIPLY]: "BINOP_MULTIPLY",
  [importmap.BINOP_MAT_MULTIPLY]: "BINOP_MAT_MULTIPLY",
  [importmap.BINOP_FLOOR_DIVIDE]: "BINOP_FLOOR_DIVIDE",
  [importmap.BINOP_TRUE_DIVIDE]: "BINOP_TRUE_DIVIDE",
  [importmap.BINOP_MODULO]: "BINOP_MODULO",
  [importmap.BINOP_POWER]: "BINOP_POWER",
  [importmap.BINOP_DIVMOD]: "BINOP_DIVMOD",
  [importmap.BINOP_CONTAINS]: "BINOP_CONTAINS",
  [importmap.BINOP_REVERSE_OR]: "BINOP_REVERSE_OR",
  [importmap.BINOP_REVERSE_XOR]: "BINOP_REVERSE_XOR",
  [importmap.BINOP_REVERSE_AND]: "BINOP_REVERSE_AND",
  [importmap.BINOP_REVERSE_LSHIFT]: "BINOP_REVERSE_LSHIFT",
  [importmap.BINOP_REVERSE_RSHIFT]: "BINOP_REVERSE_RSHIFT",
  [importmap.BINOP_REVERSE_ADD]: "BINOP_REVERSE_ADD",
  [importmap.BINOP_REVERSE_SUBTRACT]: "BINOP_REVERSE_SUBTRACT",
  [importmap.BINOP_REVERSE_MULTIPLY]: "BINOP_REVERSE_MULTIPLY",
  [importmap.BINOP_REVERSE_MAT_MULTIPLY]: "BINOP_REVERSE_MAT_MULTIPLY",
  [importmap.BINOP_REVERSE_FLOOR_DIVIDE]: "BINOP_REVERSE_FLOOR_DIVIDE",
  [importmap.BINOP_REVERSE_TRUE_DIVIDE]: "BINOP_REVERSE_TRUE_DIVIDE",
  [importmap.BINOP_REVERSE_MODULO]: "BINOP_REVERSE_MODULO",
  [importmap.BINOP_REVERSE_POWER]: "BINOP_REVERSE_POWER",
};

let branches = [
  "btrue",
  "bfalse",
  "btrue.pop",
  "bfalse.pop",
  "jmp.unwind",
  "jmp",
];
let outg = [];
function out(s: string) {outg.push(s);}
function disassemblefrom_c_opinput(opinput0: string[], p: { [key: string]: string }) {
  out(p[opinput0[1].split('& 0xff')[0].trim()] + ':');
  let opinput = opinput0.map((e) =>
    e.trim().split(",").map((e) => e.trim()).filter((e) => e).map((e, i) =>
      e.startsWith("0x")
        ? +e
        : e.endsWith(">> 8")
        ? ""
        : e.endsWith("& 0xff")
        ? p[e.split(" ")[0]]
        : e
    ).filter((e) => e !== "").map((e, i) =>
      (typeof e == "number" && i == 0)
        ? opsnm[optypes[e]] || (
          typeof e == "number" && e >= 0xb0 && e < 0xc0 && i == 0
            ? `ldloc.${e - 0xb0}`
            : typeof e == "number" && e >= 0xc0 && e < 0xd0 && i == 0
            ? `stloc.${e - 0xc0}`
            : e
        )
        : e
    ).map((e, i, a) =>
      branches.includes(a[0])
        ? (
          [[e, (a[1] | (a[2] << 8)) - 0x8000, []][i]].flat()
        )
        : [e]
    ).flat()
  );
  out(
    opinput.slice(4).map((e) =>
      '\t' + e.map((e, i) => i > 1 ? `, ${e}` : e).join(" ").replaceAll(" , ", ", ")
    ).join("\n"),
  );
}
function arrornot(s: string | string[]): string[] {
  return [s].flat();
}

// size_t slab = (ip[0] | (ip[1] << 8)) - 0x8000; ip += 2

// function pattern(
//   p: TemplateStringsArray,
//   ...s: ((p: string[]) => string | string[])[]
// ) {
//   let all = String.raw(p, s.map((_e, i) => `%%__fn${i}%%`)).trim().split("\n")
//     .map((e) => e.split(";")[0].trim()).filter((e) => e).map((e) =>
//       e.split(" ")
//     );
//   let ops = new Map<string, (p: string[]) => string | string[]>();
//   let dat = new Map<string, string[]>();
//   let output = [];
//   let fork = [...opinput];
//   for (let insn of all) {
//     let opcode = insn[0];
//     if (opcode == "%op") {
//       ops.set(insn[1], s.shift());
//     }
//     if (opcode == "%match") {
//       let dat = insn.slice(1);
//     }
//     if (opcode == "%commit") {
//       opinput = [...fork];
//     }
//   }
// }
// // roll in glbl/attr into push
// pattern`
// %op do_dot_join ${(p) => p.join(".")}
// %match glbl $id
// %rep %match attr $id2
// %produce push %do_dot_join($id $id2)
// %commit`;




for (let type of execSync('find in -type f').toString().trim().split('\n').map(e => ({ in: e, out: 'out/' + e.slice(3).split('.')[0] + '.s' }))) {
  let outdotc = execSync('python micropython/tools/mpy-tool.py --freeze ' + type.in).toString();
  let keys = (outdotc.split('enum {')[1].split('}')[0].trim().split('\n').map(e => e.trim().split(',')[0]));
  let values = outdotc.split('mp_qstr_frozen_const_pool')[1].split('{')[2].split('}')[0].trim().split('\n').map(e => e.split('"')[3]);
  let entries = keys.map((e, i) => [e, values[i]]);
  let djson = Object.fromEntries(entries);
  let osn = outdotc.split('\n');
  let data = osn.map((e, i) => [e, i] as const).filter(e => e[0].startsWith('STATIC const byte fun_data_'));
  data.map(e => osn.slice(e[1] + 1).join('\n').split('};')[0].split('\n').map(e => e.trim())).forEach(t => {
    disassemblefrom_c_opinput(t, djson);
  })
  if (!existsSync(type.out.split('/').slice(0, -1).join('/'))) {
    execSync('mkdir -p ' + type.out.split('/').slice(0, -1).join('/'));
  }
  writeFileSync(type.out, outg.join('\n'))
}


