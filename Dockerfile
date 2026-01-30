FROM eclipse-temurin:21-jre
WORKDIR /app

RUN groupadd --system spring \
 && useradd --system --gid spring --create-home spring

USER spring

COPY --from=build /app/target/*jar app.jar

EXPOSE 8085
ENTRYPOINT ["java","-jar","/app/app.jar"]
