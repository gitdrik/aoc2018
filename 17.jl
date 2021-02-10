open("17.txt") do f
    clay = Set{Tuple{Int,Int}}()
    for l in eachline(f)
        s1, s2 = split(l, ", ")
        n = parse(Int, s1[3:end])
        r1, r2 = parse.(Int, split(s2[3:end], ".."))
        if l[1]=='y'
            push!(clay, [(x, n) for x ∈ r1:r2]...)
        else
            push!(clay, [(n, y) for y ∈ r1:r2]...)
        end
    end
    stillwater = Set{Tuple{Int,Int}}()
    flowwater = Set{Tuple{Int,Int}}()
    ymin, ymax = extrema([p[2] for p ∈ clay])
    function fillstillwater(x, y)
        xl, xr = x, x
        while (xl, y) ∉ clay
            (xl, y+1) ∉ stillwater ∪ clay && return false
            xl -=1
        end
        while (xr, y) ∉ clay
            (xr, y+1) ∉ stillwater ∪ clay && return false
            xr +=1
        end
        push!(stillwater, [(n, y) for n ∈ xl+1:xr-1]...)
        return true
    end
    function fill(x, y)
        ((x, y) ∈ flowwater ∪ stillwater ∪ clay || y > ymax) && return
        push!(flowwater, (x, y))
        fill(x, y+1)
        fillstillwater(x,y) && return
        if (x, y+1) ∈ stillwater ∪ clay
            fill(x-1, y)
            fill(x+1, y)
        end
    end
    fill(500, ymin)
    println("Part 1: ", length(stillwater ∪ flowwater))
    println("Part 2: ", length(stillwater))
end
