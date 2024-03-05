with top_cust_by_pmnt as (
	select
		p.customer_id,
		sum(p.amount) as total_payment
	from {{ ref('payment') }} p
	group by 1
	order by 2 desc
	limit 10
)

select 
	tcp.customer_id,
	concat_ws(' ', c.first_name, c.last_name) as customer,
	c.store_id,
	tcp.total_payment
from top_cust_by_pmnt tcp
join {{ ref('customer') }} c on
	tcp.customer_id = c.customer_id
order by 4 desc