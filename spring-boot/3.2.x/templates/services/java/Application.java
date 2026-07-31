package {{ .PackageName }};

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Entry point. Shared by every kind of service, because every Spring Boot service needs exactly
 * this and nothing more.
 *
 * A service that needs to switch something on at startup overrides this file by shipping its own
 * java/Application.java - see the scheduler template, which adds @EnableScheduling.
 */
@SpringBootApplication
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
