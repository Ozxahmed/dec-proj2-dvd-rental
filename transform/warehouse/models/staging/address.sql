

select 
    phone,
    address, 
    city_id, 
    address2, 
    district, 
    postal_code, 
    last_update
    
from {{ source('movie_rental', 'address') }}
order by last_update desc