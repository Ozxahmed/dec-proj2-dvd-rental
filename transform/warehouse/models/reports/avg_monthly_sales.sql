-- stores by average monthly sales, ordered highest to lowest

select
    i.store_id,
    to_numeric(sum(p.amount) / datediff(day, min(p.payment_date), max(p.payment_date)) * (365/12)) as avg_monthly_sale_$,
    to_numeric(sum(p.amount)) as total_sales_$
from 
    {{ ref('payment') }} as p
inner join {{ ref('rental') }} as r 
    on p.rental_id = r.rental_id
inner join {{ ref('inventory') }} as i
    on r.inventory_id = i.inventory_id
group by
    i.store_id
order by 2 desc