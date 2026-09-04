const form = document.getElementById("adminLoginForm");

const email = document.getElementById("email");
const password = document.getElementById("password");

const jsError = document.getElementById("jsError");

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

    } else if (password.value.trim().length < 6) {

        errors.push("Password must be at least 6 characters.");

    }

    if (errors.length > 0) {

        e.preventDefault();

        jsError.innerHTML = errors.join("<br>");
        jsError.style.display = "block";

    } else {

        jsError.style.display = "none";

    }

});
