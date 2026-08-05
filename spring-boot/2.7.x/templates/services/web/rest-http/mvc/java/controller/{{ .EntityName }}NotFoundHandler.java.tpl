package {{ .PackageName }}.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import {{ .PackageName }}.service.{{ .EntityName }}NotFoundException;

// Spring Boot 2.7 equivalent of the ProblemDetail-based handler in the 3.2.x template.
@RestControllerAdvice
public class {{ .EntityName }}NotFoundHandler {

    @ExceptionHandler({{ .EntityName }}NotFoundException.class)
    public ResponseEntity<Map<String, Object>> handleNotFound({{ .EntityName }}NotFoundException ex) {
        Map<String, Object> body = new HashMap<>();
        body.put("status", HttpStatus.NOT_FOUND.value());
        body.put("title", "Not Found");
        body.put("detail", ex.getMessage());
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(body);
    }
}
