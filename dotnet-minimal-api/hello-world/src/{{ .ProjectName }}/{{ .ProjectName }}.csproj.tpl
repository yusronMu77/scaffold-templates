<Project Sdk="Microsoft.NET.Sdk.Web">

  <PropertyGroup>
    <TargetFramework>net{{ .DotnetVersion }}</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
    <RootNamespace>{{ .ProjectName }}</RootNamespace>
    <AssemblyName>{{ .ProjectName }}</AssemblyName>
    <Description>{{ .Description }}</Description>
  </PropertyGroup>

  <ItemGroup>
    <!-- @scaffold:dependencies -->
  </ItemGroup>

</Project>
