



select 
    film_id,
    actor_id,
    concat_ws('-', film_id, actor_id) as film_actor_key,
    last_update
    
from {{ source('movie_rental', 'film_actor') }}
order by last_update desc