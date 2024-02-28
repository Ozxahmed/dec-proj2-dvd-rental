import time
import requests
import base64
import logging
from typing import Literal


class AirbyteClient(object):
    FAILED_JOB_STATUS = ["incomplete", "failed", "cancelled"]

    def __init__(self, server_name: str, username: str, password: str) -> bool:
        self.server_name = server_name
        self.username = username
        self.password = password
        self.token = base64.b64encode(
            f"{self.username}:{self.password}".encode()
        ).decode()
        self.headers = {"authorization": f"Basic {self.token}"}
        logging.basicConfig(level=logging.INFO)

    def valid_connection(self) -> bool:
        """Check if connection is valid"""
        url = f"http://{self.server_name}:8006/health"

        try:
            response = requests.get(url=url, headers=self.headers)
            response.raise_for_status()

            return True
        except Exception as e:
            raise Exception(
                f"Invalid Airbyte connection. Status code: {e.response.status_code}. Error message: {e.response.text}"
            )
    
    def trigger_job(self, connection_id: str, job_type: Literal["reset", "sync"] = "sync", polling_seconds: int = 5) -> None:
        """Trigger job (reset or sync) for a connection_id"""
        post_url = f"http://{self.server_name}:8006/v1/jobs"
        post_payload = {
            "connectionId": connection_id,
            "jobType": job_type
        }

        response = requests.post(url=post_url, json=post_payload, headers=self.headers)
        job_id = response.json().get("jobId")

        if (job_status := response.json().get("status")) != "running":
            raise Exception(f"Job {job_id} has failed to start.")
        
        while job_status == "running":
            logging.info(
                f"Job {job_id} is running. Polling job status again in {polling_seconds} seconds."
            )
            time.sleep(polling_seconds)

            get_url = f"http://{self.server_name}:8000/api/v1/jobs/get"
            get_payload = {"id": job_id}

            job_response = requests.post(url=get_url, json=get_payload, headers=self.headers)
            job_status = job_response.json().get("job").get("status")  # update job status
            if job_status == "succeeded":
                logging.info(f"Job {job_id} has ran successfully.")
            elif job_status in self.FAILED_JOB_STATUS:
                raise Exception(f"Job {job_id} has failed. Job status: {job_status}. Error message: {job_response.text}.")
