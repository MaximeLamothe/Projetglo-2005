/*
    Ce script gère la validation du formulaire d'inscription.
    Lors de la soumission du formulaire, il vérifie que l'adresse email, l'âge et
    le mot de passe respectent les critères de validité.
    - Si l'une des validations échoue, la soumission du formulaire est empêchée et un message d'erreur est affiché.
*/


// Fonction qui relie les fonctions de validation de courriel et de mot de passe à la soumission du formulaire
document.addEventListener("DOMContentLoaded", function () {
    let registerForm = document.getElementById("registerForm");
    if (registerForm) {
        registerForm.addEventListener("submit", function (event) {
            // Validate Email
            if (!validateEmail()) {
                event.preventDefault(); // Empêcher la soumission du formulaire si le courriel est invalide
            }

            if (!validateAge()) {
                event.preventDefault();
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
    let password = document.getElementById("motpasse").value;
    let password_lowercase= password.toLowerCase()
    let errorMessage = document.getElementById("password-error-message");

    // Enlever le message d'erreur précédent
    if (errorMessage) {
        errorMessage.textContent = "";
    }

    // Vérifier si le mot de passe contient le prénom
    if (password_lowercase.includes(prenom)) {
        showPasswordError("Le mot de passe ne peut pas contenir votre prénom");
        return false;
    }
    // Vérifier si le mot de passe contient le nom
    if (password_lowercase.includes(nom)) {
        showPasswordError("Le mot de passe ne peut pas contenir votre nom");
        return false;
    }
    // Vérifier si le mot de passe contient le surnom
    if (password_lowercase.includes(surnom)) {
        showPasswordError("Le mot de passe ne peut pas contenir votre surnom");
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

// Fonction pour valider que l'âge est entre 5 et 105 ans
function validateAge() {
    let ageInput = document.getElementById("age").value;
    let errorMessage = document.getElementById("age-error-message");

    // vérifier que l'âge est valide (entre 5 et )
    if (ageInput < 5 || ageInput > 105) {
        if (errorMessage) {
            showAgeError("L'âge entré est invalide");
        }
        return false;
    } else {
        if (errorMessage) {
            errorMessage.textContent = ""; // Aucun message d'erreur si age valide
        }
        return true; // age valide
    }
}

// Fonction pour afficher le message d'erreur pour l'âge
function showAgeError(message) {
    let errorMessage = document.getElementById("password-error-message");
    if (errorMessage) {
        errorMessage.textContent = message;
        errorMessage.style.color = "red";
    }
}

const passwordInput = document.getElementById('motpasse');
const showPasswordCheckbox = document.getElementById('show-password');

// Si la case est cochée, on rend le mot de passe visible
showPasswordCheckbox.addEventListener('change', function() {
    if (showPasswordCheckbox.checked) {
        passwordInput.type = 'text';  // Rendre le mot de passe visible
    } else {
        passwordInput.type = 'password';  // Cacher le mot de passe
    }
});
