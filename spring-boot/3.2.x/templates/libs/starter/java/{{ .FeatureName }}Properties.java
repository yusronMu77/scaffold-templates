package {{ .PackageName }};

import org.springframework.boot.context.properties.ConfigurationProperties;

/** Configuration surface of the {{ .FeatureName }} starter. */
@ConfigurationProperties(prefix = "{{ .FeatureName | lower }}")
public class {{ .FeatureName }}Properties {

    private boolean enabled = true;

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }
}
