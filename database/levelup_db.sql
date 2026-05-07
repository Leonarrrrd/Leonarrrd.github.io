-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: levelup-db
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `diet_plans`
--

DROP TABLE IF EXISTS `diet_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diet_plans` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `diet_date` date DEFAULT NULL,
  `meal_type` enum('breakfast','lunch','dinner') DEFAULT NULL,
  `food_name` varchar(100) DEFAULT NULL,
  `calories` float DEFAULT NULL,
  `protein` float DEFAULT NULL,
  `carbs` float DEFAULT NULL,
  `fat` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `diet_plans_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diet_plans`
--

LOCK TABLES `diet_plans` WRITE;
/*!40000 ALTER TABLE `diet_plans` DISABLE KEYS */;
/*!40000 ALTER TABLE `diet_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercises`
--

DROP TABLE IF EXISTS `exercises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercises` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `muscle_group` varchar(255) DEFAULT NULL,
  `gif_url` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercises`
--

LOCK TABLES `exercises` WRITE;
/*!40000 ALTER TABLE `exercises` DISABLE KEYS */;
INSERT INTO `exercises` VALUES (1,'Barbell Incline Bench Press','Upper Chest','Chest','/img/upper-chest/barbell-incline-bench-press.gif','2026-04-22 12:32:52'),(2,'Hammer Machine Chest Press','Upper Chest','Chest','/img/upper-chest/hammer-machine-chest-press.gif','2026-04-22 12:32:52'),(3,'Incline Push-Up','Upper Chest','Chest','/img/upper-chest/incline-push-up.gif','2026-04-22 12:32:52'),(4,'Incline Shoulder Touch Push-Up','Upper Chest','Chest','/img/upper-chest/incline-shoulder-touch-push-up.gif','2026-04-22 12:32:52'),(5,'Seated Chest Press','Upper Chest','Chest','/img/upper-chest/seated-chest-press.gif','2026-04-22 12:32:52'),(6,'Cable Low Fly','Middle Chest','Chest','/img/middle-chest/cable-low-fly.gif','2026-04-22 12:32:52'),(7,'Dumbbell Flat Fly','Middle Chest','Chest','/img/middle-chest/dumbbell-flat-fly.gif','2026-04-22 12:32:52'),(8,'Machine Fly','Middle Chest','Chest','/img/middle-chest/machine-fly.gif','2026-04-22 12:32:52'),(9,'Standard Push-Up','Middle Chest','Chest','/img/middle-chest/standard-push-up.gif','2026-04-22 12:32:52'),(10,'Barbell Decline Bench Press','Lower Chest','Chest','/img/lower-chest/barbell-decline-bench-press.gif','2026-04-22 12:32:52'),(11,'Decline Push-Up','Lower Chest','Chest','/img/lower-chest/decline-push-up.gif','2026-04-22 12:32:52'),(12,'Decline Shoulder Touch Push-Up','Lower Chest','Chest','/img/lower-chest/decline-shoulder-touch-push-up.gif','2026-04-22 12:32:52'),(13,'Kneeling Decline Push-Up','Lower Chest','Chest','/img/lower-chest/kneeling-decline-push-up.gif','2026-04-22 12:32:52'),(14,'Cable Kneeling Crunch','Upper Abs','Abs','/img/upper-abs/cable-kneeling-crunch.gif','2026-04-22 12:32:52'),(15,'Crunch','Upper Abs','Abs','/img/upper-abs/crunch.gif','2026-04-22 12:32:52'),(16,'Knee-Up Crunch','Upper Abs','Abs','/img/upper-abs/knee-up-crunch.gif','2026-04-22 12:32:52'),(17,'Wall Hands To Toes Touch','Upper Abs','Abs','/img/upper-abs/wall-hands-to-toes-touch.gif','2026-04-22 12:32:52'),(18,'Wall Knee-Up Crunch','Upper Abs','Abs','/img/upper-abs/wall-knee-up-crunch.gif','2026-04-22 12:32:52'),(19,'Weighted Crunch','Upper Abs','Abs','/img/upper-abs/weighted-crunch.gif','2026-04-22 12:32:52'),(20,'Cable Standing Hip Raise','Lower Abs','Abs','/img/lower-abs/cable-standing-hip-raise.gif','2026-04-22 12:32:52'),(21,'Flat Lying Leg Raise','Lower Abs','Abs','/img/lower-abs/flat-lying-leg-raise.gif','2026-04-22 12:32:52'),(22,'Incline Reverse Crunch','Lower Abs','Abs','/img/lower-abs/incline-reverse-crunch.gif','2026-04-22 12:32:52'),(23,'Pulse Up','Lower Abs','Abs','/img/lower-abs/pulse-up.gif','2026-04-22 12:32:52'),(24,'Reverse Crunch','Lower Abs','Abs','/img/lower-abs/reverse-crunch.gif','2026-04-22 12:32:52'),(25,'Weighted Hanging Leg Raise Hip Thrust','Lower Abs','Abs','/img/lower-abs/weighted-hanging-leg-raise-hip-thrust.gif','2026-04-22 12:32:52'),(26,'Incline Board Twist Sit-Up','Side Abs','Abs','/img/side-abs/incline-board-twist-sit-up.gif','2026-04-22 12:32:52'),(27,'Leg Up Russian Twist','Side Abs','Abs','/img/side-abs/leg-up-russian-twist.gif','2026-04-22 12:32:52'),(28,'Russian Twist','Side Abs','Abs','/img/side-abs/russian-twist.gif','2026-04-22 12:32:52'),(29,'Side Waist Touch Heel','Side Abs','Abs','/img/side-abs/side-waist-touch-heel.gif','2026-04-22 12:32:52'),(30,'Wall Side Crunch','Side Abs','Abs','/img/side-abs/wall-side-crunch.gif','2026-04-22 12:32:52'),(31,'Weighted Russian Twist','Side Abs','Abs','/img/side-abs/weighted-russian-twist.gif','2026-04-22 12:32:52'),(32,'Band Front Raise','Front Delt','Shoulders','/img/front-delt/band-front-raise.gif','2026-04-22 12:32:52'),(33,'Barbell Machine Press','Front Delt','Shoulders','/img/front-delt/barbell-machine-press.gif','2026-04-22 12:32:52'),(34,'Barbell Standing Press','Front Delt','Shoulders','/img/front-delt/barbell-standing-press.gif','2026-04-22 12:32:52'),(35,'Cable Single Arm Front Raise','Front Delt','Shoulders','/img/front-delt/cable-single-arm-front-raise.gif','2026-04-22 12:32:52'),(36,'Machine Press','Front Delt','Shoulders','/img/front-delt/machine-press.gif','2026-04-22 12:32:52'),(37,'Seated Dumbbell Press','Front Delt','Shoulders','/img/front-delt/seated-dumbbell-press.gif','2026-04-22 12:32:52'),(38,'Band Lateral Raise','Side Delt','Shoulders','/img/side-delt/band-lateral-raise.gif','2026-04-22 12:32:52'),(39,'Band Shoulder Abduction','Side Delt','Shoulders','/img/side-delt/band-shoulder-abduction.gif','2026-04-22 12:32:52'),(40,'Cable Cross Lateral Raise','Side Delt','Shoulders','/img/side-delt/cable-cross-lateral-raise.gif','2026-04-22 12:32:52'),(41,'Cable Single Arm Lateral Raise','Side Delt','Shoulders','/img/side-delt/cable-single-arm-lateral-raise.gif','2026-04-22 12:32:52'),(42,'Fixed Prone Lateral Raise','Side Delt','Shoulders','/img/side-delt/fixed-prone-lateral-raise.gif','2026-04-22 12:32:52'),(43,'Band Face Pull','Rear Delt','Shoulders','/img/rear-delt/band-face-pull.gif','2026-04-22 12:32:52'),(44,'Band Standing Reverse Fly','Rear Delt','Shoulders','/img/rear-delt/band-standing-reverse-fly.gif','2026-04-22 12:32:52'),(45,'Dumbbell Prone Fly','Rear Delt','Shoulders','/img/rear-delt/dumbbell-prone-fly.gif','2026-04-22 12:32:52'),(46,'Machine Reverse Fly','Rear Delt','Shoulders','/img/rear-delt/machine-reverse-fly.gif','2026-04-22 12:32:52'),(47,'Seated Prone Fly','Rear Delt','Shoulders','/img/rear-delt/seated-prone-fly.gif','2026-04-22 12:32:52'),(48,'Band Upright Row','Traps','Shoulders','/img/traps/band-upright-row.gif','2026-04-22 12:32:52'),(49,'Barbell Bent Over Row','Traps','Shoulders','/img/traps/barbell-bent-over-row.gif','2026-04-22 12:32:52'),(50,'Barbell Upright Row','Traps','Shoulders','/img/traps/barbell-upright-row.gif','2026-04-22 12:32:52'),(51,'Smith Bent Over Row','Traps','Shoulders','/img/traps/smith-bent-over-row.gif','2026-04-22 12:32:52'),(52,'Smith Upright Row','Traps','Shoulders','/img/traps/smith-upright-row.gif','2026-04-22 12:32:52'),(53,'Barbell Front Squat','Front','Legs','/img/front-legs/barbell-front-squat.gif','2026-04-22 12:32:52'),(54,'Barbell Single Leg Squat','Front','Legs','/img/front-legs/barbell-single-leg-squat.gif','2026-04-22 12:32:52'),(55,'Barbell Single Leg Step Up','Front','Legs','/img/front-legs/barbell-single-leg-step-up.gif','2026-04-22 12:32:52'),(56,'Barbell Squat','Front','Legs','/img/front-legs/barbell-squat.gif','2026-04-22 12:32:52'),(57,'Bodyweight Squat','Front','Legs','/img/front-legs/bodyweight-squat.gif','2026-04-22 12:32:52'),(58,'Dumbbell Front Squat','Front','Legs','/img/front-legs/dumbbell-front-squat.gif','2026-04-22 12:32:52'),(59,'Dumbbell Lunge','Front','Legs','/img/front-legs/dumbbell-lunge.gif','2026-04-22 12:32:52'),(60,'Dumbbell Single Leg Step Up','Front','Legs','/img/front-legs/dumbbell-single-leg-step-up.gif','2026-04-22 12:32:52'),(61,'Dumbbell Squat','Front','Legs','/img/front-legs/dumbbell-squat.gif','2026-04-22 12:32:52'),(62,'Hex Bar Squat','Front','Legs','/img/front-legs/hex-bar-squat.gif','2026-04-22 12:32:52'),(63,'Kettlebell Front Squat','Front','Legs','/img/front-legs/kettlebell-front-squat.gif','2026-04-22 12:32:52'),(64,'Kettlebell Goblet Squat','Front','Legs','/img/front-legs/kettlebell-goblet-squat.gif','2026-04-22 12:32:52'),(65,'Leg Press','Front','Legs','/img/front-legs/leg-press.gif','2026-04-22 12:32:52'),(66,'Machine Leg Press','Front','Legs','/img/front-legs/machine-leg-press.gif','2026-04-22 12:32:52'),(67,'Seated Leg Extension','Front','Legs','/img/front-legs/seated-leg-extension.gif','2026-04-22 12:32:52'),(68,'Seated Single Leg Extension','Front','Legs','/img/front-legs/seated-single-leg-extension.gif','2026-04-22 12:32:52'),(69,'Smith Front Squat','Front','Legs','/img/front-legs/smith-front-squat.gif','2026-04-22 12:32:52'),(70,'Smith Leg Press','Front','Legs','/img/front-legs/smith-leg-press.gif','2026-04-22 12:32:52'),(71,'Smith Lunge','Front','Legs','/img/front-legs/smith-lunge.gif','2026-04-22 12:32:52'),(72,'Smith Single Leg Squat','Front','Legs','/img/front-legs/smith-single-leg-squat.gif','2026-04-22 12:32:52'),(73,'Smith Squat','Front','Legs','/img/front-legs/smith-squat.gif','2026-04-22 12:32:52'),(74,'Wall Sit','Front','Legs','/img/front-legs/wall-sit.gif','2026-04-22 12:32:52'),(75,'Barbell Deadlift','Back Legs','Legs','/img/side-legs/barbell-deadlift.gif','2026-04-22 12:32:52'),(76,'Barbell Good Morning','Back Legs','Legs','/img/side-legs/barbell-good-morning.gif','2026-04-22 12:32:52'),(77,'Dumbbell Farmer Walk','Back Legs','Legs','/img/side-legs/dumbbell-farmer-walk.gif','2026-04-22 12:32:52'),(78,'Dumbbell Trap Bar Sumo Squat','Back Legs','Legs','/img/side-legs/dumbbell-trap-bar-sumo-squat.gif','2026-04-22 12:32:52'),(79,'Kettlebell Deadlift','Back Legs','Legs','/img/side-legs/kettlebell-deadlift.gif','2026-04-22 12:32:52'),(80,'Machine Leg Curl','Back Legs','Legs','/img/side-legs/machine-leg-curl.gif','2026-04-22 12:32:52'),(81,'Machine Single Leg Curl','Back Legs','Legs','/img/side-legs/machine-single-leg-curl.gif','2026-04-22 12:32:52'),(82,'Sumo Squat','Back Legs','Legs','/img/side-legs/sumo-squat.gif','2026-04-22 12:32:52'),(83,'Assisted Pull-Up','Upper Back','Back','/img/upper-back/assisted-pull-up.gif','2026-04-22 12:32:52'),(84,'Band Assisted Pull-Up','Upper Back','Back','/img/upper-back/band-assisted-pull-up.gif','2026-04-22 12:32:52'),(85,'Band Bent Over Row','Upper Back','Back','/img/upper-back/band-bent-over-row.gif','2026-04-22 12:32:52'),(86,'Band Seated Row','Upper Back','Back','/img/upper-back/band-seated-row.gif','2026-04-22 12:32:52'),(87,'Barbell Incline Row','Upper Back','Back','/img/upper-back/barbell-incline-row.gif','2026-04-22 12:32:52'),(88,'Barbell Row','Upper Back','Back','/img/upper-back/barbell-row.gif','2026-04-22 12:32:52'),(89,'Bodyweight Pull-Up','Upper Back','Back','/img/upper-back/bodyweight-pull-up.gif','2026-04-22 12:32:52'),(90,'Cable Behind Neck Pulldown','Upper Back','Back','/img/upper-back/cable-behind-neck-pulldown.gif','2026-04-22 12:32:52'),(91,'Cable Pulldown','Upper Back','Back','/img/upper-back/cable-pulldown.gif','2026-04-22 12:32:52'),(92,'Cable Reverse Grip Pulldown','Upper Back','Back','/img/upper-back/cable-reverse-grip-pulldown.gif','2026-04-22 12:32:52'),(93,'Cable Seated Row','Upper Back','Back','/img/upper-back/cable-seated-row.gif','2026-04-22 12:32:52'),(94,'Dumbbell Incline Row','Upper Back','Back','/img/upper-back/dumbbell-incline-row.gif','2026-04-22 12:32:52'),(95,'Dumbbell Row','Upper Back','Back','/img/upper-back/dumbbell-row.gif','2026-04-22 12:32:52'),(96,'Hex Bar Row','Upper Back','Back','/img/upper-back/hex-bar-row.gif','2026-04-22 12:32:52'),(97,'Kneeling Band Pulldown','Upper Back','Back','/img/upper-back/kneeling-band-pulldown.gif','2026-04-22 12:32:52'),(98,'Machine Row','Upper Back','Back','/img/upper-back/machine-row.gif','2026-04-22 12:32:52'),(99,'Machine Single Arm Row','Upper Back','Back','/img/upper-back/machine-single-arm-row.gif','2026-04-22 12:32:52'),(100,'Weighted Pull-Up','Upper Back','Back','/img/upper-back/weighted-pull-up.gif','2026-04-22 12:32:52'),(101,'Wide Grip Seated Row','Upper Back','Back','/img/upper-back/wide-grip-seated-row.gif','2026-04-22 12:32:52'),(102,'Band Single Arm Row','Lower Back','Back','/img/lower-back/band-single-arm-row.gif','2026-04-22 12:32:52'),(103,'Barbell Deadlift','Lower Back','Back','/img/lower-back/barbell-deadlift.gif','2026-04-22 12:32:52'),(104,'Barbell Reverse Grip Row','Lower Back','Back','/img/lower-back/barbell-reverse-grip-row.gif','2026-04-22 12:32:52'),(105,'Barbell Row','Lower Back','Back','/img/lower-back/barbell-row.gif','2026-04-22 12:32:52'),(106,'Cable Single Arm Pull','Lower Back','Back','/img/lower-back/cable-single-arm-pull.gif','2026-04-22 12:32:52'),(107,'Cable Single Arm Row','Lower Back','Back','/img/lower-back/cable-single-arm-row.gif','2026-04-22 12:32:52'),(108,'Cable Straight Arm Pushdown','Lower Back','Back','/img/lower-back/cable-straight-arm-pushdown.gif','2026-04-22 12:32:52'),(109,'Dumbbell Reverse Grip Row','Lower Back','Back','/img/lower-back/dumbbell-reverse-grip-row.gif','2026-04-22 12:32:52'),(110,'Kneeling Band Single Arm Pull','Lower Back','Back','/img/lower-back/kneeling-band-single-arm-pull.gif','2026-04-22 12:32:52'),(111,'Cable Hammer Curl','Biceps','Arms','/img/biceps/cable-hammer-curl.gif','2026-04-20 13:11:31'),(112,'Incline Dumbbell Curl','Biceps','Arms','/img/biceps/incline-dumbbell-curl.gif','2026-04-20 13:11:31'),(113,'Preacher Bench Dumbbell Curl','Biceps','Arms','/img/biceps/preacher-bench-dumbbell-curl.gif','2026-04-20 13:11:31'),(114,'Seated Hammer Curl','Biceps','Arms','/img/biceps/seated-hammer-curl.gif','2026-04-20 13:11:31'),(115,'Standing Hammer Curl','Biceps','Arms','/img/biceps/standing-hammer-curl.gif','2026-04-20 13:11:31'),(116,'Bench Dip','Triceps','Arms','/img/triceps/bench-dip.gif','2026-04-20 13:11:31'),(117,'Dumbbell Single Arm Extension','Triceps','Arms','/img/triceps/dumbbell-single-arm-extension.gif','2026-04-20 13:11:31'),(118,'Parallel Bar Dip','Triceps','Arms','/img/triceps/parallel-bar-dip.gif','2026-04-20 13:11:31'),(119,'Seated Single Arm Dumbbell Extension','Triceps','Arms','/img/triceps/seated-single-arm-dumbbell-extension.gif','2026-04-20 13:11:31'),(120,'Standing Single Arm Dumbbell Extension','Triceps','Arms','/img/triceps/standing-single-arm-dumbbell-extension.gif','2026-04-20 13:11:31'),(121,'Cable Hammer Curl','Biceps','Arms','/img/biceps/cable-hammer-curl.gif','2026-04-20 13:15:21'),(122,'Incline Dumbbell Curl','Biceps','Arms','/img/biceps/incline-dumbbell-curl.gif','2026-04-20 13:15:21'),(123,'Preacher Bench Dumbbell Curl','Biceps','Arms','/img/biceps/preacher-bench-dumbbell-curl.gif','2026-04-20 13:15:21'),(124,'Seated Hammer Curl','Biceps','Arms','/img/biceps/seated-hammer-curl.gif','2026-04-20 13:15:21'),(125,'Standing Hammer Curl','Biceps','Arms','/img/biceps/standing-hammer-curl.gif','2026-04-20 13:15:21'),(126,'Bench Dip','Triceps','Arms','/img/triceps/bench-dip.gif','2026-04-20 13:15:21'),(127,'Dumbbell Single Arm Extension','Triceps','Arms','/img/triceps/dumbbell-single-arm-extension.gif','2026-04-20 13:15:21'),(128,'Parallel Bar Dip','Triceps','Arms','/img/triceps/parallel-bar-dip.gif','2026-04-20 13:15:21'),(129,'Seated Single Arm Dumbbell Extension','Triceps','Arms','/img/triceps/seated-single-arm-dumbbell-extension.gif','2026-04-20 13:15:21'),(130,'Standing Single Arm Dumbbell Extension','Triceps','Arms','/img/triceps/standing-single-arm-dumbbell-extension.gif','2026-04-20 13:15:21');
/*!40000 ALTER TABLE `exercises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `foods`
--

DROP TABLE IF EXISTS `foods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `foods` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL,
  `calories` double NOT NULL,
  `protein` double NOT NULL,
  `carbs` double NOT NULL,
  `fat` double NOT NULL,
  `serving_size` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foods`
--

LOCK TABLES `foods` WRITE;
/*!40000 ALTER TABLE `foods` DISABLE KEYS */;
INSERT INTO `foods` VALUES (1,'Chicken Breast','protein','both',165,31,0,3.6,'100g'),(2,'Turkey Breast','protein','cut',135,29,0,1.5,'100g'),(3,'Lean Beef','protein','bulk',170,26,0,7,'100g'),(4,'Egg White','protein','both',52,11,0.5,0.2,'100g'),(5,'Whole Egg','protein','bulk',155,13,1.1,11,'100g'),(6,'Tuna (canned in water)','protein','both',116,25,0,1,'100g'),(7,'Salmon','protein','bulk',208,20,0,13,'100g'),(8,'Cod Fish','protein','cut',82,18,0,0.7,'100g'),(9,'Greek Yogurt (plain)','protein','both',59,10,3.6,0.4,'100g'),(10,'Cottage Cheese','protein','both',98,11,3.4,4.3,'100g'),(11,'Tofu','protein','both',76,8,1.9,4.8,'100g'),(12,'Lentils','protein','both',116,9,20,0.4,'100g'),(13,'Brown Rice','carb','bulk',111,2.6,23,0.9,'100g'),(14,'Oatmeal','carb','both',68,2.4,12,1.4,'100g'),(15,'Sweet Potato','carb','bulk',86,1.6,20,0.1,'100g'),(16,'Quinoa','carb','both',120,4.4,21,1.9,'100g'),(17,'Buckwheat','carb','cut',92,3.4,19,0.6,'100g'),(18,'Cauliflower Rice','carb','cut',25,2,5,0.3,'100g'),(19,'Whole Wheat Bread','carb','bulk',265,13,49,3.2,'100g'),(20,'White Rice','carb','bulk',130,2.7,28,0.3,'100g'),(21,'Avocado','fat','both',160,2,8.5,14.7,'100g'),(22,'Almonds','fat','both',579,21,21.6,49.9,'100g'),(23,'Olive Oil','fat','both',884,0,0,100,'1 tbsp'),(24,'Chia Seeds','fat','both',486,16.5,42.1,30.7,'100g'),(25,'Peanut Butter','fat','bulk',588,25,20,50,'100g'),(26,'Walnuts','fat','both',654,15,14,65,'100g'),(27,'Broccoli','vegetable','both',34,2.8,6.6,0.4,'100g'),(28,'Spinach','vegetable','both',23,2.9,3.6,0.4,'100g'),(29,'Zucchini','vegetable','both',17,1.2,3.1,0.3,'100g'),(30,'Bell Pepper','vegetable','both',31,1,6,0.3,'100g'),(31,'Asparagus','vegetable','both',20,2.2,3.7,0.1,'100g'),(32,'Cucumber','vegetable','both',15,0.7,3.6,0.1,'100g'),(33,'Banana','fruit','bulk',89,1.1,22.8,0.3,'1 medium'),(34,'Apple','fruit','both',52,0.3,13.8,0.2,'1 medium'),(35,'Blueberries','fruit','cut',57,0.7,14.5,0.3,'100g'),(36,'Orange','fruit','both',47,0.9,11.8,0.1,'1 medium'),(37,'Strawberries','fruit','cut',32,0.7,7.7,0.3,'100g'),(38,'Milk (2%)','dairy','both',50,3.3,4.8,2,'100ml'),(39,'Protein Powder (Whey)','other','bulk',120,24,3,1.5,'1 scoop (30g)'),(40,'Cheddar Cheese','dairy','bulk',404,25,1.3,33,'100g');
/*!40000 ALTER TABLE `foods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template_exercises`
--

DROP TABLE IF EXISTS `template_exercises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `template_exercises` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `exercise_name` varchar(255) DEFAULT NULL,
  `order_index` int DEFAULT NULL,
  `reps` int DEFAULT NULL,
  `sets` int DEFAULT NULL,
  `template_id` bigint DEFAULT NULL,
  `weight_kg` float DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template_exercises`
--

LOCK TABLES `template_exercises` WRITE;
/*!40000 ALTER TABLE `template_exercises` DISABLE KEYS */;
INSERT INTO `template_exercises` VALUES (1,NULL,1,12,4,1,40,'chest'),(2,NULL,2,12,4,1,40,'chest'),(3,NULL,3,12,4,1,40,'chest'),(4,NULL,4,12,4,1,40,'chest'),(5,NULL,1,12,4,2,15,'shoulders'),(6,NULL,2,12,4,2,15,'shoulders'),(7,NULL,3,12,4,2,15,'shoulders'),(8,NULL,4,12,4,2,15,'shoulders'),(9,NULL,1,12,4,3,35,'back'),(10,NULL,2,12,4,3,35,'back'),(11,NULL,3,12,4,3,35,'back'),(12,NULL,4,12,4,3,35,'back'),(13,NULL,1,15,4,4,50,'legs'),(14,NULL,2,15,4,4,50,'legs'),(15,NULL,3,15,4,4,50,'legs'),(16,NULL,4,15,4,4,50,'legs'),(17,NULL,1,12,4,5,10,'arms'),(18,NULL,2,12,4,5,10,'arms'),(19,NULL,3,12,4,5,10,'arms'),(20,NULL,4,12,4,5,10,'arms'),(21,NULL,1,20,3,6,0,'core'),(22,NULL,2,20,3,6,0,'core'),(23,NULL,3,20,3,6,0,'core'),(24,NULL,4,20,3,6,0,'core'),(25,NULL,1,30,1,7,0,'cardio'),(26,NULL,2,30,1,7,0,'cardio');
/*!40000 ALTER TABLE `template_exercises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trophies`
--

DROP TABLE IF EXISTS `trophies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trophies` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `icon_url` varchar(255) DEFAULT NULL,
  `requirement_type` varchar(255) DEFAULT NULL,
  `requirement_value` int NOT NULL,
  `tier` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trophies`
--

LOCK TABLES `trophies` WRITE;
/*!40000 ALTER TABLE `trophies` DISABLE KEYS */;
INSERT INTO `trophies` VALUES (22,'FIRST_WORKOUT','Starter','Complete your first workout',NULL,'WORKOUT_COUNT',1,'bronze'),(23,'WORKOUT_30','Dedicated','Complete 30 workouts',NULL,'WORKOUT_COUNT',30,'silver'),(24,'WORKOUT_60','Self-disciplined','Complete 60 workouts',NULL,'WORKOUT_COUNT',60,'gold'),(25,'XP_100','Rising Star','Earn 100 XP total',NULL,'TOTAL_XP',100,'bronze'),(26,'XP_500','XP Collector','Earn 500 XP total',NULL,'TOTAL_XP',500,'silver'),(27,'XP_1000','Elite athlete','Earn 1000 XP total',NULL,'TOTAL_XP',1000,'gold'),(28,'STREAK_3','Getting Started','3-Day Streak',NULL,'STREAK_DAYS',3,'bronze'),(29,'STREAK_7','7-Day Warrior','7-Day Streak',NULL,'STREAK_DAYS',7,'silver'),(30,'STREAK_30','30-Day Warrior','30-Day Streak',NULL,'STREAK_DAYS',30,'gold');
/*!40000 ALTER TABLE `trophies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_trophies`
--

DROP TABLE IF EXISTS `user_trophies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_trophies` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `trophy_id` bigint NOT NULL,
  `earned_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `trophy_id` (`trophy_id`),
  CONSTRAINT `user_trophies_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_trophies_ibfk_2` FOREIGN KEY (`trophy_id`) REFERENCES `trophies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_trophies`
--

LOCK TABLES `user_trophies` WRITE;
/*!40000 ALTER TABLE `user_trophies` DISABLE KEYS */;
INSERT INTO `user_trophies` VALUES (12,17,22,'2026-04-22 04:53:59'),(13,17,28,'2026-04-24 04:55:46'),(14,17,25,'2026-04-24 04:55:53'),(15,17,29,'2026-04-24 05:05:51'),(16,18,22,'2026-04-22 06:30:24'),(17,18,28,'2026-04-25 06:35:18'),(18,19,22,'2026-04-23 06:53:16'),(19,20,22,'2026-04-22 08:09:43'),(20,22,22,'2026-05-05 10:13:29'),(21,23,22,'2026-05-05 11:01:16'),(22,25,22,'2026-05-06 11:54:18');
/*!40000 ALTER TABLE `user_trophies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `height` float DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `goal` varchar(255) DEFAULT NULL,
  `xp` int DEFAULT '0',
  `streak_days` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `email` varchar(255) NOT NULL,
  `training_frequency` double DEFAULT '1.2',
  `age` int NOT NULL DEFAULT '0',
  `TDEE` int DEFAULT NULL,
  `registration_date` date DEFAULT NULL,
  `registration_weight` double DEFAULT NULL,
  `pet_type` varchar(255) DEFAULT NULL,
  `pet_level` int DEFAULT '1' COMMENT '宠物等级 1-20',
  `pet_exp` int DEFAULT '0' COMMENT '宠物当前经验值',
  `pet_mood` int DEFAULT '100' COMMENT '心情值 0-100',
  `pet_energy` int DEFAULT '100' COMMENT '体力值 0-100',
  `pet_last_active` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后活动时间',
  `pet_stage` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Zicheng Niu','$2a$10$i3H50wzMa/4dyHSjM2qBFepX9/uMoLui1k2wdOwsUUsCEt2jvU/vC',175,70,'man',NULL,0,0,'2026-04-17 12:06:17','13939094579@icloud.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(2,'Test1','$2a$10$tL45iG1U76G60TO.wqNPQel9A09tmbNlADP2Zz2YMQARb4lXNJ2/O',111,111,'man',NULL,0,0,'2026-04-17 12:10:48','11111111@test.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(3,'111','$2a$10$VpPxiUa7aIEf1ZeUXMFu/OPXIUFbGnOw3TPKINpKh68fIPko2oBo2',111,111,'111',NULL,0,0,'2026-04-17 14:12:33','111111@111.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(4,'111','$2a$10$WmY22fv5OLcOk6ampt2ioeQZnHxj3O35Pco9tSHIWR22Ut1rHxhfm',111,111,'man',NULL,0,0,'2026-04-17 14:17:11','111111111@111.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(5,'111','$2a$10$AJDE95gCJMVgHJvKEFF5uurzkwCa.BUdnZHtnBxs9Msxyr7.c9bFe',111,111,'man',NULL,0,0,'2026-04-18 11:40:41','1111111111@111.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(6,'111','$2a$10$4Sw1VMkE1GIH1CIZ2MzJxu9/4ZR3xwlZPSb76xiwh9SlQnJeSU74u',111,111,'man',NULL,0,0,'2026-04-18 11:44:29','111111111111@111.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(7,'111','$2a$10$lrIyWoO0ygbivJTAvzZ.WeXsytWHG3vRGOvswHwE884nNLbhz0Clu',111,111,'man',NULL,0,0,'2026-04-18 11:51:19','1111@111.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(8,'111','$2a$10$78Ojad9hLVodVS7ki1x0nuluOUYTL09d5QDekmi7uZMzgFa/gjdWG',111,111,'man',NULL,20,1,'2026-04-18 11:55:36','11111@111.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(9,'leo','$2a$10$TdYo7fsnV5nrdSMjIC/GeOVzt1L/kex8Kryu7tCOvdhA2Awr/mcXG',175,70,'man',NULL,920,46,'2026-04-18 13:18:42','leo123@111.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(10,'leo1','$2a$10$2v5.DbTsRYolt2cGKyffreUnHroMboGykGSx3xLUfqaUzE1HW0wgS',175,70,'man',NULL,60,3,'2026-04-19 10:37:07','leo111@111.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(11,'111','$2a$10$hyQTqDOWFXVpVOI9xkevc.HjPWzzAmPLw5.Tgn1Bg/wwuflj9WAP2',177,66,'man',NULL,100,5,'2026-04-19 10:47:30','leo222@111.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(12,'111','$2a$10$hvyJT.LC66B2iGB.n2caH.4.Zk3UwKNSFFyZ8exYNjcjh6Yt6AGn6',123,66,'man',NULL,20,1,'2026-04-19 13:27:53','leo333@111.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(13,'test','$2a$10$Q6AaKKxaJxd.5RExx3qsfORhTexmd7nCIVdtRkAyrF51d91ofHUv6',178,77,'man',NULL,100,5,'2026-04-19 13:39:42','leo444@111.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(14,'111','$2a$10$UGM7rjQHQh3GLUwxJzi7fOZwQSllh9WD7MIjz/l4V2fBKVs9v88Ay',111,111,'woman',NULL,0,0,'2026-04-19 14:17:24','leo555@111.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(15,'zwy','$2a$10$P7YdoC/0uoEDdI/eJIQ6LOGsvEMnDo0wW2mhs0unjbzpsTyobmiKi',111,111,'man',NULL,140,7,'2026-04-20 05:05:58','zwy111@111.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(16,'111','$2a$10$55QbA6wUHYnQ7QuiNHLWOeqktOXUSur8.IArAijlFxjodxzfgwUbO',111,111,'man',NULL,20,1,'2026-04-20 10:20:45','zwy222@111.com',1.2,0,NULL,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(17,'123','$2a$10$/ZEkmxBIgAy72VIuz8tqDOUinydk/cwaQyarPPgdl.TGWC7Hpvyqy',123,123,'man','gain',200,10,'2026-04-21 16:11:46','GerdaHollowayezw@mail.com',1.55,12,3012,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(18,'diaonan da','$2a$10$Zh.rt.RAmbRh3ofN5gvhLe/VS/mP4VEFaHp6snuv03Z2NxHxFDvz6',111,111,'man','lose',60,3,'2026-04-22 06:20:52','10020721672131231awdwadawdadwa@qq.com',1.55,22,2633,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(19,'diaonan da','$2a$10$S5fylm1BOA5WkE8UWs7e2eBZaj8h8PJ7eTwv7ZRTgwCIbxINNwjZS',40,55,'man','lose',20,1,'2026-04-22 06:51:20','10020721672131231awdwadawdadwaa@qq.com',1.55,11,1162,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(20,'diaodnan dadd','$2a$10$Li77TyjFAu5qVxggYHKJ/unRwnlvdg/2B34KLFYK08/uQo4PR5HAy',177,89,'man','lose',20,1,'2026-04-22 08:07:57','100207216yukyukyy7@qq.com',1.375,12,2669,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(21,'di','$2a$10$ECKphN8jn3fbpUNBUVo0jONr2Oi1YNaVl.9vMgkObBI6GiOjAgeAi',177,77,'man','lose',0,0,'2026-04-22 08:10:29','10020721671231321@qq.com',1.375,18,2462,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(22,'diaonan da','$2a$10$zo4H5TJ1iyifoeggnRETAe.vVaV/fFHTItPIS77kTXykyekPwojGG',177,123,'man','gain',20,1,'2026-05-05 10:13:02','10020721673213123131312321@qq.com',1.2,19,2695,NULL,NULL,NULL,1,0,100,100,'2026-05-05 10:26:35',NULL),(23,'diaonan da','$2a$10$p/4ApHiEw/KyTcUeCS2mJ.faK7.a2OqeZaNDWxHvBGhPMROPynUwG',177,123,'man','lose',20,1,'2026-05-05 10:36:08','1002072167321312313131232111@qq.com',1.2,19,2695,NULL,NULL,'grass',6,22,80,7,'2026-05-06 11:27:11',3),(24,'diaonan da','$2a$10$To8gGp9XDijDyCvEd5lA.uxKXfR50WMxg5jURUQtEAi/xaPQ6m0dK',177,123,'man','lose',0,0,'2026-05-06 11:49:07','10020721673213123131312321111111111@qq.com',1.725,19,3874,NULL,NULL,'fire',1,0,100,100,'2026-05-06 11:49:15',3),(25,'diaonan da','$2a$10$bjMoUcMp44Ktv9Oga8nGKee1XXJnnO6KAXTfOThnJmxPmHe/uwJSW',177,123,'woman','gain',20,1,'2026-05-06 11:53:58','1002072167321312313131232111111111111@qq.com',1.55,19,3224,NULL,NULL,'electric',11,22,100,70,'2026-05-06 11:54:18',2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weight_logs`
--

DROP TABLE IF EXISTS `weight_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weight_logs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `date` date NOT NULL,
  `weight` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_date` (`user_id`,`date`),
  UNIQUE KEY `UKp4xw0kxr3tbvmr2v6jdunpjof` (`user_id`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weight_logs`
--

LOCK TABLES `weight_logs` WRITE;
/*!40000 ALTER TABLE `weight_logs` DISABLE KEYS */;
INSERT INTO `weight_logs` VALUES (1,17,'2026-04-22',123),(2,18,'2026-04-22',222),(3,18,'2026-04-23',88),(4,19,'2026-04-22',55),(5,19,'2026-04-23',44),(6,20,'2026-04-22',89),(7,21,'2026-04-22',77),(8,18,'2026-04-24',113),(9,22,'2026-05-05',123),(10,23,'2026-05-05',123),(11,24,'2026-05-06',123),(12,25,'2026-05-06',111);
/*!40000 ALTER TABLE `weight_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workout_exercises`
--

DROP TABLE IF EXISTS `workout_exercises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workout_exercises` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `plan_id` bigint NOT NULL,
  `exercise_id` bigint DEFAULT NULL,
  `sets` int NOT NULL,
  `reps` int NOT NULL,
  `weight_kg` float DEFAULT NULL,
  `order_index` int DEFAULT '0',
  `exercise_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `plan_id` (`plan_id`),
  KEY `exercise_id` (`exercise_id`),
  CONSTRAINT `workout_exercises_ibfk_1` FOREIGN KEY (`plan_id`) REFERENCES `workout_plans` (`id`) ON DELETE CASCADE,
  CONSTRAINT `workout_exercises_ibfk_2` FOREIGN KEY (`exercise_id`) REFERENCES `exercises` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=227 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workout_exercises`
--

LOCK TABLES `workout_exercises` WRITE;
/*!40000 ALTER TABLE `workout_exercises` DISABLE KEYS */;
INSERT INTO `workout_exercises` VALUES (1,11,NULL,3,12,NULL,1,'Push-Up'),(2,11,NULL,3,15,NULL,2,'Bodyweight Squat'),(3,11,NULL,3,60,NULL,3,'Plank'),(4,12,NULL,3,12,NULL,1,'Push-Up'),(5,12,NULL,3,15,NULL,2,'Bodyweight Squat'),(6,12,NULL,3,60,NULL,3,'Plank'),(7,13,NULL,4,10,NULL,1,'Burpee'),(8,13,NULL,4,20,NULL,2,'Mountain Climber'),(9,13,NULL,4,30,NULL,3,'Jumping Jack'),(10,14,NULL,4,90,NULL,1,'Plank'),(11,14,NULL,3,15,NULL,2,'Leg Raise'),(12,14,NULL,3,20,NULL,3,'Russian Twist'),(13,14,NULL,3,30,NULL,4,'Mountain Climber'),(14,15,NULL,3,12,NULL,1,'Push-Up'),(15,15,NULL,3,15,NULL,2,'Bodyweight Squat'),(16,15,NULL,3,60,NULL,3,'Plank'),(17,16,NULL,3,12,NULL,1,'Push-Up'),(18,16,NULL,3,15,NULL,2,'Bodyweight Squat'),(19,16,NULL,3,60,NULL,3,'Plank'),(20,17,NULL,3,12,NULL,1,'Push-Up'),(21,17,NULL,3,15,NULL,2,'Bodyweight Squat'),(22,17,NULL,3,60,NULL,3,'Plank'),(94,43,NULL,3,12,NULL,1,'Wide Push-Up'),(95,43,NULL,3,15,NULL,2,'Leg Press'),(96,43,NULL,3,60,NULL,3,'Bicycle Crunch'),(139,55,NULL,4,12,0,1,'Dips (Chest version)'),(140,55,NULL,4,12,0,2,'Dips (Chest version)'),(141,55,NULL,4,12,40,3,'Pec Deck Machine'),(142,55,NULL,4,12,0,4,'Decline Push-Up'),(143,64,NULL,4,4,0,0,'Decline Shoulder Touch Push-Up'),(144,64,NULL,4,4,0,1,'Kneeling Decline Push-Up'),(145,64,NULL,4,4,0,2,'Barbell Incline Bench Press'),(146,64,NULL,4,4,0,3,'Dumbbell Flat Fly'),(147,65,NULL,3,3,0,0,'Seated Prone Fly'),(148,65,NULL,3,3,0,1,'Barbell Machine Press'),(149,65,NULL,3,3,0,2,'Seated Dumbbell Press'),(150,65,NULL,3,3,0,3,'Cable Single Arm Lateral Raise'),(151,65,NULL,3,3,0,4,'Band Lateral Raise'),(152,65,NULL,3,3,0,5,'Barbell Bent Over Row'),(153,67,NULL,3,11,0,0,'Barbell Row'),(154,67,NULL,3,11,0,1,'Cable Reverse Grip Pulldown'),(155,67,NULL,3,11,0,2,'Barbell Incline Row'),(156,67,NULL,3,11,0,3,'Machine Single Arm Row'),(157,67,NULL,3,11,0,4,'Cable Single Arm Pull'),(158,68,NULL,3,11,0,0,'Wall Hands To Toes Touch'),(159,68,NULL,3,11,0,1,'Crunch'),(160,68,NULL,3,11,0,2,'Reverse Crunch'),(161,68,NULL,3,11,0,3,'Cable Standing Hip Raise'),(162,68,NULL,3,11,0,4,'Side Waist Touch Heel'),(163,69,NULL,4,11,0,0,'Barbell Deadlift'),(164,69,NULL,4,11,0,1,'Sumo Squat'),(165,69,NULL,4,11,0,2,'Kettlebell Goblet Squat'),(166,69,NULL,4,11,0,3,'Dumbbell Lunge'),(167,70,NULL,3,11,0,0,'Parallel Bar Dip'),(168,70,NULL,3,11,0,1,'Seated Single Arm Dumbbell Extension'),(169,70,NULL,3,11,0,2,'Bench Dip'),(170,70,NULL,3,11,0,3,'Seated Hammer Curl'),(171,70,NULL,3,11,0,4,'Cable Hammer Curl'),(172,71,NULL,3,11,0,0,'Band Standing Reverse Fly'),(173,71,NULL,3,11,0,1,'Barbell Standing Press'),(174,71,NULL,3,11,0,2,'Band Front Raise'),(175,71,NULL,3,11,0,3,'Fixed Prone Lateral Raise'),(176,71,NULL,3,11,0,4,'Cable Single Arm Lateral Raise'),(177,71,NULL,3,11,0,5,'Barbell Bent Over Row'),(178,72,NULL,3,11,0,0,'Cable Behind Neck Pulldown'),(179,72,NULL,3,11,0,1,'Band Seated Row'),(180,72,NULL,3,11,0,2,'Bodyweight Pull-Up'),(181,72,NULL,3,11,0,3,'Dumbbell Row'),(182,72,NULL,3,11,0,4,'Dumbbell Reverse Grip Row'),(183,79,NULL,4,11,0,0,'Decline Push-Up'),(184,79,NULL,4,11,0,1,'Kneeling Decline Push-Up'),(185,79,NULL,4,11,0,2,'Barbell Incline Bench Press'),(186,79,NULL,4,11,0,3,'Standard Push-Up'),(187,80,NULL,4,11,0,0,'Machine Single Leg Curl'),(188,80,NULL,4,11,0,1,'Barbell Squat'),(189,81,NULL,3,3,0,0,'Dumbbell Single Arm Extension'),(190,81,NULL,3,3,0,1,'Standing Single Arm Dumbbell Extension'),(191,81,NULL,3,3,0,2,'Dumbbell Single Arm Extension'),(192,82,NULL,3,11,0,0,'Band Standing Reverse Fly'),(193,82,NULL,3,11,0,1,'Machine Press'),(194,82,NULL,3,11,0,2,'Seated Dumbbell Press'),(195,82,NULL,3,11,0,3,'Cable Single Arm Lateral Raise'),(196,82,NULL,3,11,0,4,'Band Shoulder Abduction'),(197,82,NULL,3,11,0,5,'Barbell Upright Row'),(198,83,NULL,3,11,0,0,'Dumbbell Incline Row'),(199,83,NULL,3,11,0,1,'Band Bent Over Row'),(200,83,NULL,3,11,0,2,'Barbell Row'),(201,83,NULL,3,11,0,3,'Barbell Incline Row'),(202,83,NULL,3,11,0,4,'Barbell Reverse Grip Row'),(203,84,NULL,4,11,0,0,'Decline Shoulder Touch Push-Up'),(204,84,NULL,4,11,0,1,'Decline Push-Up'),(205,84,NULL,4,11,0,2,'Incline Shoulder Touch Push-Up'),(206,84,NULL,4,11,0,3,'Standard Push-Up'),(207,85,NULL,3,3,0,0,'Cable Reverse Grip Pulldown'),(208,85,NULL,3,3,0,1,'Bodyweight Pull-Up'),(209,85,NULL,3,3,0,2,'Kneeling Band Pulldown'),(210,85,NULL,3,3,0,3,'Dumbbell Incline Row'),(211,85,NULL,3,3,0,4,'Band Single Arm Row'),(212,86,NULL,3,3,0,0,'Dumbbell Single Arm Extension'),(213,86,NULL,3,3,0,1,'Parallel Bar Dip'),(214,86,NULL,3,3,0,2,'Parallel Bar Dip'),(215,86,NULL,3,3,0,3,'Cable Hammer Curl'),(216,86,NULL,3,3,0,4,'Preacher Bench Dumbbell Curl'),(217,87,NULL,3,3,0,0,'Cable Seated Row'),(218,87,NULL,3,3,0,1,'Band Bent Over Row'),(219,87,NULL,3,3,0,2,'Wide Grip Seated Row'),(220,87,NULL,3,3,0,3,'Weighted Pull-Up'),(221,87,NULL,3,3,0,4,'Band Single Arm Row'),(222,88,NULL,3,3,0,0,'Crunch'),(223,88,NULL,3,3,0,1,'Wall Knee-Up Crunch'),(224,88,NULL,3,3,0,2,'Pulse Up'),(225,88,NULL,3,3,0,3,'Flat Lying Leg Raise'),(226,88,NULL,3,3,0,4,'Side Waist Touch Heel');
/*!40000 ALTER TABLE `workout_exercises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workout_plans`
--

DROP TABLE IF EXISTS `workout_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workout_plans` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `plan_date` date DEFAULT NULL,
  `is_finished` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `workout_plans_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workout_plans`
--

LOCK TABLES `workout_plans` WRITE;
/*!40000 ALTER TABLE `workout_plans` DISABLE KEYS */;
INSERT INTO `workout_plans` VALUES (1,8,'2026-04-18',1),(11,9,'2026-04-19',1),(12,10,'2026-04-19',1),(13,11,'2026-04-19',1),(14,12,'2026-04-19',1),(15,13,'2026-04-19',1),(16,15,'2026-04-20',1),(17,9,'2026-04-20',1),(43,16,'2026-04-21',1),(55,9,'2026-04-21',0),(64,17,'2026-04-22',1),(65,17,'2026-04-24',1),(66,17,'2026-04-23',1),(67,17,'2026-04-03',1),(68,16,'2026-04-22',0),(69,16,'2026-04-23',0),(70,16,'2026-04-24',0),(71,15,'2026-04-22',0),(72,14,'2026-04-22',0),(79,18,'2026-04-22',1),(80,18,'2026-04-23',1),(81,18,'2026-04-25',1),(82,19,'2026-04-23',1),(83,20,'2026-04-22',1),(84,14,'2026-04-23',0),(85,14,'2026-05-05',0),(86,22,'2026-05-05',1),(87,23,'2026-05-05',1),(88,25,'2026-05-06',1);
/*!40000 ALTER TABLE `workout_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workout_templates`
--

DROP TABLE IF EXISTS `workout_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workout_templates` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `difficulty` varchar(255) DEFAULT NULL,
  `goal` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workout_templates`
--

LOCK TABLES `workout_templates` WRITE;
/*!40000 ALTER TABLE `workout_templates` DISABLE KEYS */;
INSERT INTO `workout_templates` VALUES (1,'intermediate','Muscle','Chest Power','/img/chest.png'),(2,'intermediate','Muscle','Shoulder Boulder','/img/shoulder.png'),(3,'intermediate','Muscle','Back Attack','/img/back.png'),(4,'advanced','Muscle','Leg Day','/img/legs.png'),(5,'intermediate','Tone','Arm Specialist','/img/arms.png'),(6,'beginner','Stability','Core Crusher','/img/core.png'),(7,'beginner','Weight Loss','Cardio Burn','/img/cardio.png');
/*!40000 ALTER TABLE `workout_templates` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-05 22:06:50
