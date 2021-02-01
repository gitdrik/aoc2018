open("15.txt") do f
    cave = [[c for c ∈ l] for l ∈ eachline(f)]
    es = Dict{Tuple{Int,Int}, Int}()
    gs = Dict{Tuple{Int,Int}, Int}()
    for (i, l) ∈ enumerate(cave), (j, c) ∈ enumerate(l)
        if c=='E'
            es[(i, j)] = 200
        elseif c=='G'
            gs[(i, j)] = 200
        end
    end
    oes, ogs = deepcopy(es), deepcopy(gs)
    adj(p) = [p.-(1, 0), p.-(0, 1), p.+(0, 1), p.+(1, 0)]

    function move(me, friends, foes, cave)
        length(setdiff(adj(me), keys(foes))) < 4 && return me, friends
        hp = pop!(friends, me)
        seen, q = Set([me]), [(me...,[])]
        while !isempty(q)
            (i, j, prev) = popfirst!(q)
            (i, j) ∈ keys(foes) && return prev[2], push!(friends, prev[2] => hp)
            for (k, l) ∈ adj((i, j))
                ((k,l) ∈ seen || cave[k][l]=='#' || (k, l) ∈ keys(friends)) && continue
                push!(seen, (k, l))
                push!(q, (k, l, [prev; [(i,j)]]))
            end
        end
        return me, push!(friends, me=>hp)
    end

    function attack(me, foes, players, power)
        fs = sort([(hp, i, j) for (i,j) ∈ adj(me) if (i,j)∈keys(foes) for hp∈foes[(i,j)]])
        isempty(fs) && return players, foes
        (hp, i, j) = fs[1]
        if hp > power
            foes[(i, j)] = hp-power
        else
            delete!(foes, (i, j))
            players = setdiff(players, [(i,j)])
        end
        return players, foes
    end

    function play(es, gs, cave)
        turns = 0
        while !isempty(gs) && !isempty(es)
            players = sort(collect(keys(es) ∪ keys(gs)))
            fullturn = true
            while !isempty(players)
                p = popfirst!(players)
                if (isempty(gs) || isempty(es))
                    fullturn = false
                    break
                end
                if p ∈ keys(es)
                    p, es = move(p, es, gs, cave)
                    players, gs = attack(p, gs, players, 3)
                elseif p ∈ keys(gs)
                    p, gs = move(p, gs, es, cave)
                    players, es = attack(p, es, players, 3)
                end
            end
            turns += fullturn
        end
        return turns * (sum(values(gs)) + sum(values(es)))
    end
    println("Part 1: ", play(es, gs, cave))

    function play2(es, gs, cave)
        for elfpower ∈ Iterators.countfrom(4)
            turns = 0
            while !isempty(gs) && !isempty(es)
                players = sort(collect(keys(es) ∪ keys(gs)))
                fullturn = true
                while !isempty(players)
                    if (isempty(gs) || isempty(es))
                        fullturn = false
                        break
                    end
                    p = popfirst!(players)
                    if p ∈ keys(es)
                        p, es = move(p, es, gs, cave)
                        players, gs = attack(p, gs, players, elfpower)
                    elseif p ∈ keys(gs)
                        p, gs = move(p, gs, es, cave)
                        players, es = attack(p, es, players, 3)
                    end
                end
                turns += fullturn
            end
            length(es)==length(oes) && return turns * (sum(values(gs)) + sum(values(es)))
            es, gs = deepcopy(oes), deepcopy(ogs)
        end
    end
    es, gs = deepcopy(oes), deepcopy(ogs)
    println("Part 2: ", play2(es, gs, cave))
end
