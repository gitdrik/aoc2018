open("20.txt") do f
    cs = readline(f)[2:end-1]
    map = Dict{Tuple{Int,Int},Set{Tuple{Int,Int}}}()
    dirs = Dict('N'=>(-1,0), 'E'=>(0,1), 'S'=>(1,0), 'W'=>(0,-1))
    cs = replace(cs, "|)"=>")")
    function makemap(cs, pos)
        for (i, c) ∈ enumerate(cs)
            if c ≠ '('
                npos = pos .+ dirs[c]
                pos ∉ keys(map) ? map[pos] = Set([npos]) : push!(map[pos], npos)
                npos ∉ keys(map) ? map[npos] = Set([pos]) : push!(map[npos], pos)
                pos = npos
            else
                forks, depth, start = [], 0, i+1
                for j ∈ i+1:length(cs)
                    depth += cs[j] == '('
                    if depth == 0
                        if cs[j] == '|'
                            push!(forks, start:j-1)
                            start = j+1
                        elseif cs[j] == ')'
                            push!(forks, start:j-1)
                            start = j+1
                            break
                        end
                    end
                    depth -= cs[j] == ')'
                end
                for f ∈ forks
                    makemap(SubString(cs, f)*SubString(cs, start, length(cs)), pos)
                end
                break
            end
        end
    end
    makemap(cs, (0, 0))

    seen, q, d = Dict{Tuple{Int, Int}, Int}((0,0)=>0), [(0,0,0)], 0
    while !isempty(q)
        (x, y, d) = popfirst!(q)
        for p ∈ map[(x,y)]
            if p ∉ keys(seen)
                seen[p] = d + 1
                push!(q, (p..., d + 1))
            end
        end
    end
    println("Part 1: ", d)
    println("Part 2: ", sum(values(seen).>999))
end
