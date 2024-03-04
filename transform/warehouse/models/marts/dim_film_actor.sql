select
    {{ dbt_utils.generate_surrogate_key(['a.actor_id']) }} as actor_key,
    a.actor_id,
    a.first_name, 
    a.last_name,
    fa.film_id,
    f.title,
    fa.film_actor_key
from {{ ref('actor')}} as a
inner join {{ ref('film_actor')}} as fa on
    a.actor_id = fa.actor_id
inner join {{ ref('film') }} as f on
    fa.film_id = f.film_id