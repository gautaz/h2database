FROM amazoncorretto:8u362-alpine3.17 as base

FROM base as build
COPY . /src
WORKDIR /src/h2
RUN ./build.sh jar

FROM base
COPY --from=build /src/h2/bin/*.jar /opt/h2database/h2.jar
RUN adduser -D h2
USER h2
ENTRYPOINT ["/usr/bin/java", "-cp", "/opt/h2database/h2.jar", "org.h2.tools.Server"]
CMD ["-web", "-webAllowOthers", "-tcp", "-tcpAllowOthers"]
