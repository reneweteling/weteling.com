import bulmaCarousel from "bulma-carousel";
import Rails from "@rails/ujs";
import autosize from "autosize";
Rails.start();

document.addEventListener("DOMContentLoaded", () => {
  autosize(document.querySelectorAll("textarea"));

  // reCAPTCHA v3 for contact form
  const contactForm = document.getElementById("contact-form");
  if (contactForm && typeof grecaptcha !== "undefined") {
    // Store original submit handler
    let isSubmitting = false;

    contactForm.addEventListener("ajax:before", function(event) {
      if (isSubmitting) {
        return true; // Allow the actual submission
      }

      // Prevent submission until we have the token
      event.preventDefault();
      const form = this;

      grecaptcha.ready(function() {
        grecaptcha
          .execute(document.querySelector("[data-sitekey]")?.dataset.sitekey, {
            action: "contact",
          })
          .then(function(token) {
            // Add token to form
            let recaptchaInput = form.querySelector(
              'input[name="g-recaptcha-response"]'
            );
            if (!recaptchaInput) {
              recaptchaInput = document.createElement("input");
              recaptchaInput.setAttribute("type", "hidden");
              recaptchaInput.setAttribute("name", "g-recaptcha-response");
              form.appendChild(recaptchaInput);
            }
            recaptchaInput.value = token;

            // Now submit the form
            isSubmitting = true;
            Rails.fire(form, "submit");
            isSubmitting = false;
          })
          .catch(function(error) {
            console.error("reCAPTCHA error:", error);
            alert("reCAPTCHA verification failed. Please try again.");
          });
      });

      return false;
    });
  }

  bulmaCarousel.attach("#projects-carousel", {
    slidesToScroll: 1,
    slidesToShow: 3,
    infinite: true,
    autoplay: true,
    autoplaySpeed: 4000,
    breakpoints: [
      { changePoint: 768, slidesToShow: 1, slidesToScroll: 1 },
      { changePoint: 1024, slidesToShow: 2, slidesToScroll: 1 },
      { changePoint: 1224, slidesToShow: 3, slidesToScroll: 1 },
    ],
  });

  // Get all "navbar-burger" elements
  const $navbarBurgers = Array.prototype.slice.call(
    document.querySelectorAll(".navbar-burger"),
    0
  );

  // Check if there are any navbar burgers
  if ($navbarBurgers.length > 0) {
    // Add a click event on each of them
    $navbarBurgers.forEach((el) => {
      el.addEventListener("click", () => {
        // Get the target from the "data-target" attribute
        const target = el.dataset.target;
        const $target = document.getElementById(target);

        // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
        el.classList.toggle("is-active");
        $target.classList.toggle("is-active");
      });
    });
  }

  // Message
  (document.querySelectorAll(".message .delete") || []).forEach(($delete) => {
    $notification = $delete.parentNode;

    $delete.addEventListener("click", () => {
      $notification.parentNode.parentNode.removeChild($notification.parentNode);
    });
  });
});
