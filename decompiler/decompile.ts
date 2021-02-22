// <module>: ; test.py
// 	MP_BC_LOAD_FAST_N 38, 36, 0
// 	true ; $push(True)
// 	st.name fancy ; fancy = $pop(0);
// 	loadname fancy ; $push(fancy);
// 	bfalse .L36 ; if $pop(0) {
// 	true ; $push(True)
// 	st.name x ; x = $pop(0)
// 	loadname print ; $push(print)
// 	str asdf ; $push("asdf")
// 	loadname x ; $push(x)
// 	call 2 ; $push($pop(2)($pop(0), $pop(1)))
// .L36: ; }
// 	pop ; $afterbrpop()
// 	none ; $push(None)

import { readFileSync } from 'fs'
type fmt = string[][]

function evalopwithstack(shadow: string[], i: number, x: fmt, stack: string[], tablevel: number): { stack: string[]; tablevel: number } {
	let e = shadow[i]
	if (e == null) {
		for (let e of stack) {
			console.log('    '.repeat(tablevel) + '$push(' + e + ')')
		}
		stack = []
		console.log('    '.repeat(tablevel) + 'BROKEN_OP`' + x[i].join(' ') + '`')
	} else {
		let cnt = Math.max(-1, ...(e.match(/\$pop\([0-9]+\)/g) || []).map(e => +e.slice(5, -1))) + 1
		let data = []
		for (let i = 0; i < cnt; i++) {
			if (stack.length) {
				data.push(stack.pop())
			} else {
				data.push('__pop')
			}
		}
		let out = e
			.replaceAll(/\$pop\([0-9]+\)/g, p => data[p.slice(5, -1)])
			.replaceAll(/\$fun\([^\)]+\)/g, p => {
//				// Quick fix to get decompiling to finish.
//				console.log('    '.repeat(tablevel) + 'def ' + p.slice(5, -1) + '(*args):')
//				decompile_text(grps.get(p.slice(5, -1)), tablevel + 1) // '__tfn_' + p
				return p.slice(5, -1)
			})
			.replaceAll(/\$fst\([^,]+,[^\)]+\)/g, p => {
				let [id, nm] = p.slice(5, -1).split(',')
				console.log('    '.repeat(tablevel) + 'def ' + nm + '(*args):')
				decompile_text(grps.get(nm), tablevel + 1) // '__tfn_' + p
				return '$nop'
			})
			.replaceAll(/\$warp\([0-9]+\)/g, p => {
				let q = +p.slice(6, -1)
				//evalopwithstack
				// (shadow: string[], i: number, x: fmt, stack: string[], tablevel: number)
				let new_stk = []
				for (let li = q; x[li][0] != 'btrue'; li++) {
					let xu = evalopwithstack(shadow, li, x, new_stk, 10)
					new_stk = xu.stack
				}
				return new_stk[0]
			})
			.replaceAll(/\$ign\([^\)]+\)/g, '')
		if (out == '$nop') return { stack, tablevel }
		let tableveln = tablevel
		if (out.endsWith('{')) {
			tableveln++
			out = out.slice(0, -1).trim() + ':'
		}
		if (out.startsWith('}')) {
			tableveln--
			if (out != '}') tablevel--
			out = out.slice(1).trim()
		}
		if (out.startsWith('$push(') && out.endsWith(')')) {
			stack.push(out.slice(6, -1))
		} else if (out.startsWith('$psh2(') && out.endsWith(')')) {
			stack.push(out.slice(6, -1))
			stack.push(out.slice(6, -1))
		} else if (out == '$dup') {
			let x = stack.pop()
			stack.push(x)
			stack.push(x)
		} else if (out == '}') {
			console.log('    '.repeat(tablevel) + stack.pop())
		} else if (out == '#') {
		} else {
			console.log('    '.repeat(tablevel) + out)
		}
		tablevel = tableveln
	}
	return { stack, tablevel }
}

// 	ret ; return $pop()
let grps = new Map<string, string>()
let ids = []
function decompile_text(text: string, tlba: number = 0) {
	let map_z = new Map<string, string>()
	let x2: fmt = text
		.split('\n')
		.slice(1)
		.map((e, i) => (e.startsWith('\t') ? e.trim().split(' ') : (map_z.set(e.slice(0, -1), (+i + 1).toString()), ['nop'])))
		.map(e => e.map(f => map_z.get(f) || f))

	let x: fmt = x2
	let decompilerShadow: (string | null)[] = x.map(_ => null)
	let branches = ['btrue', 'bfalse', 'btrue.pop', 'bfalse.pop', 'jmp.unwind', 'jmp', 'for.iter']

	let opcode2data = new Map(
		Object.entries({
			true: '$push(True)',
			false: '$push(False)',
			pop: '$pop(0)',
			none: '$push(None)',
			ret: 'return $pop(0)',
			'st.name': '$1 = $pop(0)',
			loadname: '$push($1)',
			glbl: '$push($1)',
			int: '$push($1)',
			deref: '$push(args[$1])',
			'st.deref': 'args[$1] = $pop(0)',

			'ldloc.0': '$push(args[0])',
			'ldloc.1': '$push(args[1])',
			'ldloc.2': '$push(args[2])',
			'ldloc.3': '$push(args[3])',
			'ldloc.4': '$push(args[4])',
			'ldloc.5': '$push(args[5])',
			'ldloc.6': '$push(args[6])',
			'ldloc.7': '$push(args[7])',
			'ldloc.8': '$push(args[8])',
			'ldloc.9': '$push(args[9])',
			'ldloc.10': '$push(args[10])',

			'stloc.0': 'args[0] = $pop(0)',
			'stloc.1': 'args[1] = $pop(0)',
			'stloc.2': 'args[2] = $pop(0)',
			'stloc.3': 'args[3] = $pop(0)',
			'stloc.4': 'args[4] = $pop(0)',
			'stloc.5': 'args[5] = $pop(0)',
			'stloc.6': 'args[6] = $pop(0)',
			'stloc.7': 'args[7] = $pop(0)',
			'stloc.8': 'args[8] = $pop(0)',
			'stloc.9': 'args[9] = $pop(0)',
			'stloc.10': 'args[10] = $pop(0)',

			add: '$push($pop(1) + $pop(0))',
			lt: '$push($pop(1) < $pop(0))',
			'sub.in': '$push($pop(1) - $pop(0))',

			raiseobj: 'raise $pop(0)',
			'del.name': 'del $1',
			nop: '$nop',
			buildclass: '$push(__build_class__)',
			'st.attr': '$pop(0).$1 = $pop(1)',
			attr: '$push($pop(0).$1)',
			method: '$push($pop(0).$1)',
			null: 'null',
			'ld.arrsub': '$push($pop(1)[$pop(0)])',
			is: '$push($pop(1) is $pop(0))',
			ematch: '$push($pop(1) is $pop(0))',
			not: `$push(not $pop(0))`,
			dup: `$dup`,
		})
	)
	for (let opidx in x) {
		let op = x[opidx]
		if (opcode2data.has(op[0])) {
			decompilerShadow[opidx] = opcode2data.get(op[0]).replace(/\$[0-9]/g, p => op[p.slice(1)])
		}
	}

	for (let opidx in x) {
		let op = x[opidx]
		if (op[0] == 'str') {
			// if case
			// op[1]
			decompilerShadow[opidx] = `$push(${JSON.stringify(op[1])})`
		}
	}

//	for (let opidx in x) {
//		let op = x[opidx]
//		if (op[0] == 'except.setup') {
//			let current = +op[1]
//			decompilerShadow[opidx] = 'try {'
//			decompilerShadow[current - 2] = `$push(__except)`
//			decompilerShadow[current - 1] = `} except Exception as __except {`
//			let end_ptr = +x[current - 2][1] - 2
//			do {
//				decompilerShadow[current + 5] = `$nop`
//				let offset = +x[current + 5][1]
//				for (let i = 0; i < 5; i++) decompilerShadow[offset + i] = '$nop'
//				decompilerShadow[offset + 5] = '$psh2(__except)'
//				current = +x[current + 3][1]
//			} while (current != end_ptr)
//			decompilerShadow[end_ptr - 3] = '}'
//		}
//	}

	for (let opidx in x) {
		let op = x[opidx]
		let nxop = x[1 + +opidx]
		if (op[0] == 'import.nm') {
			let my_name = op[1]
			if (nxop[0] == 'st.name') {
				decompilerShadow[1 + +opidx] = `$nop`
				let used_name = nxop[1]
				if (used_name != my_name) {
					decompilerShadow[+opidx] = `import ${my_name} as ${used_name} $ign($pop(1))`
				} else {
					decompilerShadow[+opidx] = `import ${my_name} $ign($pop(1))`
				}
			}
			if (nxop[0] == 'import.all') {
				decompilerShadow[1 + +opidx] = `$nop`
				decompilerShadow[+opidx] = `from ${my_name} import * $ign($pop(1))`
			}
			if (nxop[0] == 'import.from') {
				// we need to iterate :(
				// that's the only way.
				let map = []
				for (let i = +opidx + 1; x[i][0] != 'pop'; i += 2, decompilerShadow[i] = '$nop') {
					let [mine, theirs] = [x[i][1], x[i + 1][1]]
					if (mine == theirs) {
						map.push(mine)
					} else {
						map.push(`${mine} as ${theirs}`)
					}
					decompilerShadow[i] = `$nop`
					decompilerShadow[i + 1] = `$nop`
				}
				decompilerShadow[opidx] = `from ${my_name} import ${map.join(', ')} $ign($pop(1))`
			}
		}
	}
	// while-loop
	for (let opidx in x) {
		let op = x[opidx]
		if (op[0] == 'jmp') {
			let tgop = +op[1]
			for (let i = +op[1]; i < x.length && !branches.includes(x[i - 1][0]); i++) {
				if (x[i][0] == 'btrue') {
					tgop = i
				}
			}
			if (x[tgop] && x[tgop][0] == 'btrue') {
				decompilerShadow[opidx] = `while $warp(${op[1]}) {`
				decompilerShadow[tgop] = '}'
			}
		}
	}
	// for-loop
	for (let opidx in x) {
		let op = x[opidx]
		if (op[0] == 'ld.iterstack' && x[+opidx + 2][0] == 'for.iter' && x[+opidx + 1][0] == 'nop' && x[+opidx + 3][0] == 'st.name') {
			decompilerShadow[opidx] = '$nop'
			decompilerShadow[+opidx + 2] = '$nop'
			decompilerShadow[+opidx + 3] = `for ${x[+opidx + 3][1]} in $pop(0) {`
			decompilerShadow[+x[+opidx + 2][1] - 2] = '}'
			// we land insn after }
			// on the jmp
		}
	}
	// fun-norm
	for (let opidx in x) {
		let op = x[opidx]
		if (op[0] == 'mkfun') {
			// call
			// $push($pop(2)($pop(0), $pop(1)))
			decompilerShadow[opidx] = `$push($fun(${op[1]}))`
		}
		if (op[0] == 'mkfun.defargs') {
			// call
			// $push($pop(2)($pop(0), $pop(1)))
			decompilerShadow[opidx] = `$push($fun(${op[1]})$ign($pop(0))`
		}
	}
	// fun-store
	for (let opidx in x) {
		let op = x[opidx]
		if (op[0] == 'mkfun' && x[1 + +opidx][0] == 'st.name') {
			decompilerShadow[+opidx] = `$fst(${op[1]},${x[1 + +opidx][1]})`
			decompilerShadow[+opidx + 1] = `$nop`
		}
	}
	for (let opidx in x) {
		let op = x[opidx]
		if (op[0] == 'bfalse' && +op[1] > +opidx) {
			// if case
			// op[1]
			// this is actually a pop right after the if case to pop off the argument to bfalse.
			if (x[+op[1] - 2][0] == 'jmp') {
				decompilerShadow[opidx] = 'if $pop(0) {'
				decompilerShadow[+op[1] - 2] = '} else {'
				decompilerShadow[+x[+op[1] - 2][1] - 1] = '}#'
			} else {
				decompilerShadow[opidx] = 'if $pop(0) {'
				decompilerShadow[+op[1]] = '}'
			}
		}
	}

	for (let opidx in x) {
		let op = x[opidx]
		if (op[0] == 'call' || op[0] == 'call.meth') {
			// call
			// $push($pop(2)($pop(0), $pop(1)))
			decompilerShadow[opidx] = `$push($pop(${op[1]})(${' '
				.repeat(+op[1])
				.split('')
				.map((_, i) => `$pop(${i})`)
				.reverse()
				.join(', ')}))`
		}
	}
	for (let opidx in x) {
		let op = x[opidx]
		if (op[0] == 'tuple') {
			// call
			// $push($pop(2)($pop(0), $pop(1)))
			decompilerShadow[opidx] = `$push((${' '
				.repeat(+op[1])
				.split('')
				.map((_, i) => `$pop(${i})`)
				.reverse()
				.join(', ')},))`
		}
	}
	for (let opidx in x) {
		let op = x[opidx]
		if (op[0] == 'list') {
			// call
			// $push($pop(2)($pop(0), $pop(1)))
			decompilerShadow[opidx] = `$push([${' '
				.repeat(+op[1])
				.split('')
				.map((_, i) => `$pop(${i})`)
				.reverse()
				.join(', ')}])`
		}
	}

	let stack = []
	let i = -1
	let tablevel = tlba
	for (let _e of decompilerShadow) {
		i++
		let o = evalopwithstack(decompilerShadow, i, x, stack, tablevel)
		stack = o.stack
		tablevel = o.tablevel
	}
}

let totalinput = readFileSync(process.argv[2]).toString()
let cur: string = '_'
for (let l of totalinput.split('\n')) {
	if (l.trim() == '') continue
	if (!l.startsWith('.') && l.endsWith(':')) {
		// we are an fn
		grps.set(l.slice(0, -1), '')
		cur = l.slice(0, -1)
		ids.push(cur)
	} else {
		grps.set(cur, grps.get(cur) + '\n' + l)
	}
}
decompile_text(grps.get('<module>'), 0)
