

select 
    email,
    active, 
    picture, 
    password as staff_password, 
    staff_id, 
    store_id, 
    username,
    first_name,
    last_name, 
    address_id,
    last_update
    
from {{ source('movie_rental', 'staff') }}
order by last_update desc