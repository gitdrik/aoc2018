open("10.txt") do f
    pos = Array{Int}(undef, 356, 2)
    vel = Array{Int}(undef, 356, 2)
    for (i, l) ∈ enumerate(eachline(f))
        pos[i,:] = parse.(Int, split(l[11:24], ','))
        vel[i,:] = parse.(Int, split(l[37:42], ','))
    end
    tzero = round(Int,[vel[:,1];vel[:,2]] \ [-pos[:,1];-pos[:,2]])
    message, minsize, tmin = [], typemax(Int), 0
    xrange, yrange = 0:0, 0:0
    for t ∈ tzero-10:tzero+10
        candidate = pos .+ vel .* t
        xmin, xmax = extrema(candidate[:,1])
        ymin, ymax = extrema(candidate[:,1])
        size = (xmax-xmin)*(ymax-ymin)
        if size < minsize
            minsize = size
            message = candidate
            tmin = t
            xrange, yrange = xmin:xmax, ymin:ymax
        end
    end
    mset = Set([message[i,:] for i ∈ axes(message,1)])
    println("Part 1:")
    for y ∈ yrange
        for x ∈ xrange
            print([x,y] ∈ mset ? '#' : '.')
        end
        println()
    end
    println("Part 2: ", tmin)
end
