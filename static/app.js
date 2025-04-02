// Fonction qui relie les fonctions de validation de courriel et de mot de passe à la soumission du formulaire
document.addEventListener("DOMContentLoaded", function () {
    let registerForm = document.getElementById("registerForm");
    if (registerForm) {
        registerForm.addEventListener("submit", function (event) {
            // Validate Email
            if (!validateEmail()) {
                event.preventDefault(); // Empêcher la soumission du formulaire si le courriel est invalide
            }

            // Validate Password
            if (!validatePassword()) {
                event.preventDefault(); // Empêcher la soumission du formulaire si le mot de passe est invalide
            }
        });
    }
});

// Fonction pour valider le format du courriel
function validateEmail() {
    let emailInput = document.getElementById("courriel").value;
    let errorMessage = document.getElementById("error-message");

    // Regex pour le courriel
    let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    // vérifier que le courriel respecte le bon format
    if (!emailPattern.test(emailInput)) {
        if (errorMessage) {
            errorMessage.textContent = "Veuillez entrer une adresse courriel valide";
            errorMessage.style.color = "red";
        }
        return false; // courriel invalide
    } else {
        if (errorMessage) {
            errorMessage.textContent = ""; // Aucun message d'erreur si courriel valide
        }
        return true; // courriel valide
    }
}

function validatePassword() {
    let prenom = document.getElementById("prenom").value.toLowerCase();
    let nom = document.getElementById("nom").value.toLowerCase();
    let surnom = document.getElementById("surnom").value.toLowerCase();
    let password = document.getElementById("motpasse").value.toLowerCase();
    let errorMessage = document.getElementById("password-error-message");

    // Enlever le message d'erreur précédent
    if (errorMessage) {
        errorMessage.textContent = "";
    }

    // Vérifier si le mot de passe contient le prénom
    if (password.includes(prenom)) {
        showPasswordError("Le mot de passe ne peut pas contenir votre prénom");
        return false;
    }
    // Vérifier si le mot de passe contient le nom
    if (password.includes(nom)) {
        showPasswordError("Le mot de passe ne peut pas contenir votre nom");
        return false;
    }
    // Vérifier si le mot de passe contient le surnom/nom d'utilisateur
    if (password.includes(surnom)) {
        showPasswordError("Le mot de passe ne peut pas contenir votre nom d'utilisateur");
        return false;
    }

    // Longueur du mot de passe et format
    let passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).{6,}$/;

    if (!passwordPattern.test(password)) {
        showPasswordError("Le mot de passe doit contenir au moins un chiffre, une lettre majuscule, une lettre minuscule et un caractère spécial.");
        return false;
    }

    return true; // Mot de passe valide
}

function showPasswordError(message) {
    let errorMessage = document.getElementById("password-error-message");
    if (errorMessage) {
        errorMessage.textContent = message;
        errorMessage.style.color = "red";
    }
}