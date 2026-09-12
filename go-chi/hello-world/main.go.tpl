// {{ .ServiceName }} - {{ .Description }}
// Minimal runnable Go service: one GET / route plus a GET /healthz, no persistence.
package main

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/go-chi/chi/v5"
)

func newRouter() http.Handler {
	r := chi.NewRouter()

	r.Get("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("Hello, {{ .ServiceName }}!"))
	})

	r.Get("/healthz", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(map[string]string{"status": "ok"})
	})

	return r
}

func main() {
	log.Println("{{ .ServiceName }} listening on :8080")
	if err := http.ListenAndServe(":8080", newRouter()); err != nil {
		log.Fatal(err)
	}
}
