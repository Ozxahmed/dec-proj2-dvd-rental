-- Top 10 actors

with top_actors as (
	select
		a.actor_id,
		count(*) as total_number_of_rentals
	from {{ ref('rental') }} r
	inner join {{ ref('inventory') }} i on
		r.inventory_id = i.inventory_id
	inner join {{ ref('film_actor') }} fa on
		i.film_id = fa.film_id
	inner join {{ ref('actor') }} a on
		fa.actor_id = a.actor_id
	group by 1
	order by 2 desc
	limit 10
),
movies_acted_in as (
	select
		actor_id,
		count(*) as num_of_movies_acted_in
	from {{ ref('film_actor') }}
	group by 1
	order by 2 desc
)

select
	concat_ws(' ', first_name, last_name) as actor_name,
	num_of_movies_acted_in,
    total_number_of_rentals
from top_actors ta
inner join movies_acted_in mai on
	ta.actor_id = mai.actor_id
inner join {{ ref('actor') }} a on
    ta.actor_id = a.actor_id
order by 2 desc