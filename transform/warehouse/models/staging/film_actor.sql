{{
    config(
        materialized="incremental",
        unique_key=["film_id", "actor_id"],
        incremental_strategy="delete+insert"
    )
}}

select 
    film_id,
    actor_id,
    concat_ws('-', film_id, actor_id) as film_actor_key,
    last_update
from {{ source('movie_rental', 'film_actor') }}

{% if is_incremental() %}
    where last_update > (select max(last_update) from {{ this }} )
{% endif %}

order by last_update asc