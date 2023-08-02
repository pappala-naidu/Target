CREATE VIEW `your_project.your_dataset.vw_recent_sales` AS
SELECT product_id, product_name, quantity, sales_date
FROM `your_project.your_dataset.sales_data`
WHERE sales_date >= CURRENT_DATE - INTERVAL '30' DAY;