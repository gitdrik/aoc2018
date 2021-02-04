open("16.txt") do f
    ls = readlines(f)
    befores, cmds, afters = [], [], []
    for l in ls[1:3130]
        isempty(l) && continue
        if l[1] ∈ '0':'9'
            push!(cmds, [parse(Int, s) for s in split(l)])
        elseif l[1:9]=="Before: ["
            push!(befores, [parse(Int, s) for s in split(l[10:19], ',')])
        elseif l[1:9]=="After:  ["
            push!(afters, [parse(Int, s) for s in split(l[10:19], ',')])
        end
    end

    function addr(a, b, c, r)
        regs = copy(r)
        regs[c+1] = regs[a+1] + regs[b+1]
        return regs
    end
    function addi(a, b, c, r)
        regs = copy(r)
        regs[c+1] = regs[a+1] + b
        return regs
    end
    function mulr(a, b, c, r)
        regs = copy(r)
        regs[c+1] = regs[a+1] * regs[b+1]
        return regs
    end
    function muli(a, b, c, r)
        regs = copy(r)
        regs[c+1] = regs[a+1] * b
        return regs
    end
    function banr(a, b, c, r)
        regs = copy(r)
        regs[c+1] = regs[a+1] & regs[b+1]
        return regs
    end
    function bani(a, b, c, r)
        regs = copy(r)
        regs[c+1] = regs[a+1] & b
        return regs
    end
    function borr(a, b, c, r)
        regs = copy(r)
        regs[c+1] = regs[a+1] | regs[b+1]
        return regs
    end
    function bori(a, b, c, r)
        regs = copy(r)
        regs[c+1] = regs[a+1] | b
        return regs
    end
    function setr(a, b, c, r)
        regs = copy(r)
        regs[c+1] = regs[a+1]
        return regs
    end
    function seti(a, b, c, r)
        regs = copy(r)
        regs[c+1] = a
        return regs
    end
    function gtir(a, b, c, r)
        regs = copy(r)
        regs[c+1] = a > regs[b+1]
        return regs
    end
    function gtri(a, b, c, r)
        regs = copy(r)
        regs[c+1] = regs[a+1] > b
        return regs
    end
    function gtrr(a, b, c, r)
        regs = copy(r)
        regs[c+1] = regs[a+1] > regs[b+1]
        return regs
    end
    function eqir(a, b, c, r)
        regs = copy(r)
        regs[c+1] = a==regs[b+1]
        return regs
    end
    function eqri(a, b, c, r)
        regs = copy(r)
        regs[c+1] = regs[a+1]==b
        return regs
    end
    function eqrr(a, b, c, r)
        regs = copy(r)
        regs[c+1] = regs[a+1]==regs[b+1]
        return regs
    end

    funcs = [addr, addi, mulr, muli, banr, bani, borr, bori, setr, seti, gtir, gtri, gtrr, eqir, eqri, eqrr]
    fcomp(before, cmd, after, funcs) = [f(cmd[2],cmd[3],cmd[4],before)==after for f ∈ funcs]
    threeormore = sum([sum(fcomp(befores[i], cmds[i], afters[i], funcs)) ≥ 3  for i ∈ 1:length(cmds)])
    println("Part 1: ", threeormore)

    fdict, i = Dict{Int,Int}(), 1
    while true
        c = fcomp(befores[i], cmds[i], afters[i], funcs)
        founds = findall(c)
        unfounds = setdiff(founds, values(fdict))
        if length(unfounds)==1
            fdict[cmds[i][1]] = unfounds[1]
            length(fdict)==16 && break
        end
        i = mod1(i+1, length(cmds))
    end
    pgm = [parse.(Int, split(l)) for l ∈ ls[3131:end]]
    regs = zeros(Int, 4)
    for p ∈ pgm
        regs = funcs[fdict[p[1]]](p[2], p[3], p[4], regs)
    end
    println("Part 2: ", regs[1])
end
