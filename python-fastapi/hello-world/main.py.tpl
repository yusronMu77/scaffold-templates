"""{{ .PackageName }} - {{ .Description }}"""

from fastapi import FastAPI

app = FastAPI(title="{{ .PackageName }}", description="{{ .Description }}")


@app.get("/")
def read_root():
    return {"message": "Hello, {{ .PackageName }}!"}


@app.get("/healthz")
def healthz():
    return {"status": "ok"}
