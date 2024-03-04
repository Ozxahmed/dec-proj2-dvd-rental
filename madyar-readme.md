# Airbyte ELT Project Documentation

## Overview

This document provides an overview of the ELT project that utilizes Airbyte to extract data from an OLTP (Online Transactional Processing) DVD Rental database stored in PostgreSQL and load it into a "mock" OLAP data warehouse hosted within Snowflake for downstream processing.

## Project Components

### 1. Source Database: DVD Rental Database (OLTP)

The source database is an OLTP system running on PostgreSQL. We have chosen the DVD Rental database as our source system for its realistic simulation of a DVD rental store's operations. The database includes tables such as Customers, Films, Rentals, Inventory, and Payments, providing comprehensive data for analysis.

The DVD Rental database comes pre-populated with sample data, allowing for immediate exploration and analysis without the need for extensive data entry. It serves as an ideal dataset for educational and training purposes, offering a realistic scenario for practicing SQL queries, data analysis, and database management techniques.

### 2. Destination Data Warehouse: Snowflake (OLAP)

Snowflake is the destination data warehouse where the extracted data from the DVD Rental database will be loaded for analytical processing.

## Project Workflow

1. **Extraction (E)**: Airbyte connects to the PostgreSQL database and leverages the enabled Change Data Capture (CDC) functionality to extract data efficiently. CDC ensures that only the changed or updated data since the last extraction is captured. CDC also allows for the capture of hard deletes from source data. 

2. **Loading (L)**: Airbyte loads the extracted data into Snowflake using the appropriate Snowflake connector.

3. **Transformation (T)**: Transformation tasks, if necessary, can be performed with downstream processes such as DBT running against Snowflake. 

## Implementation Steps

1. **Set up Airbyte**:
    - The initial trigger for Airbyte's connection to the PostgreSQL database was facilitated by enabling Change Data Capture (CDC) within the source system.
    - Airbyte utilizes the CDC functionality to track changes in the source database, ensuring that only incremental data is extracted during each extraction cycle.
    - The extracted data is then loaded into Snowflake for further processing and analysis.

2. **Deploy Airbyte on AWS EC2 with SSH Tunneling**:
    - Launch an EC2 instance on AWS and connect to it via SSH.
    - Install Docker and Docker Compose on the EC2 instance.
    - Clone the Airbyte repository and start the Docker containers.
    - Access Airbyte securely via SSH tunneling.

## CDC Functionality Screenshots

Here are some screenshots that demonstrate the CDC functionality working inside Airbyte:

1. **Insert Functionality**:

   ![PostgreSQL insert query](docs\images\insert-query.png)
   ![Airbyte insert extraction](docs\images\insert-airbyte.png)
   ![Snowflake insert results](docs\images\insert-results.png)

2. **Update Functionality**:

   ![PostgreSQL update query](docs\images\update-query.png)
   ![Airbyte update extraction](docs\images\update-airbyte.png)
   ![Snowflake update results on destination table](docs\images\update-results.png)
   ![Updated record inside of airbyte_internals table](docs\images\update-results-2.png)

3. **Delete Functionality**:

   ![PostgreSQL delete query](docs\images\hard-delete-query.png)
   ![Snowflake delete results on destination table](docs\images\hard-delete-results.png)
   ![Deleted record inside of airbyte_internals table](docs\images\hard-delete-results-2.png)

## Conclusion

This documentation provides an overview of the ELT project utilizing Airbyte to extract data from a PostgreSQL database, leveraging the Change Data Capture (CDC) functionality for efficient data extraction, and loading it into Snowflake for analytical purposes. By following the outlined steps and best practices, organizations can efficiently manage their data pipeline, enabling informed decision-making and analysis.
