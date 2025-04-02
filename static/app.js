// Fonction qui valide le format du courriel avant de l'envoyer au serveur

document.addEventListener("DOMContentLoaded", function () {
    let emailForm = document.getElementById("emailForm");
    if (emailForm) {
        emailForm.addEventListener("submit", function (event) {
            // Validate Email
            if (!validateEmail()) {
                event.preventDefault(); // Prevent form submission if email is invalid
            }

            // Validate Password
            if (!validatePassword()) {
                event.preventDefault(); // Prevent form submission if password is invalid
            }
        });
    }
});

// Function to validate email
function validateEmail() {
    let emailInput = document.getElementById("courriel").value;
    let errorMessage = document.getElementById("error-message");

    // Regex for email validation
    let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    // Check if email matches the pattern
    if (!emailPattern.test(emailInput)) {
        if (errorMessage) {
            errorMessage.textContent = "Veuillez entrer une adresse courriel valide";
            errorMessage.style.color = "red";
        }
        return false; // Invalid email
    } else {
        if (errorMessage) {
            errorMessage.textContent = ""; // Clear error message if email is valid
        }
        return true; // Valid email
    }
}

// Function to validate password
function validatePassword() {
    let prenom = document.getElementById("prenom").value.toLowerCase();
    let nom = document.getElementById("nom").value.toLowerCase();
    let surnom = document.getElementById("surnom").value.toLowerCase();
    let password = document.getElementById("motpasse").value.toLowerCase();

    // Check if password contains the first name, last name, or username
    if (password.includes(prenom)) {
        alert("Le mot de passe ne peut pas contenir votre prénom");
        return false;
    }
    if (password.includes(nom)) {
        alert("Le mot de passe ne peut pas contenir votre nom");
        return false;
    }
    if (password.includes(surnom)) {
        alert("Le mot de passe ne peut pas contenir votre nom d'utilisateur");
        return false;
    }

    // Password length and format validation
    let passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).{6,}$/;
    if (!passwordPattern.test(password)) {
        alert("Le mot de passe doit contenir au moins un chiffre, une lettre majuscule, une lettre minuscule et un caractère spécial.");
        return false;
    }

    return true; // Valid password
}


/* document.addEventListener("DOMContentLoaded", function () {
    let emailForm = document.getElementById("emailForm"); // essayer d'obtenir emailForm de la page
    if (emailForm) {  // validation seulement si email form sur la page
        document.getElementById("emailForm").addEventListener("submit", function (event) {
        let emailInput = document.getElementById("courriel").value;
        let errorMessage = document.getElementById("error-message");

        // REGEX pour l'adresse courriel
        let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        if (!emailPattern.test(emailInput)) {
            event.preventDefault(); // Empêcher la soumission du formulaire
            if (errorMessage) {
                errorMessage.textContent = "Veuillez entrer une adresse courriel valide";
                errorMessage.style.color = "red";
                }
            } else if (errorMessage) {
                errorMessage.textContent = ""; // Aucun message d'erreur
            }
    });
});

// Fonction qui valide le mot de passe avant de l'envoyer au serveur. La fonction vérifie que le mot de passe
// ne contient pas le prénom, le nom, ni le nom d'utilisateur

function validatePassword() {
    let prenom = document.getElementById("prenom").value.toLowerCase();
    let nom = document.getElementById("nom").value.toLowerCase();
    let surnom = document.getElementById("surnom").value.toLowerCase();

    let password = document.getElementById("password").value.toLowerCase();

    if (password.includes(prenom)) {
        alert("Le mot de passe ne peut pas contenir votre prénom");
        return false;
    }
    if (password.includes(nom)) {
        alert("Le mot de passe ne peut pas contenir votre nom");
        return false;
    }
    if (password.includes(surnom)) {
        alert("Le mot de passe ne peut pas contenir votre nom d'utilisateur");
        return false;
    }

    return true;
} */

