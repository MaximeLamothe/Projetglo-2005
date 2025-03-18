// Fonction qui valide le format du courriel avant de l'envoyer au serveur
document.addEventListener("DOMContentLoaded", function () {
    // let emailForm = document.getElementById("emailForm"); // essayer d'obtenir emailForm de la page
    //     if (emailForm) {  // validation seulement si email form sur la page
    document.getElementById("emailForm").addEventListener("submit", function (event) {
        let emailInput = document.getElementById("courriel").value;
        let errorMessage = document.getElementById("error-message");

        // REGEX pour l'adresse courriel
        let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        if (!emailPattern.test(emailInput)) {
            event.preventDefault(); // Empêcher de soumettre le formulaire
            errorMessage.textContent = "Veuillez entrer une adresse courriel valide";
        } else {
            errorMessage.textContent = ""; // Aucun message d'erreur
        }
    });
});