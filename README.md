# POC project for Argo Workflows

# Reference documents

1. [Workflow-related CRD specifications](https://argo-workflows.readthedocs.io/en/latest/fields/)
2. [Sensor CRD specification](https://github.com/argoproj/argo-events/blob/master/api/sensor.md)

# Steps taken

## Helm installation

1. Add the Helm repo
    ```sh
    helm repo add argo https://argoproj.github.io/argo-helm;
    ```
2. Search for the `argo/argo-workflows` Helm chart
    ```sh
    helm search repo argo-workflows

    # sample output
    NAME                    CHART VERSION   APP VERSION     DESCRIPTION                                       
    argo/argo-workflows     0.40.3          v3.5.2          A Helm chart for Argo Workflows
    ```
3. Added correct version (`0.40.3`` in above example output) as a chart dependency
4. Run `helm dep update`
