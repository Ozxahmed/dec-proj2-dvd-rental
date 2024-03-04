{{
    config(
        materialized="incremental",
        unique_key=["actor_id"],
        incremental_strategy="delete+insert"
    )
}}

select 
    actor_id,
    first_name, 
    last_name,  
    last_update
    
from {{ source('movie_rental', 'actor') }}

{% if is_incremental() %}
    where last_update > (select max(last_update) from {{ this }} )
{% endif %}

order by last_update asc
