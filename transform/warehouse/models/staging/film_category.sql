{{
    config(
        materialized="incremental",
        unique_key=["film_id", "category_id"],
        incremental_strategy="delete+insert"
    )
}}

select 
    film_id,
    category_id,
    last_update
from {{ source('movie_rental', 'film_category') }}

{% if is_incremental() %}
    where last_update > (select max(last_update) from {{ this }} )
{% endif %}

order by last_update asc