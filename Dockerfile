# reference : https://github.com/google/cadvisor/blob/master/deploy/Dockerfile
FROM registry-jinan-lab.inspurcloud.cn/library/os/inspur-alpine-3.10:5.0.0

RUN echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf


COPY  cadvisor /usr/bin/cadvisor

EXPOSE 9125

HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --quiet --tries=1 --spider http://localhost:9125/healthz || exit 1

CMD ["-logtostderr","--store_container_labels=false","--docker_only=true","--disable_metrics=percpu,hugetlb,sched,tcp,udp,advtcp,process,network,disk"]

ENTRYPOINT ["/usr/bin/cadvisor"]
