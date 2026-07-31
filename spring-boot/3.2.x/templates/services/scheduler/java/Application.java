package {{ .PackageName }};

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * OVERRIDES the shared entry point at services/java/Application.java.
 *
 * Same output path, so the deeper level wins and this file replaces it entirely. The only reason it
 * exists is @EnableScheduling - everything else is identical, which is exactly the "small
 * difference" case the inheritance chain is built for.
 */
@SpringBootApplication
@EnableScheduling
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
