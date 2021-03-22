open("25.txt") do f
    P = split.(readlines(f), ',') .|> p -> parse.(Int, p)
    C = []
    for p ∈ P
        cs = []
        for (i, c) ∈ enumerate(C)
            for s ∈ c
                sum(abs.(p .- s)) > 3 && continue
                push!(cs, i)
                break
            end
        end
        if cs ≠ []
            push!(C[cs[1]], p)
            push!(C, vcat(C[cs]...))
            deleteat!(C, cs)
        else
            push!(C, [p])
        end
    end
    println("Day 25: ", length(C))
end
