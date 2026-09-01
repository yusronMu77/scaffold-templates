{{ include "java.header" . }}
package {{ .PackageName }};

import static org.slf4j.LoggerFactory.getLogger;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class {{ .ApplicationName }}Controller {

    private static final Logger LOG = getLogger({{ .ApplicationName }}Controller.class);

    @GetMapping(path = "/", produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, String> helloWorld() throws UnknownHostException {
        Map<String, String> response = new HashMap<>();
        response.put("message", "Hello World!");
        response.put("hostname", InetAddress.getLocalHost().getHostName());
        response.put("ip", InetAddress.getLocalHost().getHostAddress());
        LOG.info("Returning {}", response);
        return response;
    }
}
