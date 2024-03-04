-- Top rented film rating by store

with rating_rankings as (
    select
    	f.rating,
        i.store_id,
    	count(*) as total_rentals
    from {{ ref('rental') }} as r
    inner join {{ ref('inventory') }} as i
        on r.inventory_id = i.inventory_id
    inner join {{ ref('film') }} as f
        on i.film_id = f.film_id
    group by 1, 2
)

select
    store_id,
    rating,
    total_rentals,
    {{ format_2_dec_places("100 * ratio_to_report(total_rentals) over (partition by store_id)") }} as percent_of_total
from rating_rankings
order by 1 asc, 3 desc