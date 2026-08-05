# Multi-stage build. Lives at the services/ level, not at the scaffold level, because only a
# runnable service gets containerised - a library or a parent POM must not receive this file.
#
# The JDK tag comes from .JavaVersion, which the version line supplies, so bumping Spring Boot and
# its Java baseline together needs no change here.

# ---- build ----------------------------------------------------------------------------------
FROM maven:3.9-eclipse-temurin-{{ .JavaVersion }} AS build
WORKDIR /build

# Dependencies first: this layer is cached as long as pom.xml is unchanged, so ordinary source
# edits do not re-download the world.
COPY pom.xml .
RUN mvn -B -q dependency:go-offline

COPY src ./src
RUN mvn -B -q clean package -DskipTests

# ---- run ------------------------------------------------------------------------------------
FROM eclipse-temurin:{{ .JavaVersion }}-jre-alpine
WORKDIR /app

# Never run as root.
RUN addgroup -S app && adduser -S app -G app
USER app

COPY --from=build /build/target/*.jar app.jar

ENV JAVA_OPTS="-XX:MaxRAMPercentage=75.0"
ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar /app/app.jar"]
