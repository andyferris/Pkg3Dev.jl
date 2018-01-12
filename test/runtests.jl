using Pkg3Dev
using Base.Test
using Pkg3

@testset "Pkg3Dev" begin
    # Make a depot
    depotpath = tempname()
    Pkg3Dev.create_depot(depotpath)
    @test isdir(depotpath)
    @test isdir(joinpath(depotpath, "registries"))
    @test Pkg3Dev.DEFAULT_DEPOT[] == depotpath
    @test depotpath in Pkg3.depots()
    
    # Make a registry
    Pkg3Dev.create_registry("TestRegistry", depot = depotpath)
    @test isdir(joinpath(depotpath, "registries", "TestRegistry"))
    @test isfile(joinpath(depotpath, "registries", "TestRegistry", "registry.toml"))
    @test Pkg3Dev.registry_depot("TestRegistry") == depotpath

    # TODO Make a new, registered package
    Pkg3Dev.create_package("TestPackage", "TestRegistry"; license = "MIT")
    @test isdir(joinpath(depotpath, "development", "TestPackage"))
    @test isfile(joinpath(depotpath, "development", "TestPackage", "README.md"))
    @test isfile(joinpath(depotpath, "development", "TestPackage", "LICENSE.md"))
    @test isfile(joinpath(depotpath, "development", "TestPackage", "src", "TestPackage.jl"))
    @test isfile(joinpath(depotpath, "development", "TestPackage", "test", "runtests.jl"))


    # TODO Add some dependencies to package and make a version of the package

    # TODO Try adding and `using` the package and check that Pkg3 understands the registry.

end