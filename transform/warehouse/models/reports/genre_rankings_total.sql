-- Top rented genre's across all stores


with genre_rankings as (
    select
    	c.category_name,
    	count(*) as total_rentals
    from {{ ref('rental') }} as r
    inner join {{ ref('inventory') }} as i on 
        r.inventory_id = i.inventory_id
    inner join {{ ref('film_category') }} fc on 
        i.film_id = fc.film_id
    inner join {{ ref('category') }} as c on 
        fc.category_id = c.category_id
    group by 1
)

select
    category_name,
    total_rentals,
    {{ format_2_dec_places("100 * ratio_to_report(total_rentals) over ()") }} as percent_of_total_rentals
from genre_rankings
order by 2 desc