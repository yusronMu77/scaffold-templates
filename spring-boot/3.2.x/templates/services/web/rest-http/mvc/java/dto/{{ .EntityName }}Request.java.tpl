{{ include "java.header" . }}
package {{ .PackageName }}.dto;

// A wildcard import, deliberately: the constraints are written in `data.entity.fields`, so this
// template cannot know which annotations a project will end up using. Naming them one by one would
// mean that adding @Positive to a field requires editing this file too - exactly the coupling the
// data block removes.
import {{ .JakartaNs }}.validation.constraints.*;

/**
 * Inbound payload. Kept separate from the domain model so the HTTP contract can change
 * independently of the domain - and so validation annotations stay out of the model.
 *
 * The field list comes from `data.entity.fields` - see mvc/jig.yaml.
 */
public record {{ .EntityName }}Request(
{{- range $i, $f := .Data.entity.fields }}{{ if $i }},{{ end }}
{{ range $f.constraints }}        {{ . }}
{{ end }}        {{ $f.type }} {{ $f.name }}
{{- end }}) {
}
