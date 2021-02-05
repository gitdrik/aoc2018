open("16.txt") do f
    ls = readlines(f)
    befs, cmds, afts = [], [], []
    for l in ls[1:3130]
        isempty(l) && continue
        if l[1] ∈ '0':'9'
            push!(cmds, [parse(Int, s) for s in split(l)])
        elseif l[1:9]=="Before: ["
            push!(befs, [parse(Int, s) for s in split(l[10:19], ',')])
        elseif l[1:9]=="After:  ["
            push!(afts, [parse(Int, s) for s in split(l[10:19], ',')])
        end
    end

    function op(c, r, expr)
        regs = copy(r)
        regs[c+1] = expr
        return regs
    end
    ops = [(a, b, c, r) -> op(c, r, r[a+1] + r[b+1]),
           (a, b, c, r) -> op(c, r, r[a+1] + b),
           (a, b, c, r) -> op(c, r, r[a+1] * r[b+1]),
           (a, b, c, r) -> op(c, r, r[a+1] * b),
           (a, b, c, r) -> op(c, r, r[a+1] & r[b+1]),
           (a, b, c, r) -> op(c, r, r[a+1] & b),
           (a, b, c, r) -> op(c, r, r[a+1] | r[b+1]),
           (a, b, c, r) -> op(c, r, r[a+1] | b),
           (a, b, c, r) -> op(c, r, r[a+1]),
           (a, b, c, r) -> op(c, r, a),
           (a, b, c, r) -> op(c, r, a > r[b+1]),
           (a, b, c, r) -> op(c, r, r[a+1] > b),
           (a, b, c, r) -> op(c, r, r[a+1] > r[b+1]),
           (a, b, c, r) -> op(c, r, a==r[b+1]),
           (a, b, c, r) -> op(c, r, r[a+1]==b),
           (a, b, c, r) -> op(c, r, r[a+1]==r[b+1])]

    opmatch(bef, cmd, aft, ops) = [f(cmd[2], cmd[3], cmd[4], bef)==aft for f ∈ ops]
    opmatches = [opmatch(b, c, a, ops) for (b, c, a) ∈ zip(befs, cmds, afts)]
    println("Part 1: ", sum(sum.(opmatches) .≥ 3))

    fdict, i = Dict{Int,Int}(), 0
    while true
        i = mod1(i+1, length(cmds))
        unmatched = setdiff(findall(opmatches[i]), values(fdict))
        length(unmatched) ≠ 1 && continue
        fdict[cmds[i][1]] = unmatched[1]
        length(fdict)==16 && break
    end
    cmds = [parse.(Int, split(l)) for l ∈ ls[3131:end]]
    regs = zeros(Int, 4)
    for c ∈ cmds
        regs = ops[fdict[c[1]]](c[2], c[3], c[4], regs)
    end
    println("Part 2: ", regs[1])
end
