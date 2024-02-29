

select 
    store_id, 
    address_id,
    manager_staff_id,
    last_update
    
from {{ source('movie_rental', 'store') }}
order by last_update desc