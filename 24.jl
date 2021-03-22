function twentyfour()
    G = [[522*177, 14,  522,  9327, 177, "slashing", [], [], 0],
         [2801*10,  7, 2801,  3302,  10, "bludgeoning", [], [], 0],
         [112*809,  8,  112, 11322, 809, "slashing", [], [], 0],
         [2974*23, 11, 2974,  9012,  23, "slashing", [], [], 0],
         [4805*15,  5, 4805,  8717,  15, "bludgeoning", [], ["radiation"], 0],
         [1466*17, 10, 1466,  2562,  17, "radiation", ["radiation", "fire"], [], 0],
         [2513*4,   3, 2513,  1251,   4, "slashing", ["cold"], ["fire"], 0],
         [6333*14,  9, 6333,  9557,  14, "fire", ["slashing"], [], 0],
         [2582*5,   2, 2582,  1539,   5, "slashing", ["bludgeoning"], [], 0],
         [2508*27,  4, 2508,  8154,  27, "bludgeoning", [], ["bludgeoning", "cold"], 0],
         [2766*14,  1, 2766, 20953,  14, "radiation", [], ["fire"], 1],
         [4633*6,  15, 4633, 18565,   6, "fire", ["cold", "slashing"], [], 1],
         [239*320, 16,  239, 47909, 320, "slashing", [], ["slashing", "cold"], 1],
         [409*226, 17,  409, 50778, 226, "fire", ["radiation"], [], 1],
         [1280*60, 13, 1280, 54232,  60, "bludgeoning", ["slashing", "fire", "bludgeoning"], [], 1],
         [451*163,  6,  451, 38251, 163, "bludgeoning", ["bludgeoning"], [], 1],
         [1987*31, 20, 1987, 37058,  31, "slashing", [] , [], 1],
         [1183*24, 12, 1183, 19147,  24, "fire", [], ["slashing"], 1],
         [133*287, 19,  133, 22945, 287, "radiation", ["cold", "bludgeoning"], ["slashing"], 1],
         [908*97,  18,  908, 47778,  97, "fire", [], [], 1]]

    function fight(G, boost)
        for g ∈ G[1:10]
            g[5] += boost
            g[1] = g[3] * g[5]
        end

        damage(a, b) = (a[6] ∉ b[7]) * a[5] * (1 + (a[6]∈b[8]))
        alleq(x) = all(y -> y == x[1], x)

        oldu = ()
        while !alleq([g[9] for g ∈ G])
            # If no one die, it's a tie
            u = ([g[3] for g ∈ G]...,)
            u == oldu && return nothing, 0
            oldu = u
            # Select targets
            sort!(G, rev=true)
            targets = Dict()
            for a ∈ G
                max_dmg = 0
                for b ∈ G
                    a[9] == b[9] && continue
                    b ∈ values(targets) && continue
                    dmg = damage(a, b)
                    dmg ≤ max_dmg && continue
                    max_dmg = dmg
                    targets[a[2]] = b
                end
            end
            # Attack!
            for i ∈ 20:-1:1
                i ∉ keys(targets) && continue
                a, b = findfirst(a->a[2]==i, G), findfirst(b->b==targets[i], G)
                G[a][3] < 1 && continue
                dmg = damage(G[a], G[b])
                deaths = dmg * G[a][3] ÷ G[b][4]
                G[b][3] -= deaths
                G[b][1] = G[b][3] * G[b][5]
            end
            G = filter(g -> g[3] > 0, G)
        end
        return G[1][9], sum(g[3] for g in G)
    end
    println("Part 1: ", fight(deepcopy(G), 0)[2])
    for boost ∈ Iterators.countfrom(1)
        win, units = fight(deepcopy(G), boost)
        win ≠ 0 && continue
        println("Part 2: ", units)
        break
    end
end
twentyfour()
