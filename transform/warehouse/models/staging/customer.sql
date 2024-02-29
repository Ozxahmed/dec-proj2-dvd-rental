

select  
    customer_id,
    email, 
    active, 
    activebool,
    store_id, 
    first_name,
    last_name,
    address_id,
    create_date,
    last_update
    
from {{ source('movie_rental', 'customer') }}
order by last_update desc