using DataStructures

open("13.txt") do f
    ls = readlines(f)
    carts = SortedSet{Tuple{Int, Int, Tuple{Int, Int},Int}}()
    for (i, l) ∈ enumerate(ls), (j, c) ∈ enumerate(l)
        if c == '^'
            push!(carts, (i, j, (-1, 0), 0))
        elseif c == '>'
            push!(carts, (i, j, ( 0, 1), 0))
        elseif c == 'v'
            push!(carts, (i, j, ( 1, 0), 0))
        elseif c == '<'
            push!(carts, (i, j, ( 0,-1), 0))
        end
    end
    ncarts = SortedSet{Tuple{Int, Int, Tuple{Int, Int}, Int}}()
    onedone = false
    while true
        if isempty(carts)
            if length(ncarts)==1
                (i,j,_,_) = pop!(ncarts)
                println("Part 2: ", j-1, ',', i-1)
                break
            end
            carts = ncarts
            ncarts = SortedSet{Tuple{Int, Int, Tuple{Int, Int}, Int}}()
        end
        (i, j, d, t) = pop!(carts)
        (i, j) = (i, j) .+ d
        if any((i, j) == (k, l) for (k, l, _, _) ∈ carts ∪ ncarts)
            carts = filter(c->(c[1],c[2])≠(i,j), carts)
            ncarts = filter(c->(c[1],c[2])≠(i,j), ncarts)
            onedone && continue
            println("Part 1: ", j-1, ',', i-1)
            onedone = true
            continue
        end
        if ls[i][j] == '/'
            d = .-reverse(d)
        elseif ls[i][j] == '\\'
            d = reverse(d)
        elseif ls[i][j] == '+'
            if t==0 # left
                d = d[1]==0 ? .-reverse(d) : reverse(d)
            elseif t==2 # right
                d = d[1]==0 ? reverse(d) : .-reverse(d)
            end
            t = mod(t+1,3)
        end
        push!(ncarts, (i, j, d, t))
    end
end
