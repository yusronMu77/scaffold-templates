app:
  architecture: microservice

spring:
  cloud:
    openfeign:
      client:
        config:
          default:
            connectTimeout: {{ .ConnectTimeoutMs }}
            readTimeout: {{ .ReadTimeoutMs }}
            loggerLevel: basic

# Calls to siblings can fail, so surface the client's own health alongside the app's.
management:
  endpoint:
    health:
      show-details: when-authorized
