# add dbt deps 
# add --target prod flag once prod env is created
python -m integration.pipelines.airbyte_extract_load && cd transform/warehouse && dbt build
