#!/bin/sh

# Run for rules in SEMGREP_RULES env var
semgrep-agent --json > /output.json
status=$?

# Output to stdout
cat /output.json | jq .

# Log to Splunk HEC
cat /output.json | jq -c '{event: .[]}' | curl -k -H "Authorization: Splunk ${SAST_SPLUNK_TOKEN}" https://${SPLUNK_HEC_HOST}/services/collector/event -d @-

# Exit with status from the semgrep scan
exit $status