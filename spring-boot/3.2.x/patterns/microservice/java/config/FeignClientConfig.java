package {{ .PackageName }}.config;

import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

/**
 * Enables declarative HTTP clients for calling sibling services.
 *
 * Contributed by the microservice pattern overlay rather than by any service template: whether a
 * service talks to siblings is an architecture decision, orthogonal to whether it is a REST API or
 * a scheduler. That is why --style is a separate axis from the category chain.
 *
 * Timeouts are configured in application.yml, also contributed by this overlay.
 */
@Configuration
@EnableFeignClients(basePackages = "{{ .PackageName }}")
public class FeignClientConfig {
}
