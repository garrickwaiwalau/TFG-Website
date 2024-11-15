// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"

// Import Alpine.js as an ES module
import "alpinejs"

// Initialize Alpine.js if needed
document.addEventListener('alpine:init', () => {
    Alpine.data('navbar', () => ({
        isOpen: false,  // Initial state for the menu (closed)
        toggleMenu() {
            this.isOpen = !this.isOpen; // Toggle the menu when clicked
        }
    }));
});

//Logo Carousel pause animation
document.addEventListener("DOMContentLoaded", function() {
    const carousel = document.querySelector('.slide-track');

    if (carousel){

        carousel.addEventListener('mouseover', function() {
            carousel.style.animationPlayState = 'paused';  // Pause the animation
        });

        carousel.addEventListener('mouseout', function() {
            carousel.style.animationPlayState = 'running';  // Resume the animation
        });

    }
});
