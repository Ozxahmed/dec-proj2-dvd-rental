
select
    actor_id,
    first_name,
    last_name,
    last_update
from {{ source('movie_rental', 'actor') }}
