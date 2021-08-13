# semgrepsplunk
Docker image extending the Semgrep agent with the capability to log to Splunk HEC


docker build -t gyrospectre/semgrepsplunk .

export SEMGREP_RULES="p/ci p/owasp-top-ten p/security-audit"
docker run -v $(pwd):/src --workdir /src -e SEMGREP_RULES gyrospectre/semgrepsplunk
