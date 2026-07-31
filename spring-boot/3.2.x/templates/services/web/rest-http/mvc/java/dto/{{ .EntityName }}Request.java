package {{ .PackageName }}.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * Inbound payload. Kept separate from the domain model so the HTTP contract can change
 * independently of the domain - and so validation annotations stay out of the model.
 */
public record {{ .EntityName }}Request(

        @NotBlank(message = "name must not be blank")
        @Size(max = 200, message = "name must be at most 200 characters")
        String name) {
}
