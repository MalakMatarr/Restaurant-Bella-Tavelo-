<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title> Bella Tavelo </title>
    
    <link rel="stylesheet" href="css/global.css">
	
	<link rel="stylesheet" href="css/contact.css">

    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">

</head>



<body>

    <!-- NAVIGATION BAR -->
    
    <header class="navbar">
    
        <div class="nav-container">
    
            <div class="brand"> Bella Tavelo </div>
    
            <nav class="nav-links">
    
                <a href="homepage.jsp"> Home </a>
    
                <a href="MenuServlet"> Menu </a>
    
                <a href="about.jsp"> About </a>
    
                <a class="active" href="contact.jsp"> Contact </a>
    
                <a href="faq.jsp"> FAQ </a>
    
            </nav>
    
            <%
			    String userName = (String) session.getAttribute("userName");
			%>
			
			<div class="nav-buttons">
			
			    <% if (userName != null) { %>
			
			        <span class="welcome-text">Hi, <%= userName %></span>
			        
			        <a href="MyOrders" class="login-btn">My Orders</a>
			        
			        <a href="LogoutServlet" class="login-btn">Logout</a>
			
			    <% } else { %>
			
			        <a href="login.html" class="login-btn">Login / Register</a>
			
			    <% } %>
			
			    <a href="cart.jsp" class="cart-btn" aria-label="View cart">
			        
			        <span class="material-symbols-outlined">shopping_cart</span>
			    
			    </a>
			
			</div>
			
        </div>
        
    </header>



    <main class="contact-page">

        <!-- HERO -->
        
        <section class="contact-hero">
        
            <div class="contact-hero-overlay"></div>
        
            <div class="contact-hero-content container">
        
                <span class="section-tag"> Modern Italian Hospitality </span>
        
                <div class="flag-line" aria-hidden="true">
        
                    <span class="flag-green"></span>
        
                    <span class="flag-cream"></span>
        
                    <span class="flag-red"></span>
        
                </div>
        
                <h1> Reserve the Bella Tavelo Experience </h1>
        
                <p>
                    From intimate dinners to private celebrations, 
                    our hospitality team is ready to welcome you with warm Italian care, 
                    refined service, and memorable dining.
                </p>

                <div class="contact-feature-grid">
               
                    <article class="feature-card feature-green">
               
                        <span class="material-symbols-outlined"> event_seat </span>
               
                        <h3> Reservations </h3>
               
                        <p> Book a table for lunch, dinner, or a special evening with us. </p>
               
                    </article>

                    <article class="feature-card feature-cream">
               
                        <span class="material-symbols-outlined"> celebration </span>
               
                        <h3> Private Dining </h3>
               
                        <p> Let us prepare elegant gatherings for birthdays, anniversaries, and events. </p>
               
                    </article>

                    <article class="feature-card feature-red">
                       
                        <span class="material-symbols-outlined"> shopping_cart </span>
                       
                        <h3> Ordering Help </h3>
                       
                        <p> Ask about online orders, checkout support, cart issues, or order confirmation. </p>
                    
                    </article>
               
                </div>
            
            </div>
        
        </section>

        
        <!-- MAIN CONTACT -->
   
        <section class="contact-main-section container">
   
            <aside class="contact-visit-panel">
   
                <div class="contact-panel-image">
    
                    <img src="images/stock7.png">
   
                </div>
             
                <div class="contact-panel-content">
             
                    <span class="contact-eyebrow light"> A Tavola </span>
             
                    <h2> An evening shaped by Italian warmth. </h2>
             
                    <p>
                        For urgent reservations, calling the restaurant is the fastest option. 
                        For everything else, we are delighted to assist you.
                    </p>

                    <div class="contact-detail-list">
                  
                        <div class="detail-item">
                  
                            <span class="material-symbols-outlined"> call </span>
                  
                            <div>
                  
                                <small> Contact Number </small>
                  
                                <strong> +39 312 345 6789 </strong>
                  
                            </div>
                  
                        </div>

                        <div class="detail-item">
                  
                            <span class="material-symbols-outlined"> mail </span>
                  
                            <div>
                  
                                <small> Email Address </small>
                  
                                <strong> bellatavelo@gmail.com </strong>
                  
                            </div>
                  
                        </div>
                  
                    </div>

                    <ul class="contact-hours-list">
                  
                        <li>
                  
                            <span> Monday </span>
                  
                            <strong> Closed </strong>
                  
                        </li>
                  
                        <li>
                  
                            <span> Tuesday - Saturday </span>
                  
                            <strong> 12:00 PM - 11:30 PM </strong>
                  
                        </li>
                  
                        <li>
                  
                            <span> Sunday </span>
                  
                            <strong> 11:00 AM - 4:00 PM </strong>
                  
                        </li>
                  
                    </ul>
                
                </div>
           
            </aside>


            <section class="contact-form-card" id="message-form">
  
                <span class="contact-eyebrow"> Write to Our Hospitality Team </span>
  
                <h2> Send an Enquiry </h2>
  
                <p class="contact-form-intro">
  
                    Share your details below and we will reply with the same warmth and care we bring to every table.
  
                </p>

                <form class="contact-form">
     
                    <div class="form-row">
     
                        <div class="form-group">
     
                            <label for="name"> Name </label>
     
                            <input id="name" name="name" type="text" placeholder="Your name">
     
                        </div>

                        <div class="form-group">
     
                            <label for="email"> Email Address </label>
     
                            <input id="email" name="email" type="email" placeholder="yourname@example.com">
     
                        </div>
     
                    </div>

                    <div class="form-row">
     
                        <div class="form-group">
     
                            <label for="subject"> Enquiry Type </label>
     
                            <select id="subject" name="subject">
     
                                <option value="reservation"> Reservation Enquiry </option>
     
                                <option value="events"> Private Dining </option>
     
                                <option value="order"> Ordering Enquiry </option>
     
                                <option value="feedback"> Feedback </option>
     
                                <option value="others"> Others </option>
     
                            </select>
     
                        </div>
     
                    </div>

                    <div class="form-group">
     
                        <label for="message"> Message </label>
     
                        <textarea id="message" name="message" rows="6" placeholder="Tell us how we can assist you, from reservations to ordering support."></textarea>
     
                    </div>

                    <button type="submit" class="contact-submit-btn">

                        Submit Enquiry

                        <span class="material-symbols-outlined"> arrow_forward </span>

                    </button>

                </form>

            </section>

        </section>



        <!-- QUOTE BANNER -->
     
        <section class="contact-quote container">
     
            <div class="contact-quote-box">
     
                <span class="section-tag"> Benvenuti </span>
                
                <h2> &ldquo;A memorable Italian evening begins long before the first plate arrives.&rdquo; </h2>
     
                <p>
     
                    At Bella Tavelo, every enquiry is welcomed with the same elegance, warmth, and attention that define our table.
     
                </p>
     
            </div>
     
        </section>



        <!-- LOCATION PREVIEW -->
      
        <section class="contact-location container">
      
            <div class="contact-location-image">
      
                <img src="images/florence.jpg">

                <div class="contact-location-card">
    
                    <span class="material-symbols-outlined"> pin_drop </span>
    
                    <div>
    
                        <p class="contact-card-label"> Find the Restaurant </p>
    
                        <h2> Italian soul, modern comfort, and an atmosphere worth lingering in. </h2>
    
                        <p>
                            Arrive early for aperitivo, stay late for dessert, and let the evening unfold in a setting inspired by timeless Italian charm.
                        </p>
    
                    </div>
    
                </div>
    
            </div>
    
        </section>

    </main>



    <!-- FOOTER -->
    
    <footer>
        
        <div class="footer-container">
        
            <div class="footer-bottom"> Group 09 &copy; 2026 </div>
    
            <div class="footer-links">
  	
  	            <a href="privacypolicy.html"> Privacy Policy </a>
	        
	            <a href="termsandservices.html"> Terms & Services </a>
    
            </div>
    
        </div>
    
    </footer>

</body>

</html>
