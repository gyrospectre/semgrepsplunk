FROM returntocorp/semgrep-agent:latest

WORKDIR /
COPY execute.sh ./
RUN chmod +x /execute.sh
# Install curl and jq from latest APK
RUN apk add --no-cache curl jq

CMD ["/execute.sh"]