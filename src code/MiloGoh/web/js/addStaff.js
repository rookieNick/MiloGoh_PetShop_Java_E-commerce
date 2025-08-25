        function togglePasswordVisibility() {
            var password = document.getElementById("password");
            var confirmPassword = document.getElementById("confirmPassword");

            if (password.type === "password") {
                password.type = "text";
                confirmPassword.type = "text";
            } else {
                password.type = "password";
                confirmPassword.type = "password";
            }
        }
        
        function generateRandomPassword(inputId) {
    var alphabet = 'abcdefghijklmnopqrstuvwxyz';
    var numbers = '0123456789';
    var specials = '!@#$%&';
    var password = '';

    // Generate one alphabet
    password += alphabet.charAt(Math.floor(Math.random() * alphabet.length));

    // Generate three numbers
    for (var i = 0; i < 3; i++) {
        password += numbers.charAt(Math.floor(Math.random() * numbers.length));
    }

    // Generate one special character
    password += specials.charAt(Math.floor(Math.random() * specials.length));

    // Generate five characters (including capital letters and small letters)
    var characters = alphabet + alphabet.toUpperCase() + numbers + specials;
    for (var i = 0; i < 5; i++) {
        password += characters.charAt(Math.floor(Math.random() * characters.length));
    }

    // Shuffle the password characters to make it more random
    password = password.split('').sort(function(){return 0.5-Math.random()}).join('');

    document.getElementById('confirmPassword').value = password;
    document.getElementById('password').value = password;
}