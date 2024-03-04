select 
    fa.film_id,
    fa.actor_id, 
    a.first_name, 
    a.last_name
from {{ ref('film_actor')}} as fa 
left join {{ ref('actor')}} as a
    on fa.actor_id = a.actor_id