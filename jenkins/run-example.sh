#!/usr/bin/env bash

proxy=${proxy:-}
noproxy=${noproxy:-}

while [ $# -gt 0 ]; do
    case "$1" in
        --proxy)
            proxy="$2"
            shift
            ;;
        --no-proxy|--noproxy)
            noproxy="$2"
            shift
            ;;
        --*)
            echo "Illegal option $1"
            ;;
    esac
    shift $(( $# > 0 ? 1 : 0 ))
done

# ip4=$(/sbin/ip -o -4 addr list "${iface}" | awk '{print $4}' |cut -d/ -f1 | head -n1);

curl_opts_array=()
if [ -n "${proxy}" ]; then
  curl_opts_array+=("--proxy $proxy")
fi
if [ -n "${noproxy}" ]; then
  curl_opts_array+=("--noproxy $noproxy")
fi
curl_opts="${curl_opts_array[*]}"
echo "curl_opts=${curl_opts}"

name="jenkins"
host_data="/data/jenkins"

mkdir -p "${host_data}/jenkins_home/init.groovy.d"

pushd "${host_data}/jenkins_home/init.groovy.d/" || exit 1
    curl ${curl_opts} -O -f#SL --retry 1 --connect-timeout 5 -m 20 "https://github.com/dyrnq/dist/raw/main/jenkins/init-jenkins.groovy" || \
    curl -O -f#SL --retry 10 "https://fastly.jsdelivr.net/gh/dyrnq/dist@main/jenkins/init-jenkins.groovy" || \
    curl -O -f#SL --retry 10 "https://testingcf.jsdelivr.net/gh/dyrnq/dist@main/jenkins/init-jenkins.groovy" || \
    exit 1
popd || exit 1
pushd "${host_data}" || exit 1
    curl ${curl_opts} -O -f#SL --retry 1 --connect-timeout 5 -m 20 "https://github.com/dyrnq/dist/raw/main/jenkins/jvm.options" || \
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
