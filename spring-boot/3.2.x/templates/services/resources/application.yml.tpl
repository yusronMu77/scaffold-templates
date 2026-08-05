spring:
  application:
    name: {{ .ArtifactId }}

# Health and readiness, needed by every service whatever it does. A web service also exposes these
# over HTTP; that part is configured at the web/ level, not here.
management:
  endpoint:
    health:
      probes:
        enabled: true
  health:
    livenessstate:
      enabled: true
    readinessstate:
      enabled: true

logging:
  level:
    root: INFO
    {{ .PackageName }}: DEBUG
