select 
     {{ dbt_utils.star(from=ref('fct_rental'), relation_alias='fct_rental', except=[
          "rental_key", "customer_key", "staff_key", "film_key"]) 
     }},  
     {{ dbt_utils.star(from=ref('dim_staff'), relation_alias='dim_staff', except=[
          "staff_key"]) 
     }},  
     {{ dbt_utils.star(from=ref('dim_film'), relation_alias='dim_film', except=[
          "film_key"]) 
     }},  
     {{ dbt_utils.star(from=ref('dim_film_actor'), relation_alias='dim_film_actor', except=[
          "actor_key", "film_actor_key", "film_key", "film_id", "title"]) 
     }},  
     {{ dbt_utils.star(from=ref('dim_date'), relation_alias='dim_date', except=[])
     }},  
     {{ dbt_utils.star(from=ref('dim_customer'), relation_alias='dim_customer', except=[
          "customer_key"]) 
     }},  
from 
     {{ ref('fct_rental') }} as fct_rental
inner join {{ ref('dim_staff') }} as dim_staff 
     on fct_rental.staff_key=dim_staff.staff_key
inner join {{ ref('dim_film') }} as dim_film 
     on fct_rental.film_key=dim_film.film_key
inner join {{ ref('dim_film_actor') }} as dim_film_actor 
     on dim_film.film_key=dim_film_actor.film_key
inner join {{ ref('dim_customer') }} as dim_customer 
     on fct_rental.customer_key=dim_customer.customer_key
inner join {{ ref('dim_date') }} as dim_date 
     on fct_rental.rental_date=dim_date.date_day


