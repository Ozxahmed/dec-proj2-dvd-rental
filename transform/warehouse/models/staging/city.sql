

select 
    city, 
    city_id, 
    country_id, 
    last_update
    
from {{ source('movie_rental', 'city') }}
order by last_update desc