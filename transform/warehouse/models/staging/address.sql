

select 
    address_id,
    address,
    address2,
    phone,
    city_id, 
    district, 
    postal_code, 
    last_update
    
from {{ source('movie_rental', 'address') }}
order by last_update desc