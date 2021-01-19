open("12.txt") do f
    ls = readlines(f)
    ostate = [c=='#' for c ∈ ls[1][16:end]]
    rules = Dict{Array{Bool},Bool}([c=='#' for c ∈ s[1:5]]=>s[10]=='#' for s in ls[3:34])

    state = [falses(4);copy(ostate);falses(20)]
    for t ∈ 1:20
        state = [[false,false];[rules[state[i:i+4]] for i ∈ 1:length(state)-4];[false,false]]
    end
    println("Part 1: ", sum((-4:length(state)-5)[state]))

    reps = 50000000000
    state = [falses(4);copy(ostate);falses(50)]
    for t ∈ 1:113
        state = [[false,false];[rules[state[i:i+4]] for i ∈ 1:length(state)-4];[false,false,false]]
    end
    # from t=113 all rows are the same, the plants just move one step right/generation
    rsteps = reps-113
    sum2 = sum((rsteps-4:rsteps+length(state)-5)[state])
    println("Part 2: ", sum2)
end
