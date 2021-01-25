function scoresafter(practicerounds)
    scores, e1, e2 = [3, 7], 1, 2
    while length(scores) < practicerounds+10
        push!(scores, reverse(digits(scores[e1]+scores[e2]))...)
        e1 = mod1(e1+scores[e1]+1, length(scores))
        e2 = mod1(e2+scores[e2]+1, length(scores))
    end
    return join(scores[practicerounds+1:practicerounds+10])
end
println("Part 1: ", scoresafter(540561))

function scoresbefore(sequence)
    scores, e1, e2 = [3, 7], 1, 2
    seq = reverse(digits(sequence))
    lseq = length(seq)
    while true
        push!(scores, reverse(digits(scores[e1]+scores[e2]))...)
        e1 = mod1(e1+scores[e1]+1, length(scores))
        e2 = mod1(e2+scores[e2]+1, length(scores))
        length(scores) ≤ lseq && continue
        seq==scores[end-lseq+1:end] && return length(scores)-lseq
        seq==scores[end-lseq:end-1] && return length(scores)-lseq-1
    end
end
println("Part 2: ", scoresbefore(540561))
