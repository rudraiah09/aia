FROM centos:7

RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y \
    curl \
    git \
    iputils \
    ca-certificates \
    jq \
    software-properties-common \
    redhat-lsb-core \
    libicu \
    yum clean all
    

# Install Azure CLI using the Azure RPM package
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
    sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo' && \
    yum install -y azure-cli

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT [ "./start.sh" ]

