################################################
# 
# `foundry-base` layer is where we build our own foundry container to use as a base image for
# anything that needs to use forge/anvil/cast/etc. This uses thrackle-io/foundry to install
# numbered versions of foundry's tools, using a modified `foundryup` and a foundry.lock file.
# The Foundry tools are installed as precompiled binaries providing a fast build time.
#
# This layer is cached and not re-built unless there is a change to foundry.lock.
################################################

FROM rust:1.78.0-bookworm AS foundry-base

RUN apt update
RUN apt install -y curl unzip git make procps python3 python3-pip python3.11-venv jq gh npm

WORKDIR /usr/local/foundry

COPY foundry.lock .

## Install Foundry via Thrackle's foundryup, using version set in foundry.lock (awk ignores comments)
RUN curl -sSL https://raw.githubusercontent.com/thrackle-io/foundry/refs/heads/master/foundryup/foundryup -o /usr/local/bin/foundryup && \
  chmod +x /usr/local/bin/foundryup && \
  FOUNDRY_DIR=/usr/local foundryup --version $(awk '$1~/^[^#]/' foundry.lock)

################################################
#
# `anvil` layer runs Anvil the local development chain from Foundry
#
# FOUNDRY_PROFILE selects a profile from foundry.toml
# RUST_LOG configures anvil output information. I think. 
# CHAIN_ID is the chain-id Anvil runs on
#
################################################

FROM foundry-base AS anvil
ENV FOUNDRY_PROFILE=docker
ENV RUST_LOG=backend,api,node,rpc=warn
ENV CHAIN_ID=31337
ENTRYPOINT ["/usr/bin/bash", "-c"]
CMD ["anvil", "--host 0.0.0.0", "--chain-id $CHAIN_ID"]
