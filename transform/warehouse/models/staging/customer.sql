

select 
    active, 
    store_id,
    first_name,
    last_name, 
    activebool, 
    address_id,
    create_date,
    customer_id,
    last_update
    
from {{ source('movie_rental', 'customer') }}
order by last_update desc