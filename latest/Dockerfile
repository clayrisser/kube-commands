FROM alpine:edge

WORKDIR /tmp

ENV PATH="${PATH}:/root/.krew/bin"

RUN apk add --no-cache \
      bash \
      curl \
      git \
      openssl
RUN curl -LO https://dl.k8s.io/release/v1.20.0/bin/linux/amd64/kubectl && \
      install kubectl /usr/local/bin && \
      ln -s /usr/local/bin/kubectl /usr/local/bin/k
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
  chmod 700 get_helm.sh && \
  ./get_helm.sh
RUN ( \
      set -x; cd "$(mktemp -d)" && \
      OS="$(uname | tr '[:upper:]' '[:lower:]')" && \
      ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" && \
      curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" && \
      tar zxvf krew.tar.gz && \
      KREW=./krew-"${OS}_${ARCH}" && \
      "$KREW" install krew \
    ) && \
    export PATH="${PATH}:${HOME}/.krew/bin" && \
    kubectl krew update && \
    kubectl krew upgrade
RUN export PATH="${PATH}:${HOME}/.krew/bin" && \
    kubectl krew install ctx && \
    kubectl krew install ns
RUN rm -rf /tmp/* /tmp/.* 2>&1 | true

ENTRYPOINT /usr/local/bin/kubectl
