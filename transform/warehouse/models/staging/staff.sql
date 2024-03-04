{{
    config(
        materialized="incremental",
        unique_key=["staff_id"],
        incremental_strategy="delete+insert"
    )
}}

select 
    email,
    active, 
    picture, 
    password as staff_password, 
    staff_id, 
    store_id, 
    username,
    first_name,
    last_name, 
    address_id,
    last_update
from {{ source('movie_rental', 'staff') }}

{% if is_incremental() %}
    where last_update > (select max(last_update) from {{ this }} )
{% endif %}

order by last_update asc