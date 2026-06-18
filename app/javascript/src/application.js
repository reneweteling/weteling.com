import Rails from "@rails/ujs";
import autosize from "autosize";
import AOS from "aos";
import "aos/dist/aos.css";

Rails.start();

document.addEventListener("DOMContentLoaded", () => {
  // Initialize AOS scroll animations
  AOS.init({
    duration: 700,
    once: true,
    offset: 80,
  });

  autosize(document.querySelectorAll("textarea"));

  // Mobile nav toggle
  const burger = document.getElementById("nav-burger");
  const menu = document.getElementById("nav-menu");
  if (burger && menu) {
    burger.addEventListener("click", () => {
      burger.classList.toggle("active");
      menu.classList.toggle("hidden");
    });

    // Close menu when clicking a link
    menu.querySelectorAll("a").forEach((link) => {
      link.addEventListener("click", () => {
        burger.classList.remove("active");
        menu.classList.add("hidden");
      });
    });
  }

  // Timeline expand/collapse with animation
  const timelineToggle = document.getElementById("timeline-toggle");
  if (timelineToggle) {
    let expanded = false;
    const hiddenItems = document.querySelectorAll(".timeline-hidden");
    const toggleLabel = timelineToggle.querySelector("span:first-child");
    const toggleArrow = timelineToggle.querySelector("span:last-child");
    const showMoreText = toggleLabel.textContent;
    const showLessText =
      document.documentElement.lang === "nl" ? "Toon minder" : "Show less";

    // Prepare hidden items for animation
    hiddenItems.forEach((item) => {
      item.style.transition =
        "max-height 0.4s ease, opacity 0.3s ease, margin 0.4s ease";
    });

    timelineToggle.addEventListener("click", () => {
      expanded = !expanded;

      if (expanded) {
        hiddenItems.forEach((item, idx) => {
          item.classList.remove("hidden");
          item.style.maxHeight = "0px";
          item.style.opacity = "0";
          // Stagger the reveal
          setTimeout(() => {
            item.style.maxHeight = item.scrollHeight + "px";
            item.style.opacity = "1";
          }, idx * 50);
          // Clear maxHeight after animation so content isn't clipped
          setTimeout(() => {
            item.style.maxHeight = "none";
          }, idx * 50 + 450);
        });
      } else {
        hiddenItems.forEach((item) => {
          item.style.maxHeight = item.scrollHeight + "px";
          // Force reflow
          item.offsetHeight;
          item.style.maxHeight = "0px";
          item.style.opacity = "0";
        });
        setTimeout(() => {
          hiddenItems.forEach((item) => {
            item.classList.add("hidden");
            item.style.maxHeight = "";
            item.style.opacity = "";
          });
        }, 450);
      }

      toggleLabel.textContent = expanded ? showLessText : showMoreText;
      toggleArrow.textContent = expanded ? "↑" : "↓";

      if (expanded && typeof AOS !== "undefined") {
        setTimeout(() => AOS.refresh(), 500);
      }
    });
  }

  // Navbar background + text/logo color on scroll
  const nav = document.querySelector("nav");
  if (nav) {
    const navLinks = nav.querySelectorAll(".nav-link");
    const navLogo = nav.querySelector(".nav-logo");
    const updateNav = () => {
      if (window.scrollY > 80) {
        nav.classList.add("bg-white/90", "backdrop-blur-md", "shadow-sm");
        nav.classList.remove("bg-transparent");
        navLinks.forEach((link) => {
          link.classList.remove("text-white", "hover:text-blue-300");
          link.classList.add("text-gray-700", "hover:text-blue-600");
        });
        if (navLogo) {
          navLogo.classList.remove("nav-logo-white");
        }
      } else {
        nav.classList.remove("bg-white/90", "backdrop-blur-md", "shadow-sm");
        nav.classList.add("bg-transparent");
        navLinks.forEach((link) => {
          link.classList.remove("text-gray-700", "hover:text-blue-600");
          link.classList.add("text-white", "hover:text-blue-300");
        });
        if (navLogo) {
          navLogo.classList.add("nav-logo-white");
        }
      }
    };
    window.addEventListener("scroll", updateNav);
    updateNav();
  }
});
