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
let rowCount = 1; // to keep track of row numbers for labels
function addRow() {
    const formRows = document.getElementById('formRows');
    rowCount++;

    // Create new row
    const newRow = document.createElement('div');
    newRow.classList.add('form-row', 'mt-2', 'grid', 'grid-cols-1', 'gap-x-6', 'gap-y-8', 'sm:grid-cols-8');

    newRow.innerHTML = `
        <div class="flex flex-col pr-2">
        <label for="productName${rowCount}" class="mb-2 text-sm/6 font-medium text-gray-900">Product Name</label>
    <input type="text" id="productName${rowCount}" name="productName[]" class="form-input px-4 py-2 border border-gray-300 rounded-md" placeholder="" required>
    </div>

    <div class="flex flex-col pr-2">
        <label for="productQuantity${rowCount}" class="mb-2 text-sm/6 font-medium text-gray-900">Product Quantity</label>
        <input type="number" id="productQuantity${rowCount}" name="productQuantity[]" class="form-input px-4 py-2 border border-gray-300 rounded-md" placeholder="" required>
    </div>

    <div class="flex flex-col pr-2">
        <label for="typeOfGoods${rowCount}" class="mb-2 text-sm/6 font-medium text-gray-900">Type of Goods</label>
        <input type="text" id="typeOfGoods${rowCount}" name="typeOfGoods[]" class="form-input px-4 py-2 border border-gray-300 rounded-md" placeholder="" required>
    </div>

    <div class="flex flex-col pr-2">
        <label for="length${rowCount}" class="mb-2 text-sm/6 font-medium text-gray-900">Length (in.)</label>
        <input type="number" id="length${rowCount}" name="length[]" class="form-input px-4 py-2 border border-gray-300 rounded-md" placeholder="" required>
    </div>

    <div class="flex flex-col pr-2">
        <label for="width${rowCount}" class="mb-2 text-sm/6 font-medium text-gray-900">Width (in.)</label>
        <input type="number" id="width${rowCount}" name="width[]" class="form-input px-4 py-2 border border-gray-300 rounded-md" placeholder="" required>
    </div>

    <div class="flex flex-col pr-2">
        <label for="height${rowCount}" class="mb-2 text-sm/6 font-medium text-gray-900">Height (in.)</label>
        <input type="number" id="height${rowCount}" name="height[]" class="form-input px-4 py-2 border border-gray-300 rounded-md" placeholder="" required>
    </div>

    <div class="flex flex-col pr-2">
        <label for="weight${rowCount}" class="mb-2 text-sm/6 font-medium text-gray-900">Weight (lbs.)</label>
        <input type="number" id="weight${rowCount}" name="weight[]" class="form-input px-4 py-2 border border-gray-300 rounded-md" placeholder="" required>
    </div>

    <button type="button" class="text-red-500 hover:text-red-700 ml-2" onclick="removeRow(this)">Remove</button>
`;

// Append the new row to the form rows container
    formRows.appendChild(newRow);
}