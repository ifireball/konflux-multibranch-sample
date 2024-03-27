FROM registry.access.redhat.com/ubi9/ubi:9.3-1610 as builder

RUN \
  yum install -y \
    --disablerepo="*" \
    --enablerepo=ubi-9-baseos-rpms,ubi-9-appstream-rpms \
    git && \
  yum clean all
COPY . /src
RUN \
  cd /src && \
  echo echo "\"$(git branch --show-current)\"" > entrypoint.sh && \
  chmod +x entrypoint.sh

LABEL name="Branch exposing image"
LABEL description="A container image that shows the branch it was built from"
LABEL com.redhat.component="konflux-multibranch-sample"
LABEL io.k8s.description="A container image that shows the branch it was built from"
LABEL io.k8s.display-name="Branch exposing image"

COPY LICENSE /licenses/

USER 65532:65532
