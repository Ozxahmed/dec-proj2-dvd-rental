

select
    {{ dbt_utils.generate_surrogate_key(['customer.customer_id']) }} as customer_key,
    customer.customer_id,
    address.address_id as customer_address_id,
    customer.active as customer_active, 
    customer.store_id as customer_store_id,
    customer.first_name as customer_first_name,
    customer.last_name as customer_last_name,  
    Date(customer.create_date) as customer_create_date,
    address.address as customer_address, 
    address.address2 as customer_address2,
    customer.email as customer_email,
    address.district as cusomer_district, 
    address.postal_code as cusomter_postal_code,
    city.city as customer_city,
    city.city_id as customer_city_id,
    country.country as customer_country,
    country.country_id as customer_country_id,
    customer.last_update as customer_last_updated

from {{ ref('customer')}} as customer
left join {{ ref('address')}} as address
    on customer.address_id = address.address_id
left join {{ ref('city')}} as city 
    on address.city_id = city.city_id
left join {{ ref('country')}} as country 
    on city.country_id = country.country_id