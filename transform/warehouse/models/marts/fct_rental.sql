with rental_payment as (
    select 
        rental_id, 
        sum(amount) as amount
    from {{ ref('payment') }}
    group by rental_id
)   

select
    {{ dbt_utils.generate_surrogate_key(['r.rental_id']) }} as rental_key,
    {{ dbt_utils.generate_surrogate_key(['r.customer_id']) }} as customer_key,
    {{ dbt_utils.generate_surrogate_key(['r.staff_id']) }} as staff_key,
    {{ dbt_utils.generate_surrogate_key(['i.film_id']) }} as film_key,
    date(r.rental_date) as rental_date,
    date(r.return_date) as return_date,
    rp.amount as amount
from
    {{ ref('rental') }} as r
left join {{ ref('inventory') }} i 
    on r.inventory_id = i.inventory_id
left join rental_payment as rp 
    on r.rental_id = rp.rental_id