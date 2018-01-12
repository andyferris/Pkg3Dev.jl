module Pkg3Dev

using Pkg3
using MicroLogging

const DEFAULT_DEPOT = Ref{String}()

include("depots.jl")     # create a new depot, make a different one default, etc
include("registries.jl") # create a new registry in a depot, git push registry, etc
include("packages.jl")   # create a new package, register a package to a registry, etc
include("versions.jl")   # create a new version of a package, modify, push, etc

function __init__()
    DEFAULT_DEPOT[] = Pkg3.depots()[1]
end

end # module
