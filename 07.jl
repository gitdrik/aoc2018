using DataStructures
using OrderedCollections

open("07.txt") do f
    childs = DefaultDict{Char, Set{Char}}(Set())
    parents = DefaultDict{Char, Set{Char}}(Set())
    for ws in split.(eachline(f))
        push!(childs[ws[2][1]], ws[8][1])
        push!(parents[ws[8][1]], ws[2][1])
    end
    grandparent = pop!(setdiff(keys(childs), keys(parents)))
    grandchild = pop!(setdiff(keys(parents), keys(childs)))
    nexts = SortedSet{Char}([grandparent])
    dones = OrderedSet{Char}()
    while true
        next = pop!(nexts)
        push!(dones, next)
        next == grandchild && break
        for c ∈ childs[next]
            !all(p ∈ dones for p ∈ parents[c]) && continue
            push!(nexts, c)
        end
    end
    println("Part 1: ", join(dones))

    nexts = SortedSet{Char}([grandparent])
    dones = OrderedSet{Char}()
    ws = [[0,'@'],[0,'@'],[0,'@'],[0,'@'],[0,'@']]
    for t ∈ Iterators.countfrom(1)
        predones = Set{Char}()
        for i ∈ 1:5
            if ws[i][1]==0 && !isempty(nexts)
                c = pop!(nexts)
                ws[i] = [Int(c)-4, c]
            elseif ws[i][1]==1
                push!(predones, ws[i][2])
            end
            ws[i][1] = max(ws[i][1]-1, 0)
        end
        for d ∈ predones
            push!(dones, d)
            for c ∈ childs[d]
                !all(p ∈ dones for p ∈ parents[c]) && continue
                push!(nexts, c)
            end
        end
        if grandchild ∈ dones
            println("Part 2: ", t)
            break
        end
    end
end
