package {{ .PackageName }};

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * The one test every service should have: proof that the Spring context actually starts. It catches
 * most wiring mistakes before anything else runs.
 */
@SpringBootTest
class ApplicationTests {

    @Test
    void contextLoads() {
    }
}
