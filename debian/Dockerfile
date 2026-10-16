ARG DEBIAN_VERSION_CODENAME=trixie
FROM debian:${DEBIAN_VERSION_CODENAME}
ARG DEBIAN_VERSION_CODENAME

# Make sure we're generating manpages
RUN rm -f /etc/dpkg/dpkg.cfg.d/docker && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update -qq && \
  apt-get install -qq -y --no-install-recommends \
    man-db \
    manpages && \
  rm -rf /var/lib/apt/lists/*

# Install general development packages
RUN export DEBIAN_FRONTEND=noninteractive && \
  apt-get update -qq && \
  apt-get install -qq -y --no-install-recommends \
    coreutils \
    curl \
    ca-certificates \
    cmake \
    build-essential \
    git \
    gnupg \
    iputils-ping \
    libffi-dev \
    libssl-dev \
    libsqlite3-dev \
    libpq-dev \
    libzstd-dev \
    libyaml-dev \
    neovim \
    net-tools \
    openssh-client \
    pkg-config \
    sudo \
    unzip \
    wget \
    zlib1g-dev && \
  rm -rf /var/lib/apt/lists/*

# Create a regular server admin user (e.g., 'sysadmin') with sudo powers
RUN useradd --create-home --shell /bin/bash sysadmin && \
    echo "sysadmin ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/sysadmin && \
    chmod 0440 /etc/sudoers.d/sysadmin

# Cache apt-update for the end-user (so it's faster to install packages later)
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update -qq

# Switch to the new user and set the working directory
USER sysadmin
WORKDIR /home/sysadmin

CMD ["/bin/bash"]
