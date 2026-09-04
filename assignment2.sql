CREATE DATABASE IF NOT EXISTS bella_tavelo;

USE bella_tavelo;

-- ===================== USERS =====================


DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS admins;

CREATE TABLE admins (
    admin_id    INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(100) NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO admins (full_name, email, password)
VALUES ('Admin User', 'admin@bellatavelo.com', '123456');

CREATE TABLE users (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(100) NOT NULL UNIQUE,
    phone       VARCHAR(20)  NOT NULL,
    password    VARCHAR(255) NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ================ CATEGORIES & MENU ================


CREATE TABLE categories (
    category_id     INT AUTO_INCREMENT PRIMARY KEY,
    category_name   VARCHAR(50) NOT NULL UNIQUE,
    description     VARCHAR(255)
);

CREATE TABLE menu_items (
    item_id         INT AUTO_INCREMENT PRIMARY KEY,
    category_id     INT NOT NULL,
    name            VARCHAR(100) NOT NULL,
    description     VARCHAR(255),
    ingredients     VARCHAR(255),
    nutrition_info  VARCHAR(255),
    price           DECIMAL(8,2) NOT NULL,
    image_url       VARCHAR(255),
    is_available    BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ================ ORDERS & ORDER ITEMS ================


CREATE TABLE orders (
    order_id          INT AUTO_INCREMENT PRIMARY KEY,
    user_id           INT NOT NULL,
    total_price       DECIMAL(10,2) NOT NULL,
    status            VARCHAR(30)  NOT NULL DEFAULT 'Pending',
    payment_method    VARCHAR(30)  NOT NULL DEFAULT 'COD',
    delivery_address  VARCHAR(255) NOT NULL DEFAULT '',
    contact_phone     VARCHAR(20)  NOT NULL DEFAULT '',
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE order_items (
    order_item_id   INT AUTO_INCREMENT PRIMARY KEY,
    order_id        INT NOT NULL,
    item_id         INT NOT NULL,
    food_name       VARCHAR(100) NOT NULL DEFAULT '',
    quantity        INT NOT NULL DEFAULT 1,
    addons          VARCHAR(255) NULL,
    price           DECIMAL(8,2) NOT NULL,
    subtotal        DECIMAL(10,2) NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ================ TRANSACTIONS ================

CREATE TABLE transactions (
    transaction_id  INT AUTO_INCREMENT PRIMARY KEY,
    order_id        INT NOT NULL,
    payment_status  VARCHAR(30) NOT NULL,
    payment_date    DATETIME NOT NULL,
    amount          DECIMAL(10,2) NOT NULL,
    payment_method  VARCHAR(30) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ===================== SEED DATA =====================

INSERT INTO users (full_name, email, phone, password)
VALUES
('Admin User', 'admin@bellatavelo.com', '0123456789', '123456'),
('Sarah Lim', 'sarah.lim@example.com', '0187654321', '123456');

INSERT INTO categories (category_name, description) VALUES
('Starters', 'Light bites, to awaken your palate and begin the meal'),
('First course', 'Opening course, focused on foundational flavors'),
('Main course', 'The centerpiece of your dining experience, featuring hearty dishes'),
('Desserts', 'Sweet creations to conclude your meal'),
('Wine and beverages', 'A curated selection of drinks');


INSERT INTO menu_items (category_id, name, description, ingredients, nutrition_info, price, image_url) VALUES
(1, 'Carpaccio di Manzo', 'Thinly sliced raw beef tenderloin with arugula, parmesan, and truffle oil', 'Beef tenderloin, arugula, parmesan, truffle oil, lemon', '480 kcal, 22g protein, 4g carbs, 18g fat', 68.00, 'images/carpaccio.webp'),
(1, 'Burrata alla Caprese', 'Creamy burrata with heirloom tomatoes and basil oil', 'Burrata, tomato, basil, olive oil', '320 kcal, 14g protein, 8g carbs, 26g fat', 52.00, 'images/burrata.jpe'),
(2, 'Spaghetti Carbonara', 'Classic Roman pasta with egg yolk, pecorino romano, and crispy guanciale', 'Spaghetti, guanciale, egg yolk, pecorino romano, black pepper', '650 kcal, 28g protein, 70g carbs, 26g fat', 72.00, 'images/carbonarapasta.png'),
(2, 'Risotto ai Funghi Porcini', 'Slow-cooked arborio rice with porcini mushrooms and parmesan', 'Arborio rice, porcini, parmesan, white wine, butter', '540 kcal, 12g protein, 68g carbs, 20g fat', 78.00, 'images/risotto.jpe'),
(2, 'Tagliatelle al Tartufo Nero', 'Fresh tagliatelle with black truffle cream sauce', 'Tagliatelle, black truffle, cream, parmesan', '610 kcal, 15g protein, 72g carbs, 26g fat', 92.00, 'images/tagliatelle.jpe'),
(3, 'Osso Buco alla Milanese', 'Braised veal shank with saffron risotto', 'Veal shank, saffron, white wine, arborio rice, gremolata', '780 kcal, 48g protein, 60g carbs, 32g fat', 138.00, 'images/ossobuco.png'),
(3, 'Pizza Margherita', 'Traditional Neapolitan pizza with san marzano tomatoes, fresh mozzarella, and basil', 'Pizza dough, san marzano tomatoes, mozzarella, fresh basil, olive oil', '720 kcal, 24g protein, 95g carbs, 22g fat', 58.00, 'images/margheritapizza.png'),
(3, 'Branzino al Sale', 'Whole sea bass baked in a salt crust, filleted tableside', 'Sea bass, sea salt, rosemary, lemon', '420 kcal, 40g protein, 2g carbs, 24g fat', 128.00, 'images/branzino.png'),
(4, 'Tiramisu Classico', 'Classic mascarpone and espresso-soaked ladyfingers', 'Mascarpone, espresso, ladyfingers, cocoa', '420 kcal, 6g protein, 42g carbs, 24g fat', 38.00, 'images/tiramisu.png'),
(4, 'Panna Cotta', 'Silky vanilla panna cotta with mixed berry coulis', 'Cream, vanilla, gelatin, mixed berries', '310 kcal, 4g protein, 28g carbs, 20g fat', 34.00, 'images/pannacotta.jpg'),
(5, 'Chianti Classico (Glass)', 'Tuscan red wine, medium-bodied', 'Sangiovese grapes', '125 kcal, 0g protein, 4g carbs, 0g fat', 48.00, 'images/chianti.webp');

INSERT INTO orders (user_id, total_price, status, payment_method, delivery_address, contact_phone) VALUES
(2, 146.00, 'Preparing', 'COD', '12 Jalan Bella, Muar, Johor', '0123456789'),
(2, 92.00, 'Delivered', 'CARD', '12 Jalan Bella, Muar, Johor', '0123456789');

INSERT INTO order_items (order_id, item_id, food_name, quantity, addons, price, subtotal) VALUES
(1, 1, 'Carpaccio di Manzo', 1, NULL, 68.00, 68.00),
(1, 7, 'Tiramisù della Casa', 1, NULL, 38.00, 38.00),
(1, 9, 'Chianti Classico (Glass)', 1, NULL, 48.00, 48.00),
(2, 4, 'Tagliatelle al Tartufo Nero', 1, NULL, 92.00, 92.00);

-- DROP DATABASE bella_tavelo;