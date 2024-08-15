# FROM maven:3.8-eclipse-temurin-17-alpine as build
# LABEL authors="Thien"
# WORKDIR /build
# COPY pom.xml ./
# COPY src/ ./src/
# RUN mvn clean package -DskipTests

# FROM eclipse-temurin:17.0.9_9-jre-alpine
# WORKDIR /app
# # Create a group and user
# RUN addgroup -g 1024 runnergroup
# RUN adduser -D -u 1024 apprunner -G runnergroup
# RUN chown -R apprunner:runnergroup /app
# USER apprunner
# COPY --chown=apprunner:runnergroup --from=build /build/target/*.jar ./run.jar
# CMD java -jar run.jar
# # docker build --tag springapp:v1 .
# # mvn clean package -DskipTests
#     # Xóa thư mục target.
#     # Cập nhật các phụ thuộc của ứng dụng bằng cách chạy các mục tiêu compile và package.
#     # Xây dựng mã nguồn của ứng dụng. Bỏ qua Test
#     # Đóng gói ứng dụng thành một .jar file và đặt nó vào thư mục target.
#     # nếu l mvn clean install thì thêm bước Sao chép .jar file đã đóng gói vào kho lưu cục bộ trong .m2 directory. nhưng điều này không cần thiết.


# Use a base image that includes Java 17 and Maven
FROM maven:3.8-eclipse-temurin-17-alpine AS build
# ARG TOKEN
# ENV CODEARTIFACT_AUTH_TOKEN=$TOKEN
WORKDIR /app
COPY pom.xml .
# COPY settings.xml /root/.m2/
RUN mvn dependency:go-offline
COPY src/ ./src/
RUN mvn package -DskipTests

# Start a new container with Java 17 and Alpine Linux, with Amazon Corretto
FROM eclipse-temurin:17-jre-alpine
# ARG SPRING_APPLICATION_JSON
# ENV SPRING_APPLICATION_JSON=${SPRING_APPLICATION_JSON}
WORKDIR /app
COPY --from=build /app/target/*.jar ./app.jar
EXPOSE 443
CMD java -jar app.jar