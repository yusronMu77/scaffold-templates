package {{ .PackageName }}.dto;

// Wildcard, for the same reason as the 3.2.x template: the constraint annotations are written in
// `data.entity.fields`, so this file cannot know which ones a project uses.
import {{ .JakartaNs }}.validation.constraints.*;

/**
 * Java 8 equivalent of the record in the 3.2.x template. Same fields, same constraints, same
 * source: `data.entity.fields`. Only the shape - a bean with getters and setters instead of a
 * record - is what this override exists for.
 */
public class {{ .EntityName }}Request {
{{ range $f := .Data.entity.fields }}
{{- range $f.constraints }}    {{ . }}
{{ end }}    private {{ $f.type }} {{ $f.name }};

    public {{ $f.type }} {{ $f.name }}() {
        return {{ $f.name }};
    }

    public void set{{ $f.name | title }}({{ $f.type }} {{ $f.name }}) {
        this.{{ $f.name }} = {{ $f.name }};
    }
{{ end }}}
