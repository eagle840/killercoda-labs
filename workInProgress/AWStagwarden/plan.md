# Lab Plan: AWS Boto3 with MiniStack and Jupyter Lab

## Objective
To provide an interactive, hands-on experience using the AWS SDK for Python (`boto3`) to interact with a local AWS-compatible API (MiniStack) from within a Jupyter Lab environment.

## Updated Learning Path

1.  **Environment Setup (MiniStack)**
    - Verify MiniStack is running.
    - Configure AWS CLI to point to the local MiniStack endpoint.
    - Create a test S3 bucket.

2.  **Python Environment Setup**
    - Install Python 3.12 and `venv`.
    - Create and activate a virtual environment.
    - Install `boto3` and `jupyterlab`.

3.  **Jupyter Lab Configuration & Boto3**
    - Launch Jupyter Lab.
    - Configure the notebook environment to connect to MiniStack's endpoint.
    - *Note: Refer to the [official Boto3 documentation](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html) for detailed API references.*

4.  **Hands-on Exercises**
    - Upload/download a dummy file via Boto3 in Jupyter.

5.  **Conclusion**
    - Review of what was learned and how this pattern translates to real AWS usage.
