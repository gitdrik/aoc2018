open("03.txt") do f
    fabric = zeros(Int, 1000, 1000)
    claims = []
    for l ∈ eachline(f)
        ss = split(split(l,"@ ")[2], ": ")
        x, y = parse.(Int, split(ss[1], ","))
        b, h = parse.(Int, split(ss[2], "x"))
        fabric[x+1:x+b, y+1:y+h] .+= 1
        push!(claims, (x,y,b,h))
    end
    println("Part 1: ", sum(fabric .> 1))

    for (i, (x,y,b,h)) ∈ enumerate(claims)
        if all(fabric[x+1:x+b, y+1:y+h].== 1)
            println("Part 2: ", i)
            break
        end
    end
end
