
document.addEventListener('DOMContentLoaded', function () {
    var form = document.getElementById('checkoutForm');
    if (!form) return;

    var addressField = document.getElementById('deliveryAddress');
    var phoneField = document.getElementById('contactPhone');
    var cardFields = document.getElementById('cardFields');
    var cardNumberField = document.getElementById('cardNumber');
    var cardExpiryField = document.getElementById('cardExpiry');
    var cardCvvField = document.getElementById('cardCvv');
    var errorBox = document.getElementById('formErrorBox');
    var paymentRadios = form.querySelectorAll('input[name="paymentMethod"]');

    function isCardSelected() {
        return document.getElementById('payCard').checked;
    }

    function toggleCardFields() {
        if (isCardSelected()) {
            cardFields.classList.remove('d-none');
        } else {
            cardFields.classList.add('d-none');
            clearFieldError(cardNumberField);
            clearFieldError(cardExpiryField);
            clearFieldError(cardCvvField);
        }
    }

    paymentRadios.forEach(function (radio) {
        radio.addEventListener('change', toggleCardFields);
    });
    toggleCardFields();

    function showFieldError(field, show) {
        if (show) {
            field.classList.add('is-invalid');
        } else {
            field.classList.remove('is-invalid');
        }
    }

    function clearFieldError(field) {
        field.classList.remove('is-invalid');
    }

    function showFormError(message) {
        errorBox.textContent = message;
        errorBox.classList.remove('d-none');
    }

    function hideFormError() {
        errorBox.classList.add('d-none');
    }

    form.addEventListener('submit', function (event) {
        var isValid = true;
        hideFormError();

        // Delivery address: at least 10 characters
        var address = addressField.value.trim();
        var addressValid = address.length >= 10;
        showFieldError(addressField, !addressValid);
        if (!addressValid) isValid = false;

        // Phone: digits, spaces, + and - only, 9-15 chars
        var phone = phoneField.value.trim();
        var phoneValid = /^[0-9+\-\s]{9,15}$/.test(phone);
        showFieldError(phoneField, !phoneValid);
        if (!phoneValid) isValid = false;

        // Card details, only required when "Card" payment method is selected
        if (isCardSelected()) {
            var cardNumber = cardNumberField.value.replace(/\s/g, '');
            var cardNumberValid = /^[0-9]{16}$/.test(cardNumber);
            showFieldError(cardNumberField, !cardNumberValid);
            if (!cardNumberValid) isValid = false;

            var expiry = cardExpiryField.value.trim();
            var expiryValid = /^(0[1-9]|1[0-2])\/[0-9]{2}$/.test(expiry);
            showFieldError(cardExpiryField, !expiryValid);
            if (!expiryValid) isValid = false;

            var cvv = cardCvvField.value.trim();
            var cvvValid = /^[0-9]{3,4}$/.test(cvv);
            showFieldError(cardCvvField, !cvvValid);
            if (!cvvValid) isValid = false;
        }

        if (!isValid) {
            event.preventDefault();
            showFormError('Please fix the highlighted fields before placing your order.');
        }
    });

    // Clear the red outline as soon as the user starts correcting a field
    [addressField, phoneField, cardNumberField, cardExpiryField, cardCvvField].forEach(function (field) {
        if (!field) return;
        field.addEventListener('input', function () {
            clearFieldError(field);
        });
    });
});
