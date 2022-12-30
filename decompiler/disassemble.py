#!/usr/bin/python3

import argparse
import os
import importlib  
import io 
import sys

MP_BC_MASK_FORMAT                 = 0xf0
MP_BC_MASK_EXTRA_BYTE             = 0x9e

MP_BC_FORMAT_BYTE                 = 0
MP_BC_FORMAT_QSTR                 = 1
MP_BC_FORMAT_VAR_UINT             = 2
MP_BC_FORMAT_OFFSET               = 3

# MP_BC_BASE_RESERVED               = 0x00  # ----------------

MP_BC_BASE_QSTR_O                 = 0x10  # LLLLLLSSSDDII---
MP_BC_BASE_VINT_E                 = 0x20  # MMLLLLSSDDBBBBBB
MP_BC_BASE_VINT_O                 = 0x30  # UUMMCCCC--------
MP_BC_BASE_JUMP_E                 = 0x40  # J-JJJJJEEEEF----
MP_BC_BASE_BYTE_O                 = 0x50  # LLLLSSDTTTTTEEFF
MP_BC_BASE_BYTE_E                 = 0x60  # --BREEEYYI------

MP_BC_LOAD_CONST_SMALL_INT_MULTI  = 0x70  # LLLLLLLLLLLLLLLL
MP_BC_LOAD_FAST_MULTI             = 0xb0  # LLLLLLLLLLLLLLLL
MP_BC_STORE_FAST_MULTI            = 0xc0  # SSSSSSSSSSSSSSSS
MP_BC_UNARY_OP_MULTI              = 0xd0  # OOOOOOO
MP_BC_BINARY_OP_MULTI             = 0xd7  #        OOOOOOOOO

################################################################################

importmap = {
    "MP_BC_LOAD_CONST_FALSE":       (MP_BC_BASE_BYTE_O + 0x00),
    "MP_BC_LOAD_CONST_NONE":        (MP_BC_BASE_BYTE_O + 0x01),
    "MP_BC_LOAD_CONST_TRUE":        (MP_BC_BASE_BYTE_O + 0x02),
    "MP_BC_LOAD_CONST_SMALL_INT":   (MP_BC_BASE_VINT_E + 0x02),  # signed var-int
    "MP_BC_LOAD_CONST_STRING":      (MP_BC_BASE_QSTR_O + 0x00),  # qstr
    "MP_BC_LOAD_CONST_OBJ":         (MP_BC_BASE_VINT_E + 0x03),  # ptr
    "MP_BC_LOAD_NULL":              (MP_BC_BASE_BYTE_O + 0x03),
    "MP_BC_LOAD_FAST_N":            (MP_BC_BASE_VINT_E + 0x04),  # uint
    "MP_BC_LOAD_DEREF":             (MP_BC_BASE_VINT_E + 0x05),  # uint
    "MP_BC_LOAD_NAME":              (MP_BC_BASE_QSTR_O + 0x01),  # qstr
    "MP_BC_LOAD_GLOBAL":            (MP_BC_BASE_QSTR_O + 0x02),  # qstr
    "MP_BC_LOAD_ATTR":              (MP_BC_BASE_QSTR_O + 0x03),  # qstr
    "MP_BC_LOAD_METHOD":            (MP_BC_BASE_QSTR_O + 0x04),  # qstr
    "MP_BC_LOAD_SUPER_METHOD":      (MP_BC_BASE_QSTR_O + 0x05),  # qstr
    "MP_BC_LOAD_BUILD_CLASS":       (MP_BC_BASE_BYTE_O + 0x04),
    "MP_BC_LOAD_SUBSCR":            (MP_BC_BASE_BYTE_O + 0x05),
    "MP_BC_STORE_FAST_N":           (MP_BC_BASE_VINT_E + 0x06),  # uint
    "MP_BC_STORE_DEREF":            (MP_BC_BASE_VINT_E + 0x07),  # uint
    "MP_BC_STORE_NAME":             (MP_BC_BASE_QSTR_O + 0x06),  # qstr
    "MP_BC_STORE_GLOBAL":           (MP_BC_BASE_QSTR_O + 0x07),  # qstr
    "MP_BC_STORE_ATTR":             (MP_BC_BASE_QSTR_O + 0x08),  # qstr
    "MP_BC_STORE_SUBSCR":           (MP_BC_BASE_BYTE_O + 0x06),
    "MP_BC_DELETE_FAST":            (MP_BC_BASE_VINT_E + 0x08),  # uint
    "MP_BC_DELETE_DEREF":           (MP_BC_BASE_VINT_E + 0x09),  # uint
    "MP_BC_DELETE_NAME":            (MP_BC_BASE_QSTR_O + 0x09),  # qstr
    "MP_BC_DELETE_GLOBAL":          (MP_BC_BASE_QSTR_O + 0x0a),  # qstr
    "MP_BC_DUP_TOP":                (MP_BC_BASE_BYTE_O + 0x07),
    "MP_BC_DUP_TOP_TWO":            (MP_BC_BASE_BYTE_O + 0x08),
    "MP_BC_POP_TOP":                (MP_BC_BASE_BYTE_O + 0x09),
    "MP_BC_ROT_TWO":                (MP_BC_BASE_BYTE_O + 0x0a),
    "MP_BC_ROT_THREE":              (MP_BC_BASE_BYTE_O + 0x0b),
    "MP_BC_JUMP":                   (MP_BC_BASE_JUMP_E + 0x02),  # rel byte code offset, 16-bit signed, in excess
    "MP_BC_POP_JUMP_IF_TRUE":       (MP_BC_BASE_JUMP_E + 0x03),  # rel byte code offset, 16-bit signed, in excess
    "MP_BC_POP_JUMP_IF_FALSE":      (MP_BC_BASE_JUMP_E + 0x04),  # rel byte code offset, 16-bit signed, in excess
    "MP_BC_JUMP_IF_TRUE_OR_POP":    (MP_BC_BASE_JUMP_E + 0x05),  # rel byte code offset, 16-bit signed, in excess
    "MP_BC_JUMP_IF_FALSE_OR_POP":   (MP_BC_BASE_JUMP_E + 0x06),  # rel byte code offset, 16-bit signed, in excess
    "MP_BC_UNWIND_JUMP":            (MP_BC_BASE_JUMP_E + 0x00),  # rel byte code offset, 16-bit signed, in excess; then a byte
    "MP_BC_SETUP_WITH":             (MP_BC_BASE_JUMP_E + 0x07),  # rel byte code offset, 16-bit unsigned
    "MP_BC_SETUP_EXCEPT":           (MP_BC_BASE_JUMP_E + 0x08),  # rel byte code offset, 16-bit unsigned
    "MP_BC_SETUP_FINALLY":          (MP_BC_BASE_JUMP_E + 0x09),  # rel byte code offset, 16-bit unsigned
    "MP_BC_POP_EXCEPT_JUMP":        (MP_BC_BASE_JUMP_E + 0x0a),  # rel byte code offset, 16-bit unsigned
    "MP_BC_FOR_ITER":               (MP_BC_BASE_JUMP_E + 0x0b),  # rel byte code offset, 16-bit unsigned
    "MP_BC_WITH_CLEANUP":           (MP_BC_BASE_BYTE_O + 0x0c),
    "MP_BC_END_FINALLY":            (MP_BC_BASE_BYTE_O + 0x0d),
    "MP_BC_GET_ITER":               (MP_BC_BASE_BYTE_O + 0x0e),
    "MP_BC_GET_ITER_STACK":         (MP_BC_BASE_BYTE_O + 0x0f),
    "MP_BC_BUILD_TUPLE":            (MP_BC_BASE_VINT_E + 0x0a),  # uint
    "MP_BC_BUILD_LIST":             (MP_BC_BASE_VINT_E + 0x0b),  # uint
    "MP_BC_BUILD_MAP":              (MP_BC_BASE_VINT_E + 0x0c),  # uint
    "MP_BC_STORE_MAP":              (MP_BC_BASE_BYTE_E + 0x02),
    "MP_BC_BUILD_SET":              (MP_BC_BASE_VINT_E + 0x0d),  # uint
    "MP_BC_BUILD_SLICE":            (MP_BC_BASE_VINT_E + 0x0e),  # uint
    "MP_BC_STORE_COMP":             (MP_BC_BASE_VINT_E + 0x0f),  # uint
    "MP_BC_UNPACK_SEQUENCE":        (MP_BC_BASE_VINT_O + 0x00),  # uint
    "MP_BC_UNPACK_EX":              (MP_BC_BASE_VINT_O + 0x01),  # uint
    "MP_BC_RETURN_VALUE":           (MP_BC_BASE_BYTE_E + 0x03),
    "MP_BC_RAISE_LAST":             (MP_BC_BASE_BYTE_E + 0x04),
    "MP_BC_RAISE_OBJ":              (MP_BC_BASE_BYTE_E + 0x05),
    "MP_BC_RAISE_FROM":             (MP_BC_BASE_BYTE_E + 0x06),
    "MP_BC_YIELD_VALUE":            (MP_BC_BASE_BYTE_E + 0x07),
    "MP_BC_YIELD_FROM":             (MP_BC_BASE_BYTE_E + 0x08),
    "MP_BC_MAKE_FUNCTION":          (MP_BC_BASE_VINT_O + 0x02),  # uint
    "MP_BC_MAKE_FUNCTION_DEFARGS":  (MP_BC_BASE_VINT_O + 0x03),  # uint
    "MP_BC_MAKE_CLOSURE":           (MP_BC_BASE_VINT_E + 0x00),  # uint; extra byte
    "MP_BC_MAKE_CLOSURE_DEFARGS":   (MP_BC_BASE_VINT_E + 0x01),  # uint; extra byte
    "MP_BC_CALL_FUNCTION":          (MP_BC_BASE_VINT_O + 0x04),  # uint
    "MP_BC_CALL_FUNCTION_VAR_KW":   (MP_BC_BASE_VINT_O + 0x05),  # uint
    "MP_BC_CALL_METHOD":            (MP_BC_BASE_VINT_O + 0x06),  # uint
    "MP_BC_CALL_METHOD_VAR_KW":     (MP_BC_BASE_VINT_O + 0x07),  # uint
    "MP_BC_IMPORT_NAME":            (MP_BC_BASE_QSTR_O + 0x0b),  # qstr
    "MP_BC_IMPORT_FROM":            (MP_BC_BASE_QSTR_O + 0x0c),  # qstr
    "MP_BC_IMPORT_STAR":            (MP_BC_BASE_BYTE_E + 0x09),
    
    "UNOP_POSITIVE":                0xd0,
    "UNOP_NEGATIVE":                0xd1,
    "UNOP_INVERT":                  0xd2,
    "UNOP_NOT":                     0xd3,
    
    "BINOP_LESS":                   0xd7,
    "BINOP_MORE":                   0xd8,
    "BINOP_EQUAL":                  0xd9,
    "BINOP_LESS_EQUAL":             0xda,
    "BINOP_MORE_EQUAL":             0xdb,
    "BINOP_NOT_EQUAL":              0xdc,
    "BINOP_IN":                     0xdd,
    "BINOP_IS":                     0xde,
    "BINOP_EXCEPTION_MATCH":        0xdf,
    "BINOP_INPLACE_OR":             0xe0,
    "BINOP_INPLACE_XOR":            0xe1,
    "BINOP_INPLACE_AND":            0xe2,
    "BINOP_INPLACE_LSHIFT":         0xe3,
    "BINOP_INPLACE_RSHIFT":         0xe4,
    "BINOP_INPLACE_ADD":            0xe5,
    "BINOP_INPLACE_SUBTRACT":       0xe6,
    "BINOP_INPLACE_MULTIPLY":       0xe7,
    "BINOP_INPLACE_MAT_MULTIPLY":   0xe8,
    "BINOP_INPLACE_FLOOR_DIVIDE":   0xe9,
    "BINOP_INPLACE_TRUE_DIVIDE":    0xea,
    "BINOP_INPLACE_MODULO":         0xeb,
    "BINOP_INPLACE_POWER":          0xec,
    "BINOP_OR":                     0xed,
    "BINOP_XOR":                    0xee,
    "BINOP_AND":                    0xef,
    "BINOP_LSHIFT":                 0xf0,
    "BINOP_RSHIFT":                 0xf1,
    "BINOP_ADD":                    0xf2,
    "BINOP_SUBTRACT":               0xf3,
    "BINOP_MULTIPLY":               0xf4,
    "BINOP_MAT_MULTIPLY":           0xf5,
    "BINOP_FLOOR_DIVIDE":           0xf6,
    "BINOP_TRUE_DIVIDE":            0xf7,
    "BINOP_MODULO":                 0xf8,
    "BINOP_POWER":                  0xf9,
    "BINOP_DIVMOD":                 0xfa,
    "BINOP_CONTAINS":               0xfb,
    "BINOP_REVERSE_OR":             0xfc,
    "BINOP_REVERSE_XOR":            0xfd,
    "BINOP_REVERSE_AND":            0xfe,
    "BINOP_REVERSE_LSHIFT":         0xff,
    "BINOP_REVERSE_RSHIFT":         0x100,
    "BINOP_REVERSE_ADD":            0x101,
    "BINOP_REVERSE_SUBTRACT":       0x102,
    "BINOP_REVERSE_MULTIPLY":       0x103,
    "BINOP_REVERSE_MAT_MULTIPLY":   0x104,
    "BINOP_REVERSE_FLOOR_DIVIDE":   0x105,
    "BINOP_REVERSE_TRUE_DIVIDE":    0x106,
    "BINOP_REVERSE_MODULO":         0x107,
    "BINOP_REVERSE_POWER":          0x108,
}

optypes = { op_value: op_name for op_name, op_value in importmap.items() }

opsnm = {
    "MP_BC_LOAD_CONST_FALSE":       "false",
    "MP_BC_LOAD_CONST_NONE":        "none",
    "MP_BC_LOAD_CONST_TRUE":        "true",
    "MP_BC_LOAD_CONST_SMALL_INT":   "int",
    "MP_BC_LOAD_CONST_STRING":      "str",
    "MP_BC_LOAD_CONST_OBJ":         "constobj",
    "MP_BC_LOAD_NULL":              "null",
    "MP_BC_LOAD_FAST_N":            "MP_BC_LOAD_FAST_N",
    "MP_BC_LOAD_DEREF":             "deref",
    "MP_BC_LOAD_NAME":              "loadname",
    "MP_BC_LOAD_GLOBAL":            "glbl",
    "MP_BC_LOAD_ATTR":              "attr",
    "MP_BC_LOAD_METHOD":            "method",
    "MP_BC_LOAD_SUPER_METHOD":      "supermethod",
    "MP_BC_LOAD_BUILD_CLASS":       "buildclass",
    "MP_BC_LOAD_SUBSCR":            "ld.arrsub",
    "MP_BC_STORE_FAST_N":           "MP_BC_STORE_FAST_N",
    "MP_BC_STORE_DEREF":            "st.deref",
    "MP_BC_STORE_NAME":             "st.name",
    "MP_BC_STORE_GLOBAL":           "st.glbl",
    "MP_BC_STORE_ATTR":             "st.attr",
    "MP_BC_STORE_SUBSCR":           "st.arrsub",
    "MP_BC_DELETE_FAST":            "del.fast",
    "MP_BC_DELETE_DEREF":           "del.deref",
    "MP_BC_DELETE_NAME":            "del.name",
    "MP_BC_DELETE_GLOBAL":          "del.glbl",
    "MP_BC_DUP_TOP":                "dup",
    "MP_BC_DUP_TOP_TWO":            "dup2",
    "MP_BC_POP_TOP":                "pop",
    "MP_BC_ROT_TWO":                "rot",
    "MP_BC_ROT_THREE":              "rot3",
    "MP_BC_JUMP":                   "jmp",
    "MP_BC_POP_JUMP_IF_TRUE":       "btrue",
    "MP_BC_POP_JUMP_IF_FALSE":      "bfalse",
    "MP_BC_JUMP_IF_TRUE_OR_POP":    "btrue.pop",
    "MP_BC_JUMP_IF_FALSE_OR_POP":   "bfalse.pop",
    "MP_BC_UNWIND_JUMP":            "jmp.unwind",
    "MP_BC_SETUP_WITH":             "with.setup",
    "MP_BC_SETUP_EXCEPT":           "except.setup",
    "MP_BC_SETUP_FINALLY":          "finally.setup",
    "MP_BC_POP_EXCEPT_JUMP":        "except.jump",
    "MP_BC_FOR_ITER":               "for.iter",
    "MP_BC_WITH_CLEANUP":           "with.chleanup",
    "MP_BC_END_FINALLY":            "finally.end",
    "MP_BC_GET_ITER":               "ld.iter",
    "MP_BC_GET_ITER_STACK":         "ld.iterstack",
    "MP_BC_BUILD_TUPLE":            "tuple",
    "MP_BC_BUILD_LIST":             "list",
    "MP_BC_BUILD_MAP":              "map",
    "MP_BC_STORE_MAP":              "st.map",
    "MP_BC_BUILD_SET":              "MP_BC_BUILD_SET",
    "MP_BC_BUILD_SLICE":            "slice",
    "MP_BC_STORE_COMP":             "MP_BC_STORE_COMP",
    "MP_BC_UNPACK_SEQUENCE":        "MP_BC_UNPACK_SEQUENCE",
    "MP_BC_UNPACK_EX":              "MP_BC_UNPACK_EX",
    "MP_BC_RETURN_VALUE":           "ret",
    "MP_BC_RAISE_LAST":             "rethrow",
    "MP_BC_RAISE_OBJ":              "raiseobj",
    "MP_BC_RAISE_FROM":             "throwfrom",
    "MP_BC_YIELD_VALUE":            "yield",
    "MP_BC_YIELD_FROM":             "yieldfrom",
    "MP_BC_MAKE_FUNCTION":          "mkfun",
    "MP_BC_MAKE_FUNCTION_DEFARGS":  "mkfun.defargs",
    "MP_BC_MAKE_CLOSURE":           "mkclosure",
    "MP_BC_MAKE_CLOSURE_DEFARGS":   "mkclosure.defargs",
    "MP_BC_CALL_FUNCTION":          "call",
    "MP_BC_CALL_FUNCTION_VAR_KW":   "call.kw",
    "MP_BC_CALL_METHOD":            "call.meth",
    "MP_BC_CALL_METHOD_VAR_KW":     "call.kvmeth",
    "MP_BC_IMPORT_NAME":            "import.nm",
    "MP_BC_IMPORT_FROM":            "import.from",
    "MP_BC_IMPORT_STAR":            "import.all",
    
    "UNOP_POSITIVE":                "assertint",
    "UNOP_NEGATIVE":                "neg",
    "UNOP_INVERT":                  "invert",
    "UNOP_NOT":                     "not",
    
    "BINOP_LESS":                   "lt",
    "BINOP_MORE":                   "qt",
    "BINOP_EQUAL":                  "eq",
    "BINOP_LESS_EQUAL":             "le",
    "BINOP_MORE_EQUAL":             "qe",
    "BINOP_NOT_EQUAL":              "ne",
    "BINOP_IN":                     "in",
    "BINOP_IS":                     "is",
    "BINOP_EXCEPTION_MATCH":        "ematch",
    "BINOP_INPLACE_OR":             "or.in",
    "BINOP_INPLACE_XOR":            "xor.in",
    "BINOP_INPLACE_AND":            "and.in",
    "BINOP_INPLACE_LSHIFT":         "shl.in",
    "BINOP_INPLACE_RSHIFT":         "shr.in",
    "BINOP_INPLACE_ADD":            "add.in",
    "BINOP_INPLACE_SUBTRACT":       "sub.in",
    "BINOP_INPLACE_MULTIPLY":       "mul.in",
    "BINOP_INPLACE_MAT_MULTIPLY":   "matmul.in",
    "BINOP_INPLACE_FLOOR_DIVIDE":   "floordiv.in",
    "BINOP_INPLACE_TRUE_DIVIDE":    "div.in",
    "BINOP_INPLACE_MODULO":         "mod.in",
    "BINOP_INPLACE_POWER":          "pow.in",
    "BINOP_OR":                     "or",
    "BINOP_XOR":                    "xor",
    "BINOP_AND":                    "and",
    "BINOP_LSHIFT":                 "shl",
    "BINOP_RSHIFT":                 "shr",
    "BINOP_ADD":                    "add",
    "BINOP_SUBTRACT":               "sub",
    "BINOP_MULTIPLY":               "mul",
    "BINOP_MAT_MULTIPLY":           "matmul",
    "BINOP_FLOOR_DIVIDE":           "floordiv",
    "BINOP_TRUE_DIVIDE":            "truediv",
    "BINOP_MODULO":                 "mod",
    "BINOP_POWER":                  "pow",
    "BINOP_DIVMOD":                 "divmod",
    "BINOP_CONTAINS":               "in",
    "BINOP_REVERSE_OR":             "or.rev",
    "BINOP_REVERSE_XOR":            "xor.rev",
    "BINOP_REVERSE_AND":            "and.rev",
    "BINOP_REVERSE_LSHIFT":         "shl.rev",
    "BINOP_REVERSE_RSHIFT":         "shr.rev",
    "BINOP_REVERSE_ADD":            "add.rev",
    "BINOP_REVERSE_SUBTRACT":       "sub.rev",
    "BINOP_REVERSE_MULTIPLY":       "mul.rev",
    "BINOP_REVERSE_MAT_MULTIPLY":   "matmul.rev",
    "BINOP_REVERSE_FLOOR_DIVIDE":   "floordiv.rev",
    "BINOP_REVERSE_TRUE_DIVIDE":    "truediv.rev",
    "BINOP_REVERSE_MODULO":         "mod.rev",
    "BINOP_REVERSE_POWER":          "pow.rev",
}

branches = [
    "jmp",
    "btrue",
    "bfalse",
    "btrue.pop",
    "bfalse.pop",
    "jmp.unwind"
]

branches2 = [
    "with.setup",
    "except.setup",
    "finally.setup",
    "except.jump",
    "for.iter"
]


class capturing(list):
    def __enter__(self):
        self._stdout = sys.stdout
        sys.stdout = self._stringio = io.StringIO()
        return self

    def __exit__(self, *args):
        self.extend(self._stringio.getvalue().splitlines())
        del self._stringio
        sys.stdout = self._stdout


def flatten(itr):
    if type(itr) in (str, bytes):
        yield itr
    else:
        for x in itr:
            try:
                yield from flatten(x)
            except TypeError:
                yield x


def flat(x):
    return [e for e in flatten([x])]


def disassemblefrom_c_opinput(opinput0, p):
    globals()['outg'].append(p[opinput0[1].split('& 0xff')[0].strip()] + ':')
    
    globals()['off'] = 0
    globals()['usedAddresses'] = set()
    
    def process_opinput1(line):
        stage0 = line.strip().split(",")
        
        stage1 = stage0
        stage1 = [e.strip() for e in stage1]
        stage1 = [e for e in stage1 if e]
        
        globals()['off'] += len(stage1)
        stage1.append(str(globals()['off']))
        
        def stage2_lbd(e):
            if e.startswith('0x'):
                return int(e, 16)
            elif e.endswith('>> 8'):
                return ''
            elif e.endswith('& 0xff'):
                return p[e.split(' ')[0]]
            else:
                return e
        
        stage2 = stage1
        stage2 = [stage2_lbd(e) for e in stage2]
        stage2 = [e for e in stage2 if e != '']
        
        def stage3_lbd(e, i):
            if (type(e) is int) and (i == 0):
                if (e in optypes) and (optypes[e] in opsnm):
                    return opsnm[optypes[e]]
                elif (type(e) is int) and (e >= MP_BC_LOAD_FAST_MULTI) and (e < MP_BC_STORE_FAST_MULTI) and (i == 0):
                    return 'ldloc.{}'.format(e - MP_BC_LOAD_FAST_MULTI)
                elif (type(e) is int) and (e >= MP_BC_STORE_FAST_MULTI) and (e < MP_BC_UNARY_OP_MULTI) and (i == 0):
                    return 'stloc.{}'.format(e - MP_BC_STORE_FAST_MULTI)
                elif (type(e) is int) and (e >= 0x80) and (e < 0x90) and (i == 0):  # 128 to 144
                    return 'int {}'.format(e - 0x80)
                else:
                    print('Unknown opcode: {}'.format(e))
                    return '{}'.format(e)
            else:
                # print('Opcode: {} position {}'.format(e, i))
                return e
        
        stage3 = stage2
        stage3 = [stage3_lbd(e, i) for e, i in zip(stage3, range(len(stage3)))]
        
        def stage4_lbd(e, i, a):
            if a[0] in branches:
                address = (a[1] | (int(a[2]) << 8)) - 0x8000 + globals()['off']
                globals()['usedAddresses'].add(address)
                return flat([e, '.L' + str(address), [], e, e][i])
            elif a[0] in branches2:
                address = (a[1] | (int(a[2]) << 8)) + globals()['off']
                globals()['usedAddresses'].add(address)
                return flat([e, '.L' + str(address), [], e, e][i])
            else:
                return [e]
        
        stage4 = stage3
        stage4 = [stage4_lbd(e, i, stage4) for e, i in zip(stage4, range(len(stage4)))]
        
        return flat(stage4)
    
    opinput1 = opinput0
    opinput1 = [process_opinput1(e) for e in opinput1]
    
    globals()['off'] = 0
    
    def process_opinput2(e, i, a):
        def comma_test(e1, i1):
            if i1 > 1:
                return ', {}'.format(e1)
            else: 
                return str(e1)
        
        e2 = [comma_test(e1, i1) for e1, i1 in zip(e[:-1], range(len(e[:-1])))]
        e3 = ' '.join(e2)
        e4 = e3.replace(' , ', ', ')
        
        if (i >= 1) and (int(a[i - 1][-1]) in globals()['usedAddresses']):
            return '.L' + a[i - 1][len(a[i - 1]) - 1] + ':\n\t' + e4
        else:
            return '\t' + e4
    
    opinput2 = opinput1[4:]
    opinput2 = [process_opinput2(e, i, opinput2) for e, i in zip(opinput2, range(len(opinput2)))]
        
    globals()['outg'].append('\n'.join(opinput2))


def get_enums(dotc_content):
    enum_keys = []
    num_lines = len(dotc_content)
    found_pos = -1
    for i in range(num_lines):
        line = dotc_content[i]
        if line == 'enum {':
            found_pos = i
            break
    if found_pos == -1:
        return enum_keys
    for i in range(found_pos+1, num_lines):
        line = dotc_content[i]
        if line == '};':
            break
        enum_keys.append(line.split(',')[0].split('=')[0].strip())
    return enum_keys


def get_values(dotc_content):
    enum_values = []
    num_lines = len(dotc_content)
    found_pos = -1
    for i in range(num_lines):
        line = dotc_content[i]
        if 'mp_qstr_frozen_const_pool' in line:
            found_pos = i
            break
    if found_pos == -1:
        return enum_values
    for i in range(found_pos+6, num_lines):
        line = dotc_content[i]
        if line.strip() == '},':
            break
        enum_values.append(line.split('"')[3].strip())
    return enum_values


################################################################################


if __name__ == "__main__":
    print("Initialising disassembler...")
    
    print("Parsing arguments...")
    parser = argparse.ArgumentParser(description="Disassembles an '.mpy' micropython script.")
    parser.add_argument("script_path", help="Script file name to disassemble.")
    parser.add_argument("output_path", nargs='?', help="Output file to used for disassembled output.", default="")
    arguments = parser.parse_args()

    print("Checking script...")
    if not os.path.isfile(arguments.script_path):
        raise FileNotFoundError("Failed to find the script file at the given path.")
        
    if not os.access(arguments.script_path, os.R_OK):
        raise PermissionError("Do not have permission to read the script file.")

    if arguments.output_path != "":
        print("Checking output...")
        if os.path.isfile(arguments.output_path):
            raise FileNotFoundError("Found an existing file at the output file path.")
            
    print("Running mpy-tool on script...")
    root_dir = os.path.dirname(os.path.abspath(__file__))
    sys.path.insert(0, root_dir + '/micropython/tools')
    mpy_tool = importlib.import_module("mpy-tool")
    mpy_tool.config.MICROPY_LONGINT_IMPL = {
        "none": mpy_tool.config.MICROPY_LONGINT_IMPL_NONE,
        "longlong": mpy_tool.config.MICROPY_LONGINT_IMPL_LONGLONG,
        "mpz": mpy_tool.config.MICROPY_LONGINT_IMPL_MPZ,
    }["mpz"]
    mpy_tool.config.MPZ_DIG_SIZE = 16
    mpy_tool.config.native_arch = mpy_tool.MP_NATIVE_ARCH_NONE
    mpy_tool.config.MICROPY_QSTR_BYTES_IN_LEN = 1
    mpy_tool.config.MICROPY_QSTR_BYTES_IN_HASH = 1
    base_qstrs = {}
    raw_codes = [mpy_tool.read_mpy(arguments.script_path)]
    try:
        with capturing() as captured_output:
            mpy_tool.freeze_mpy(base_qstrs, raw_codes)
    except mpy_tool.FreezeError as er:
        print(er, file=sys.stderr)
        sys.exit(1)
    
    print("Processing output of mpy-tool...")

    keys = get_enums(captured_output)
    
    values = get_values(captured_output)
    
    # Double check we have extracted the map correctly.
    assert(len(keys) == len(values))
    
    entries = dict((key, value) for key, value in zip(keys, values))
    
    data = [[line, index] for line, index in zip(captured_output, range(len(captured_output))) if line.startswith('STATIC const byte fun_data_')]
    
    globals()['outg'] = []
    
    functions_raw = [('\n'.join(captured_output[line_index[1] + 1:])).split('};')[0].split('\n') for line_index in data]
    functions = [[function_line.strip() for function_line in function] for function in functions_raw]
    
    for function in functions:
        disassemblefrom_c_opinput(function, entries)

    if arguments.output_path != "":
        print("Writing output...")
        output_file = open(arguments.output_path, 'w') 
        output_file.write('\n'.join(globals()['outg']))
    else:
        print("Disassembled output...")
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print('\n'.join(globals()['outg']))
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        
    print("Finished.")
