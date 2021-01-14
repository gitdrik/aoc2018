open("03.txt") do f
    fabric = zeros(Int, 1000, 1000)
    claims = []
    for l ∈ eachline(f)
        ss = split(split(l,"@ ")[2], ": ")
        x, y = parse.(Int, split(ss[1], ","))
        b, h = parse.(Int, split(ss[2], "x"))
        xr, yr = x+1:x+b, y+1:y+h
        fabric[xr, yr] .+= 1
        push!(claims, (xr, yr))
    end
    println("Part 1: ", sum(fabric .> 1))

    println("Part 2: ", findfirst(c->all(fabric[c...] .== 1), claims))
#    for (i, c) ∈ enumerate(claims)
#        if all(fabric[c...] .== 1)
#            println("Part 2: ", i)
#            break
#        end
#    end
end
