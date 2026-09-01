<?xml version="1.0" encoding="UTF-8"?>
<!-- This file is part of the scaffolding hello-world project and overrides the default POM configuration. -->

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

  <dependencies>
{{- range .Dependencies }}
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
  </dependencies>

{{- if eq .ExecutableJar "true" }}

  <build>
    <plugins>
      <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
      </plugin>
    </plugins>
  </build>
{{- end }}

</project>
