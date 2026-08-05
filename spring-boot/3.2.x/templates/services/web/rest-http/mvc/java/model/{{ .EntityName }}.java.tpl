{{ include "java.header" . }}
package {{ .PackageName }}.model;

/**
 * Domain model. Deliberately a plain record with no persistence annotations: the database choice
 * is a separate decision, and this template does not make it for you.
 *
 * The field list comes from `data.entity.fields` - see mvc/jig.yaml.
 */
public record {{ .EntityName }}(Long id, {{ include "entity.params" . }}) {
}
