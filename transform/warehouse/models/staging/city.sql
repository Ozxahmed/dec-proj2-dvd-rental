{{
    config(
        materialized="incremental",
        unique_key=["city_id"],
        incremental_strategy="delete+insert"
    )
}}

select 
    city, 
    city_id, 
    country_id, 
    last_update
from {{ source('movie_rental', 'city') }}

{% if is_incremental() %}
    where last_update > (select max(last_update) from {{ this }} )
{% endif %}

order by last_update asc