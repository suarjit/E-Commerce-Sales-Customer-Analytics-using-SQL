CREATE database ecomerce;

USE ecomerce;

SHOW TABLES;

SELECT * FROM olist_customers_dataset;

-- Q1. What is the total number of orders and total revenue?
SELECT (SELECT COUNT(DISTINCT order_id) FROM olist_orders_dataset) AS total_orders,
(SELECT ROUND(SUM(oi.price), 2)
     FROM olist_order_items_dataset oi
     JOIN olist_orders_dataset o
       ON oi.order_id = o.order_id
     WHERE o.order_status <> 'canceled') AS total_revenue;
     
-- Q2. What are the monthly and yearly sales trends?
-- Monthly sales trend
SELECT DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS sales_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS monthly_revenue
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'canceled'
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY sales_month;

-- Yearly sales trend
SELECT YEAR(o.order_purchase_timestamp) AS sales_year,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS yearly_revenue
FROM
    olist_orders_dataset o
        JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
WHERE o.order_status <> 'canceled'
GROUP BY YEAR(o.order_purchase_timestamp)
ORDER BY sales_year;

-- Q3. Which product categories generate the highest revenue?
SELECT p.product_category_name AS category,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o
    ON oi.order_id = o.order_id
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
WHERE o.order_status <> 'canceled'
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;

-- Q4. Which products have the highest sales volume?
SELECT oi.product_id,
    COUNT(*) AS units_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o
    ON oi.order_id = o.order_id
WHERE o.order_status <> 'canceled'
GROUP BY oi.product_id
ORDER BY units_sold DESC
LIMIT 10;

-- Q5. Which sellers generate the highest revenue?
SELECT s.seller_id,s.seller_city,s.seller_state,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS orders_sold
FROM olist_sellers_dataset s
JOIN olist_order_items_dataset oi
    ON s.seller_id = oi.seller_id
JOIN olist_orders_dataset o
    ON oi.order_id = o.order_id
WHERE o.order_status <> 'canceled'
GROUP BY s.seller_id,s.seller_city,s.seller_state
ORDER BY total_revenue DESC
LIMIT 10;

-- Q6. Which cities or states generate the most sales?
SELECT c.customer_state,c.customer_city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'canceled'
GROUP BY c.customer_state,c.customer_city
ORDER BY total_revenue DESC
LIMIT 10;

-- Q7. What is the average order value (AOV)?
WITH order_totals AS ( SELECT o.order_id,
        SUM(oi.price) AS order_revenue
    FROM olist_orders_dataset o
    JOIN olist_order_items_dataset oi
        ON o.order_id = oi.order_id
    WHERE o.order_status <> 'canceled'
    GROUP BY o.order_id
)
SELECT ROUND(AVG(order_revenue), 2) AS average_order_value FROM order_totals;

-- Q8. Which payment methods are most commonly used?
SELECT payment_type, COUNT(*) AS payment_records,
    COUNT(DISTINCT order_id) AS orders_using_method,
    ROUND(SUM(payment_value), 2) AS total_payment_value
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY orders_using_method DESC;

-- Q9. What is the average delivery time?
SELECT ROUND(
       AVG(
            TIMESTAMPDIFF( DAY,order_purchase_timestamp,order_delivered_customer_date)
        ),2) AS average_delivery_days
FROM olist_orders_dataset
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;
  
  -- Q10. Which categories have the highest customer ratings?
SELECT p.product_category_name AS category,
    ROUND(AVG(r.review_score), 2) AS average_rating,
    COUNT(DISTINCT r.review_id) AS review_count
FROM olist_order_reviews_dataset r
JOIN olist_order_items_dataset oi
    ON r.order_id = oi.order_id
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY average_rating DESC;

  -- Q11. Are late deliveries associated with lower review scores?
  SELECT
    CASE
        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
        THEN 'Late'
        ELSE 'On Time or Early'
    END AS delivery_status,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM olist_orders_dataset o
JOIN olist_order_reviews_dataset r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY
    CASE
        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
        THEN 'Late'
        ELSE 'On Time or Early'
    END
ORDER BY average_review_score;

-- Q12. Who are the top customers based on spending
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_spent
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'canceled'
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;

-- Q13. What percentage of orders are canceled?
SELECT
    COUNT(*) AS total_orders,
    SUM(
        CASE
            WHEN order_status = 'canceled' THEN 1
            ELSE 0
        END
    ) AS canceled_orders,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN order_status = 'canceled' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS canceled_percentage
FROM olist_orders_dataset;
-- Q14. Which categories have high sales but poor customer ratings?
SELECT
    p.product_category_name AS category,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(AVG(r.review_score), 2) AS average_rating
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o
    ON oi.order_id = o.order_id
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
LEFT JOIN olist_order_reviews_dataset r
    ON o.order_id = r.order_id
WHERE o.order_status <> 'canceled'
GROUP BY p.product_category_name
HAVING SUM(oi.price) > (
    SELECT AVG(category_revenue)
    FROM (
        SELECT
            p2.product_category_name,
            SUM(oi2.price) AS category_revenue
        FROM olist_order_items_dataset oi2
        JOIN olist_orders_dataset o2
            ON oi2.order_id = o2.order_id
        JOIN olist_products_dataset p2
            ON oi2.product_id = p2.product_id
        WHERE o2.order_status <> 'canceled'
        GROUP BY p2.product_category_name
    ) AS avg_revenue
)
AND AVG(r.review_score) < 3.5
ORDER BY total_revenue DESC;

-- HAVING — Categories with revenue greater than ₹1,00,000
SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o
    ON oi.order_id = o.order_id
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
WHERE o.order_status <> 'canceled'
GROUP BY p.product_category_name
HAVING SUM(oi.price) > 100000
ORDER BY total_revenue DESC;

-- Window functions — Month-over-month revenue comparison
SELECT
    sales_month,
    monthly_revenue,
    LAG(monthly_revenue) OVER (
        ORDER BY sales_month
    ) AS previous_month_revenue
FROM (
    SELECT
        DATE_FORMAT(
            o.order_purchase_timestamp, '%Y-%m'
        ) AS sales_month,
        ROUND(SUM(oi.price), 2) AS monthly_revenue
    FROM olist_orders_dataset o
    JOIN olist_order_items_dataset oi
        ON o.order_id = oi.order_id
    WHERE o.order_status <> 'canceled'
    GROUP BY DATE_FORMAT(
        o.order_purchase_timestamp, '%Y-%m'
    )
) AS monthly_sales
ORDER BY sales_month;

-- Subquery — Products earning above average revenue per product
WITH product_revenue AS (
    SELECT
        oi.product_id,
        SUM(oi.price) AS total_revenue
    FROM olist_order_items_dataset oi
    JOIN olist_orders_dataset o
        ON oi.order_id = o.order_id
    WHERE o.order_status <> 'canceled'
    GROUP BY oi.product_id
)
SELECT
    product_id,
    ROUND(total_revenue, 2) AS total_revenue
FROM product_revenue
WHERE total_revenue > (
    SELECT AVG(total_revenue)
    FROM product_revenue
)
ORDER BY total_revenue DESC;