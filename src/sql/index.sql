create database restaurant;
use restaurant;
CREATE TABLE IF NOT EXISTS contact_info
(
    contact_info_id VARCHAR(100),
    name VARCHAR (100) NOT NULL,
    address VARCHAR (150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    PRIMARY KEY(contact_info_id)
);
CREATE TABLE IF NOT EXISTS users(
    user_id VARCHAR(100),
    username VARCHAR(50),
    password VARCHAR(255),
    PRIMARY KEY(user_id),
    FOREIGN KEY (user_id) REFERENCES contact_info(contact_info_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS food_category
(
    food_category_name VARCHAR(100),
    PRIMARY KEY(food_category_name)
);
CREATE TABLE IF NOT EXISTS food_item
(
    food_item_name VARCHAR(100),
    food_item_price double(10,2),
    food_category_name VARCHAR(100),
    PRIMARY KEY(food_item_name),
    FOREIGN KEY (food_category_name) REFERENCES food_category(food_category_name)
);
CREATE TABLE IF NOT EXISTS menu
(
    menu_name VARCHAR(100),
    menu_start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP UNIQUE,
    menu_end_date DATE,
    is_menu_active BOOLEAN DEFAULT 0,
    PRIMARY KEY(menu_name,menu_start_date)
);
CREATE TABLE IF NOT EXISTS menu_content
(
    menu_name VARCHAR(100),
    food_item_name VARCHAR(100),
    is_food_available BOOLEAN DEFAULT 1,
    FOREIGN KEY (menu_name) REFERENCES menu(menu_name),
    FOREIGN KEY (food_item_name) REFERENCES food_item(food_item_name)
);
CREATE TABLE IF NOT EXISTS customer(
    customer_id VARCHAR(100) PRIMARY KEY,
    FOREIGN KEY (customer_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS staff_category
(
    staff_category VARCHAR (100) PRIMARY KEY,
    salary double(10,2)
);
CREATE TABLE IF NOT EXISTS staff(
    staff_id VARCHAR(100) PRIMARY KEY,
    staff_category VARCHAR(100),
    last_paid_date TIMESTAMP,
    joined_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP UNIQUE,
    FOREIGN KEY (staff_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_category) REFERENCES staff_category(staff_category) ON DELETE CASCADE);

CREATE TABLE IF NOT EXISTS import_company
(
    import_company_id VARCHAR(100) PRIMARY KEY,
    total_transactions double(10,2) DEFAULT 0.0,
    remain_transactions double(10,2) DEFAULT 0.0,
    FOREIGN KEY(import_company_id) REFERENCES contact_info(contact_info_id)
);

CREATE TABLE IF NOT EXISTS restaurant
(
    restaurant_id VARCHAR(100) PRIMARY KEY,
    total_staff INTEGER(10),
    capacity INTEGER(10),
    total_tables INTEGER(10),
    FOREIGN KEY(restaurant_id) REFERENCES contact_info(contact_info_id)  ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS restaurant_table(
    table_no INTEGER(10) PRIMARY KEY,
    is_empty BOOLEAN DEFAULT 1
);

CREATE TABLE IF NOT EXISTS import(
    import_company_id VARCHAR(100),
    bill_no INTEGER(10),
    total_price double(10,2),
    import_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP UNIQUE NOT NULL,
    PRIMARY KEY(bill_no),
    FOREIGN KEY(import_company_id) REFERENCES import_company(import_company_id)
);
CREATE TABLE IF NOT EXISTS import_type(
    import_type VARCHAR(120) PRIMARY KEY,
    measure_unit VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS import_detail(
    import_good VARCHAR(200),
    import_type VARCHAR(120),
    bill_no INTEGER(10),
    quantity double(10,2),
    price double(10,2),
    FOREIGN KEY (bill_no) REFERENCES import(bill_no) ON DELETE CASCADE,
    FOREIGN KEY(import_type) REFERENCES import_type(import_type)
);
CREATE TABLE IF NOT EXISTS stock(
    stock_name VARCHAR(200) PRIMARY KEY,
	type_of_stock VARCHAR(120),
    last_import_date TIMESTAMP,
    quantity double(10,2),
    FOREIGN KEY (last_import_date) REFERENCES import(import_date),
    FOREIGN KEY(type_of_stock) REFERENCES import_type(import_type)
);
CREATE TABLE IF NOT EXISTS reservation
(
    customer_id VARCHAR(100),
    table_no INTEGER(10),
    number_of_person INTEGER(2),
    reservation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP UNIQUE,
    reservation_fulfilled_status BOOLEAN DEFAULT 0,
    reserved_for_date TIMESTAMP,
    reserved_for_time TIME,
    PRIMARY KEY (reservation_date),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (table_no) REFERENCES restaurant_table(table_no)
);
CREATE TABLE IF NOT EXISTS food_order
(
    order_id VARCHAR(120),
    order_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP UNIQUE,
    is_order_complete BOOLEAN DEFAULT 0,
    PRIMARY KEY (order_id)
);

CREATE TABLE IF NOT EXISTS home_delivery(
    home_delivery_no VARCHAR(120),
    customer_id VARCHAR(120),
    delivery_staff_id VARCHAR(120),
    is_delivered BOOLEAN DEFAULT 0,
    PRIMARY KEY (home_delivery_no),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (delivery_staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE IF NOT EXISTS order_item(
    order_id VARCHAR(50),
    food_item_name VARCHAR(100),
    quantity INT(3) DEFAULT 1,
    FOREIGN KEY (order_id) REFERENCES food_order(order_id),
    FOREIGN KEY (food_item_name) REFERENCES food_item(food_item_name)
);
CREATE TABLE IF NOT EXISTS bill(
	bill_no VARCHAR(100) PRIMARY KEY,
	order_id VARCHAR(120),
	total_price double(15,5),
    issue_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP UNIQUE,
    FOREIGN KEY(order_id) REFERENCES food_order(order_id)
);
CREATE TABLE IF NOT EXISTS order_relates_staff(
    order_id VARCHAR(50),
    staff_id VARCHAR(120),
    FOREIGN KEY (order_id) REFERENCES food_order(order_id),
   FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE IF NOT EXISTS order_relates_table(
    order_id VARCHAR(50),
    table_no INT (11),
    FOREIGN KEY (order_id) REFERENCES food_order(order_id),
    FOREIGN KEY(table_no) REFERENCES restaurant_table(table_no)
);
CREATE TABLE IF NOT EXISTS order_relates_home_delivery(
    order_id VARCHAR(50),
    home_delivery_no VARCHAR(120),
    FOREIGN KEY (order_id) REFERENCES food_order(order_id),
    FOREIGN KEY (home_delivery_no) REFERENCES home_delivery(home_delivery_no)
);



create table food_cat(
food_cat_id varchar(12) not null,
food_cat_name varchar(18),
primary key(food_cat_id)
);

create table food_it(
food_item_id varchar(10) not null,
name char(18),
price int(7),
food_category_id int(10),
primary key(food_item_id)
);


insert into food_cat(food_cat_id,food_cat_name) values(1,'Breakfast');
insert into food_cat(food_cat_id,food_cat_name) values(2,'Snacks');
insert into food_cat(food_cat_id,food_cat_name) values(3,'Soups/Salad');
insert into food_cat(food_cat_id,food_cat_name) values(4,'Beverages');
insert into food_cat(food_cat_id,food_cat_name) values(5,'Bar/Cocktail');
insert into food_cat(food_cat_id,food_cat_name) values(6,'Dinner');
insert into food_cat(food_cat_id,food_cat_name) values(7,'Dessert');


insert into food_it(food_item_id,name,price,food_category_id) values(1,'Milk',80,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(2,'Americano',120,1);
insert into food_it(food_item_id,name,price,food_category_id) values(3,'Expresso',80,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(4,'Coffee',100,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(5,'Tea',70,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(6,'Egg Toast',80,1);
insert into food_it(food_item_id,name,price,food_category_id) values(7,'Chicken Sandwich',150,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(8,'Veg Sandwich',110,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(9,'Butter Toast',100,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(10,'PanCake',120,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(11,'Breakfast Burrito',150,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(12,'Oatmeal',250,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(13,'Muffin',150,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(14,'Donut',80,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(15,'Toast',150,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(16,'Omelete',80,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(17,'Grilled fish',120,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(18,'Bread and Jam',120,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(19,'Side Hash Brown',120,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(20,'Boiled Eggs',50,1 );
insert into food_it(food_item_id,name,price,food_category_id) values(21,'CheeseBalls',100,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(22,'Veg Tempora',120,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(23,'French Fries',130,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(24,'Panner Tikka',250,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(25,'Veg Pakoda',120,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(26,'Panner Pakoda',210,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(27,'Alu Chip',150,2);
insert into food_it(food_item_id,name,price,food_category_id) values(28,'Mustang Alu',120,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(29,'Veg Sizzler',200,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(30,'Fish Fry',120,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(31,'Chicken Fry',200,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(32,'Chicken Momo',180,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(33,'Veg Momo',150,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(34,'C Momo',220,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(35,'Jhol Momo',200,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(36,'Cookie',120,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(37,'Cake',100,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(38,'Onion Rings',120,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(39,'Fried Shrimp',150,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(40,'Burger',130,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(41,'Veg Pizza',220,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(42,'Chicken Pizza',270,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(43,'Mixed Pizza',150,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(44,'Mushroom Pizza',230,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(45,'Mozzarella Sticks',140,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(46,'Hot Wings',210,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(47,'Grilled Chicken',250,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(48,'Roasted Chicken',270,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(49,'Singapore Fish',170,2 );
insert into food_it(food_item_id,name,price,food_category_id) values(50,'Hot Dog',180,2 );


insert into food_it(food_item_id,name,price,food_category_id) values(51,'Tomato Soup',120,3 );
insert into food_it(food_item_id,name,price,food_category_id) values(52,'Won Ton Soup',250,3 );
insert into food_it(food_item_id,name,price,food_category_id) values(53,'Chicken Soup',200,3 );
insert into food_it(food_item_id,name,price,food_category_id) values(54,'Mushroom Soup',160,3 );
insert into food_it(food_item_id,name,price,food_category_id) values( 55,'Egg Droup Soup',220,3);
insert into food_it(food_item_id,name,price,food_category_id) values(56,'Chinese Soup',130,3 );
insert into food_it(food_item_id,name,price,food_category_id) values(57,'Vegetable Soup',100,3 );
insert into food_it(food_item_id,name,price,food_category_id) values(58,'Mixed Soup',150,3 );
insert into food_it(food_item_id,name,price,food_category_id) values(59,'Hot and Sour Soup',200,3 );
insert into food_it(food_item_id,name,price,food_category_id) values(60,'Bean Soup',120,3 );
insert into food_it(food_item_id,name,price,food_category_id) values(61,'CocaCola',60,4 );
insert into food_it(food_item_id,name,price,food_category_id) values(62,'Fanta',60,4  );
insert into food_it(food_item_id,name,price,food_category_id) values(63,'Slice',70,4  );
insert into food_it(food_item_id,name,price,food_category_id) values(64,'Orange Juice',40,4  );
insert into food_it(food_item_id,name,price,food_category_id) values( 65,'RedBull',90,4 );
insert into food_it(food_item_id,name,price,food_category_id) values(66,'Cold Coffee',160,4  );
insert into food_it(food_item_id,name,price,food_category_id) values(67,'Cold Coffee with icecream',250,4  );
insert into food_it(food_item_id,name,price,food_category_id) values( 68,'Lemon Soda',60,4 );
insert into food_it(food_item_id,name,price,food_category_id) values(69,'Mango lassi',90,4  );
insert into food_it(food_item_id,name,price,food_category_id) values(70,'Vanilla Lattee',120,4 );
insert into food_it(food_item_id,name,price,food_category_id) values(71,'Mojito',300,5 );
insert into food_it(food_item_id,name,price,food_category_id) values(72,'Tequila',290,5 );
insert into food_it(food_item_id,name,price,food_category_id) values(73,'Bloody Mary',390,5 );
insert into food_it(food_item_id,name,price,food_category_id) values(74,'Margarita',250,5 );
insert into food_it(food_item_id,name,price,food_category_id) values(75,'Cape codder',270,5 );
insert into food_it(food_item_id,name,price,food_category_id) values(76,'On Beach',240,5 );
insert into food_it(food_item_id,name,price,food_category_id) values(77,'Screwdriver',290,5 );
insert into food_it(food_item_id,name,price,food_category_id) values(78,'Chinese Salamander',190,5 );
insert into food_it(food_item_id,name,price,food_category_id) values( 79,'Orange creamsicle',390,5);
insert into food_it(food_item_id,name,price,food_category_id) values( 80,'Root Float',280,5);
insert into food_it(food_item_id,name,price,food_category_id) values(81,'Red Wine',210,5 );
insert into food_it(food_item_id,name,price,food_category_id) values(82,'Robert Mondavi Wine',280,5 );
insert into food_it(food_item_id,name,price,food_category_id) values( 83,'Brick House Wine',210,5);
insert into food_it(food_item_id,name,price,food_category_id) values( 84,'August cellars Wine',280,5);
insert into food_it(food_item_id,name,price,food_category_id) values( 85,'Red Fort Wine',350,5);
insert into food_it(food_item_id,name,price,food_category_id) values( 86,'Del rio Wine',220,5);
insert into food_it(food_item_id,name,price,food_category_id) values( 87,'Hopler Wine',280,5);
insert into food_it(food_item_id,name,price,food_category_id) values( 88,'Root Float',280,5);
insert into food_it(food_item_id,name,price,food_category_id) values(89,'Dog Point Wine',220,5 );
insert into food_it(food_item_id,name,price,food_category_id) values(90,'Belle Glos Wine',210,5 );
insert into food_it(food_item_id,name,price,food_category_id) values(91,'Red Label',400,5 );
insert into food_it(food_item_id,name,price,food_category_id) values(92,'Remy Martin',410,5 );
insert into food_it(food_item_id,name,price,food_category_id) values(93,'Mc Doweles',500,5 );
insert into food_it(food_item_id,name,price,food_category_id) values(94,'Nuns Island',550,5 );
insert into food_it(food_item_id,name,price,food_category_id) values( 95,'The Dalmore 57',700,5);
insert into food_it(food_item_id,name,price,food_category_id) values(96,'Coconut Brandy',800,5 );
insert into food_it(food_item_id,name,price,food_category_id) values(97,'Diva Vodka',1200,5 );
insert into food_it(food_item_id,name,price,food_category_id) values( 98,'Henri Dudognon',450,5);
insert into food_it(food_item_id,name,price,food_category_id) values( 99,'Platinum liquor',550,5);
insert into food_it(food_item_id,name,price,food_category_id) values( 100,'DaMLFI lIMONCELLO',350,5);
insert into food_it(food_item_id,name,price,food_category_id) values(101,'Steam Rice',200,6 );
insert into food_it(food_item_id,name,price,food_category_id) values(102,'Plain Fried Rice',220,6 );
insert into food_it(food_item_id,name,price,food_category_id) values(103,'Thakali Set',250,6 );
insert into food_it(food_item_id,name,price,food_category_id) values(104,'Mushroom Rice Set',240,6 );
insert into food_it(food_item_id,name,price,food_category_id) values( 105,'Chicken Rice Set',270,6);
insert into food_it(food_item_id,name,price,food_category_id) values( 106,'Fish Rice Set',230,6);
insert into food_it(food_item_id,name,price,food_category_id) values(107,'Roti',100,6 );
insert into food_it(food_item_id,name,price,food_category_id) values(108,'Paratha ',120,6 );
insert into food_it(food_item_id,name,price,food_category_id) values( 109,'Shrimp Rice Set',250,6);
insert into food_it(food_item_id,name,price,food_category_id) values(110,'Mixed Rice Set',220,6 );
insert into food_it(food_item_id,name,price,food_category_id) values(111,'Toffee and Honey Comb',250,7 );
insert into food_it(food_item_id,name,price,food_category_id) values(112,'Cheese Cake',120,7 );
insert into food_it(food_item_id,name,price,food_category_id) values(113,'Apple Pie',120,7 );
insert into food_it(food_item_id,name,price,food_category_id) values( 114,'Salted Caramel Mousse',240,7);
insert into food_it(food_item_id,name,price,food_category_id) values( 115,'Malster Ice Cream Sundae',120,7);
insert into food_it(food_item_id,name,price,food_category_id) values( 116,'Vanilla Comb',280,7);
insert into food_it(food_item_id,name,price,food_category_id) values( 117,'Chocolate Brownie',320,7);
insert into food_it(food_item_id,name,price,food_category_id) values( 118,'Banana Boat',270,7);
insert into food_it(food_item_id,name,price,food_category_id) values( 119,'Profitroles',210,7);
insert into food_it(food_item_id,name,price,food_category_id) values( 120,'Curd and Pavlova',250,7);



insert into food_category
    (food_category_name)
values('Breakfast');
insert into food_category
    (food_category_name)
values('Snacks');
insert into food_category
    (food_category_name)
values('Soups/Salad');
insert into food_category
    (food_category_name)
values('Beverages');
insert into food_category
    (food_category_name)
values('Bar/Cocktail');
insert into food_category
    (food_category_name)
values('Dinner');
insert into food_category
    (food_category_name)
values('Dessert');


insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Milk', 80,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Americano', 120,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Expresso', 80,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Coffee', 100,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Tea', 70,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Egg Toast', 80,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Chicken Sandwich', 150,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Veg Sandwich', 110,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Butter Toast', 100,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('PanCake', 120,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Breakfast Burrito', 150,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Oatmeal', 250,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Muffin', 150,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Donut', 80,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Toast', 150,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Omelete', 80,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Grilled fish', 120,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Bread and Jam', 120,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Side Hash Brown', 120,"Breakfast");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Boiled Eggs', 50,"Breakfast");

insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('CheeseBalls', 100,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Veg Tempora', 120,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('French Fries', 130,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Panner Tikka', 250,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Veg Pakoda', 120,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Panner Pakoda', 210,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Alu Chip', 150,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Mustang Alu', 120,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Veg Sizzler', 200,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Fish Fry', 120,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Chicken Fry', 200,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Chicken Momo', 180,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Veg Momo', 150,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('C Momo', 220,"Snacks");

insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Chips', 100,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Cookie', 120,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Cake', 100,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Onion Rings', 120,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Fried Shrimp', 150,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Burger', 130,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Veg Pizza', 220,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Chicken Pizza', 270,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Mixed Pizza', 150,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Mushroom Pizza', 230,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Mozzarella Sticks', 140,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Hot Wings', 210,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Grilled Chicken', 250,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Roasted Chicken', 270,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Singapore Fish', 170,"Snacks");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Hot Dog', 180,"Snacks");

insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Tomato Soup', 120,"Soups/Salad");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Won Ton Soup', 250,"Soups/Salad");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Chicken Soup', 200,"Soups/Salad");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Mushroom Soup', 160,"Soups/Salad");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Egg Droup Soup', 220,"Soups/Salad");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Chinese Soup', 130,"Soups/Salad");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Vegetable Soup', 100,"Soups/Salad");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Mixed Soup', 150,"Soups/Salad");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Hot and Sour Soup', 200,"Soups/Salad");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Bean Soup', 120,"Soups/Salad");

insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('CocaCola', 60, "Beverages");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Fanta', 60, "Beverages");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Slice', 70, "Beverages");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Orange Juice', 40, "Beverages");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('RedBull', 90, "Beverages");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Cold Coffee', 160, "Beverages");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Cold Coffee with icecream', 250, "Beverages");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Lemon Soda', 60, "Beverages");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Mango lassi', 90, "Beverages");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Vanilla Lattee', 120, "Beverages");

insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Mojito', 300, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Tequila', 290, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Bloody Mary', 390, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Margarita', 250, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Cape codder', 270, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('On Beach', 240, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Screwdriver', 290, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Chinese Salamander', 190, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Orange creamsicle', 390, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Root Float', 280, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Red Wine', 210, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Robert Mondavi Wine', 280, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Brick House Wine', 210, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('August cellars Wine', 280, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Red Fort Wine', 350, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Del rio Wine', 220, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Hopler Wine', 280, "Bar/Cocktail");

insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Dog Point Wine', 220, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Belle Glos Wine', 210, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Red Label', 400, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Remy Martin', 410, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Mc Doweles', 500, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Nuns Island', 550, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('The Dalmore 57', 700, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Coconut Brandy', 800, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Diva Vodka', 1200, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Henri Dudognon', 450, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Platinum liquor', 550, "Bar/Cocktail");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('DaMLFI lIMONCELLO', 350, "Bar/Cocktail");

insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Steam Rice', 200, "Dinner");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Plain Fried Rice', 220, "Dinner");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Thakali Set', 250, "Dinner");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Mushroom Rice Set', 240, "Dinner");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Chicken Rice Set', 270, "Dinner");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Fish Rice Set', 230, "Dinner");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Roti', 100, "Dinner");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Paratha ', 120, "Dinner");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Shrimp Rice Set', 250, "Dinner");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Mixed Rice Set', 220, "Dinner");

insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Toffee and Honey Comb', 250, "Dessert");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Cheese Cake', 120, "Dessert");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Apple Pie', 120, "Dessert");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Salted Caramel Mousse', 240,"Dessert");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Malster Ice Cream Sundae', 120,"Dessert");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Vanilla Comb', 280,"Dessert");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Chocolate Brownie', 320,"Dessert");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Banana Boat', 270,"Dessert");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Profitroles', 210,"Dessert");
insert into food_item
    (food_item_name,food_item_price,food_category_name)
values('Curd and Pavlova', 250,"Dessert");


insert into menu
    (menu_name,menu_start_date,menu_end_date,is_menu_active)
values('New Year Set','2012-12-12','2012-12-24',false);
insert into menu
    (menu_name,menu_start_date,menu_end_date,is_menu_active)
values('Dashain Set','2013-09-01','2013-09-18',false);
insert into menu
    (menu_name,menu_start_date,menu_end_date,is_menu_active)
values('Lhosar Special','2014-08-01','2014-09-1',false);
insert into menu
    (menu_name,menu_start_date,menu_end_date)
values('Dinner Set','2015-07-19','2015-08-08');
insert into menu
    (menu_name,menu_start_date,menu_end_date)
values('Coffee Special','2016-08-21','2016-09-18');
insert into menu
    (menu_name,menu_start_date,menu_end_date)
values('Indian Set','2017-09-25','2017-09-28');
insert into menu
    (menu_name,menu_start_date,menu_end_date)
values('Chinese Special','2018-11-21','2018-12-03');
insert into menu
    (menu_name,menu_start_date,menu_end_date)
values('Tihar Special','2019-12-01','2019-12-18');



insert into menu_content
    (menu_name,food_item_name,is_food_available)
values('New Year Set','PanCake',false);
insert into menu_content
    (menu_name,food_item_name,is_food_available)
values('Dashain Set','Chicken Fry',false);
insert into menu_content
    (menu_name,food_item_name,is_food_available)
values('Lhosar Special','Hot Wings',false);
insert into menu_content
    (menu_name,food_item_name,is_food_available)
values('New Year Set','Mozzarella Sticks',false);
insert into menu_content
    (menu_name,food_item_name,is_food_available)
values('Dinner Set','Thakali Set',false);
insert into menu_content
    (menu_name,food_item_name,is_food_available)
values('Coffee Special','Americano',false);
insert into menu_content
    (menu_name,food_item_name,is_food_available)
values('Indian Set','Paratha',false);
insert into menu_content
    (menu_name,food_item_name,is_food_available)
values('Chinese Special','Onion Rings',false);
insert into menu_content
    (menu_name,food_item_name,is_food_available)
values('Tihar Special','Mustang Alu',true);


