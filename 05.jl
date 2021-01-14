open("05.txt") do f
    m = [c for c ∈ readline(f)]
    function react(m)
        notready = true
        while notready
            keep = Array{Int,1}([])
            i = 1
            notready = false
            while i ≤ length(m)
                if i < length(m) && abs(m[i]-m[i+1]) == 32
                    i += 2
                    notready = true
                    continue
                end
                push!(keep, i)
                i += 1
            end
            m = m[keep]
        end
        return length(m)
    end
    println("Part 1: ", react(m))

    minl = typemax(Int)
    for c ∈ 'a':'z'
        l = filter(a-> a ≠ c && a ≠ c-32, m) |> react
        minl = min(minl, l)
    end
    println("Part 2: ", minl)
end
