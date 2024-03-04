

    select 
        film.film_id,
        l.language_id as film_language_id,
        l.language_name,
        fc.category_id,
        cat.category_name,
        film.title, 
        film.film_length, 
        film.rating, 
        film.fulltext, 
        film.description, 
        film.language_id, 
        film.rental_rate, 
        film.release_year, 
        film.rental_duration, 
        film.replacement_cost, 
        film.special_features

    from  {{ ref('film')}} as film
    left join {{ ref('film_category')}} as fc
        on film.film_id = fc.film_id
    left join {{ ref('category')}} as cat
        on fc.category_id = cat.category_id
    left join {{ ref('language') }} as l 
        on film.language_id = l.language_id




