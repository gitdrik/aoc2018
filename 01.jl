open("01.txt") do f
    ns = parse.(Int,readlines(f))
    println("Part 1: ", sum(ns))

    i, sm, sms = 1, 0, Set()
    while true
        sm += ns[i]
        sm ∈ sms && break
        push!(sms, sm)
        i = mod1(i+1, length(ns))
    end
    println("Part 2: ", sm)
end
