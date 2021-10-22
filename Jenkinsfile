pipeline {
    agent { dockerfile true }
    parameters{ choice(name: 'VERSION', choices: ['0.18.1']) }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploying version ${params.VERSION}"
            }
        }
    }
}
