<?xml version="1.0" encoding="UTF-8"?>
<!--
  Shared by every Spring Boot version and every kind of artefact. Written once, here.

  It serves a runnable service, a plain library and a parent POM alike, because the differences
  between them are values rather than structure:

    .Packaging      jar (service, library)  |  pom (parent)
    .ExecutableJar  true (service)          |  false (library, parent)
    .Dependencies   the deduplicated union declared across the whole inheritance chain

  Three near-identical copies of this file would drift apart within a release or two; two
  variables and a conditional will not.
-->
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>{{ .SpringBootVersion }}</version>
    <relativePath/>
  </parent>

  <groupId>{{ .GroupId }}</groupId>
  <artifactId>{{ .ArtifactId }}</artifactId>
  <version>0.0.1-SNAPSHOT</version>
  <packaging>{{ .Packaging }}</packaging>
  <name>{{ .ArtifactId }}</name>
  <description>{{ .Description }}</description>

  <properties>
    <java.version>{{ .JavaVersion }}</java.version>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>

{{- /*
  Entries with scope "import" are BOMs: they belong in <dependencyManagement>, never in
  <dependencies>. The engine attaches no meaning to the scope - this template does the routing,
  which is what keeps Maven's rules out of the engine.
*/}}
{{- if eq .Packaging "pom" }}

  <!-- A parent POM manages versions for its children instead of depending on things itself. -->
  <dependencyManagement>
    <dependencies>
{{- range .Dependencies }}
      <dependency>
        <groupId>{{ .groupId }}</groupId>
        <artifactId>{{ .artifactId }}</artifactId>
        <version>{{ if .version }}{{ .version }}{{ else }}${project.version}{{ end }}</version>
        {{- if .type }}
        <type>{{ .type }}</type>
        {{- end }}
        {{- if .scope }}
        <scope>{{ .scope }}</scope>
        {{- end }}
      </dependency>
{{- end }}
    </dependencies>
  </dependencyManagement>
{{- else }}
{{- $boms := list }}{{ $direct := list }}
{{- range .Dependencies }}{{ if eq .scope "import" }}{{ $boms = append $boms . }}{{ else }}{{ $direct = append $direct . }}{{ end }}{{ end }}
{{- if $boms }}

  <!-- BOMs: manage versions for coordinates the Spring Boot parent does not cover. -->
  <dependencyManagement>
    <dependencies>
{{- range $boms }}
      <dependency>
        <groupId>{{ .groupId }}</groupId>
        <artifactId>{{ .artifactId }}</artifactId>
        <version>{{ .version }}</version>
        <type>{{ if .type }}{{ .type }}{{ else }}pom{{ end }}</type>
        <scope>import</scope>
      </dependency>
{{- end }}
    </dependencies>
  </dependencyManagement>
{{- end }}

  <dependencies>
{{- range $direct }}
    <dependency>
      <groupId>{{ .groupId }}</groupId>
      <artifactId>{{ .artifactId }}</artifactId>
      {{- if .version }}
      <version>{{ .version }}</version>
      {{- end }}
      {{- if .scope }}
      <scope>{{ .scope }}</scope>
      {{- end }}
    </dependency>
{{- end }}
    <!-- @scaffold:dependencies -->
  </dependencies>
{{- end }}

{{- if eq .ExecutableJar "true" }}

  <build>
    <plugins>
      <!-- Repackages into an executable fat jar. A library must NOT have this: the repackaged jar
           cannot be used as a dependency by other modules. -->
      <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
      </plugin>
    </plugins>
  </build>
{{- end }}

</project>
