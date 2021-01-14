open("03.txt") do f
    fabric = zeros(Int, 1000, 1000)
    claims = []
    for l ∈ eachline(f)
        ss = split(split(l,"@ ")[2], ": ")
        x, y = parse.(Int, split(ss[1], ","))
        w, h = parse.(Int, split(ss[2], "x"))
        claim = (x+1:x+w, y+1:y+h)
        fabric[claim...] .+= 1
        push!(claims, claim)
    end
    println("Part 1: ", sum(fabric .> 1))
    println("Part 2: ", findfirst(claim->all(fabric[claim...] .== 1), claims))
end
