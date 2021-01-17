open("09.txt") do f
    players, lastmarble = readline(f) |> split |> ss->parse.(Int, (ss[1],ss[7]))
    function maxscore(players, lastmarble)
        scores = zeros(Int, players)
        ring, current = [[1,0,1]], 1
        for m ∈ 1:lastmarble
            if m % 23 != 0
                before = ring[current][3]
                after = ring[before][3]
                push!(ring, [before, m, after])
                current = length(ring)
                ring[before][3] = current
                ring[after][1] = current
            else
                for _ ∈ 1:7
                    current = ring[current][1]
                end
                scores[mod1(m, players)] += ring[current][2]+m
                before = ring[current][1]
                after = ring[current][3]
                ring[before][3] = after
                ring[after][1] = before
                current = after
            end
        end
        maximum(scores)
    end
    println("Part 1: ", maxscore(players, lastmarble))
    println("Part 2: ", maxscore(players, 100*lastmarble))
end
