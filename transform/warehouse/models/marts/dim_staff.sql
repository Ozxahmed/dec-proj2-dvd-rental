select 
    {{ dbt_utils.generate_surrogate_key(['staff.staff_id']) }} as staff_key,
    staff.staff_id as staff_id,
    staff.store_id as staff_store_id, 
    staff.address_id as staff_address_id,
    staff.username as staff_username,
    staff.first_name as staff_first_name,
    staff.last_name as staff_last_name,
    staff.email as staff_email,
    staff.active as staff_active,
    address.address as staff_address,
    address.phone as staff_phone, 
    address.city_id as staff_city_id,
    address.district as staff_district, 
    address.postal_code as staff_postal_code,
    city.city as staff_city,
    city.country_id as staff_country_id,
    country.country as staff_country
from {{ ref('staff')}} as staff
left join {{ ref('address')}} as address
    on staff.address_id = address.address_id
left join {{ ref('city')}} as city 
    on address.city_id = city.city_id
left join {{ ref('country')}} as country 
    on city.country_id = country.country_id


