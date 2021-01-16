open("08.txt") do f
    ns = parse.(Int, split(readline(f)))
    ns2 = deepcopy(ns)

    function metasum!(ns)
        nodes, metas = [popfirst!(ns) for _ ∈ 1:2]
        ms = 0
        for _ ∈ 1:nodes
            ms += metasum!(ns)
        end
        ms += sum([popfirst!(ns) for _ ∈ 1:metas])
        return ms
    end
    println("Part 1: ", metasum!(ns))

    function nodevalue!(ns)
        nodes, metas = [popfirst!(ns) for _ ∈ 1:2]
        vs = []
        for _ ∈ 1:nodes
            push!(vs, nodevalue!(ns))
        end
        if isempty(vs)
            value = sum([popfirst!(ns) for _ ∈ 1:metas])
        else
            value = 0
            for m ∈ [popfirst!(ns) for _ ∈ 1:metas]
                m ∉ axes(vs,1) && continue
                value += vs[m]
            end
        end
        return value
    end
    println("Part 2: ", nodevalue!(ns2))
end
