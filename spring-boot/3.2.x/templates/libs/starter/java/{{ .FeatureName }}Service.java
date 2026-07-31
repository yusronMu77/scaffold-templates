package {{ .PackageName }};

/** What the starter actually provides to consumers. */
public class {{ .FeatureName }}Service {

    private final {{ .FeatureName }}Properties properties;

    public {{ .FeatureName }}Service({{ .FeatureName }}Properties properties) {
        this.properties = properties;
    }

    public boolean isEnabled() {
        return properties.isEnabled();
    }
}
