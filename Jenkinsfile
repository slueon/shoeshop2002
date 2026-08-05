pipeline {
    agent any

    stages {
        stage('1. Kéo mã nguồn từ GitHub') {
            steps {
                // Kéo code mới nhất từ nhánh main
                git branch: 'main', url: 'https://github.com/slueon/shoeshop2002.git'
            }
        }
        
        stage('2. Build, Đóng gói & Triển khai (Docker)') {
            steps {
                // Lệnh này sẽ tự động: 
                // - Chạy mvn clean package (bên trong Docker)
                // - Đóng gói file .jar thành Image mới
                // - Tắt container app cũ và chạy container app mới
                sh 'docker compose up -d --build app'
            }
        }
        
        stage('3. Dọn dẹp hệ thống') {
            steps {
                // Xóa các image rác sinh ra trong quá trình build để nhẹ máy
                sh 'docker image prune -f'
            }
        }
    }
}