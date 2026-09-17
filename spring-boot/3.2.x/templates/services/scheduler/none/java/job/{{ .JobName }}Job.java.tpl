package {{ .PackageName }}.job;

import java.time.Instant;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * Worked example of a scheduled job.
 *
 * The cron expression is read from configuration rather than hardcoded, so the schedule can be
 * changed per environment without a rebuild. The `:{{ .JobCron }}` fallback is what --mode=job
 * (scaffold-cli#79) resolves to when this job is added to a project whose application.yml this
 * mode deliberately leaves untouched (see services/scheduler/none/job/jig.yaml) - the job still
 * runs out of the box, and adding the property later overrides this compiled-in default.
 */
@Component
public class {{ .JobName }}Job {

    private static final Logger log = LoggerFactory.getLogger({{ .JobName }}Job.class);

    @Scheduled(cron = "${app.jobs.{{ .JobName | lower }}.cron:{{ .JobCron }}}")
    public void run() {
        log.info("{{ .JobName }}Job started at {}", Instant.now());
        // TODO: replace with real work
        log.info("{{ .JobName }}Job finished");
    }
}
