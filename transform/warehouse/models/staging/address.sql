{{
    config(
        materialized="incremental",
        unique_key=["address_id"],
        incremental_strategy="delete+insert"
    )
}}

select 
    address_id,
    address,
    address2,
    phone,
    city_id, 
    district, 
    postal_code, 
    last_update
from {{ source('movie_rental', 'address') }}

{% if is_incremental() %}
    where last_update > (select max(last_update) from {{ this }} )
{% endif %}

order by last_update asc