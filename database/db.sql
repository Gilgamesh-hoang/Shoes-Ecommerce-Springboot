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


-- Dumping database structure for shoe_project
CREATE DATABASE IF NOT EXISTS `shoe_project` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `shoe_project`;

-- Dumping structure for table shoe_project.carts
CREATE TABLE IF NOT EXISTS `carts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKb5o626f86h46m4s7ms6ginnop` (`user_id`),
  CONSTRAINT `FKb5o626f86h46m4s7ms6ginnop` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoe_project.carts: ~0 rows (approximately)
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` (`id`, `user_id`) VALUES
	(1, 3);
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;

-- Dumping structure for table shoe_project.cart_items
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoe_project.cart_items: ~2 rows (approximately)
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;

-- Dumping structure for table shoe_project.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(4) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoe_project.categories: ~9 rows (approximately)
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `is_deleted`, `created_at`, `code`, `name`) VALUES
	(1, 0, '2024-04-23 21:27:33', 'tennis', 'Tennis'),
	(2, 0, '2024-04-23 21:27:33', 'jordan', 'Jordan'),
	(3, 0, '2024-04-23 21:27:33', 'training-gym', 'Training & Gym'),
	(4, 0, '2024-04-23 21:27:33', 'football', 'Football'),
	(5, 0, '2024-04-23 21:27:33', 'basketball', 'Basketball'),
	(6, 0, '2024-04-23 21:27:33', 'running', 'Running'),
	(8, 1, '2024-04-26 15:36:22', 'isDeleted', ''),
	(11, 0, NULL, 'soccer', 'Soccer');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Dumping structure for table shoe_project.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(4) DEFAULT 0,
  `shipping_fee` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `address` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK32ql8ubntj5uh44ph9659tiih` (`user_id`),
  CONSTRAINT `FK32ql8ubntj5uh44ph9659tiih` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoe_project.orders: ~0 rows (approximately)
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- Dumping structure for table shoe_project.order_items
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoe_project.order_items: ~0 rows (approximately)
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;

-- Dumping structure for table shoe_project.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `short_description` varchar(255) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoe_project.products: ~13 rows (approximately)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `name`, `description`, `thumbnail`, `short_description`, `category_id`, `price`, `is_deleted`, `created_at`, `is_hot`, `discount`, `quantity`) VALUES
	(1, 'Nike Air Max 90', '&lt;p&gt;You tryna be comfortable all day, every day? We got you. The AJ1 Low has all the looks of the hoops original, with less weight and a sleek profile. Plus, they go with any \\\'fit&mdash;just lace up and go.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&amp;nbsp;&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Benefits&lt;/strong&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Nike Air technology absorbs impact for cushioning with every step.&lt;/li&gt;&lt;li&gt;Genuine and synthetic leather and textile materials combine for lightweight durability and a great fit.&lt;/li&gt;&lt;li&gt;Rubber outsole provides ample traction.&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;&lt;br&gt;&amp;nbsp;&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Product Details&lt;/strong&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Jumpman logo on tongue&lt;/li&gt;&lt;li&gt;Stitched-down Swoosh logo&lt;ul&gt;&lt;li&gt;Shown: Black/Black/White&lt;/li&gt;&lt;li&gt;Style: DV0990-001&lt;/li&gt;&lt;/ul&gt;&lt;/li&gt;&lt;/ul&gt;', 'http://res.cloudinary.com/da5wewzih/image/upload/v1704212059/zdyy9vcookwn8pe9cgh6.png', 'Inspired by the original that debuted in 1985, the Air Jordan 1 Low offers a clean, classic look that\\\'s familiar yet always fresh.', 6, 101.7, 0, '2024-04-23 21:35:13', 1, 0.2, 50),
	(2, 'Nike Tech Hera', '&lt;p&gt;Rooted in early 2000s running, the Tech Hera is here to fulfill all of your chunky sneaker wishes. The wavy lifted midsole and aged neutral palette level up your look while keeping you comfortable. Its durable design holds up beautifully to everyday wear&mdash;which is perfect, because you will definitely want to wear these every day.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&amp;nbsp;&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Benefits&lt;/strong&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Upper combines airy mesh with real and synthetic leather for dimension and durability.&lt;/li&gt;&lt;li&gt;Chunky design has a subtle platform to give you a little extra height.&lt;/li&gt;&lt;li&gt;Full-length rubber outsole delivers durable traction.&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;&lt;br&gt;&amp;nbsp;&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Product Details&lt;/strong&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Padded collar&lt;/li&gt;&lt;li&gt;Pull tab on heel&lt;/li&gt;&lt;li&gt;Embroidered Swoosh logo&lt;ul&gt;&lt;li&gt;Shown: Sail/Light Ore', 'http://res.cloudinary.com/da5wewzih/image/upload/v1704215356/nw9wcfdali4xqcvysmlm.png', 'Rooted in early 2000s running, the Tech Hera is here to fulfill all of your chunky sneaker wishes.', 2, 175.2, 0, '2024-04-23 21:35:44', 1, 0.1, 50),
	(3, 'Nike Mercurial Superfly 9 Club', '&lt;p&gt;Instantly tilt the pitch in the bold design of the light and low-to-the-ground Superfly 9 Club MG. Fast is in the Air.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Drive your speed&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;The speed cage inside the structure is made from a thin but strong material that secures the foot to the outsole without adding additional weight for optimal lockdown.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Dig in, take off&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;Unique traction pattern offers super-charged traction with quick release to create separation.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Improved fit&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;Flyknit wraps your ankle in soft, stretchy fabric for a secure feel. A redone design improves the fit, so that it better simulates the foot. We did this by conducting multiple wear tests on hundreds of athletes. The result is a more contoured toe box and better lockdown in the heel.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Feel the ball&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;A mo', 'http://res.cloudinary.com/da5wewzih/image/upload/v1704233310/eqmlo8nlmbifxinsegpf.png', 'Instantly tilt the pitch in the bold design of the light and low-to-the-ground Superfly 9 Club MG.', 3, 170.7, 0, '2024-04-23 21:37:27', 1, 0.2, 50),
	(4, 'Nike Go FlyEase', '&lt;p&gt;Ditch the laces and get outside. These kicks feature Nike\\\'s revolutionary FlyEase technology, making on-and-off a breeze. With a heel that pivots open for a totally hands-free entry, they\\\'re great for people with limited mobility&mdash;or anyone who wants a quicker way to get going.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Step In and Go&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;The entire heel (including the sole) hinges open and stays open until you\\\'re ready. Just slip in and step down to make the heel move back into place and secure your foot.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;&quot;CushIon&quot; Every Step&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;Plush Cushlon foam gives each heel-to-toe transition a smooth, cushioned feeling.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Lightweight Structure&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;Airy fabric in the upper lets your feet breathe while durable, no-sew overlays provide structure and stability.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Product Details&lt;/strong&gt;&lt;/p&gt;&lt;', 'http://res.cloudinary.com/da5wewzih/image/upload/v1704233684/ahtnmfvovwgx38bgt2d6.png', 'Ditch the laces and get outside. These kicks feature Nike\\\'s revolutionary FlyEase technology, making on-and-off a breeze', 4, 127.8, 0, '2024-04-23 21:37:34', 1, 0.1, 50),
	(5, 'Nike Air Huarache Runner', '&lt;p&gt;When it fits this well and looks this good, it doesn\\\'t need a Swoosh logo. The Air Huarache takes on a classic silhouette with a runner-inspired design, mixed materials and rich neutrals for a look that is both nostalgic and brand new. With its stretchy, foot-hugging fabric and futuristic heel cage, it\\\'s still everything you love about the Huarache.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Benefits&lt;/strong&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Inspired by water skiing, the stretchy upper and cushioned inner sleeve create a snug fit for an incredible feel.&lt;/li&gt;&lt;li&gt;Originally designed for performance running, Nike Air cushioning delivers lasting comfort.&lt;/li&gt;&lt;li&gt;A caged heel adds support and is paired with an elongated tongue to keep the early \\\'90s look you love.&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;&lt;strong&gt;Product details&lt;/strong&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Rubber sole&lt;/li&gt;&lt;li&gt;Variable-width lacing&lt;/li&gt;&lt;li&gt;Not intended for use as P', 'http://res.cloudinary.com/da5wewzih/image/upload/v1704234050/gdrknjwyagdjpxig1yd6.png', 'When it fits this well and looks this good, it doesn\\\'t need a Swoosh logo.', 5, 126.9, 0, '2024-04-23 21:37:44', 0, 0.0, 50),
	(6, 'Nike Waffle Debut', '&lt;p&gt;Free Shipping*&lt;/p&gt;&lt;p&gt;To get accurate shipping information &lt;a href=&quot;/user/address&quot;&gt;Edit Location&lt;/a&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;Retro gets modernized with these sleek sneaks inspired by the Nike Daybreak. Era-echoing suede and nylon are paired in complementary colors, and the updated wedge midsole gives you an extra lift. Style, comfort, iconic Waffle outsole&mdash;this is a perfect new addition to your daily rotation.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Benefits&lt;/strong&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Swoosh wraps around your heel to form a pull tab, adding aesthetic appeal to on-and-off functionality.&lt;/li&gt;&lt;li&gt;Lifted foam midsoles give you an elevated look and all-day comfort.&lt;/li&gt;&lt;li&gt;Soft suede overlays nod to vintage materials while textile underlays add durability.&lt;/li&gt;&lt;li&gt;Rubber Waffle outsole adds durable traction and heritage style.&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;&lt;strong&gt;Product Details&lt;/stron', 'http://res.cloudinary.com/da5wewzih/image/upload/v1704268740/bkrq1pgyze889v5be2gp.png', 'Retro gets modernized with these sleek sneaks inspired by the Nike Daybreak.', 6, 151.1, 0, '2024-04-23 21:37:46', 0, 0.0, 50),
	(7, 'Nike Elevate 3', '&lt;p&gt;&lt;strong&gt;Free Shipping*&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;To get accurate shipping information &lt;a href=&quot;/user/address&quot;&gt;Edit Location&lt;/a&gt;&lt;/p&gt;&lt;p&gt;Level up your game on both ends of the floor in the Nike Renew Elevate 3. Specifically tuned for 2-way players who want to make an impact offensively and defensively, this shoe helps you optimize your ability with all-game, all-season support and stability. Improved traction and arch support enhance cutting and pivoting, which can make the difference down the stretch.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;On-Point Pivots&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;A generative, athlete-tested traction allows for better pivoting around the forefoot, allowing you to feel more secure and locked in when spinning, stopping and starting.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Lace Up&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;We added extra lace holes on the medial midfoot to give you the extra security you need for all-important arch sup', 'http://res.cloudinary.com/da5wewzih/image/upload/v1704269225/qheu2fgefuytcnnzpmgg.png', 'Level up your game on both ends of the floor in the Nike Renew Elevate 3', 1, 174.9, 0, '2024-04-23 21:39:01', 0, 0.0, 50),
	(8, 'Nike Air Max SC', '&lt;p&gt;&lt;strong&gt;Free Shipping*&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;To get accurate shipping information &lt;a href=&quot;/user/address&quot;&gt;Edit Location&lt;/a&gt;&lt;/p&gt;&lt;p&gt;With its familiar design lines, heritage track aesthetic and visible Max Air cushioning, the Nike Air Max SC is the perfect way to finish off any outfit. Smooth leather and lightweight knit textiles add depth and durability while a tinted Air unit in the heel brightens your day with every step.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Benefits&lt;/strong&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Leather combines with airy knits and mesh for durable construction that\\\'s breathable and comfortable enough to wear all day.&lt;/li&gt;&lt;li&gt;Originally designed for running, Max Air unit in heels deliver lightweight cushioning with every step.&lt;/li&gt;&lt;li&gt;Foam midsole adds cushioning that lasts.&lt;/li&gt;&lt;li&gt;Rubber outsole provides traction and durability.&lt;ul&gt;&lt;li&gt;Shown: White/Light Lemon Twist/', 'http://res.cloudinary.com/da5wewzih/image/upload/v1704269655/kut4qnvut5cpwloxgrqy.png', 'With its familiar design lines, heritage track aesthetic and visible Max Air cushioning, the Nike Air Max SC is the perfect way to finish off any outfit', 2, 121.2, 0, '2024-04-23 21:39:06', 0, 0.0, 50),
	(9, 'Nike Air Max 270', '&lt;p&gt;Free Shipping*&lt;/p&gt;&lt;p&gt;To get accurate shipping information &lt;a href=&quot;/user/address&quot;&gt;Edit Location&lt;/a&gt;&lt;/p&gt;&lt;p&gt;&lt;strong&gt;LEGENDARY AIR GETS LIFTED.&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;Nike\\\'s first lifestyle Air Max brings you style, comfort and big Air in the Nike Air Max 270. The design draws inspiration from Air Max icons, showcasing Nike\\\'s huge innovation with its large window and fresh details.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Benefits&lt;/strong&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;The Max Air 270 unit delivers all-day comfort.&lt;/li&gt;&lt;li&gt;Knit and synthetic fabric on the upper provides a lightweight fit and airy feel.&lt;/li&gt;&lt;li&gt;Foam midsole feels soft and comfortable.&lt;/li&gt;&lt;li&gt;Stretchy inner sleeve creates a personalized fit.&lt;/li&gt;&lt;li&gt;Rubber on the outsole adds traction and durability.&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;&lt;strong&gt;Product Details&lt;/strong&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Mesh ', 'http://res.cloudinary.com/da5wewzih/image/upload/v1704269813/ftllqqdrl0sveehjomp9.png', 'Nike\\\'s first lifestyle Air Max brings you style, comfort and big Air in the Nike Air Max 270.', 3, 181.1, 0, '2024-04-23 21:39:08', 0, 0.0, 50),
	(10, 'Nike Air Max 90', '&lt;p&gt;Free Shipping*&lt;/p&gt;&lt;p&gt;To get accurate shipping information &lt;a href=&quot;/user/address&quot;&gt;Edit Location&lt;/a&gt;&lt;/p&gt;&lt;p&gt;&lt;strong&gt;COMFORT, HERITAGE. NOTHING BETTER.&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;Nothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colors celebrate your fresh look while Max Air cushioning adds comfort to the journey.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Performance Comfort&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;Originally designed for performance running, the Max Air unit in the heel adds unbelievable cushioning.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Versatile Style&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;The low-top design combines with a padded collar for a sleek look that feels soft and comfortable.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Retro Vibes&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;The stitched overlays and TPU ', 'http://res.cloudinary.com/da5wewzih/image/upload/v1704270012/njsatpli7rviso6zqtp1.png', 'Nothing as fly, nothing as comfortable, nothing as proven.', 4, 142.2, 0, '2024-04-23 21:39:13', 0, 0.0, 50),
	(11, 'Jordan Spizike Low', '&lt;p&gt;&lt;strong&gt;Free Shipping*&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;To get accurate shipping information &lt;a href=&quot;/user/address&quot;&gt;Edit Location&lt;/a&gt;&lt;/p&gt;&lt;p&gt;The Spizike takes elements of four classic Jordans, combines them, and gives you one iconic sneaker. It\\\'s an homage to Spike Lee formally introducing Hollywood and hoops in a culture moment. You get a great looking pair of kicks with some history. What more can you ask for? Ya dig?&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Benefits&lt;/strong&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Visible Nike Air-Sole unit provides lightweight cushioning.&lt;/li&gt;&lt;li&gt;Rubber outsole gives you ample traction.&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;&lt;strong&gt;Product Details&lt;/strong&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Not intended for use as Personal Protective Equipment (PPE)&lt;ul&gt;&lt;li&gt;Shown: Legion Green/Military Brown/University Red/Black&lt;/li&gt;&lt;li&gt;Style: FD4653-300&lt;/li&gt;&lt;/ul&gt;&lt;/li&gt;&lt;/ul&gt;', 'http://res.cloudinary.com/da5wewzih/image/upload/v1704270190/ucfxuf0zmifaezmbitp0.png', 'The Spizike takes elements of four classic Jordans, combines them, and gives you one iconic sneaker.', 5, 167.5, 0, '2024-04-23 21:39:18', 0, 0.0, 50),
	(12, 'Air Jordan 1 High G NRG', '&lt;p&gt;&lt;strong&gt;Free Shipping*&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;To get accurate shipping information &lt;a href=&quot;/user/address&quot;&gt;Edit Location&lt;/a&gt;&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;p&gt;One of the reasons why MJ loves golf so much: It&rsquo;s like looking into a mirror. The only opponent he sees is staring right back at him. No teammates to play off. No defender to go at. Just him, his swing and the course. This special AJ1 High, with its metallic finishes, chrome aglets and glossy Air Jordan details, takes inspiration from the internal drive that inspires both MJ and us to keep getting better every day.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Original AJ1 Design&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;Real and synthetic leather and bold color-blocking recreate the classic look.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Air Cushioning&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;Encapsulated Air in the heel cushions every step.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;Heritage Traction&lt;/strong&g', 'http://res.cloudinary.com/da5wewzih/image/upload/v1704270515/vzqfnuxgyczzazte698u.png', 'One of the reasons why MJ loves golf so much: It&rsquo;s like looking into a mirror.', 6, 111.0, 0, '2024-04-23 21:39:24', 0, 0.0, 50),
	(21, 'Phi Nhan', '<p>Ngày 24-2, tròn một năm chiến sự ở Ukraine, Bộ Ngoại giao Trung Quốc công bố tài liệu nêu lập trường về các giải pháp chính trị cho cuộc xung đột Nga - Ukraine.</p>', 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714209904/djsjlj9nb1flmg6ri6da.jpg', 'Ngày 24-2, tròn một năm chiến sự ở Ukraine, Bộ Ngoại giao Trung Quốc công bố tài liệu nêu lập trường về các giải pháp chính trị cho cuộc xung đột Nga - Ukraine.', 1, 1.0, 0, NULL, 0, 0.0, 50);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

-- Dumping structure for table shoe_project.product_images
CREATE TABLE IF NOT EXISTS `product_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FKqnq71xsohugpqwf3c9gxmsuy` (`product_id`),
  CONSTRAINT `FKqnq71xsohugpqwf3c9gxmsuy` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoe_project.product_images: ~2 rows (approximately)
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` (`id`, `product_id`, `image_url`, `is_deleted`) VALUES
	(19, 21, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714209907/wu9076sdvufzgyauhqpq.jpg', 1),
	(20, 21, 'http://res.cloudinary.com/dvh2rphf4/image/upload/v1714209906/e0b8iic3cvtzpicelug1.png', 1);
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;

-- Dumping structure for table shoe_project.product_sizes
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
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoe_project.product_sizes: ~60 rows (approximately)
/*!40000 ALTER TABLE `product_sizes` DISABLE KEYS */;
INSERT INTO `product_sizes` (`id`, `is_deleted`, `product_id`, `size_id`, `created_at`) VALUES
	(1, 0, 1, 1, '2024-04-23 22:03:01'),
	(2, 0, 1, 2, '2024-04-23 22:03:01'),
	(3, 0, 1, 3, '2024-04-23 22:03:01'),
	(4, 0, 1, 4, '2024-04-23 22:03:01'),
	(5, 0, 2, 2, '2024-04-23 22:03:01'),
	(6, 0, 2, 1, '2024-04-23 22:03:01'),
	(7, 0, 2, 3, '2024-04-23 22:03:01'),
	(8, 0, 2, 5, '2024-04-23 22:03:01'),
	(9, 0, 3, 1, '2024-04-23 22:03:01'),
	(10, 0, 3, 3, '2024-04-23 22:03:01'),
	(11, 0, 3, 5, '2024-04-23 22:03:01'),
	(12, 0, 3, 7, '2024-04-23 22:03:01'),
	(13, 0, 4, 1, '2024-04-23 22:03:01'),
	(14, 0, 4, 2, '2024-04-23 22:03:01'),
	(15, 0, 4, 7, '2024-04-23 22:03:01'),
	(16, 0, 4, 8, '2024-04-23 22:03:01'),
	(17, 0, 5, 6, '2024-04-23 22:03:01'),
	(18, 0, 5, 7, '2024-04-23 22:03:01'),
	(19, 0, 5, 8, '2024-04-23 22:03:01'),
	(20, 0, 6, 1, '2024-04-23 22:03:01'),
	(21, 0, 6, 2, '2024-04-23 22:03:01'),
	(22, 0, 6, 5, '2024-04-23 22:03:01'),
	(23, 0, 6, 6, '2024-04-23 22:03:01'),
	(24, 0, 7, 1, '2024-04-23 22:03:01'),
	(25, 0, 7, 7, '2024-04-23 22:03:01'),
	(26, 0, 7, 8, '2024-04-23 22:03:01'),
	(27, 0, 8, 4, '2024-04-23 22:03:01'),
	(28, 0, 8, 5, '2024-04-23 22:03:01'),
	(29, 0, 8, 7, '2024-04-23 22:03:01'),
	(30, 0, 9, 1, '2024-04-23 22:03:01'),
	(31, 0, 9, 2, '2024-04-23 22:03:01'),
	(32, 0, 9, 6, '2024-04-23 22:03:01'),
	(33, 0, 9, 7, '2024-04-23 22:03:01'),
	(34, 0, 9, 8, '2024-04-23 22:03:01'),
	(35, 0, 10, 6, '2024-04-23 22:03:01'),
	(36, 0, 10, 5, '2024-04-23 22:03:01'),
	(37, 0, 10, 4, '2024-04-23 22:03:01'),
	(38, 0, 10, 2, '2024-04-23 22:03:01'),
	(39, 0, 10, 8, '2024-04-23 22:03:01'),
	(40, 0, 11, 6, '2024-04-23 22:03:01'),
	(41, 0, 11, 1, '2024-04-23 22:03:01'),
	(42, 0, 11, 2, '2024-04-23 22:03:01'),
	(43, 0, 11, 3, '2024-04-23 22:03:01'),
	(44, 0, 11, 4, '2024-04-23 22:03:01'),
	(45, 0, 12, 4, '2024-04-23 22:03:01'),
	(46, 0, 12, 5, '2024-04-23 22:03:01'),
	(47, 0, 12, 6, '2024-04-23 22:03:01'),
	(48, 0, 12, 7, '2024-04-23 22:03:01'),
	(49, 0, 12, 8, '2024-04-23 22:03:01'),
	(50, 0, 12, 1, '2024-04-23 22:03:01'),
	(127, 1, 21, 1, NULL),
	(128, 1, 21, 3, NULL),
	(129, 1, 21, 5, NULL),
	(130, 1, 21, 2, NULL),
	(131, 1, 21, 4, NULL),
	(132, 1, 21, 7, NULL),
	(133, 1, 21, 6, NULL),
	(134, 1, 21, 8, NULL),
	(135, 0, 21, 3, NULL),
	(136, 0, 21, 4, NULL);
/*!40000 ALTER TABLE `product_sizes` ENABLE KEYS */;

-- Dumping structure for table shoe_project.sizes
CREATE TABLE IF NOT EXISTS `sizes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(4) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table shoe_project.sizes: ~9 rows (approximately)
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

-- Dumping structure for table shoe_project.users
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

-- Dumping data for table shoe_project.users: ~3 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `user_name`, `password`, `email`, `full_name`, `otp`, `phone_number`, `role`, `created_at`, `is_deleted`) VALUES
	(1, 'a', '$2a$12$9szEjqLykjaQVvPTnccyRuPLqAfBwCUMRNut8OECjLXLS4HW0LyiG', 'a@gmail.com', NULL, NULL, NULL, 'ADMIN', '2024-04-25 23:39:56', 0),
	(2, 'b', '$2a$12$9szEjqLykjaQVvPTnccyRuPLqAfBwCUMRNut8OECjLXLS4HW0LyiG', 'B', NULL, NULL, NULL, 'USER', '2024-04-25 23:40:15', 0),
	(3, 'admin', '$2a$10$qQe72nmrIkR5P.iehoeOeujBRIjfvdrMMb8evvOl5Y6BJXD0TyAH6', '21130363@st.hcmuaf.edu.vn', 'Võ Phi Hoàng', NULL, NULL, 'USER', NULL, 0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
