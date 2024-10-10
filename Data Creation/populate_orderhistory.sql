INSERT INTO order_history (order_id, order_status_id, status_date)
SELECT
o.order_id,
1 AS order_status_id,
o.order_date + FLOOR(RANDOM() * 60 * 60 * 12) * '1 second'::interval AS status_date
FROM orders o
WHERE o.order_date < NOW() - '12 hours'::interval;

INSERT INTO order_history (order_id, order_status_id, status_date)
SELECT
o.order_id,
2 AS order_status_id,
o.status_date + FLOOR(RANDOM() * 60 * 60 * 24 * 2) * '1 second'::interval AS status_date
FROM order_history o
WHERE o.status_date < NOW() - '2 days'::interval
ORDER BY RANDOM()
LIMIT 6800;

INSERT INTO order_history (order_id, order_status_id, status_date)
SELECT
o.order_id,
3 AS order_status_id,
o.status_date + FLOOR(RANDOM() * 60 * 60 * 24 * 2) * '1 second'::interval AS status_date
FROM order_history o
WHERE o.status_date < NOW() - '2 days'::interval
AND o.order_status_id = 2
ORDER BY RANDOM()
LIMIT 4000;

INSERT INTO order_history (order_id, order_status_id, status_date)
SELECT
o.order_id,
4 AS order_status_id,
o.status_date + FLOOR(RANDOM() * 60 * 60 * 24 * 6) * '1 second'::interval AS status_date
FROM order_history o
WHERE o.status_date < NOW() - '6 days'::interval
AND o.order_status_id = 3
ORDER BY RANDOM()
LIMIT 3500;

INSERT INTO order_history (order_id, order_status_id, status_date)
SELECT
o.order_id,
5 AS order_status_id,
o.status_date + FLOOR(RANDOM() * 60 * 60 * 24) * '1 second'::interval AS status_date
FROM order_history o
WHERE o.order_status_id = 1
AND NOT EXISTS (
    SELECT 1
    FROM order_history oh
    WHERE oh.order_id = o.order_id
    AND oh.order_status_id = 2
)
ORDER BY RANDOM()
LIMIT 300;

INSERT INTO order_history (order_id, order_status_id, status_date)
SELECT
o.order_id,
6 AS order_status_id,
o.status_date + FLOOR(RANDOM() * 60 * 60 * 24 * 7) * '1 second'::interval AS status_date
FROM order_history o
WHERE o.order_status_id = 1
AND EXISTS (
    SELECT 1
    FROM order_history oh
    WHERE oh.order_id = o.order_id
    AND oh.order_status_id = 4
)
AND o.status_date < NOW() - '7 days'::interval
ORDER BY RANDOM()
LIMIT 200;
