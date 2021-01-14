open("04.txt") do f
    ls = sort(readlines(f))
    sleepschedule, i = Dict{Int, Array{Int}}(), 1
    while i < length(ls)
        g = parse(Int, split(ls[i])[4][2:end])
        awake, wakes = falses(60), 1
        for j ∈ i+1:length(ls)
            ws = split(ls[j])
            if ws[3] == "falls"
                m = parse(Int, ws[2][4:5])
                awake[wakes:m] .= true
            elseif ws[3] == "wakes"
                wakes = parse(Int, ws[2][4:5])+1
            end
            i = j
            ws[3] == "Guard" && break
        end
        awake[wakes:60] .= true
        if g ∉ keys(sleepschedule)
            sleepschedule[g] = zeros(Int, 60)
        end
        sleepschedule[g] .+= .!awake
    end
    sumsleep = Dict([(g, sum(sleepschedule[g])) for g ∈ keys(sleepschedule)])
    guard = argmax(sumsleep)
    maxminute = argmax(sleepschedule[guard])-1
    println("Part 1: ", guard*(maxminute))

    maxsleep = Dict([(g, maximum(sleepschedule[g])) for g ∈ keys(sleepschedule)])
    guard = argmax(maxsleep)
    maxminute = argmax(sleepschedule[guard])-1
    println("Part 2: ", guard*(maxminute))
end
