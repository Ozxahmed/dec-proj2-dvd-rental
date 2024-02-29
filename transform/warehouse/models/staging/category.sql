

select 
    name as category_name, 
    category_id,
    last_update   
from {{ source('movie_rental', 'category') }}
order by last_update desc