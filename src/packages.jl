# TODO packages in "development" mode symlinked under depot/development/PackageName?

function create_package(name::String, registry::String; path::String = joinpath(registry_depot(registry), "development", name), license::Union{Void, String} = nothing, repo::Union{Void, String} = nothing)
    #depot = registry_depot(registry)
    if isdir(path)
        error("Package path exists")
    else 
        mkpath(path)
    end

    # Make README.md, LICENSE.md, dependencies.toml, compatibility.toml, src/, test/
    open(joinpath(path, "README.md"), "w") do io
        write(io, "# $name\n")
    end

    if license === nothing
        error("Must specify license (\"MIT\" or \"proprietary\")")
    end
    if license == "MIT" # TODO we need the name of the copyright holder
        open(joinpath(path, "LICENSE.md"), "w") do io
            write(io, """
            The $name.jl package is licensed under the MIT "Expat" License:
            
            > Copyright (c) 2018.
            >
            > Permission is hereby granted, free of charge, to any person obtaining a copy
            > of this software and associated documentation files (the "Software"), to deal
            > in the Software without restriction, including without limitation the rights
            > to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
            > copies of the Software, and to permit persons to whom the Software is
            > furnished to do so, subject to the following conditions:
            >
            > The above copyright notice and this permission notice shall be included in all
            > copies or substantial portions of the Software.
            >
            > THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
            > IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
            > FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
            > AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
            > LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
            > OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
            > SOFTWARE.
            >            
            """)
        end
    elseif license == "proprietary" # TODO we need the name of the copyright holder
        open(joinpath(path, "LICENSE.md"), "w") do io
            write(io, "Copyright (c) 2018.\n\nAll rights reserved.\n")
        end
    end

    open(joinpath(path, "dependencies.toml"), "w") do io
    end

    open(joinpath(path, "compatibility.toml"), "w") do io
    end

    mkdir(joinpath(path, "src"))
    open(joinpath(path, "src", "$name.jl"), "w") do io
        write(io, """
            module $name

            # package code goes here

            end # module
            """)
    end

    mkdir(joinpath(path, "test"))
    open(joinpath(path, "test", "runtests.jl"), "w") do io
        write(io, """
            using Pkg3
            using $name
            using Base.Test

            @test 1 == 0
            """)
    end

    register_package(name, registry; path = path)
end

function register_package(pkgname::String, registry::String; path::String = "", uuid::String = string(Base.Random.uuid4()), shard::Bool = (registry == "Uncurated"))
    # TODO
end
