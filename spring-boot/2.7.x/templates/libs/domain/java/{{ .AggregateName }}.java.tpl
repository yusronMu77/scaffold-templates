package {{ .PackageName }};

import java.util.Objects;

/**
 * Domain type shared between services. Deliberately free of persistence and serialisation
 * annotations: each consumer decides how it stores or transports this, and a shared model that
 * hardcodes those choices forces them on everyone.
 *
 * Java 8 equivalent of the record in the 3.2.x template.
 */
public final class {{ .AggregateName }} {

    private final String id;
    private final String name;

    public {{ .AggregateName }}(String id, String name) {
        this.id = Objects.requireNonNull(id, "id");
        this.name = Objects.requireNonNull(name, "name");
    }

    public String id() {
        return id;
    }

    public String name() {
        return name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof {{ .AggregateName }})) {
            return false;
        }
        {{ .AggregateName }} other = ({{ .AggregateName }}) o;
        return Objects.equals(id, other.id) && Objects.equals(name, other.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name);
    }

    @Override
    public String toString() {
        return "{{ .AggregateName }}[id=" + id + ", name=" + name + "]";
    }
}
