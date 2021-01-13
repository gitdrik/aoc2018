open("02.txt") do f
    ids = [[c for c ∈ s] for s ∈ readlines(f)]
    twos = sum([any(length(findall(a->a==c, s))==2 for c ∈ s) for s ∈ ids])
    threes = sum([any(length(findall(a->a==c, s))==3 for c ∈ s) for s ∈ ids])
    println("Part 1: ", twos*threes)
    
    for i ∈ 1:length(ids)-1, j ∈ i+1:length(ids)
        if sum(ids[i].!=ids[j]) == 1
            println("Part 2: ", join(ids[i][ids[i].==ids[j]]))
            break
        end
    end
end
