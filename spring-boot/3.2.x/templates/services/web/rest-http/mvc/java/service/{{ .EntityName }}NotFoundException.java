package {{ .PackageName }}.service;

/**
 * Thrown when a lookup finds nothing. Mapped to HTTP 404 by the controller advice, so the service
 * layer never has to know about HTTP.
 */
public class {{ .EntityName }}NotFoundException extends RuntimeException {

    public {{ .EntityName }}NotFoundException(Long id) {
        super("{{ .EntityName }} %d not found".formatted(id));
    }
}
