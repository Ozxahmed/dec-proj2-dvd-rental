


select 
    country, 
    country_id, 
    last_update
    
from {{ source('movie_rental', 'country') }}
order by last_update desc