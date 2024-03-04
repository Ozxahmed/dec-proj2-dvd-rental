{{
    config(
        materialized="incremental",
        unique_key=["country_id"],
        incremental_strategy="delete+insert"
    )
}}

select 
    country, 
    country_id, 
    last_update  
from {{ source('movie_rental', 'country') }}

{% if is_incremental() %}
    where last_update > (select max(last_update) from {{ this }} )
{% endif %}

order by last_update asc