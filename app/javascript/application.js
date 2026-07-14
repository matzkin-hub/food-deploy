// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"


document.addEventListener('turbo:load', () => {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('in-view')
      } else {
        entry.target.classList.remove('in-view')
      }
    });
  }, {threshold: 1});

  document.querySelectorAll('.parent-box').forEach(card => {
    observer.observe(card)
  });
});
