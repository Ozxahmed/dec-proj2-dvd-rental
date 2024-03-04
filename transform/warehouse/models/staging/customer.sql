{{
    config(
        materialized="incremental",
        unique_key=["customer_id"],
        incremental_strategy="delete+insert"
    )
}}

select  
    customer_id,
    email, 
    active, 
    activebool,
    store_id, 
    first_name,
    last_name,
    address_id,
    create_date,
    last_update
from {{ source('movie_rental', 'customer') }}

{% if is_incremental() %}
    where last_update > (select max(last_update) from {{ this }} )
{% endif %}

order by last_update asc