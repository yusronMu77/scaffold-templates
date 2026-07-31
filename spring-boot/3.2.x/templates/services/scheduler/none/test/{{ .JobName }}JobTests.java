package {{ .PackageName }};

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import {{ .PackageName }}.job.{{ .JobName }}Job;

/**
 * Replaces the generic ApplicationTests (see `exclude:` in this template's manifest): it starts the
 * context like that one did, and additionally asserts the scheduled bean is actually registered -
 * which is the mistake worth catching in a scheduler.
 */
@SpringBootTest
class {{ .JobName }}JobTests {

    @Autowired
    private {{ .JobName }}Job job;

    @Test
    void contextLoadsAndJobIsRegistered() {
        assertThat(job).isNotNull();
    }
}
