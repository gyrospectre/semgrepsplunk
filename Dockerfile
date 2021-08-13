FROM returntocorp/semgrep-agent:latest

WORKDIR /
COPY scan-and-log ./
RUN chmod +x /scan-and-log
# Install curl and jq from latest APK
RUN apk add --no-cache curl jq

CMD ["/scan-and-log"]