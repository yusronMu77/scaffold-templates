using System.Net.Http.Json;
using Microsoft.AspNetCore.Mvc.Testing;

namespace {{ .ProjectName }}.Tests;

public class ApiTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly HttpClient _client;

    public ApiTests(WebApplicationFactory<Program> factory)
    {
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Healthz_ReturnsOk()
    {
        var response = await _client.GetAsync("/healthz");
        response.EnsureSuccessStatusCode();

        var body = await response.Content.ReadFromJsonAsync<StatusResponse>();
        Assert.Equal("ok", body?.Status);
    }

    [Fact]
    public async Task Root_GreetsByName()
    {
        var response = await _client.GetAsync("/");
        response.EnsureSuccessStatusCode();

        var text = await response.Content.ReadAsStringAsync();
        Assert.Equal("Hello, {{ .ProjectName }}!", text);
    }

    private record StatusResponse(string Status);
}
