{{
    config(
        materialized="incremental",
        unique_key=["store_id"],
        incremental_strategy="delete+insert"
    )
}}

select 
    store_id, 
    address_id,
    manager_staff_id,
    last_update    
from {{ source('movie_rental', 'store') }}

{% if is_incremental() %}
    where last_update > (select max(last_update) from {{ this }} )
{% endif %}

order by last_update asc