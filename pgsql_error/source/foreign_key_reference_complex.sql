
CREATE TABLE `prajwal_test.customers` (
  `customer_id` INT64,
  `customer_name` STRING(100),
  `customer_email` STRING(100)
);

-- Create the 'orders' table
CREATE TABLE `prajwal_test.orders` (
  `order_id` INT64,
  `order_date` DATETIME,
  `customer_id` INT64
);

-- Create the 'products' table
CREATE TABLE `prajwal_test.products` (
  `product_id` INT64,
  `product_name` STRING(100),
  `product_price` NUMERIC
);

-- Create the 'order_items' table (Assuming it already exists)
CREATE TABLE `prajwal_test.order_items` (
  `order_item_id` INT64,
  `order_id` INT64,
  `product_id` INT64,
  `quantity` INT64
);

-- Add foreign key reference to 'orders' table
ALTER TABLE `prajwal_test.order_items`
ADD CONSTRAINT `fk_order_items_orders` FOREIGN KEY (`order_id`) REFERENCES `prajwal_test.orders`(`order_id`);

-- Add foreign key reference to 'products' table
ALTER TABLE `prajwal_test.order_items`
ADD CONSTRAINT `fk_order_items_products` FOREIGN KEY (`product_id`) REFERENCES `prajwal_test.products`(`product_id`);
