open("23.txt") do f
    bots, dists = [], []
    for l in eachline(f)
        ps, rs = split(l, ">, r=")
        r = parse(Int, rs)
        x, y, z = parse.(Int, split(ps[6:end], ','))
        push!(bots, (r, x, y, z))
        d = sum(abs.([x, y, z]))
        push!(dists, d-r:d+r)
    end
    bmax = maximum(bots)
    n = sum([sum(abs.(bmax[2:4].-b[2:4])) ≤ bmax[1] for b ∈ bots])
    println("Part 1: ", n)

    intersections = [Set{Int}() for _ ∈ eachindex(bots)]
    for i ∈ 1:length(bots), j ∈ i:length(bots)
        if sum(abs.(bots[i][2:4].-bots[j][2:4])) ≤ bots[i][1]+bots[j][1]
            push!(intersections[i], j)
            push!(intersections[j], i)
        end
    end
    # remove outliers; remaining signal radii all intersect
    dists = dists[length.(intersections).>900]
    println("Part 2: ", minimum(∩(dists...)))
end

#=  # Alternative ending.
    # Slow walk from zero towards weighted average of invisibles
    # after removing outlers. About 100 times slower, but worked.
    bots = bots[length.(intersections).>900]
    pos = [0,0,0]
    while true
        invisible, divisor, avgdist = 0, 0, [0, 0, 0]
        for b ∈ bots
            delta = b[2:4].-pos
            if sum(abs.(delta)) > b[1]
                invisible += 1
                avgdist += delta./b[1]
                divisor += 1/b[1]
            end
        end
        invisible == 0 && break
        pos += round.(Int, invisible * 1e-7 .* avgdist ./ divisor)
    end
    println("Part 2: ", sum(pos), " @ ", pos)
end  =#
