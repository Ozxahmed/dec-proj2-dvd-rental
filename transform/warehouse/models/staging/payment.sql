{{
    config(
        incremental_strategy="append"
    )
}}

select 
    amount, 
    staff_id, 
    rental_id,
    payment_id, 
    customer_id,
    payment_date
from {{ source('movie_rental', 'payment') }}
order by payment_date asc