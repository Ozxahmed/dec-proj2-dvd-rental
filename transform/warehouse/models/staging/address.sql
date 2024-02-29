

select 
    phone,
    address,
    address_id, 
    city_id, 
    address2, 
    district, 
    postal_code, 
    last_update
    
from {{ source('movie_rental', 'address') }}
order by last_update desc