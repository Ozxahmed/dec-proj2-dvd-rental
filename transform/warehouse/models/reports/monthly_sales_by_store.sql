SELECT
    i.store_id,
    SUM(CASE WHEN EXTRACT(MONTH FROM p.payment_date) = 2 THEN p.amount ELSE 0 END) AS "2007_month_2",
    SUM(CASE WHEN EXTRACT(MONTH FROM p.payment_date) = 3 THEN p.amount ELSE 0 END) AS "2007_month_3",
    SUM(CASE WHEN EXTRACT(MONTH FROM p.payment_date) = 4 THEN p.amount ELSE 0 END) AS "2007_month_4",
	SUM(CASE WHEN EXTRACT(MONTH FROM p.payment_date) = 5 THEN p.amount ELSE 0 END) AS "2007_month_5",
    SUM(p.amount) AS total_sales
FROM
    {{ ref('payment') }} p
inner join {{ ref('rental') }} r on
	p.rental_id = r.rental_id
inner join {{ ref('inventory') }} i on
	r.inventory_id = i.inventory_id
GROUP BY
    i.store_id
ORDER BY
    i.store_id