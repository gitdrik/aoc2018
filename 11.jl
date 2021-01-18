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

function maxs(sn, szr)
    fc = fuelcells(sn)
    mx, my, msz, ms = 0, 0, 0, -50
    for sz ∈ szr, x ∈ 1:size(fc,1)+1-sz, y ∈ 1:size(fc,2)+1-sz
        mc = sum(fc[x:x+sz-1, y:y+sz-1])
        if mc > ms
            mx, my, msz, ms = x, y, sz, mc
        end
    end
    return mx, my, msz
end
println("Part 1: ", join(maxs(7400, 3:3)[1:2],','))
println("Part 2: ", join(maxs(7400, 3:30),','))
