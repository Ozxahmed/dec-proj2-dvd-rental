


select 
    film_id,
    category_id,
    last_update
    
from {{ source('movie_rental', 'film_category') }}
order by last_update desc