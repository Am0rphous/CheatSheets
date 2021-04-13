# Gitlab

### Commands
````powershell
sudo gitlab-rake gitlab:check > gitlab-rake.log
````

### Clean up
- [Clean up](https://docs.gitlab.com/ee/raketasks/cleanup.html#remove-orphan-artifact-files)
````powershell
sudo gitlab-rake gitlab:cleanup:orphan_job_artifact_files DRY_RUN=false              # deletes orphan job artefacts
````
