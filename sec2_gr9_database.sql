SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE DATABASE IF NOT EXISTS  sec2_gr9_database  DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE  sec2_gr9_database ;
-- --------------------------------

-- table structure for table 'Admin'
create table  admins  (
 admin_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 admin_firstname  varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
 admin_lastname  varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
 admin_sex varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
 admin_tel  varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL unique,
 admin_email  varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
 admin_address varchar(100)  CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
 admin_province varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
 admin_zipcode int NOT NULL,
 admin_username varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
 admin_password  varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
 admin_retypepassword varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
 image_path VARCHAR(255) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- Dumping data for table `admin`

insert into admins (admin_id, admin_firstname, admin_lastname, admin_sex, admin_tel, admin_email, admin_address, admin_province, admin_zipcode, admin_username, admin_password, admin_retypepassword, image_path) values
(6687001, 'Keatikun', 'Komkeng', 'Male', '082-5204864', 'Kettikungkom@gmail.com', 'เพชรเกษม53 หมู่บ้านทิพธนา', 'กรุงเทพมหานคร', 10160, 'Inwong', 'ong6687001', 'ong6687001', 'ong.jpg'),
(6687002, 'Techit', 'Thititammajiaraya', 'Male', '085-41438022', 'techit.thi@student.mahidol.edu', 'บางช้าง', 'นครปฐม', 73110, 'k4inuii', 'pluem6687002', 'pluem6687002', 'pluem.jpg'),
(6687031, 'Pornpawee', 'Pathompornwiwat', 'Female', '063-1973255', 'Bellpornpawee40@gmail.com', '95ถนนยิงเป้าใต้', 'นครปฐม', 73000, 'Bellbell', 'bell6687031', 'bell6687031', 'bell.jpg'),
(6687088, 'Thanason', 'Boonmark', 'Male', '080-5354455', 'Twinsp217@gmail.com', 'เชียงรากน้อย', 'พระนครศรีอยุธยา', 13180, 'Pengdeadeye', 'peng6687088', 'peng6687088', 'peng.jpg');


create table categories (
cat_id varchar(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL unique primary key ,
cat_name varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci; 
insert into categories (cat_id, cat_name) values
('001', 'Molly'),
('002', 'SkullPanda'),
('003', 'Hirono'),
('004', 'Crybaby'),
('005', 'Pucky'),
('006', 'ETC'),
('007', 'Bag'),
('008', 'Case'),
('009', 'Doll'),
('010', 'Mirror'),
('011', 'Pin'),
('012', 'Other'),
('013', 'Dimoo');



CREATE TABLE product (
        product_id INT NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
        product_name VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
        product_price INT NOT NULL,
        product_quantity INT NOT NULL,
        product_size VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
        product_material VARCHAR(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
        cat_id VARCHAR(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
        FOREIGN KEY (cat_id) REFERENCES categories(cat_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO product (product_id, product_name, product_price, product_quantity, product_size, product_material, cat_id) 
VALUES 
(100, 'MEGA SPACE MOLLY 100% Series 3', 430, 0, 'Height about 7-8cm', 'PVC/ABS/PC', '001'),
(101, 'MEGA SPACE MOLLY 100% BLIND BOX SERIES', 430, 10, '76mm height', 'PVC/ABS', '001'),
(102, 'MOLLY Anniversary Statues Classical Retro 2 Series Figures', 430, 15, 'Height about 12 cm', 'ABS/PVC', '001'),
(103, 'MOLLY My Instant Superpower Series Figures', 380, 8, 'Height about 7.8-9.9cm', 'ABS/PVC', '001'),
(104, 'MOLLY Carb-Lover Series Figures', 380, 12, 'Height about 7-11cm', 'ABS/PVC', '001'),
(105, 'Baby Molly When I was Three！Series Figures', 380, 6, 'Height about 6.9-13cm', 'ABS/PVC', '001'),

(200, 'SKULLPANDA Tell Me What You Want Series Figures', 380, 15, 'Height about 6-13cm', 'PVC/ABS/Polyester/Nylon/Magnet', '002'),
(201, 'SKULLPANDA The Sound Series Figures', 380, 10, 'Height about 7-11cm', 'ABS/PVC/Magnet', '002'),
(202, 'SKULLPANDA Image Of Reality Series Figures', 380, 7, 'Height about 5-8cm', 'PVC/ABS/POM/Magnet', '002'),
(203, 'SKULLPANDA The Warmth Series', 380, 12, 'Height about 6-9cm', 'PVC/ABS', '002'),

(300, 'Hirono×Le Petit Prince Series Figures', 380, 5, 'Height about 8-12cm', 'PVC/ABS/Hardware/Magnet', '003'),
(301, 'Hirono Shelter Series Figures', 380, 6, 'Height about 6-10cm', 'PVC/ABS/Magnet', '003'),
(302, 'HIRONO Reshape Series Figures', 380, 10, 'Height about 8.6-10.3cm', 'PVC/ABS', '003'),
(303, 'HIRONO The Other One Series', 380, 9, 'Height about 6.6 - 9.2cm', 'PVC/ABS/Hardware/Magnet', '003'),
(304, 'HIRONO Mime Series Figures', 380, 8, 'Height about 8.6-10.3cm', 'PVC/ABS', '003'),

(400, 'Crybaby Crying Parade Series', 380, 12, 'Height about 4.6-10.5cm', 'PVC/ABS', '004'),
(401, 'CRYBABY Crying Again Series Figures', 380, 15, 'Height about 8-10cm', 'PVC/ABS', '004'),
(402, 'CRYBABY × Powerpuff Girls Series Figures', 380, 10, 'Height about 6-9cm', 'PVC/ABS', '004'),

(500, 'PUCKY The Feast Series Figures', 380, 7, 'Height about 6.9-9.3cm', 'PVC/ABS', '005'),
(501, 'PUCKY Animal Tea Party Series', 380, 10, 'Height about 6.9-9.3cm', 'PVC/ABS', '005'),
(600, 'Sweet Bean Fruit World Adventure Series Figures', 380, 8, 'Height about 6.9-9.3cm', 'PVC/ABS', '006'),
(601, 'Disney Winnie the Pooh Gift Giving Series Figures', 380, 6, ' Combined height about 10cm', 'PVC/ABS', '006'),
(602, 'Lil Peach Riot：Loading! Series Figures', 380, 5, 'Height about 8.2-9cm', 'PVC/ABS', '006'),

(700, 'THE MONSTERS FALL IN WILD SERIES-Denim Messenger Bag', 1050, 12, '562134cm', 'Outer layer-65%cotton, 35%terylene', '007'),
(701, 'THE MONSTERS FALL IN WILD SERIES-Denim Apron Bag', 900, 8, '48cm37.5cm', 'Outer layer-65%cotton, 35%terylene', '007'),
(702, 'THE MONSTERS FALL IN WILD SERIES-Bucket Hat Mini Bag Blind Box', 550, 15, '15156.5cm(Lanyard not included)', 'Bellflower outer layer: 65%cotton, 32%terylene, 3%spandex', '007'),
(703, 'KUBO JEANS SERIES-Messenger Bag', 850, 10, '35cm11cm30.5cm', 'Outer Layer-65% Cotton, 35%Terylene', '007'),
(800, 'We are Twinkle Twinkle Series-Earphone Case', 550, 14, '8810cm', 'Silicone/Polyester/Zinc Alloy', '008'),
(801, 'DIMOO Weaving Wonders Series-Phone Case', 550, 10, 'Mobile phone same size','Silicone/Zinc alloy', '008'),
(802, 'LABUBU Originals-Brown Silicone Earphone Bag', 430, 8, 'Height about 9cm', 'Silicone/Zinc Alloy', '008'),
(803, 'THE MONSTERS Let s Have Fun Together Series-Mobile Phone Bracket', 550, 10, '12cm7.5cm16cm', 'PVC/ABS/Silicone/Hardware', '008'),
(804, 'CRYBABY Crying Again Series-Earphone Case (Love Makes Us Cry)', 550, 15, '10.5107.5cm', 'Silicone/Polyester/Nylon/Alloy','008'),
(805, 'DIMOO Weaving Wonders Series-Quilt Phone Case Blind Box', 850, 7, '21cm13cm8cm(Not Include the Rope)','Polyester/Zinc Alloy','008'),
(806, 'CRYBABY Crying Again Series-Phone Case for iPhone 16 Pro Max', 1050, 5, '2716cm','Polyester/PC/Alloy','008'),
(807, 'CRYBABY Crying Again Series-Phone Case for iPhone 15 Pro Max', 1050, 10, '27*16cm','Polyester/PC/Alloy','008'),
(808, 'CRYBABY Crying Again Series-Earphone Case (Duck You)', 550, 12, '10.5107.5cm', 'Silicone/Polyester/Nylon/Alloy', '008'),

(900, 'THE MONSTERS - Have a Seat Vinyl Plush Blind Box', 550, 8, 'Height about 8720cm(including hanging loop)', 'Polyester/ABS/Iron wire/Nylon', '009'),
(901, 'THE MONSTERS - FLIP WITH ME Vinyl Plush Doll', 2690, 5, '201540cm', 'Polyester/Cotton/TPR/PVC/PE', '009'),
(902, 'CRYBABY Sunset Concert Series-Plush Doll', 1050, 6, '211228cm', 'Polyester/Spandex/POM', '009'),
(903, 'CRYBABY CHEER UP, BABY! SERIES-Plush Doll Pendant', 430, 7, '116.515', 'Polyester', '009'),
(904, 'THE MONSTERS - Tasty Macarons Vinyl Face Blind Box', 550, 8, 'Height about 17cm', 'Polyester/PVC', '009'),
(905, 'CRYBABY CHEER UP, BABY! SERIES-Plush Doll', 1050, 5, 'Height about 221432cm', 'Polyester/Spandex/POM/PE', '009'),
(906, 'ted2 ted action plush doll', 1550, 6, 'Height about 30cm', 'Polyester', '009'),
(907, 'CRYBABY Sad Club Series-Plush Flower Blind Box', 380, 7, '16cm6cm29cm', 'Polyester', '009'),
(908, 'LABUBU Time to Chill-Vinyl Plush Doll', 2190, 5, 'about 20x16.4x37.5cm', 'Polyester/Cotton/Fiber', '009'),
(000, 'CRYBABY × Powerpuff Girls Series-Mirror Pendant', 430, 8, 'Height about 11.5cm', 'silicone/Glass', '010'),
(110, 'THE MONSTERS Let s Have Fun Together Series-Badge Blind Box', 230, 20, 'Height about 4cm', 'Zinc Alloy', '011'),
(120, 'DIMOO - More Than a Gift Bouquet Box', 3190, 15, '17838cm(Single piece)', 'Polyester/PP', '012'),
(121, 'Care Bears Cozy Life Series-Acrylic Phone Lanyard Blind Box', 270, 10, 'Rope length about 54cm', 'Terylene/Zinc Alloy/Acrylic', '012'),
(130, 'DIMOO Weaving Wonders Series Figures', 380, 5, 'Height about 7-11cm', 'PVC/ABS', '013'),
(131, 'DIMOO Animal Kingdom Series Figures', 380, 7, 'Height about 6-8cm', 'PVC/ABS', '013'),
(132, 'DIMOO By Your Side Series Figures', 380, 10, 'Height about 8cm', 'PVC/ABS', '013');


CREATE TABLE images_product (
    image_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- กำหนด image_id เป็น Primary Key
    id INT NOT NULL, -- อ้างอิงถึง product_id
    image_path VARCHAR(255) NOT NULL,
    FOREIGN KEY (id) REFERENCES product(product_id) -- id เป็น Foreign Key
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO images_product (image_id, id, image_path)
values (1000, 100, 'https://prod-thailand-res.popmart.com/default/20240731_171817_505119____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(1010, 101, 'https://prod-eurasian-res.popmart.com/default/1_vwwDGJiw2a_1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(1020, 102, 'https://prod-thailand-res.popmart.com/default/20240701_115758_825046____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(1030, 103, 'https://prod-thailand-res.popmart.com/default/20241029_153008_491907____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(1040, 104, 'https://prod-thailand-res.popmart.com/default/20241014_115110_618925____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(1050, 105, 'https://prod-eurasian-res.popmart.com/default/20240422_103008_437701__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),

(2000, 200, 'https://prod-thailand-res.popmart.com/default/20241105_173934_896208____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(2010, 201, 'https://prod-thailand-res.popmart.com/default/20240625_101712_684735____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(2020, 202, 'https://prod-eurasian-res.popmart.com/default/20240209_225419_585138__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(2030, 203, 'https://prod-eurasian-res.popmart.com/default/1_JXq4BcLoLv_1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),

(3000, 300, 'https://prod-thailand-res.popmart.com/default/20241023_142056_056759____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(3010, 301, 'https://prod-thailand-res.popmart.com/default/20240715_095555_134897____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(3020, 302, 'https://prod-eurasian-res.popmart.com/default/20231228_175155_872547__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(3030, 303, 'https://prod-eurasian-res.popmart.com/default/20230914_111733_280620__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(3040, 304, 'https://prod-eurasian-res.popmart.com/default/1_8r6j4COoFC_1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),

(4000, 400, 'https://prod-thailand-res.popmart.com/default/20241115_095234_068144____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(4010, 401, 'https://prod-thailand-res.popmart.com/default/20240924_095748_398503____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(4020, 402, 'https://prod-eurasian-res.popmart.com/default/20240304_164111_296715__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),

(5000, 500, 'https://prod-eurasian-res.popmart.com/default/20240520_100548_536518____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(5010, 501, 'https://prod-thailand-res.popmart.com/default/20240624_160733_750698____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),

(6000, 600, 'https://prod-thailand-res.popmart.com/default/20240903_103045_135667____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(6010, 601, 'https://prod-thailand-res.popmart.com/default/20241106_103213_605026____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(6020, 602, 'https://prod-thailand-res.popmart.com/default/20241030_152615_219838____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),

(7000, 700, 'https://prod-eurasian-res.popmart.com/default/20240412_094600_140466__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(7010, 701, 'https://prod-eurasian-res.popmart.com/default/20240412_094107_617730__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(7020, 702, 'https://prod-eurasian-res.popmart.com/default/20240411_175024_812348__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(7030, 703, 'https://prod-eurasian-res.popmart.com/default/20240415_174143_432407__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),

(8000, 800, 'https://prod-thailand-res.popmart.com/default/20240913_160604_081566____1_____1200x1200.jpg'),
(8010, 801, 'https://prod-thailand-res.popmart.com/default/20241030_102057_715216____1_____1200x1200.jpg'),
(8020, 802, 'https://prod-eurasian-res.popmart.com/default/20231101_150235_592747__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(8030, 803, 'https://prod-thailand-res.popmart.com/default/20240819_160712_779062____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(8040, 804, 'https://prod-thailand-res.popmart.com/default/20240930_215511_653580____2_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(8050, 805, 'https://prod-thailand-res.popmart.com/default/20241031_144158_836080____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(8060, 806, 'https://prod-thailand-res.popmart.com/default/20240930_214749_147232____16_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(8070, 807, 'https://prod-thailand-res.popmart.com/default/20240930_214459_185152____15_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(8080, 808, 'https://prod-thailand-res.popmart.com/default/20240930_215845_414527____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),

(9000, 900, 'https://prod-thailand-res.popmart.com/default/20240710_104247_853112____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(9010, 901, 'https://prod-thailand-res.popmart.com/default/20240708_115313_158820____1-1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(9020, 902, 'https://prod-eurasian-res.popmart.com/default/20240617_143204_955539____4_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(9030, 903, 'https://prod-eurasian-res.popmart.com/default/20240428_144901_860029__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(9040, 904, 'https://prod-eurasian-res.popmart.com/default/20231026_101051_200156__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(9050, 905, 'https://prod-eurasian-res.popmart.com/default/20240428_143432_982624__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(9060, 906, 'https://prod-thailand-res.popmart.com/default/20240701_115426_840894____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(9070, 907, 'https://prod-eurasian-res.popmart.com/default/20240104_111455_924463__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(9080, 908, 'https://prod-eurasian-res.popmart.com/default/1_NI0jRK7JpO_1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),

(0000, 000, 'https://prod-eurasian-res.popmart.com/default/20240307_185736_898050__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),

(1100, 110, 'https://prod-thailand-res.popmart.com/default/20240819_162020_329691____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(1200, 120, 'https://prod-thailand-res.popmart.com/default/20240716_145509_793769____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(1210, 121, 'https://prod-eurasian-res.popmart.com/default/20231229_003606_129677__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(1300, 130, 'https://prod-thailand-res.popmart.com/default/20240930_124946_956300____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(1310, 131, 'https://prod-eurasian-res.popmart.com/default/20240315_163746_207298__1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp'),
(1320, 132, 'https://prod-eurasian-res.popmart.com/default/20240612_102058_963725____1_____1200x1200.jpg?x-oss-process=image/resize,p_40,format,webp,format,webp');

CREATE TABLE login (
    Username varchar(255) NOT NULL,
    admin_password  varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
    Login_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE images_product ADD CONSTRAINT fk_product_id FOREIGN KEY (id) REFERENCES product(product_id) ON DELETE CASCADE;

COMMIT;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


CREATE USER 'sec2_gr9_database'@'localhost' IDENTIFIED BY 'Sec2Group9';
GRANT ALL PRIVILEGES ON sec2_gr9_database.* TO 'sec2_gr9_database'@'localhost';


