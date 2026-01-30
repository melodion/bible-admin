# ==============================
# Build Stage
# ==============================
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn -B -e -C -ntp dependency:go-offline

COPY . .
RUN mvn clean package -Pprod -DskipTests

# ==============================
# Runtime Stage
# ==============================
FROM eclipse-temurin:21-jre
WORKDIR /app

RUN addgroup -S spring && adduser -S spring -G spring
USER spring

COPY --from=build /app/target/*jar app.jar

EXPOSE 8085
ENTRYPOINT ["java","-jar","/app/app.jar"]
