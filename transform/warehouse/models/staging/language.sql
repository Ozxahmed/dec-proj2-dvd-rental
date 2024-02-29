

select 
    name as language_name,
    language_id,
    last_update
    
from {{ source('movie_rental', 'language') }}
order by last_update desc