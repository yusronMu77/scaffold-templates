package {{ .PackageName }};

import java.util.Objects;

/**
 * Domain type shared between services. Deliberately free of persistence and serialisation
 * annotations: each consumer decides how it stores or transports this, and a shared model that
 * hardcodes those choices forces them on everyone.
 */
public record {{ .AggregateName }}(String id, String name) {

    public {{ .AggregateName }} {
        Objects.requireNonNull(id, "id");
        Objects.requireNonNull(name, "name");
    }
}
