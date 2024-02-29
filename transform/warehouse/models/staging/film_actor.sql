



select 
    film_id,
    actor_id,
    last_update
    
from {{ source('movie_rental', 'film_actor') }}
order by last_update desc