function fuelcells(sn)
    fc = Array{Int}(undef, 300, 300)
    for x ∈ axes(fc, 2), y ∈ axes(fc, 1)
        rid = x + 10
        pow = (y*(rid)+sn)*rid
        pow = pow ≥ 100 ? digits(pow)[3] : 0
        pow -= 5
        fc[x,y] = pow
    end
    return fc
end

function maxs(sn, sr)
    fc = fuelcells(sn)
    mx, my, ms, m = 0, 0, 0, -50
    for s ∈ sr, x ∈ 1:size(fc,1)+1-s, y ∈ 1:size(fc,2)+1-s
        mc = sum(fc[x:x+s-1, y:y+s-1])
        if mc > m
            mx, my, ms, m = x, y, s, mc
        end
    end
    return mx, my, ms
end
println("Part 1: ", join(maxs(7400, 3:3)[1:2],','))
println("Part 2: ", join(maxs(7400, 3:30),','))
