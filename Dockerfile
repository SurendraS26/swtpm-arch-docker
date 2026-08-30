# Sometimes it's better to use arch cause it feels like gem.
ARG ARCH_BASE=archlinux:base
FROM ${ARCH_BASE}

LABEL org.opencontainers.image.title="swtpm-arch" \
      org.opencontainers.image.description="Software TPM 2.0 emulator on Arch Linux" \
      org.opencontainers.image.source="https://github.com/SurendraS26/swtpm-arch-docker" \
      org.opencontainers.image.licenses="MIT" \
      maintainer="Surendra S"


RUN echo -e "\033[1;32m[*]\033[0m \033[1;32mInitializing build sequence...\033[0m" && \
    echo -e "\033[1;36m[>]\033[0m Syncing package database with pacman..." && \
    pacman -Syu --noconfirm --needed swtpm tpm2-tss && \
    echo -e "\033[1;32m[+]\033[0m \033[1;32mswtpm + tpm2-tss installed successfully.\033[0m" && \
    echo -e "\033[1;36m[>]\033[0m Purging package cache..." && \
    pacman -Scc --noconfirm && \
    rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/* && \
    echo -e "\033[1;32m[+]\033[0m \033[1;32mCache wiped. Footprint minimized.\033[0m" && \
    echo -e "\033[1;35m[✓]\033[0m \033[1;35mDependency stage complete.\033[0m"


ENV TPMSTATE_DIR=/var/lib/swtpm/tpmstate \
    SWTPM_SERVER_PORT=2321 \
    SWTPM_CTRL_PORT=2322

RUN echo -e "\033[1;36m[>]\033[0m Provisioning TPM state directory..." && \
    mkdir -p ${TPMSTATE_DIR} && \
    echo -e "\033[1;32m[+]\033[0m \033[1;32m${TPMSTATE_DIR} ready.\033[0m" && \
    echo -e "\033[1;33m[i]\033[0m Awaiting runtime injection..."

VOLUME ["/var/lib/swtpm/tpmstate"]
EXPOSE 2321 2322

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD swtpm_ioctl --tcp 127.0.0.1:2322 -g || exit 1


ENTRYPOINT ["/usr/bin/swtpm"]
CMD ["socket", "--tpm2", \
    "--server", "type=tcp,port=2321,bindaddr=0.0.0.0", \
    "--ctrl",   "type=tcp,port=2322,bindaddr=0.0.0.0", \
    "--flags", "not-need-init", \
    "--tpmstate", "dir=/var/lib/swtpm/tpmstate"]

