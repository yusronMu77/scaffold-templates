// {{ .PackageName }} - {{ .Description }}
// Minimal runnable Express app: no router split, no persistence, just two routes.

const express = require("express");

const app = express();

app.get("/", (req, res) => {
  res.send("Hello, {{ .PackageName }}!");
});

app.get("/healthz", (req, res) => {
  res.json({ status: "ok" });
});

module.exports = app;

if (require.main === module) {
  const port = process.env.PORT || 3000;
  app.listen(port, () => {
    console.log(`{{ .PackageName }} listening on port ${port}`);
  });
}
