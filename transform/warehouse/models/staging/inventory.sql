

select 
    film_id,
    store_id,
    inventory_id,
    last_update
    
from {{ source('movie_rental', 'inventory') }}
order by last_update desc