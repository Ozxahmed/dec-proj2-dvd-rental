{% set film_ratings = ["PG", "NC-17", "R", "G", "PG-13"] %}

select
    year(p.payment_date) as year,
    month(p.payment_date) as month,
    {% for rating in film_ratings %}
        sum(case when f.rating = '{{ rating }}' then p.amount else 0 end) as "{{ rating }}_movie_revenue"
        {%- if not loop.last -%}
            ,
        {% endif %}
    {% endfor %}
from {{ ref('payment') }} p
inner join {{ ref('rental') }} r on 
    p.rental_id = r.rental_id
inner join {{ ref('inventory') }} i on
    r.inventory_id = i.inventory_id
inner join {{ ref('film') }} f on 
    i.inventory_id = f.film_id
group by 1, 2
order by 1, 2
