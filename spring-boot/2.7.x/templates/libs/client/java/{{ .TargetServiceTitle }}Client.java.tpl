package {{ .PackageName }};

import org.springframework.web.client.RestTemplate;

/**
 * Typed client for the {{ .TargetService }} service.
 *
 * Wrapping the HTTP call here means callers depend on a method signature rather than on a URL and a
 * JSON shape, so the contract can change in one place.
 *
 * Spring 5 equivalent of the 3.2.x template: RestClient only exists from Spring Framework 6.1, so
 * this line uses RestTemplate.
 */
public class {{ .TargetServiceTitle }}Client {

    private final RestTemplate restTemplate;
    private final String baseUrl;

    public {{ .TargetServiceTitle }}Client(String baseUrl) {
        this.restTemplate = new RestTemplate();
        this.baseUrl = baseUrl;
    }

    public String ping() {
        return restTemplate.getForObject(baseUrl + "/actuator/health", String.class);
    }
}
