const form = document.getElementById("registerForm");

const fullName = document.getElementById("fullName");
const email = document.getElementById("email");
const phone = document.getElementById("phone");
const password = document.getElementById("password");
const confirmPassword = document.getElementById("confirmPassword");

const message = document.getElementById("message");

const params = new URLSearchParams(window.location.search);

if (message) {

    if (params.get("error") === "email") {

        message.innerHTML = "Email already exists.";
        message.className = "error-message";

    }

    else if (params.get("error") === "failed") {

        message.innerHTML = "Registration failed. Please try again.";
        message.className = "error-message";

    }

}

form.addEventListener("submit", function (e) {

    let errors = [];

    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phonePattern = /^\+?[0-9]{8,15}$/;
    const namePattern = /^[A-Za-z\s]+$/;

    // Full Name
    if (fullName.value.trim() === "") {

        errors.push("Full name is required.");

    }
    else if (!namePattern.test(fullName.value.trim())) {

        errors.push("Full name should contain letters only.");

    }

    // Email
    if (email.value.trim() === "") {

        errors.push("Email is required.");

    }
    else if (!emailPattern.test(email.value.trim())) {

        errors.push("Please enter a valid email address.");

    }

    // Phone Number
    if (phone.value.trim() === "") {

        errors.push("Phone number is required.");

    }
    else if (!phonePattern.test(phone.value.trim())) {

        errors.push("Phone number must contain 8 to 15 digits.");

    }

    // Password
    if (password.value.trim() === "") {

        errors.push("Password is required.");

    }
    else if (password.value.length < 6) {

        errors.push("Password must be at least 6 characters.");

    }

    // Confirm Password
    if (confirmPassword.value.trim() === "") {

        errors.push("Please confirm your password.");

    }
    else if (password.value !== confirmPassword.value) {

        errors.push("Passwords do not match.");

    }

    if (errors.length > 0) {

        e.preventDefault();

        alert(errors.join("\n"));

    }

});