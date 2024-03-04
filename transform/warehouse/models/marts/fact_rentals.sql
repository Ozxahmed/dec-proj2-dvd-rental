with rental_payment as (
    select 
        rental_id, 
        sum(amount) amount
    from {{ ref('payment') }}
    group by rental_id
)   

select
    rental.rental_id,
    inv.inventory_id,
    date(rental_date) as rental_date,
    rental.customer_id,
    date(return_date) as return_date,
    rental.staff_id,
    inv.film_id,
    inv.store_id,
    amount
from
    {{ ref('rental') }} as rental
    left join {{ ref('inventory') }} inv 
        on rental.inventory_id = inv.inventory_id
    left join rental_payment as payment 
        on rental.rental_id = payment.rental_id