// {{ .ProjectName }} - {{ .Description }}
// Minimal runnable ASP.NET Core Minimal API: one GET / route plus a GET /healthz, no persistence.

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hello, {{ .ProjectName }}!");
app.MapGet("/healthz", () => Results.Json(new { status = "ok" }));

app.Run();

public partial class Program { }
