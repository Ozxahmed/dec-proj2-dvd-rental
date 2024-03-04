-- Top rented genre's by store


with genre_rankings as (
    select
    	c.category_name,
        i.store_id,
    	count(*) as total_rentals
    from {{ ref('rental') }} as r
    inner join {{ ref('inventory') }} as i on 
        r.inventory_id = i.inventory_id
    inner join {{ ref('film_category') }} fc on 
        i.film_id = fc.film_id
    inner join {{ ref('category') }} as c on 
        fc.category_id = c.category_id
    group by 1, 2
)

select
    store_id,
    category_name,
    total_rentals,
    {{ format_2_dec_places("100 * ratio_to_report(total_rentals) over (partition by store_id)") }} as percent_of_total_rentals
from genre_rankings
order by 1 asc, 3 desc