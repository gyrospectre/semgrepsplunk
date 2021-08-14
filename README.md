# SemgrepSplunk

A Docker image that extends the [returntocorp/semgrep-agent](https://hub.docker.com/r/returntocorp/semgrep-agent) image with the capability to send test results (failures) to Splunk via a [HEC input](https://docs.splunk.com/Documentation/SplunkCloud/8.2.2106/Data/UsetheHTTPEventCollector).

It's intended to be used by adding to your build pipeline to run security scans on build/test, failing if issues are found, and sending the results to Splunk for alerting/reporting and analytics.

## Usage

Execute the `scan-and-log` command in the image, specifying your build environment.

```
Usage: scan-and-log [environment]

environment:
   --bitbucket    Atlassian Bitbucket 
```

A [semgrep](https://semgrep.dev/) scan will be initiated, and results sent to a [Splunk HEC endpoint](https://docs.splunk.com/Documentation/SplunkCloud/8.2.2106/Data/UsetheHTTPEventCollector). Three environment variables control the behaviour:

#### SEMGREP_RULES
A space delimited list of semgrep rulesets to run. Example `SEMGREP_RULES="p/secrets p/ci p/owasp-top-ten p/t2c-security-audit"`

#### SPLUNK_HEC_HOST
The Splunk hostname to send logs to. Example `SPLUNK_HEC_HOST="http-inputs-yourcompany.splunkcloud.com"`

#### SAST_SPLUNK_TOKEN
The Splunk HEC token for your HTTP input, used to authenticate to the endpoint. Example `SAST_SPLUNK_TOKEN="1234ABCD-1234-ABCD-1234-1234ABCD"`

### Bitbucket Pipelines
If you're using Atlassian Bitbucket, the `--bitbucket` switch will add the following [standard Bitbucket env vars](https://support.atlassian.com/bitbucket-cloud/docs/variables-and-secrets/) to the output sent to Splunk. This allows you to filter/report on repo other code repository variables.

    BITBUCKET_BUILD_NUMBER
    BITBUCKET_COMMIT
    BITBUCKET_WORKSPACE
    BITBUCKET_REPO_SLUG
    BITBUCKET_BRANCH
    BITBUCKET_PR_ID
    BITBUCKET_PR_DESTINATION_BRANCH

To run in your pipeline, use something like this in the `bitbucket-pipelines.yml` of your repo:

```yaml
pipelines:
  pull-requests:
    '**':
      - step:
        name: Security Code Scan
        image: gyrospectre/semgrepsplunk
        script:
          - /scan-and-log --bitbucket
```
You can use account level variables to set the Semgrep ruleset account wide, to ensure consistency of scans across all repositories.

## Docker Image
Available on Docker Hub, see https://hub.docker.com/r/gyrospectre/semgrepsplunk.