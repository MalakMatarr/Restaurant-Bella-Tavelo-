const form = document.getElementById("loginForm");

const email = document.getElementById("email");
const password = document.getElementById("password");

const message = document.getElementById("message");

const params = new URLSearchParams(window.location.search);

if (params.get("message")) {
    message.innerHTML = params.get("message");
    message.className = "error-message";
}

if (params.get("error") === "invalid") {

    message.innerHTML = "Invalid email or password.";
    message.className = "error-message";

}

if (params.get("success") === "registered") {

    message.innerHTML = "Registration successful! Please log in.";
    message.className = "success-message";

}

form.addEventListener("submit", function (e) {

    let errors = [];

    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (email.value.trim() === "") {

        errors.push("Email is required.");

    } else if (!emailPattern.test(email.value.trim())) {

        errors.push("Please enter a valid email address.");

    }

    if (password.value.trim() === "") {

        errors.push("Password is required.");

    }

    if (errors.length > 0) {

        e.preventDefault();

        alert(errors.join("\n"));

    }

});