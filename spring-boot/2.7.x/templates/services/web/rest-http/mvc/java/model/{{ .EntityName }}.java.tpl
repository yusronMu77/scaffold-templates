package {{ .PackageName }}.model;

import java.util.Objects;

/**
 * Java 8 has no records, so the 3.2.x version of this file cannot compile here. This is the kind of
 * difference that has to be an override rather than a variable.
 *
 * The field list, though, is NOT duplicated: it comes from the same `data.entity.fields` the 3.2.x
 * record reads, declared once in 3.2.x/.../mvc/jig.yaml and inherited by this version. Only
 * the language shape differs, which is the whole point of an override.
 */
public final class {{ .EntityName }} {

    private final Long id;
{{- range .Data.entity.fields }}
    private final {{ .type }} {{ .name }};
{{- end }}

    public {{ .EntityName }}(Long id, {{ include "entity.params" . }}) {
        this.id = id;
{{- range .Data.entity.fields }}
        this.{{ .name }} = {{ .name }};
{{- end }}
    }

    public Long id() {
        return id;
    }
{{ range .Data.entity.fields }}
    public {{ .type }} {{ .name }}() {
        return {{ .name }};
    }
{{ end }}
    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof {{ .EntityName }})) {
            return false;
        }
        {{ .EntityName }} other = ({{ .EntityName }}) o;
        return Objects.equals(id, other.id)
{{- range .Data.entity.fields }}
                && Objects.equals({{ .name }}, other.{{ .name }})
{{- end }};
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, {{ include "entity.args" . }});
    }
}
