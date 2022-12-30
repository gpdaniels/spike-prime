#!/usr/bin/python3

import argparse
import os
import json
import re


opcode2data = {
    'true':         '$push(True)',
    'false':        '$push(False)',
    'pop':          '$pop(0)',
    'none':         '$push(None)',
    'ret':          'return $pop(0)',
    'st.name':      '$1 = $pop(0)',
    'loadname':     '$push($1)',
    'glbl':         '$push($1)',
    'int':          '$push($1)',
    'deref':        '$push(args[$1])',
    'st.deref':     'args[$1] = $pop(0)',

    'ldloc.0':      '$push(args[0])',
    'ldloc.1':      '$push(args[1])',
    'ldloc.2':      '$push(args[2])',
    'ldloc.3':      '$push(args[3])',
    'ldloc.4':      '$push(args[4])',
    'ldloc.5':      '$push(args[5])',
    'ldloc.6':      '$push(args[6])',
    'ldloc.7':      '$push(args[7])',
    'ldloc.8':      '$push(args[8])',
    'ldloc.9':      '$push(args[9])',
    'ldloc.10':     '$push(args[10])',

    'stloc.0':      'args[0] = $pop(0)',
    'stloc.1':      'args[1] = $pop(0)',
    'stloc.2':      'args[2] = $pop(0)',
    'stloc.3':      'args[3] = $pop(0)',
    'stloc.4':      'args[4] = $pop(0)',
    'stloc.5':      'args[5] = $pop(0)',
    'stloc.6':      'args[6] = $pop(0)',
    'stloc.7':      'args[7] = $pop(0)',
    'stloc.8':      'args[8] = $pop(0)',
    'stloc.9':      'args[9] = $pop(0)',
    'stloc.10':     'args[10] = $pop(0)',

    'add':          '$push($pop(1) + $pop(0))',
    'lt':           '$push($pop(1) < $pop(0))',
    'sub.in':       '$push($pop(1) - $pop(0))',

    'raiseobj':     'raise $pop(0)',
    'del.name':     'del $1',
    'nop':          '$nop',
    'buildclass':   '$push(__build_class__)',
    'st.attr':      '$pop(0).$1 = $pop(1)',
    'attr':         '$push($pop(0).$1)',
    'method':       '$push($pop(0).$1)',
    'null':         'null',
    'ld.arrsub':    '$push($pop(1)[$pop(0)])',
    'is':           '$push($pop(1) is $pop(0))',
    'ematch':       '$push($pop(1) is $pop(0))',
    'not':          '$push(not $pop(0))',
    'dup':          '$dup'
}

branches = [
    'jmp',
    'btrue',
    'bfalse',
    'btrue.pop',
    'bfalse.pop',
    'jmp.unwind',
    # "with.setup",
    # "except.setup",
    # "finally.setup",
    # "except.jump",
    'for.iter'
]


def evalopwithstack(shadow, i, x, stack, tablevel):
    e = shadow[i]
    if e is None:
        globals()['outg'].append(('    ' * tablevel) + '# Error: Unknown operation "' + ' '.join(x[i]) + '"')
        for index in range(len(stack)):
            globals()['outg'].append(('    ' * tablevel) + '# Error: Current stack [{}]: "{}"'.format(index, stack[index]))
        globals()['outg'].append(('    ' * tablevel) + 'pass')
        stack = []
        return [stack, tablevel]
    
    # Regex: /\$pop\([0-9]+\)/g
    pop_matches = re.finditer(r'\$pop\([0-9]+\)', e)
    pop_matches = [int(pop_match.group(0)[5:-1]) + 1 for pop_match in pop_matches]
    pop_matches.append(-1)
    cnt = max(pop_matches)
    
    data = []
    for index in range(cnt):
        if len(stack):
            data.append(stack.pop())
        else:
            data.append('__pop')
    
    out = e
    
    ############################################################################
    
    # Regex: /\$pop\([0-9]+\)/g
    def stage1_lbd(match):
        return data[int(match.group(0)[5:-1])]
    out = re.sub(r'(\$pop\([0-9]+\))', stage1_lbd, out)

    # Regex: /\$fun\([^\)]+\)/g
    def stage2_lbd(match):
        globals()['outg'].append(('    ' * tablevel) + 'def ' + match.group(0)[5:-1] + '(*args):')
        #######################################################################
        globals()['outg'].append(('    ' * (tablevel + 1)) + '# Error: Cannot determine function to call "{}".'.format(match.group(0)[5:-1]))
        globals()['outg'].append(('    ' * (tablevel + 1)) + 'pass')
        return match.group(0)[5:-1]
        #######################################################################
        decompile_text(globals()['grps'].get(match.group(0)[5:-1]), tablevel + 1)  # '__tfn_' + p
        return match.group(0)[5:-1]
    out = re.sub(r'(\$fun\([^\)]+\))', stage2_lbd, out)
    
    # Regex: /\$fst\([^,]+,[^\)]+\)/g
    def stage3_lbd(match):
        [ident, nm] = match.group(0)[5:-1].split(',')
        globals()['outg'].append(('    ' * tablevel) + 'def ' + nm + '(*args):')
        decompile_text(globals()['grps'].get(nm), tablevel + 1)  # '__tfn_' + p
        return '$nop'
    out = re.sub(r'(\$fst\([^,]+,[^\)]+\))', stage3_lbd, out)
    
    # Regex: /\$warp\([0-9]+\)/g
    def stage4_lbd(match):
        q = int(match.group(0)[6:-1])
        #######################################################################
        globals()['outg'].append(('    ' * tablevel) + '# Error: Cannot determine jump point from byte offset "{}".'.format(q))
        globals()['outg'].append(('    ' * tablevel) + 'pass')
        return '$nop'
        #######################################################################
        new_stk = []
        li = q
        while x[li][0] != 'btrue':
            xu = evalopwithstack(shadow, li, x, new_stk, 10)
            new_stk = xu[0]
            li += 1
        return new_stk[0]
    out = re.sub(r'(\$warp\([0-9]+\))', stage4_lbd, out)
    
    # Regex: /\$ign\([^\)]+\)/g
    def stage5_lbd(match):
        return ''
    out = re.sub(r'(\$ign\([^\)]+\))', stage5_lbd, out)
    
    ############################################################################
    
    if out == '$nop':
        return [stack, tablevel]
    
    tableveln = tablevel
    
    if out.endswith('{'):
        tableveln += 1
        out = out[0:-1].strip() + ':'
    
    if out.startswith('}'):
        tableveln -= 1
        if out != '}':
            tablevel -= 1
        out = out[1:].strip()
    
    if out.startswith('$push(') and out.endswith(')'):
        stack.append(out[6:-1])
    elif out.startswith('$psh2(') and out.endswith(')'):
        stack.append(out[6:-1])
        stack.append(out[6:-1])
    elif out == '$dup':
        if len(stack):
            x = stack.pop()
            stack.append(x)
            stack.append(x)
        #######################################################################
        else:
            globals()['outg'].append(('    ' * tablevel) + '# Error: Cannot duplicate stack element from empty stack.')
            globals()['outg'].append(('    ' * tablevel) + 'pass')
        #######################################################################
    elif out == '}':
        globals()['outg'].append(('    ' * tablevel) + stack.pop())
    elif out == '#':
        pass
    else:
        globals()['outg'].append(('    ' * tablevel) + out)
    
    tablevel = tableveln

    return [stack, tablevel]


def decompile_text(text, tlba=0):
    map_z = {}
    
    def x2_lbd(e, i):
        if e.startswith('\t'):
            return e.strip().split(' ', 1)
        else: 
            map_z[e[0:-1]] = str(int(i) + 1)
            return ['nop']

    x2 = text.split('\n')[1:]
    x2 = [x2_lbd(e, i) for e, i in zip(x2, range(len(x2)))]
    x2 = [[map_z.get(f, f) for f in e] for e in x2]
    
    x = x2

    decompilerShadow = [None] * len(x)

    # Regex: r'/(\$[0-9])/g'
    regex = re.compile(r'(\$[0-9])')
    for opidx in range(len(x)):
        op = x[opidx]
        if op[0] in opcode2data:
            decompilerShadow[opidx] = regex.sub(lambda match: op[int(match.group(0)[1:])], opcode2data.get(op[0]))

    # Strings.
    for opidx in range(len(x)):
        op = x[opidx]
        if op[0] == 'str':
            if len(op) == 1:
                decompilerShadow[opidx] = '$push()'
            else:
                decompilerShadow[opidx] = '$push(' + json.dumps(op[1], separators=(',', ':')) + ')'

    # Exceptions.
    for opidx in range(len(x)):
        #######################################################################
        break
        #######################################################################
        op = x[opidx]
        if op[0] == 'except.setup':
            current = int(op[1])
            decompilerShadow[opidx] = 'try {'
            decompilerShadow[opidx + current - 2] = '$push(__except)'
            decompilerShadow[opidx + current - 1] = '} except Exception as __except {'
            end_ptr = int(x[opidx + current - 2][1]) - 2
            while True:
                decompilerShadow[opidx + current + 5] = '$nop'
                offset = int(x[opidx + current + 5][1])
                for i in range(5):
                    decompilerShadow[opidx + offset + i] = '$nop'
                decompilerShadow[opidx + offset + 5] = '$psh2(__except)'
                current = int(x[opidx + current + 3][1])
                if current == end_ptr:
                    break
            decompilerShadow[opidx + end_ptr - 3] = '}'

    # Imports
    for opidx in range(len(x)):
        op = x[opidx]
        if op[0] == 'import.nm':
            nxop = x[opidx + 1]
            my_name = op[1]
            if nxop[0] == 'st.name':
                used_name = nxop[1]
                if used_name != my_name:
                    decompilerShadow[opidx] = 'import ' + my_name + ' as ' + used_name + ' $ign($pop(1))'
                else:
                    decompilerShadow[opidx] = 'import ' + my_name + ' $ign($pop(1))'
                decompilerShadow[opidx + 1] = '$nop'
            if nxop[0] == 'import.all':
                decompilerShadow[opidx] = 'from ' + my_name + ' import * $ign($pop(1))'
                decompilerShadow[opidx + 1] = '$nop'
            if nxop[0] == 'import.from':
                # We need to iterate, that's the only way.
                nxop_map = []
                i = opidx + 1
                while x[i][0] != 'pop':
                    mine = x[i][1]
                    theirs = x[i + 1][1]
                    if mine == theirs:
                        nxop_map.append(mine)
                    else:
                        nxop_map.append(mine + ' as ' + theirs)
                    decompilerShadow[i] = '$nop'
                    decompilerShadow[i + 1] = '$nop'
                    decompilerShadow[i + 2] = '$nop'
                    i += 2
                decompilerShadow[opidx] = 'from ' + my_name + ' import ' + ', '.join(nxop_map) + ' $ign($pop(1))'

    # While loops.
    for opidx in range(len(x)):
        op = x[opidx]
        if op[0] == 'jmp':
            #######################################################################
            continue
            #######################################################################
            tgop = int(op[1])
            i = int(op[1])
            while (i < len(x)) and (not x[i - 1][0] in branches):
                if x[i][0] == 'btrue':
                    tgop = i
                i = i + 1
            if (x[tgop]) and (x[tgop][0] == 'btrue'):
                decompilerShadow[opidx] = 'while $warp(' + op[1] + ') {'
                decompilerShadow[tgop] = '}'

    # For loops.
    for opidx in range(len(x)):
        op = x[opidx]
        if (op[0] == 'ld.iterstack') and (x[opidx + 1][0] == 'nop') and (x[opidx + 2][0] == 'for.iter') and (x[opidx + 3][0] == 'st.name'):
            decompilerShadow[opidx] = '$nop'
            decompilerShadow[opidx + 2] = '$nop'
            decompilerShadow[opidx + 3] = 'for ' + x[opidx + 3][1] + ' in $pop(0) {'
            decompilerShadow[int(x[opidx + 2][1]) - 2] = '}'

    # Functions call.
    for opidx in range(len(x)):
        op = x[opidx]
        if op[0] == 'mkfun':
            # Call: $push($pop(2)($pop(0), $pop(1)))
            decompilerShadow[opidx] = '$push($fun(' + op[1] + '))'
        if op[0] == 'mkfun.defargs':
            # Call: $push($pop(2)($pop(0), $pop(1)))
            decompilerShadow[opidx] = '$push($fun(' + op[1] + ')$ign($pop(0))'

    # Function store.
    for opidx in range(len(x)):
        op = x[opidx]
        if (op[0] == 'mkfun') and (x[opidx + 1][0] == 'st.name'):
            decompilerShadow[opidx] = '$fst(' + op[1] + ',' + x[opidx + 1][1] + ')'
            decompilerShadow[opidx + 1] = '$nop'

    # If statements.
    for opidx in range(len(x)):
        op = x[opidx]
        if (op[0] == 'bfalse') and (int(op[1]) > opidx):
            # if case op[1] this is actually a pop right after the if case to pop off the argument to bfalse.
            if x[int(op[1]) - 2][0] == 'jmp':
                decompilerShadow[opidx] = 'if $pop(0) {'
                decompilerShadow[int(op[1]) - 2] = '} else {'
                decompilerShadow[int(x[int(op[1]) - 2][1]) - 1] = '}#'
            else:
                decompilerShadow[opidx] = 'if $pop(0) {'
                decompilerShadow[int(op[1])] = '}'

    # Call function.
    for opidx in range(len(x)):
        #######################################################################
        break
        #######################################################################
        op = x[opidx]
        if (op[0] == 'call') or (op[0] == 'call.meth'):
            # Call: $push($pop(2)($pop(0), $pop(1)))
            args = ['$pop(' + str(i) + ')' for i in range(int(op[1]))]
            args.reverse()
            content = ', '.join(args)
            decompilerShadow[opidx] = '$push($pop(' + op[1] + ')(' + content + '))'

    for opidx in range(len(x)):
        op = x[opidx]
        if op[0] == 'tuple':
            # Call: $push($pop(2)($pop(0), $pop(1)))
            args = ['$pop(' + str(i) + ')' for i in range(int(op[1]))]
            args.reverse()
            content = ', '.join(args)
            # Original: decompilerShadow[opidx] = '$push((' + content + ',))'
            decompilerShadow[opidx] = '$push((' + content + '))'

    # Lists.
    for opidx in range(len(x)):
        op = x[opidx]
        if op[0] == 'list':
            # Call: $push($pop(2)($pop(0), $pop(1)))
            args = ['$pop(' + str(i) + ')' for i in range(int(op[1]))]
            args.reverse()
            content = ', '.join(args)
            decompilerShadow[opidx] = '$push([' + content + '])'

    stack = []
    tablevel = tlba
    for i in range(len(decompilerShadow)):
        o = evalopwithstack(decompilerShadow, i, x, stack, tablevel)
        stack = o[0]
        tablevel = o[1]


if __name__ == "__main__":
    print("Initialising decompiler...")
    
    print("Parsing arguments...")
    parser = argparse.ArgumentParser(description="Decompiles an already disassembled '.mpy' micropython script.")
    parser.add_argument("script_path", help="Disassembled script file name to decompile.")
    parser.add_argument("output_path", nargs='?', help="Output file to used for decompiled output.", default="")
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
    
    script_file = open(arguments.script_path, mode='r')
    script_contents = script_file.read()
    script_file.close()
    
    globals()['outg'] = []    
    globals()['grps'] = {}
    globals()['ids'] = []
    
    cur = '_'
    for line in script_contents.splitlines():
        if line.strip() == '':
            continue
        if (not line.startswith('.')) and (line.endswith(':')):
            # We are a function.
            cur = line[0:-1]
            globals()['grps'][cur] = ''
            globals()['ids'].append(cur)
        else:
            if cur in globals()['grps']:
                globals()['grps'][cur] = globals()['grps'].get(cur) + '\n' + line
            else:
                globals()['grps'][cur] = line
    
    decompile_text(globals()['grps'].get('<module>'), 0)
    
    if arguments.output_path != "":
        print("Writing output...")
        output_file = open(arguments.output_path, 'w') 
        output_file.write('\n'.join(globals()['outg']))
    else:
        print("Decompiled output...")
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print('\n'.join(globals()['outg']))
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    
    print("Finished.")
    
