CREATE TABLE `your_project.your_dataset.order_items` (
  `order_id` INT64,
  `customer_id` INT64
)

ALTER TABLE `your_project.your_dataset.order_items` ADD CONSTRAINT `fk_order_items_order_id` FOREIGN KEY (`order_id`) REFERENCES `your_project.your_dataset.orders` (`order_id`);