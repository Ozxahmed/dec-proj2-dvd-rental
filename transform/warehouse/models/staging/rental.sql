{{
    config(
        materialized="incremental",
        unique_key=["rental_id"],
        incremental_strategy="delete+insert"
    )
}}

select 
    staff_id, 
    rental_id, 
    customer_id,
    rental_date, 
    return_date,
    inventory_id,
    last_update    
from {{ source('movie_rental', 'rental') }}

{% if is_incremental() %}
    where last_update > (select max(last_update) from {{ this }} )
{% endif %}

order by last_update asc