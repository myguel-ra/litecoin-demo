pipeline {
    agent { label 'docker' }
    stages {
        stage('Checkout') { 
            steps {
                checkout(
                    [$class: 'GitSCM',
                    branches: [[name: '*/dev']],
                    extensions: [],
                    userRemoteConfigs: [[url: 'https://github.com/myguel-ra/litecoin-demo.git']]
                    ]
                )
            }
        }
        stage('Build') { 
            steps {
                withCredentials([usernamePassword(credentialsId: 'myguel-dockerhub', passwordVariable: 'TOKEN', usernameVariable: 'USER')]) {
                    sh 'echo $TOKEN | docker login -u $USER --password-stdin'
                    sh "docker build -t myguel/litecoin -t myguel/litecoin:${env.BUILD_ID} --build-arg VERSION=${env.VERSION} ."
                    sh "docker push myguel/litecoin --all-tags"
                    sh "docker rmi myguel/litecoin:${env.BUILD_ID}" 
                }
            }
            post { 
                always { 
                    sh 'docker logout'
                }
            }
        }
        stage('Deploy') { 
            steps {
                echo "Deploying version ${env.version}"
            }
        }
    }
}
