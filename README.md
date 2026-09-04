BELLA TAVELO - ONLINE FOOD ORDERING SYSTEM
============================================

A Java Servlet/JSP web application for an Italian restaurant, with a customer-facing
ordering site and a separate admin dashboard for managing the menu, categories, and orders.


TECH STACK
----------
- Java (Servlets + JSP, Jakarta EE)
- MySQL 8
- JSTL (jakarta.tags.core, jakarta.tags.fmt)
- Deployed on Apache Tomcat via Eclipse Dynamic Web Project


SETUP INSTRUCTIONS
-------------------

1. Create the database
   Run the provided .sql file in MySQL Workbench, phpMyAdmin, or the mysql CLI. It will:
     - Create the bella_tavelo database and all tables
     - Seed the menu, categories, an admin account, a test customer account, and two sample orders

2. Configure the database connection
   Open src/main/java/util/DBConnection.java and update the credentials to match your local
   MySQL setup if needed:

     private static final String URL = "jdbc:mysql://localhost:3306/bella_tavelo";
     private static final String USER = "root";
     private static final String PASSWORD = "your_mysql_root_password";

3. Deploy
   Import the project into Eclipse (or your IDE of choice) as a Dynamic Web Project, add it to a
   Tomcat server, and run it. The homepage is homepage.html.


TEST ACCOUNT
------------

Admin Dashboard
Log in at admin-login.jsp (linked from the site, or go directly to /admin-login.jsp).

    Field       Value
    Email       admin@bellatavelo.com
    Password    123456

From here you can manage menu items (add/edit/delete), manage categories, and view/update
customer orders.

Note: passwords are stored and checked as plain text in the database for this assignment -
there is no hashing. This is a known simplification, not an oversight.


FEATURE OVERVIEW
-----------------

Customer side
  - Browse the menu by category
  - Add items to cart, choose add-ons
  - Checkout with delivery details and payment method
  - View past orders and their status

Admin side
  - Dashboard with quick links to all admin tools
  - Add / edit / delete menu items
  - Add / edit / delete categories
  - View all orders across all customers, including items, add-ons, and total, and update order status
