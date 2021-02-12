open("19.txt") do f
    ip  = parse(Int, split(readline(f))[2])
    pgm = [[s[1:1];parse.(Int, s[2:4])] for s ∈ split.(readlines(f))]

    function op(c, r, expr)
        regs = copy(r)
        regs[c+1] = expr
        return regs
    end
    ops = Dict("addr" => (a, b, c, r) -> op(c, r, r[a+1] + r[b+1]),
               "addi" => (a, b, c, r) -> op(c, r, r[a+1] + b),
               "mulr" => (a, b, c, r) -> op(c, r, r[a+1] * r[b+1]),
               "muli" => (a, b, c, r) -> op(c, r, r[a+1] * b),
               "banr" => (a, b, c, r) -> op(c, r, r[a+1] & r[b+1]),
               "bani" => (a, b, c, r) -> op(c, r, r[a+1] & b),
               "borr" => (a, b, c, r) -> op(c, r, r[a+1] | r[b+1]),
               "bori" => (a, b, c, r) -> op(c, r, r[a+1] | b),
               "setr" => (a, b, c, r) -> op(c, r, r[a+1]),
               "seti" => (a, b, c, r) -> op(c, r, a),
               "gtir" => (a, b, c, r) -> op(c, r, a > r[b+1]),
               "gtri" => (a, b, c, r) -> op(c, r, r[a+1] > b),
               "gtrr" => (a, b, c, r) -> op(c, r, r[a+1] > r[b+1]),
               "eqir" => (a, b, c, r) -> op(c, r, a==r[b+1]),
               "eqri" => (a, b, c, r) -> op(c, r, r[a+1]==b),
               "eqrr" => (a, b, c, r) -> op(c, r, r[a+1]==r[b+1]))

    i, regs = 0, zeros(Int, 6)
    #i, regs = 0, [1, 0, 0, 0, 0, 0]
    while (i+1) ∈ eachindex(pgm)
        regs[ip+1] = i
        (cmd, a, b, c) = pgm[i+1]
        regs = ops[cmd](a, b, c, regs)
        i = regs[ip+1] + 1
        #println(regs)
        #sleep(0.3)
    end
    println("Part 1: ", regs[1])
    # Studies of part 1 and 2 while executing gave:
    println("Part 2: ", Int(1.5 * (10551326+2)))
end
