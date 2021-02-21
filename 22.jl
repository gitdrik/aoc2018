using DataStructures
function makecave(margin)
    depth  = 7305
    tx, ty = (13, 734) .+ 1
    sx, sy = (tx, ty) .+ margin
    erosion = zeros(Int, sx, sy)
    for x ∈ 1:sx, y ∈ 1:sy
        erosion[x, y] = y==1 ? ((x-1) * 16807 + depth) % 20183 :
                        x==1 ? ((y-1) * 48271 + depth) % 20183 :
                        (x, y) == (tx, ty) ? erosion[1, 1] :
                        (erosion[x-1, y] * erosion[x, y-1] + depth) % 20183
    end
    return erosion .% 3
end
println("Part 1: ", sum(makecave(0)))

function timetotarget()
    cave = makecave(20)
    tx, ty = (13, 734) .+ 1
    # type: 0 = rock, 1 = wet, 2 = narrow; tool: 0 = climbing, 1 = torch, 2 = neither
    toold = Dict(0 => [0, 1], 1 => [0, 2], 2 => [1, 2])
    tools = [toold[c] for c ∈ cave]
    times = fill(typemax(Int), size(cave))
    q = SortedSet([(0, 1, 1, 1)])
    while true
        time, x, y, tool = pop!(q)
        (x, y) == (tx, ty) && return time
        for (nx, ny) ∈ [(x+1, y), (x, y+1), (x-1, y), (x, y-1)]
            any((nx, ny) .∉ axes(cave)) && continue
            ntool = tool ∈ tools[nx, ny] ? tool : (tools[x, y] ∩ tools[nx, ny])[1]
            ntime = time + 1 + 7 * ((ntool ≠ tool) + ((nx, ny) == (tx, ty) && ntool ≠ 1))
            if ntime-7 < times[nx,ny]
                push!(q, (ntime, nx, ny, ntool))
                times[nx, ny] = min(times[nx, ny], ntime)
            end
        end
    end
end
println("Part 2: ", timetotarget())
