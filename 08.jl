open("08.txt") do f
    ns = parse.(Int, split(readline(f)))

    function metasum(ns)
        nodes, metas = ns[1:2]
        ns = ns[3:end]
        ms = 0
        for _ ∈ 1:nodes
            s, ns = metasum(ns)
            ms += s
        end
        ms += sum(ns[1:metas])
        ns = ns[1+metas:end]
        return ms, ns
    end
    println("Part 1: ", metasum(ns)[1])

    function nodevalue(ns)
        nodes, metas = ns[1:2]
        ns = ns[3:end]
        vs = []
        for _ ∈ 1:nodes
            v, ns = nodevalue(ns)
            push!(vs, v)
        end
        if isempty(vs)
            value = sum(ns[1:metas])
        else
            value = 0
            for m ∈ ns[1:metas]
                m ∉ 1:length(vs) && continue
                value += vs[m]
            end
        end
        ns = ns[1+metas:end]
        return value, ns
    end
    println("Part 2: ", nodevalue(ns)[1])
end
