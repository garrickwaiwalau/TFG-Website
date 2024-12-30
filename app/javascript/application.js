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

// Event listener in JS for adding rows on quote page
document.addEventListener("DOMContentLoaded", function() {
    const addRowButton = document.querySelector(".addRowButton");
    if (addRowButton) {
        addRowButton.addEventListener("click", addRow);
    }
});

// Event listener in JS for removing rows on quote page
// document.addEventListener("DOMContentLoaded", function() {
//     const removeRowButton = document.querySelectorAll('.removeRowButton');  // Select all buttons with the class "removeRowButton"
//
//     removeRowButton.forEach(function(button) {
//         // Add click event listener for each button
//         button.addEventListener('click', function() {
//             removeRow(button);  // Call removeRow function when button is clicked
//         });
//     });
// });

// Function to add a new row on quote page
let rowCount = 0; // to keep track of row numbers for labels
function addRow() {
    const productRows = document.getElementById('productRows');
    rowCount++;

    // Create new row
    const newRow = document.createElement('div');
    newRow.classList.add('productRow', 'form-row', 'mt-2', 'flex', 'flex-wrap', 'gap-x-6', 'gap-y-8');

    newRow.innerHTML = `
        <div class="flex-1">
          <label for="quote_products_attributes_${rowCount}_quantity" class="mb-2 text-sm/6 font-medium text-gray-900">Quantity</label>
          <input type="number" name="quote[products_attributes][${rowCount}][quantity]" id="quote_products_attributes_${rowCount}_quantity" class="w-40 form-input px-4 py-2 border border-gray-300 rounded-md">
        </div>
        
        <div class="flex-1">
          <label for="quote_products_attributes_${rowCount}_packagingType" class="mb-2 text-sm/6 font-medium text-gray-900">Packaging Type</label>
          <select name="quote[products_attributes][${rowCount}][packagingType]" id="quote_products_attributes_${rowCount}_packagingType" class="w-40 form-input px-4 py-2 border border-gray-300 rounded-md">
            <option value="Pallet(s)" selected>Pallet(s)</option>
            <option value="Piece(s)">Piece(s)</option>
          </select>
        </div>
        
        <div class="flex-1">
          <label for="quote_products_attributes_${rowCount}_length" class="mb-2 text-sm/6 font-medium text-gray-900">Gross Length (in.)</label>
          <input type="number" name="quote[products_attributes][${rowCount}][length]" id="quote_products_attributes_${rowCount}_length" class="w-40 form-input px-4 py-2 border border-gray-300 rounded-md">
        </div>
        
        <div class="flex-1">
          <label for="quote_products_attributes_${rowCount}_width" class="mb-2 text-sm/6 font-medium text-gray-900">Gross Width (in.)</label>
          <input type="number" name="quote[products_attributes][${rowCount}][width]" id="quote_products_attributes_${rowCount}_width" class="w-40 form-input px-4 py-2 border border-gray-300 rounded-md">
        </div>
        
        <div class="flex-1">
          <label for="quote_products_attributes_${rowCount}_height" class="mb-2 text-sm/6 font-medium text-gray-900">Gross Height (in.)</label>
          <input type="number" name="quote[products_attributes][${rowCount}][height]" id="quote_products_attributes_${rowCount}_height" class="w-40 form-input px-4 py-2 border border-gray-300 rounded-md">
        </div>
        
        <div class="flex-1">
          <label for="quote_products_attributes_${rowCount}_weight" class="mb-2 text-sm/6 font-medium text-gray-900">Gross Weight (lbs.)</label>
          <input type="number" name="quote[products_attributes][${rowCount}][weight]" id="quote_products_attributes_${rowCount}_weight" class="w-40 form-input px-4 py-2 border border-gray-300 rounded-md">
        </div>
        
        <div class="flex-1">
          <div class="mt-6">
            <button type="button" class="text-red-500 hover:text-red-700 ml-2" onclick="removeRow(this)">Remove</button>
          </div>
        </div>    
        
`;

// Append the new row to the form rows container
    productRows.appendChild(newRow);
}