open("12.txt") do f
    ls = readlines(f)
    rules = Dict{Array{Bool},Bool}([c=='#' for c ∈ s[1:5]]=>s[10]=='#' for s in ls[3:34])
    state = [falses(4);[c=='#' for c ∈ ls[1][16:end]];falses(30)]
    for t ∈ 1:20
        state = [[false,false];[rules[state[i:i+4]] for i ∈ 1:length(state)-4];[false,false]]
    end
    println("Part 1: ", sum((-4:length(state)-5)[state]))

    for t ∈ 21:113
        state = [[false,false];[rules[state[i:i+4]] for i ∈ 1:length(state)-4];[false,false,false]]
    end
    reps = 50000000000
    rsteps = reps-113
    # As it happens, starting at gen 113 the plant congfiguration stays the same,
    # just moving one step to the right per generation.
    println("Part 2: ", sum((rsteps-4:rsteps+length(state)-5)[state]))
end
