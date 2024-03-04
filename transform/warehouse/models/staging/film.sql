{{
    config(
        materialized="incremental",
        unique_key=["film_id"],
        incremental_strategy="delete+insert"
    )
}}

select 
    title, 
    length as film_length, 
    rating, 
    film_id, 
    fulltext, 
    description, 
    language_id, 
    rental_rate, 
    release_year, 
    rental_duration, 
    replacement_cost, 
    special_features,
    last_update
from {{ source('movie_rental', 'film') }}

{% if is_incremental() %}
    where last_update > (select max(last_update) from {{ this }} )
{% endif %}

order by last_update asc