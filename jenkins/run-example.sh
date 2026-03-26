#!/usr/bin/env bash

name="jenkins"
host_data="/data/jenkins"

mkdir -p "${host_data}/jenkins_home/init.groovy.d"

pushd "${host_data}/jenkins_home/init.groovy.d/" || exit 1
    curl -O -f#SL --retry 1 "https://github.com/dyrnq/dist/raw/main/jenkins/init-jenkins.groovy" || \
    curl -O -f#SL --retry 10 "https://fastly.jsdelivr.net/gh/dyrnq/dist@main/jenkins/init-jenkins.groovy" || \
    curl -O -f#SL --retry 10 "https://testingcf.jsdelivr.net/gh/dyrnq/dist@main/jenkins/init-jenkins.groovy" || \
    exit 1
popd || exit 1
pushd "${host_data}" || exit 1
    curl -O -f#SL --retry 1 "https://github.com/dyrnq/dist/raw/main/jenkins/jvm.options" || \
    curl -O -f#SL --retry 10 "https://fastly.jsdelivr.net/gh/dyrnq/dist@main/jenkins/jvm.options" || \
    curl -O -f#SL --retry 10 "https://testingcf.jsdelivr.net/gh/dyrnq/dist@main/jenkins/jvm.options" || \
    exit 1
popd || exit 1

chown -R 1000:1000 ${host_data}


docker rm -f ${name} >/dev/null 2>&1 || true;

docker run -d \
--restart always \
--pull always \
--name ${name} \
-p 8090:8080 \
-p 50000:50000 \
-v ${host_data}/jenkins_home:/var/jenkins_home \
-v ${host_data}/jvm.options:/etc/jvm.options \
-v /var/run/docker.sock:/var/run/docker.sock \
-e TZ=Asia/Shanghai \
-e JENKINS_OPTS="--sessionTimeout=1440 --sessionEviction=43200 --enable-future-java" \
dyrnq/jenkins:2.541.3-jdk21

docker logs -f ${name}
