open("01.txt") do f
    ns = parse.(Int,readlines(f))
    println("Part 1: ", sum(ns))

    i, sm, sms = 1, 0, Set()
    while sm ∉ sms
        push!(sms, sm)
        sm += ns[i]
        i = mod1(i+1, length(ns))
    end
    println("Part 2: ", sm)
end
