app:
  jobs:
    {{ .JobName | lower }}:
      cron: "{{ .JobCron }}"
