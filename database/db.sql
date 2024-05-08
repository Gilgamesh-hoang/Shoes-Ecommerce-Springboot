-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.24-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for shoes_project
DROP DATABASE IF EXISTS `shoes_project`;
CREATE DATABASE IF NOT EXISTS `shoes_project` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `shoes_project`;

-- Dumping structure for table shoes_project.carts
CREATE TABLE IF NOT EXISTS `carts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKb5o626f86h46m4s7ms6ginnop` (`user_id`),
  CONSTRAINT `FKb5o626f86h46m4s7ms6ginnop` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoes_project.carts: ~1 rows (approximately)
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;

-- Dumping structure for table shoes_project.cart_items
CREATE TABLE IF NOT EXISTS `cart_items` (
  `cart_id` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_size_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKpcttvuq4mxppo8sxggjtn5i2c` (`cart_id`),
  KEY `FK9xlv8dspuhuu3bgbomkopnjk8` (`product_size_id`),
  CONSTRAINT `FK9xlv8dspuhuu3bgbomkopnjk8` FOREIGN KEY (`product_size_id`) REFERENCES `product_sizes` (`id`),
  CONSTRAINT `FKpcttvuq4mxppo8sxggjtn5i2c` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoes_project.cart_items: ~0 rows (approximately)
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;

-- Dumping structure for table shoes_project.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(4) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoes_project.categories: ~8 rows (approximately)
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `is_deleted`, `created_at`, `code`, `name`) VALUES
	(1, 0, '2024-04-23 21:27:33', 'tennis', 'Tennis'),
	(2, 0, '2024-04-23 21:27:33', 'jordan', 'Jordan'),
	(3, 0, '2024-04-23 21:27:33', 'training-gym', 'Training & Gym'),
	(4, 0, '2024-04-23 21:27:33', 'football', 'Football'),
	(5, 0, '2024-04-23 21:27:33', 'basketball', 'Basketball'),
	(6, 0, '2024-04-23 21:27:33', 'running', 'Running'),
	(8, 1, '2024-04-26 15:36:22', 'isDeleted', ''),
	(15, 1, '2024-05-04 14:02:06', 'nuoc-epsadfasdas', 'soccercascz');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Dumping structure for table shoes_project.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(4) DEFAULT 0,
  `shipping_fee` int(11) DEFAULT 0,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `address` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK32ql8ubntj5uh44ph9659tiih` (`user_id`),
  CONSTRAINT `FK32ql8ubntj5uh44ph9659tiih` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoes_project.orders: ~0 rows (approximately)
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- Dumping structure for table shoes_project.order_items
CREATE TABLE IF NOT EXISTS `order_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(4) DEFAULT 0,
  `order_id` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `product_size_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbioxgbv59vetrxe0ejfubep1w` (`order_id`),
  KEY `FK9gp0n00qkdvf0jnobmixya9dq` (`product_size_id`),
  CONSTRAINT `FK9gp0n00qkdvf0jnobmixya9dq` FOREIGN KEY (`product_size_id`) REFERENCES `product_sizes` (`id`),
  CONSTRAINT `FKbioxgbv59vetrxe0ejfubep1w` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoes_project.order_items: ~0 rows (approximately)
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;

-- Dumping structure for table shoes_project.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `short_description` mediumtext DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `price` double(10,1) DEFAULT NULL,
  `is_deleted` tinyint(4) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `is_hot` tinyint(4) DEFAULT 0,
  `discount` float(2,1) DEFAULT 0.0,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKog2rp4qthbtt2lfyhfo32lsw9` (`category_id`),
  CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoes_project.products: ~12 rows (approximately)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `name`, `description`, `thumbnail`, `short_description`, `category_id`, `price`, `is_deleted`, `created_at`, `is_hot`, `discount`, `quantity`) VALUES
	(1, 'Nike Air Max 90', '<p>You gotta know where you\'ve been to know where you\'re going. We took that to heart when creating the Stay Loyal 3, a modern shoe built on the Air Jordan legacy. Inside and out, they\'re made for versatility, with minimalist looks, cloud-like cushioning and design elements that echo the AJ4. In other words, style with proven lasting power.</p><p><strong>Benefits</strong></p><ul><li>AJ4 design elements come through in the upper and the midsole.</li><li>Leather and textiles in the upper gives you a shoe built to last.</li><li>Nike Air technology absorbs impact for cushioning with every step.</li><li>Heel pull-tab gets you in and out of your shoes with ease.</li></ul><p><strong>Product details</strong></p><ul><li>Embroidered Jumpman on tongue</li><li>Screen-printed logos</li><li>Colour Shown: White/Wolf Grey/Team Red</li><li>Style: FB1396-160</li><li>Country/Region of Origin: Vietnam</li></ul>', 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810491/mjoawalgi2xnzopicgxq.webp', 'Inspired by the original that debuted in 1985, the Air Jordan 1 Low offers a clean, classic look that\\\'s familiar yet always fresh.', 6, 101.7, 0, '2024-04-23 21:35:13', 1, 0.2, 50),
	(2, 'Nike Tech Hera', '<p>You gotta know where you\'ve been to know where you\'re going. We took that to heart when creating the Stay Loyal 3, a modern shoe built on the Air Jordan legacy. Inside and out, they\'re made for versatility, with minimalist looks, cloud-like cushioning and design elements that echo the AJ4. In other words, style with proven lasting power.</p><p><strong>Benefits</strong></p><ul><li>AJ4 design elements come through in the upper and the midsole.</li><li>Leather and textiles in the upper gives you a shoe built to last.</li><li>Nike Air technology absorbs impact for cushioning with every step.</li><li>Heel pull-tab gets you in and out of your shoes with ease.</li></ul><p><strong>Product details</strong></p><ul><li>Embroidered Jumpman on tongue</li><li>Screen-printed logos</li><li>Colour Shown: White/Wolf Grey/Team Red</li><li>Style: FB1396-160</li><li>Country/Region of Origin: Vietnam</li></ul>', 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810580/ox1dmaac4h6dlezkzclv.webp', 'Rooted in early 2000s running, the Tech Hera is here to fulfill all of your chunky sneaker wishes.', 2, 175.2, 0, '2024-04-23 21:35:44', 1, 0.1, 50),
	(3, 'Nike Mercurial Superfly 9 Club', '<p>You gotta know where you\'ve been to know where you\'re going. We took that to heart when creating the Stay Loyal 3, a modern shoe built on the Air Jordan legacy. Inside and out, they\'re made for versatility, with minimalist looks, cloud-like cushioning and design elements that echo the AJ4. In other words, style with proven lasting power.</p><p><strong>Benefits</strong></p><ul><li>AJ4 design elements come through in the upper and the midsole.</li><li>Leather and textiles in the upper gives you a shoe built to last.</li><li>Nike Air technology absorbs impact for cushioning with every step.</li><li>Heel pull-tab gets you in and out of your shoes with ease.</li></ul><p><strong>Product details</strong></p><ul><li>Embroidered Jumpman on tongue</li><li>Screen-printed logos</li><li>Colour Shown: White/Wolf Grey/Team Red</li><li>Style: FB1396-160</li><li>Country/Region of Origin: Vietnam</li></ul>', 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810627/csfww6e6xqjxpvf36a5h.webp', 'Instantly tilt the pitch in the bold design of the light and low-to-the-ground Superfly 9 Club MG.', 3, 170.7, 0, '2024-04-23 21:37:27', 1, 0.2, 50),
	(4, 'Nike Go FlyEase', '<p>You gotta know where you\'ve been to know where you\'re going. We took that to heart when creating the Stay Loyal 3, a modern shoe built on the Air Jordan legacy. Inside and out, they\'re made for versatility, with minimalist looks, cloud-like cushioning and design elements that echo the AJ4. In other words, style with proven lasting power.</p><p><strong>Benefits</strong></p><ul><li>AJ4 design elements come through in the upper and the midsole.</li><li>Leather and textiles in the upper gives you a shoe built to last.</li><li>Nike Air technology absorbs impact for cushioning with every step.</li><li>Heel pull-tab gets you in and out of your shoes with ease.</li></ul><p><strong>Product details</strong></p><ul><li>Embroidered Jumpman on tongue</li><li>Screen-printed logos</li><li>Colour Shown: White/Wolf Grey/Team Red</li><li>Style: FB1396-160</li><li>Country/Region of Origin: Vietnam</li></ul>', 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810644/u4zhch4vot22jxrd8cgu.webp', 'Ditch the laces and get outside. These kicks feature Nike\\\'s revolutionary FlyEase technology, making on-and-off a breeze', 4, 127.8, 0, '2024-04-23 21:37:34', 1, 0.1, 50),
	(5, 'Nike Air Huarache Runner', '<p>You gotta know where you\'ve been to know where you\'re going. We took that to heart when creating the Stay Loyal 3, a modern shoe built on the Air Jordan legacy. Inside and out, they\'re made for versatility, with minimalist looks, cloud-like cushioning and design elements that echo the AJ4. In other words, style with proven lasting power.</p><p><strong>Benefits</strong></p><ul><li>AJ4 design elements come through in the upper and the midsole.</li><li>Leather and textiles in the upper gives you a shoe built to last.</li><li>Nike Air technology absorbs impact for cushioning with every step.</li><li>Heel pull-tab gets you in and out of your shoes with ease.</li></ul><p><strong>Product details</strong></p><ul><li>Embroidered Jumpman on tongue</li><li>Screen-printed logos</li><li>Colour Shown: White/Wolf Grey/Team Red</li><li>Style: FB1396-160</li><li>Country/Region of Origin: Vietnam</li></ul>', 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810668/srl3k225uiowt5rv3evf.webp', 'When it fits this well and looks this good, it doesn\\\'t need a Swoosh logo.', 5, 126.9, 0, '2024-04-23 21:37:44', 0, 0.0, 50),
	(6, 'Nike Waffle Debut', '<p>You gotta know where you\'ve been to know where you\'re going. We took that to heart when creating the Stay Loyal 3, a modern shoe built on the Air Jordan legacy. Inside and out, they\'re made for versatility, with minimalist looks, cloud-like cushioning and design elements that echo the AJ4. In other words, style with proven lasting power.</p><p><strong>Benefits</strong></p><ul><li>AJ4 design elements come through in the upper and the midsole.</li><li>Leather and textiles in the upper gives you a shoe built to last.</li><li>Nike Air technology absorbs impact for cushioning with every step.</li><li>Heel pull-tab gets you in and out of your shoes with ease.</li></ul><p><strong>Product details</strong></p><ul><li>Embroidered Jumpman on tongue</li><li>Screen-printed logos</li><li>Colour Shown: White/Wolf Grey/Team Red</li><li>Style: FB1396-160</li><li>Country/Region of Origin: Vietnam</li></ul>', 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810693/kp3abhd8qfwa3m6qvy4l.webp', 'Retro gets modernized with these sleek sneaks inspired by the Nike Daybreak.', 6, 151.1, 0, '2024-04-23 21:37:46', 0, 0.0, 50),
	(7, 'Nike Elevate 3', '<p>You gotta know where you\'ve been to know where you\'re going. We took that to heart when creating the Stay Loyal 3, a modern shoe built on the Air Jordan legacy. Inside and out, they\'re made for versatility, with minimalist looks, cloud-like cushioning and design elements that echo the AJ4. In other words, style with proven lasting power.</p><p><strong>Benefits</strong></p><ul><li>AJ4 design elements come through in the upper and the midsole.</li><li>Leather and textiles in the upper gives you a shoe built to last.</li><li>Nike Air technology absorbs impact for cushioning with every step.</li><li>Heel pull-tab gets you in and out of your shoes with ease.</li></ul><p><strong>Product details</strong></p><ul><li>Embroidered Jumpman on tongue</li><li>Screen-printed logos</li><li>Colour Shown: White/Wolf Grey/Team Red</li><li>Style: FB1396-160</li><li>Country/Region of Origin: Vietnam</li></ul>', 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810713/de1ejsguri0jz7zza2mc.jpg', 'Level up your game on both ends of the floor in the Nike Renew Elevate 3', 1, 174.9, 0, '2024-04-23 21:39:01', 0, 0.0, 50),
	(8, 'Nike Air Max SC', '<p>You gotta know where you\'ve been to know where you\'re going. We took that to heart when creating the Stay Loyal 3, a modern shoe built on the Air Jordan legacy. Inside and out, they\'re made for versatility, with minimalist looks, cloud-like cushioning and design elements that echo the AJ4. In other words, style with proven lasting power.</p><p><strong>Benefits</strong></p><ul><li>AJ4 design elements come through in the upper and the midsole.</li><li>Leather and textiles in the upper gives you a shoe built to last.</li><li>Nike Air technology absorbs impact for cushioning with every step.</li><li>Heel pull-tab gets you in and out of your shoes with ease.</li></ul><p><strong>Product details</strong></p><ul><li>Embroidered Jumpman on tongue</li><li>Screen-printed logos</li><li>Colour Shown: White/Wolf Grey/Team Red</li><li>Style: FB1396-160</li><li>Country/Region of Origin: Vietnam</li></ul>', 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810732/hmhecy5a1ccjomfehlfy.jpg', 'With its familiar design lines, heritage track aesthetic and visible Max Air cushioning, the Nike Air Max SC is the perfect way to finish off any outfit', 2, 121.2, 0, '2024-04-23 21:39:06', 0, 0.0, 50),
	(9, 'Nike Air Max 270', '<p>You gotta know where you\'ve been to know where you\'re going. We took that to heart when creating the Stay Loyal 3, a modern shoe built on the Air Jordan legacy. Inside and out, they\'re made for versatility, with minimalist looks, cloud-like cushioning and design elements that echo the AJ4. In other words, style with proven lasting power.</p><p><strong>Benefits</strong></p><ul><li>AJ4 design elements come through in the upper and the midsole.</li><li>Leather and textiles in the upper gives you a shoe built to last.</li><li>Nike Air technology absorbs impact for cushioning with every step.</li><li>Heel pull-tab gets you in and out of your shoes with ease.</li></ul><p><strong>Product details</strong></p><ul><li>Embroidered Jumpman on tongue</li><li>Screen-printed logos</li><li>Colour Shown: White/Wolf Grey/Team Red</li><li>Style: FB1396-160</li><li>Country/Region of Origin: Vietnam</li></ul>', 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810754/dehc6zebdpgt1rh8uya1.jpg', 'Nike\\\'s first lifestyle Air Max brings you style, comfort and big Air in the Nike Air Max 270.', 3, 181.1, 0, '2024-04-23 21:39:08', 0, 0.0, 50),
	(10, 'Nike Air Max 90', '<p>You gotta know where you\'ve been to know where you\'re going. We took that to heart when creating the Stay Loyal 3, a modern shoe built on the Air Jordan legacy. Inside and out, they\'re made for versatility, with minimalist looks, cloud-like cushioning and design elements that echo the AJ4. In other words, style with proven lasting power.</p><p><strong>Benefits</strong></p><ul><li>AJ4 design elements come through in the upper and the midsole.</li><li>Leather and textiles in the upper gives you a shoe built to last.</li><li>Nike Air technology absorbs impact for cushioning with every step.</li><li>Heel pull-tab gets you in and out of your shoes with ease.</li></ul><p><strong>Product details</strong></p><ul><li>Embroidered Jumpman on tongue</li><li>Screen-printed logos</li><li>Colour Shown: White/Wolf Grey/Team Red</li><li>Style: FB1396-160</li><li>Country/Region of Origin: Vietnam</li></ul>', 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810771/ih5aheonnmrngjwota0q.jpg', 'Nothing as fly, nothing as comfortable, nothing as proven.', 4, 142.2, 0, '2024-04-23 21:39:13', 0, 0.0, 50),
	(11, 'Jordan Spizike Low', '<p>You gotta know where you\'ve been to know where you\'re going. We took that to heart when creating the Stay Loyal 3, a modern shoe built on the Air Jordan legacy. Inside and out, they\'re made for versatility, with minimalist looks, cloud-like cushioning and design elements that echo the AJ4. In other words, style with proven lasting power.</p><p><strong>Benefits</strong></p><ul><li>AJ4 design elements come through in the upper and the midsole.</li><li>Leather and textiles in the upper gives you a shoe built to last.</li><li>Nike Air technology absorbs impact for cushioning with every step.</li><li>Heel pull-tab gets you in and out of your shoes with ease.</li></ul><p><strong>Product details</strong></p><ul><li>Embroidered Jumpman on tongue</li><li>Screen-printed logos</li><li>Colour Shown: White/Wolf Grey/Team Red</li><li>Style: FB1396-160</li><li>Country/Region of Origin: Vietnam</li></ul>', 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810795/u6xqbzvlfphizyohyp5q.webp', 'The Spizike takes elements of four classic Jordans, combines them, and gives you one iconic sneaker.', 5, 167.5, 0, '2024-04-23 21:39:18', 0, 0.0, 50),
	(12, 'Air Jordan 1 High G NRG', '<p>You gotta know where you\'ve been to know where you\'re going. We took that to heart when creating the Stay Loyal 3, a modern shoe built on the Air Jordan legacy. Inside and out, they\'re made for versatility, with minimalist looks, cloud-like cushioning and design elements that echo the AJ4. In other words, style with proven lasting power.</p><p><strong>Benefits</strong></p><ul><li>AJ4 design elements come through in the upper and the midsole.</li><li>Leather and textiles in the upper gives you a shoe built to last.</li><li>Nike Air technology absorbs impact for cushioning with every step.</li><li>Heel pull-tab gets you in and out of your shoes with ease.</li></ul><p><strong>Product details</strong></p><ul><li>Embroidered Jumpman on tongue</li><li>Screen-printed logos</li><li>Colour Shown: White/Wolf Grey/Team Red</li><li>Style: FB1396-160</li><li>Country/Region of Origin: Vietnam</li></ul>', 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810812/bk6zrq6c5dl3wrqd9lvk.webp', 'One of the reasons why MJ loves golf so much: It&rsquo;s like looking into a mirror.', 6, 111.0, 0, '2024-04-23 21:39:24', 0, 0.0, 50);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

-- Dumping structure for table shoes_project.product_images
CREATE TABLE IF NOT EXISTS `product_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FKqnq71xsohugpqwf3c9gxmsuy` (`product_id`),
  CONSTRAINT `FKqnq71xsohugpqwf3c9gxmsuy` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoes_project.product_images: ~28 rows (approximately)
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` (`id`, `product_id`, `image_url`, `is_deleted`) VALUES
	(21, 1, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810493/wcpv7iiquisybaolixe3.webp', 0),
	(22, 1, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810493/sqiccypsvzjs0ymhym6i.webp', 0),
	(23, 1, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810493/vehwzrracupitlkige5o.webp', 0),
	(24, 2, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810582/ae6uzy0j0aatmpuwyclj.webp', 0),
	(25, 2, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810582/yiew9m4vuyo7eldxj38w.webp', 0),
	(26, 2, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810582/w2glxayyehenglirjcux.webp', 0),
	(27, 3, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810629/mb0r7sllxbvsivc2h8zb.webp', 0),
	(28, 3, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810629/tjin3yzmzvlobnmckat8.webp', 0),
	(29, 4, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810646/xglf599is3mkc46fmpxe.webp', 0),
	(30, 4, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810646/pjh4wpflwiprwke60rfq.webp', 0),
	(31, 4, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810646/ayubucr57a7ceyz8612x.webp', 0),
	(32, 5, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810670/mzphiu7yucs9antbj6la.jpg', 0),
	(33, 5, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810670/cnpqobtp6cxntysfcjtl.webp', 0),
	(34, 6, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810695/qsipzc0ltyuvynuvz3cc.webp', 0),
	(35, 6, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810695/fspk0cjjchqq8l1vcxcj.webp', 0),
	(36, 7, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810715/kh54kqvcmociylpdklox.jpg', 0),
	(37, 7, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810715/lc37lyihrj9xcqg65xxs.jpg', 0),
	(38, 8, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810735/xuyovyzwympyrhmbnfmb.jpg', 0),
	(39, 8, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810735/itwzajppogbhwoty5dd1.webp', 0),
	(40, 9, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810757/a1ipsgtebb0d0ybzmq4f.jpg', 0),
	(41, 9, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810756/owutokfvpcjfposyijox.jpg', 0),
	(42, 10, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810773/lwcctmyizn4wpbrcsuwh.jpg', 0),
	(43, 10, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810773/hsye4ewrjyaqrx0pu3lm.jpg', 0),
	(44, 11, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810797/b1s3xdylhuhqkhykpfgq.webp', 0),
	(45, 11, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810797/zffnyr84kz3hnraeissh.webp', 0),
	(46, 12, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810815/xai9ypfxs8qukv8y6p3f.webp', 0),
	(47, 12, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810815/imbsjzautymoaeex2ygx.webp', 0),
	(48, 12, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714810814/gfo3ylpp3ktphkfxskbz.webp', 0);
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;

-- Dumping structure for table shoes_project.product_sizes
CREATE TABLE IF NOT EXISTS `product_sizes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(4) DEFAULT 0,
  `product_id` int(11) DEFAULT NULL,
  `size_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK4isa0j51hpdn7cx04m831jic4` (`product_id`),
  KEY `FK3bqabm2nc8yyl9to7fo8trak4` (`size_id`),
  CONSTRAINT `FK3bqabm2nc8yyl9to7fo8trak4` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`),
  CONSTRAINT `FK4isa0j51hpdn7cx04m831jic4` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoes_project.product_sizes: ~70 rows (approximately)
/*!40000 ALTER TABLE `product_sizes` DISABLE KEYS */;
INSERT INTO `product_sizes` (`id`, `is_deleted`, `product_id`, `size_id`, `created_at`) VALUES
	(147, 0, 1, 2, NULL),
	(148, 0, 1, 1, NULL),
	(149, 0, 2, 1, NULL),
	(150, 0, 2, 3, NULL),
	(151, 0, 2, 4, NULL),
	(152, 0, 2, 2, NULL),
	(153, 0, 3, 1, NULL),
	(154, 0, 3, 2, NULL),
	(155, 0, 3, 3, NULL),
	(156, 0, 3, 4, NULL),
	(157, 0, 3, 5, NULL),
	(158, 0, 3, 7, NULL),
	(159, 0, 3, 6, NULL),
	(160, 0, 4, 3, NULL),
	(161, 0, 4, 2, NULL),
	(162, 0, 4, 4, NULL),
	(163, 0, 4, 1, NULL),
	(164, 0, 5, 5, NULL),
	(165, 0, 5, 4, NULL),
	(166, 0, 5, 6, NULL),
	(167, 0, 5, 3, NULL),
	(168, 0, 5, 2, NULL),
	(169, 0, 6, 2, NULL),
	(170, 0, 6, 4, NULL),
	(171, 0, 6, 1, NULL),
	(172, 0, 6, 3, NULL),
	(173, 0, 6, 5, NULL),
	(174, 0, 6, 7, NULL),
	(175, 0, 6, 8, NULL),
	(176, 0, 6, 6, NULL),
	(177, 0, 7, 1, NULL),
	(178, 0, 7, 5, NULL),
	(179, 0, 7, 4, NULL),
	(180, 0, 7, 2, NULL),
	(181, 0, 7, 3, NULL),
	(182, 0, 7, 7, NULL),
	(183, 0, 7, 6, NULL),
	(184, 0, 7, 8, NULL),
	(185, 0, 8, 3, NULL),
	(186, 0, 8, 4, NULL),
	(187, 0, 8, 2, NULL),
	(188, 0, 8, 1, NULL),
	(189, 0, 8, 5, NULL),
	(190, 0, 8, 8, NULL),
	(191, 0, 8, 6, NULL),
	(192, 0, 8, 7, NULL),
	(193, 0, 9, 4, NULL),
	(194, 0, 9, 6, NULL),
	(195, 0, 9, 2, NULL),
	(196, 0, 9, 5, NULL),
	(197, 0, 9, 3, NULL),
	(198, 0, 9, 8, NULL),
	(199, 0, 9, 7, NULL),
	(200, 0, 10, 2, NULL),
	(201, 0, 10, 4, NULL),
	(202, 0, 10, 3, NULL),
	(203, 0, 10, 1, NULL),
	(204, 0, 10, 5, NULL),
	(205, 0, 10, 8, NULL),
	(206, 0, 10, 7, NULL),
	(207, 0, 10, 6, NULL),
	(208, 0, 11, 6, NULL),
	(209, 0, 11, 5, NULL),
	(210, 0, 11, 7, NULL),
	(211, 0, 12, 3, NULL),
	(212, 0, 12, 5, NULL),
	(213, 0, 12, 2, NULL),
	(214, 0, 12, 4, NULL),
	(215, 0, 12, 6, NULL),
	(216, 0, 12, 7, NULL);
/*!40000 ALTER TABLE `product_sizes` ENABLE KEYS */;

-- Dumping structure for table shoes_project.sizes
CREATE TABLE IF NOT EXISTS `sizes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(4) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoes_project.sizes: ~8 rows (approximately)
/*!40000 ALTER TABLE `sizes` DISABLE KEYS */;
INSERT INTO `sizes` (`id`, `is_deleted`, `created_at`, `name`) VALUES
	(1, 0, '2024-04-23 21:27:33', 'EU35'),
	(2, 0, '2024-04-23 21:27:33', 'EU36'),
	(3, 0, '2024-04-23 21:27:33', 'EU37'),
	(4, 0, '2024-04-23 21:27:33', 'EU38'),
	(5, 0, '2024-04-23 21:27:33', 'EU39'),
	(6, 0, '2024-04-23 21:27:33', 'EU40'),
	(7, 0, '2024-04-23 21:27:33', 'EU41'),
	(8, 0, '2024-04-23 21:27:33', 'EU42');
/*!40000 ALTER TABLE `sizes` ENABLE KEYS */;

-- Dumping structure for table shoes_project.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `otp` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `is_deleted` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoes_project.users: ~2 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `user_name`, `password`, `email`, `full_name`, `otp`, `phone_number`, `role`, `created_at`, `is_deleted`) VALUES
	(1, 'admin', '$2a$12$2/VOIkO7QwWOHqnz3/f96uNy8d31UpmK7Nn5dquUmXh7E7.n2XmvS', 'a@gmail.com', 'admin', NULL, NULL, 'ADMIN', '2024-04-25 23:39:56', 0),
	(2, 'user123', '$2a$12$2/VOIkO7QwWOHqnz3/f96uNy8d31UpmK7Nn5dquUmXh7E7.n2XmvS', 'b@gmail.com', 'user123', NULL, NULL, 'USER', '2024-04-25 23:40:15', 0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
