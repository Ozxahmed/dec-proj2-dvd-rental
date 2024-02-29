

select 
    staff_id, 
    rental_id, 
    customer_id,
    rental_date, 
    return_date,
    inventory_id,
    last_update
    
from {{ source('movie_rental', 'rental') }}
order by last_update desc