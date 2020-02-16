#!groovy

import static java.util.Calendar.*

def buildId
def commitId
def commitIdShort

node('slave-small') {
  wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm', 'defaultFg': 1, 'defaultBg': 2]) {
    wrap([$class: 'TimestamperBuildWrapper']) {

      currentBuild.result = "SUCCESS"
      def currentState = [:]

      stage 'setup'
      def workspace = pwd()
      withEnv(["GOPATH=${workspace}"]) {
        dir('insert-jenkins-workspace-path') {

          try {
            checkout scm
            sh "env; git rev-parse HEAD > commit-id"

            commitId = readFile('commit-id')
            commitIdShort = commitId.substring(0, 7)
            buildId = "${env.BUILD_NUMBER}-${commitIdShort}"
            if (env.BRANCH_NAME == 'master') {
              currentBuild.displayName = buildId
            } else {
              currentBuild.displayName = "${buildId}-${env.BRANCH_NAME}"
            }
            echo "commitId=${commitId}\ncommitIdShort=${commitIdShort}\n buildId=${buildId}"

            sh "git show --name-only ${commitIdShort} --pretty=format: > result"
            def changedFiles=readFile('result').trim()
            echo changedFiles

            stage 'unit test'
            // sh 'sudo apt-get install openjdk-8-jdk'
            // sh 'echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list'
            // sh 'curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -'
            // sh 'sudo apt-get update && sudo apt-get install bazel'

            if (changedFiles[-2..-1] == 'js'){
              echo "Javascript Change!"
              // sh 'bazel test javascript_test'
            }
            if (changedFiles[-2..-1] == 'php'){
               echo "PHP Change!"
                // sh 'bazel test php_test'
            } else if (changedFiles[-2..-1] != 'php' && changedFiles[-2..-1] != 'js') {
                echo "Not sure what type of change! Running both"
                // sh 'bazel test javascript_test'
                // sh 'bazel test php_test'
              }
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: './.coverage-reports', reportFiles: 'cover.html', reportName: 'Code Coverage'])
          } catch (error) {
            currentBuild.result = "FAILURE"
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: './.coverage-reports', reportFiles: 'cover.html', reportName: 'Code Coverage'])

            throw error
          }
        }
      }
    }
  }
}
