{{
    config(
        materialized="incremental",
        unique_key=["category_id"],
        incremental_strategy="delete+insert"
    )
}}

select 
    name as category_name, 
    category_id,
    last_update   
from {{ source('movie_rental', 'category') }}

{% if is_incremental() %}
    where last_update > (select max(last_update) from {{ this }} )
{% endif %}

order by last_update asc