# Bước 1: Build ứng dụng
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
# Copy file cấu hình maven và toàn bộ source code vào container
COPY pom.xml .
COPY src ./src
# Chạy lệnh build, bỏ qua test để tăng tốc
RUN mvn clean package -DskipTests

# Bước 2: Tạo môi trường chạy (Runtime) siêu nhẹ
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Chỉ copy file .jar đã được build thành công từ Bước 1 sang
COPY --from=builder /app/target/*.jar app.jar
# Mở cổng 8080 cho ứng dụng Spring Boot
EXPOSE 8080
# Lệnh khởi chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]