FROM archlinux:base
RUN pacman -Syu --noconfirm --needed swtpm && \
    pacman -Scc --noconfirm && \
    rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/*
RUN mkdir -p /var/lib/swtpm/tpmstate
COPY start.sh .
RUN chmod +x start.sh
ENTRYPOINT ["./start.sh"]

