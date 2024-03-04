

select 
    inventory_id,
    film_id,
    store_id,
    last_update
    
from {{ source('movie_rental', 'inventory') }}
order by last_update desc