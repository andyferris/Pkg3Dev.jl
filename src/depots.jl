function add_depot(path::String; default::Bool = true)
    if !isdir(path) || !isdir(joinpath(path, "registries"))
        error("Depot not found at: $path")
    end

    if path in Pkg3.depots()
        @warn "Depot already being used"
    else
        push!(Pkg3.depots(), path)
    end

    if default
        if DEFAULT_DEPOT[] != path
            @info "Setting default depot to $path"
            DEFAULT_DEPOT[] = path
        end
    end
end

"""
    create_depot(path; default = true)

Make a new
"""
function create_depot(path::String; default::Bool = true)
    regpath = joinpath(path, "registries")
    if isdir(path)
        if isdir(regpath) 
            if !isempty(readdir(regpath))
                @warn "Depot already exists at: $path"
            end
        else
            mkdir(regpath)
        end
    else
        mkdir(path)
        mkdir(joinpath(path, "registries"))
    end
    
    add_depot(path; default = default)
end

function default_depot(path::String)
    if !isdir(path) || !isdir(joinpath(path, "registries"))
        error("Depot not found at: $path")
    end
    if !(path in Pkg3.depots())
        if DEFAULT_DEPOT[] != path
            @info "Setting default depot to $path"
            DEFAULT_DEPOT[] = path
        end
    end
end