{{
    config(
        materialized="incremental",
        unique_key=["language_id"],
        incremental_strategy="delete+insert"
    )
}}

select 
    name as language_name,
    language_id,
    last_update
from {{ source('movie_rental', 'language') }}

{% if is_incremental() %}
    where last_update > (select max(last_update) from {{ this }} )
{% endif %}

order by last_update asc