
# TODO eventually wrap this in some UI to ask the questions
function create_registry(name::String; uuid = Base.Random.uuid4(), depot = DEFAULT_DEPOT[],
                         description::String = "", repo::String = "")
    
    path = joinpath(depot, "registries", name)
    if !isdir(path)
        mkdir(path)
    end

    if isfile(joinpath(path, "registry.toml"))
        error("Registry already exists. Aborting.")
    end

    # TODO learn the TOML tools
    open(joinpath(path, "registry.toml"), "w") do io
        write(io, "name = \"$name\"\n")
        write(io, "uuid = \"$uuid\"\n")
        write(io, "repo = \"$repo\"\n")
        write(io, "\n")
        write(io, "description = \"\"\"\n")
        write(io, description)
        write(io, "\"\"\"")
        write(io, "\n")
        write(io, "[packages]\n")
    end

    # TODO make this directory into a git repo (and try push upstream?)
end

"""
    registry_depot(registry::String)

Returns the path of the depot that registry named `registry` is in.
"""
function registry_depot(registry::String)
    for depot in Pkg3.depots()
        registry_path = joinpath(depot, "registries", registry)
        if isfile(joinpath(registry_path, "registry.toml"))
            return depot
        end
    end
    error("Unknown registry \"$registry\"")
end


"""
registry_depot(registry::String)

Returns the path containing the registry.toml file that the registry named `registry` is in.
"""
registry_path(registry::String) = joinpath(registry_depo(registry), "registries", registry)

# TODO clone a registry
function clone_registry(repo::String; depot = DEFAULT_DEPOT[])
    # Some LibGit2 stuff
end

# TODO push a registry to its upstream repo / perhaps make a PR for Uncurated on github