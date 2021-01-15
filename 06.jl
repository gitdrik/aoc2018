using DataStructures
open("06.txt") do f
    coords = [(a,b) for (a,b) ∈ [parse.(Int, split(l,", ")) for l ∈ readlines(f)]]
    xlo, xhi = extrema([x for (x,_) ∈ coords])
    ylo, yhi = extrema([y for (_,y) ∈ coords])
    neighbours = DefaultDict{Tuple{Int,Int},Set{Tuple{Int,Int}}}(Set())
    rsize = 0
    for x ∈ xlo:xhi, y ∈ ylo:yhi
        dists = [sum(abs.((x,y).-c)) for c in coords]
        rsize += sum(dists) < 10000
        minima = findall(==(minimum(dists)), dists)
        length(minima) > 1 && continue
        push!(neighbours[coords[minima...]], (x,y))
    end
    infinite(c) = any(x ∈ [xlo, xhi] ||
                      y ∈ [ylo, yhi] for (x,y) in neighbours[c])
    finites = filter(c->!infinite(c), coords)
    println("Part 1: ", maximum(length.([neighbours[c] for c ∈ finites])))
    println("Part 2: ", rsize)
end
