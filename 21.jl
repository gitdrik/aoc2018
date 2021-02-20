function twentyone(p1)
    r4, oldr4, r4s = 0, 0, Set{Int}()
    while true
        r3 = r4 | 65536
        r4 = 10283511
        while true
            r4 += r3 & 255
            r4 &= 16777215
            r4 *= 65899
            r4 &= 16777215
            r3 < 256 && break
            r3 = r3 ÷ 256
        end
        p1 && return r4
        r4 ∈ r4s && return oldr4
        oldr4 = r4
        push!(r4s, r4)
    end
end
println("Part 1: ", twentyone(true))
println("Part 2: ", twentyone(false))
