with rental_payment as (
    select 
        rental_id, 
        sum(amount) amount
    from {{ ref('payment') }}
    group by rental_id
)   

select
    {{ dbt_utils.generate_surrogate_key(['rental.rental_id']) }} as rental_key,
    {{ dbt_utils.generate_surrogate_key(['inventory.inventory_id']) }} as inventory_key,
    rental.rental_id,
    inventory.inventory_id,
    date(rental_date) as rental_date,
    rental.customer_id,
    date(return_date) as return_date,
    rental.staff_id,
    inventory.film_id,
    inventory.store_id,
    amount
from
    {{ ref('rental') }} as rental
    left join {{ ref('inventory') }} inventory 
        on rental.inventory_id = inventory.inventory_id
    left join rental_payment as payment 
        on rental.rental_id = payment.rental_id