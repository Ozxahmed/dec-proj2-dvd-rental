

select 
    {{ dbt_utils.generate_surrogate_key(['address.address_id']) }} as address_key,
    address.address_id,
    address.address, 
    address.address2,
    address.district, 
    address.postal_code,
    city,
    city.city_id,
    country,
    country.country_id
from {{ ref('address') }} as address
left join {{ ref('city')}} as city 
    on address.city_id = city.city_id
left join {{ ref('country')}} as country 
    on city.country_id = country.country_id

