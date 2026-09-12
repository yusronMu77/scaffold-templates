package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestHealthz(t *testing.T) {
	req := httptest.NewRequest(http.MethodGet, "/healthz", nil)
	w := httptest.NewRecorder()
	newRouter().ServeHTTP(w, req)

	if w.Code != http.StatusOK {
		t.Fatalf("expected status 200, got %d", w.Code)
	}
	want := `{"status":"ok"}` + "\n"
	if got := w.Body.String(); got != want {
		t.Fatalf("expected body %q, got %q", want, got)
	}
}

func TestRoot(t *testing.T) {
	req := httptest.NewRequest(http.MethodGet, "/", nil)
	w := httptest.NewRecorder()
	newRouter().ServeHTTP(w, req)

	if w.Code != http.StatusOK {
		t.Fatalf("expected status 200, got %d", w.Code)
	}
	want := "Hello, {{ .ServiceName }}!"
	if got := w.Body.String(); got != want {
		t.Fatalf("expected body %q, got %q", want, got)
	}
}
