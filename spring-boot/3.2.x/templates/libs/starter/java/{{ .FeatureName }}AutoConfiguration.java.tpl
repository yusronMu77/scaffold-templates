package {{ .PackageName }};

import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Auto-configuration for the {{ .FeatureName }} feature.
 *
 * Registered through META-INF/spring/...AutoConfiguration.imports, so a consumer only has to put
 * this jar on the classpath. @ConditionalOnMissingBean keeps it out of the way when the consumer
 * defines its own.
 */
@Configuration(proxyBeanMethods = false)
@ConditionalOnProperty(prefix = "{{ .FeatureName | lower }}", name = "enabled", havingValue = "true", matchIfMissing = true)
@EnableConfigurationProperties({{ .FeatureName }}Properties.class)
public class {{ .FeatureName }}AutoConfiguration {

    @Bean
    @ConditionalOnMissingBean
    public {{ .FeatureName }}Service {{ .FeatureName | lower }}Service({{ .FeatureName }}Properties properties) {
        return new {{ .FeatureName }}Service(properties);
    }
}
