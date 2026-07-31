package {{ .PackageName }}.model;

/**
 * Domain model. Deliberately a plain record with no persistence annotations: the database choice
 * is a separate decision, and this template does not make it for you.
 */
public record {{ .EntityName }}(Long id, String name) {
}
