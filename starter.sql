-- targil_1

-- מספר הזמנות לעובד: ספור את מספר ההזמנות שטופלו על ידי כל עובד.

--  הצג את שם העובד ומספר ההזמנות בהן טיפל.

SELECT
    e.first_name || ' ' || e.last_name AS full_name,
    COUNT(o.employee_id) AS orders_handel
FROM employees AS e
    INNER JOIN Orders AS o ON e.employee_id = o.employee_id
GROUP BY
    first_name,
    last_name
ORDER BY orders_handel;

-- targil_2

-- כתוב שאילתה כדי למצוא את סכום המכירות הכולל עבור כל קטגוריית מוצר במסד הנתונים,

--  הצג את שם הקטגוריה ואת סכום המכירות הכולל בסדר יורד של המכירות.

SELECT
    ca.category_name AS "category name",
    SUM(
        od.quantity * od.unit_price * (1 - od.discount)
    ) AS sum_all
FROM categories AS ca
    INNER JOIN products AS pr ON pr.category_id = ca.category_id
    INNER JOIN order_details AS od ON od.product_id = pr.product_id
GROUP BY category_name
ORDER BY sum_all DESC;

-- targil_3

-- מחיר הזמנה ממוצע: חשב את מחיר ההזמנה הממוצע עבור כל לקוח.

-- הצג את שם הלקוח ואת מחיר ההזמנה הממוצע שלו, ממוין מהגבוה לנמוך ביותר.

SELECT
    co.customer_id AS customer_name,
    AVG(o.ship_via * o.freight) AS sum_all
FROM customers AS co
    INNER JOIN orders AS o ON o.customer_id = co.customer_id
GROUP BY customer_name
ORDER BY sum_all DESC;

-- targil_4

-- 10 הלקוחות המובילים לפי הוצאה כוללת:

-- כתוב שאילתה כדי למצוא את 10 הלקוחות המובילים שהוציאו את הסכום הגבוה ביותר בסך הכל.

SELECT customer_id, freight
FROM orders
WHERE freight > 604
ORDER BY freight DESC;

-- targil_5

-- סה"כ מכירות חודשיות: חשב את סך המכירות עבור כל חודש.

-- הצג את החודש ואת סכום המכירות הכולל לאותו חודש. מיין את התוצאות לפי חודש.

SELECT order_id, order_date
FROM orders
WHERE
    date_part(order_date) = 01
ORDER BY order_date;

-- targil_6

-- מוצרים עם מלאי נמוך: מצא מוצרים במסד הנתונים שיש להם רמת מלאי מתחת לסף מסוים

-- (למשל, פחות מ-10 יחידות). הצג את שם המוצר ואת רמת המלאי הנוכחית.

SELECT
    product_name,
    units_in_stock
FROM products
WHERE units_in_stock < 10;

-- targil_7

-- לקוח עם ההזמנה היחידה הגבוהה ביותר: זהה את הלקוח שביצע את ההזמנה היחידה הגבוהה ביותר מבחינת כמות ההזמנה.

--  הצג את שם הלקוח ואת סכום ההזמנה.

SELECT
    o.customer_id AS "name", (
        MAX(od.quantity) * (od.unit_price)
    ) AS price
FROM order_details AS od
    INNER JOIN orders AS o ON o.order_id = od.order_id
GROUP BY
    customer_id,
    unit_price
ORDER BY customer_id
WHERE;

-- targil_8

-- סך ההכנסה לפי מדינה: חשב את סך ההכנסות שנוצרו על ידי הזמנות בכל מדינה.

-- הצג את המדינה ואת סך ההכנסות בסדר יורד של ההכנסה.

SELECT
    ship_country,
    count(ship_country) AS orders_num,
    count(ship_country) * sum(freight)
FROM orders
GROUP BY ship_country

-- targil_9

-- השולח הפופולרי ביותר: קבע את השולח ששימש את מירב ההזמנות.

--  הצג את שם השולח ואת מספר ההזמנות בהן טיפל.

SELECT
    s.company_name,
    count(o.ship_via)
FROM shippers AS s
    INNER JOIN orders AS o ON s.shipper_id = o.ship_via
GROUP BY company_name;

-- targil_10

-- מוצרים ללא מכירות: מצא מוצרים שעדיין לא נמכרו. הצג את שם המוצר וכל מידע רלוונטי.

SELECT
    product_name,
    units_on_order
from products
WHERE units_on_order = 0
ORDER BY product_name;
