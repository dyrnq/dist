#!/usr/bin/env bash
gosu jenkins rm -rf $JENKINS_HOME/.cache/jenkins-plugin-management-cli && \
JENKINS_UC_DOWNLOAD_URL=https://ftp.yz.yamagata-u.ac.jp/pub/misc/jenkins/plugins/ \
gosu jenkins java -jar /usr/lib/jenkins-plugin-manager.jar \
--verbose \
--plugin-download-directory /var/jenkins_home/plugins \
--jenkins-update-center https://mirrors.ustc.edu.cn/jenkins/updates/current/update-center.json \
--jenkins-experimental-update-center https://mirrors.ustc.edu.cn/jenkins/updates/experimental/update-center.json \
--jenkins-plugin-info https://mirrors.ustc.edu.cn/jenkins/updates/current/plugin-versions.json  \
--plugins \
ws-cleanup \
workflow-aggregator \
pipeline-utility-steps \
git \
ant \
email-ext \
maven-plugin \
docker-workflow \
kubernetes \
configuration-as-code


# JENKINS_UC
# JENKINS_UC_EXPERIMENTAL
# JENKINS_UC_DOWNLOAD_URL
# JENKINS_UC_HASH_FUNCTION

# JENKINS_INCREMENTALS_REPO_MIRROR
# CACHE_DIR

# JENKINS_UC_DOWNLOAD: DEPRECATED use JENKINS_UC_DOWNLOAD_URL instead.

