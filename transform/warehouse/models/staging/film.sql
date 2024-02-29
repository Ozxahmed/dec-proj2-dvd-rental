

select 
    title, 
    length as film_length, 
    rating, 
    film_id, 
    fulltext, 
    description, 
    language_id, 
    rental_rate, 
    release_year, 
    rental_duration, 
    replacement_cost, 
    special_features,
    last_update
    
from {{ source('movie_rental', 'film') }}
order by last_update desc