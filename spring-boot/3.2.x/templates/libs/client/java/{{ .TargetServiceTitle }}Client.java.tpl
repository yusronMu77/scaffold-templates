package {{ .PackageName }};

import org.springframework.web.client.RestClient;

/**
 * Typed client for the {{ .TargetService }} service.
 *
 * Wrapping the HTTP call here means callers depend on a method signature rather than on a URL and a
 * JSON shape, so the contract can change in one place.
 */
public class {{ .TargetServiceTitle }}Client {

    private final RestClient restClient;

    public {{ .TargetServiceTitle }}Client(String baseUrl) {
        this.restClient = RestClient.builder().baseUrl(baseUrl).build();
    }

    public String ping() {
        return restClient.get()
                .uri("/actuator/health")
                .retrieve()
                .body(String.class);
    }
}
