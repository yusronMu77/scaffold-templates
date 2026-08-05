{{ include "java.header" . }}
package {{ .PackageName }}.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ProblemDetail;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import {{ .PackageName }}.service.{{ .EntityName }}NotFoundException;

/**
 * Maps this template's own domain exception to HTTP 404, so the service layer can throw a plain
 * exception without importing anything HTTP-shaped.
 *
 * Domain-specific on purpose: the generic validation handler that every REST service wants lives one
 * level up, at rest-http/java/web/ValidationExceptionHandler.java. Both are active at once - Spring
 * merges @RestControllerAdvice classes.
 */
@RestControllerAdvice
public class {{ .EntityName }}NotFoundHandler {

    @ExceptionHandler({{ .EntityName }}NotFoundException.class)
    public ProblemDetail handleNotFound({{ .EntityName }}NotFoundException ex) {
        return ProblemDetail.forStatusAndDetail(HttpStatus.NOT_FOUND, ex.getMessage());
    }
}
