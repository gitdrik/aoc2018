open("18.txt") do f
    area = zeros(Int, 52, 52)
    for (i, l) ∈ enumerate(eachline(f))
        area[i+1,:] = [[0];[c=='.' ? 0 : c=='|' ? 1 : 2 for c in l];[0]]
    end

    areas = []
    for t ∈ 1:10
        narea = copy(area)
        for i ∈ 2:51, j ∈ 2:51
            narea[i,j] += (area[i,j]==0) * (sum(area[i-1:i+1,j-1:j+1].==1) ≥ 3) +
                          (area[i,j]==1) * (sum(area[i-1:i+1,j-1:j+1].==2) ≥ 3) -
                          (area[i,j]==2) * !((sum(area[i-1:i+1,j-1:j+1].==2) ≥ 2) &
                                             (sum(area[i-1:i+1,j-1:j+1].==1) ≥ 1)) * 2
        end
        area = narea
        push!(areas, area)
    end
    println("Part 1: ", sum(area.==1) * sum(area.==2))

    cyclestart, cyclelength = 0, 0
    for t ∈ Iterators.countfrom(11)
        narea = copy(area)
        for i ∈ 2:51, j ∈ 2:51
            narea[i,j] += (area[i,j]==0) * (sum(area[i-1:i+1,j-1:j+1].==1) ≥ 3) +
                          (area[i,j]==1) * (sum(area[i-1:i+1,j-1:j+1].==2) ≥ 3) -
                          (area[i,j]==2) * !((sum(area[i-1:i+1,j-1:j+1].==2) ≥ 2) &
                                             (sum(area[i-1:i+1,j-1:j+1].==1) ≥ 1)) * 2
        end
        area = narea
        if area ∈ areas
            cyclestart = findfirst(==(area), areas)
            cyclelength = t-cyclestart
            break
        else
            push!(areas, area)
        end
    end

    t2 = 1000000000
    t2e = cyclestart + mod(t2-cyclestart, cyclelength)
    println("Part 2: ", sum(areas[t2e].==1) * sum(areas[t2e].==2))
end
