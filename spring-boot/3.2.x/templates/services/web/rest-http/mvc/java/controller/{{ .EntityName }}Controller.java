package {{ .PackageName }}.controller;

import java.net.URI;
import java.util.List;

import jakarta.validation.Valid;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import {{ .PackageName }}.dto.{{ .EntityName }}Request;
import {{ .PackageName }}.model.{{ .EntityName }};
import {{ .PackageName }}.service.{{ .EntityName }}Service;

/**
 * HTTP boundary only: parse, delegate, map the result to a status code. No business logic here.
 */
@RestController
@RequestMapping("/api/{{ .EntityName | lower }}s")
public class {{ .EntityName }}Controller {

    private final {{ .EntityName }}Service service;

    public {{ .EntityName }}Controller({{ .EntityName }}Service service) {
        this.service = service;
    }

    @GetMapping
    public List<{{ .EntityName }}> findAll() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public {{ .EntityName }} findById(@PathVariable Long id) {
        return service.findById(id);
    }

    @PostMapping
    public ResponseEntity<{{ .EntityName }}> create(@Valid @RequestBody {{ .EntityName }}Request request) {
        {{ .EntityName }} created = service.create(request.name());
        return ResponseEntity.created(URI.create("/api/{{ .EntityName | lower }}s/" + created.id())).body(created);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }
}
