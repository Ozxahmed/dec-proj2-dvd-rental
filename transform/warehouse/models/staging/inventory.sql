{{
    config(
        materialized="incremental",
        unique_key=["inventory_id"],
        incremental_strategy="delete+insert"
    )
}}

select
    inventory_id,
    film_id,
    store_id,
    inventory_id,
    last_update
    
from {{ source('movie_rental', 'inventory') }}

{% if is_incremental() %}
    where last_update > (select max(last_update) from {{ this }} )
{% endif %}

order by last_update asc