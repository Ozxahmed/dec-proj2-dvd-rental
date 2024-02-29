

select 
    customer_id,
    address.address_id as customer_address_id,
    active as customer_active, 
    store_id as customer_store_id,
    first_name as customer_first_name,
    last_name as customer_last_name,  
    Date(create_date) as customer_create_date,
    address as customer_address, 
    address2 as customer_address2,
    email as customer_email,
    district as cusomer_district, 
    postal_code as cusomter_postal_code,
    city as customer_city,
    city_id as customer_city_id,
    country as customer_country,
    country_id as customer_country_id,
    last_update as customer_last_updated

from {{ ref('customer')}} as customer
left join {{ ref('dim_address')}} as address
    on customer.address_id = address.address_id
