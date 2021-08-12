FROM returntocorp/semgrep-agent:latest

WORKDIR /
COPY execute.sh ./
RUN chmod +x /execute.sh
# Install curl from latest APK
RUN apk add --no-cache curl

CMD ["sh", "execute.sh"]