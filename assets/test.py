import 'package:flutter/services.dart';

import os
import shutil
import zipfile

# Define the directory structure with file contents
structure = {
    'store_manager_2': {
        'HTML': {
            'add_product.html': '''<!DOCTYPE html>
<html>

<head>
    <title>Add Product</title>
    <link rel="stylesheet" href="/css/index.css">
    </link>
</head>

<body>

    <div>
        <nav class="nav">
            <div class="left-arrow">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                    class="bi bi-arrow-left" viewBox="0 0 16 16">
                    <path fill-rule="evenodd"
                        d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z" />
                </svg>
            </div>
            <a>Add Product</a>
        </nav>
    </div>

    <div class="form">
        <form id="add-product-form">
            <input type="text" id="prodName" name="prodName" placeholder="Enter Product Name" required><br>
            <input type="text" id="prodPrice" name="prodPrice" placeholder="Enter Product Price" required><br>
            <input type="text" id="prodQuantity" name="prodQuantity" placeholder="Enter Product Quantity" required><br>
            <div class="btns">
                <button type="submit" class="add-btn">
                    <a>Submit</a>
                </button>
            </div>
        </form>
    </div>

    <script src="/js/index.js">
    </script>
</body>
</html>''',
            'list_product.html': '''<!DOCTYPE html>
<html>

<head>
    <title>Product List</title>
    <link rel="stylesheet" href="/css/index.css"></link>
</head>

<body>
    <div>
        <nav class="nav">
            <div class="left-arrow">
                <svg xmlns="http://w3.org/2000/svg" width="16" height="16" fill="currentColor"
                    class="bi bi-arrow-left" viewBox="0 0 16 16">
                    <path fill-rule="evenodd"
                        d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z" />
                </svg>
            </div>
            <a>List Of Products</a>
        </nav>
    </div>

    <div class="btns">
        <button type="button" class="add-btn">
            <a href="add_product.html">Add Product</a>
        </button>
    </div>

    <div class="product-container">
        <p id="prodName">{{prodName}}</p><br>
        <p id="prodPrice">{{prodPrice}}</p>
        <p id="prodQuantity">{{prodQuantity}}</p>
    </div>

    <script src="/js/list_product.js"></script>
</body>
</html>''',
        },
        'js': {
            'index.js': '''console.log('list of products')

// Retrieve the list of products from local storage
const productList = JSON.parse(localStorage.getItem('products')) || [];

// Get the product container element
const productContainer = document.querySelector('.product-container');

// Function to display the products in the container
function displayProducts() {
  // Clear the existing content in the product container
  productContainer.innerHTML = '';

  // Loop through the list of products and create HTML elements to display them
  productList.forEach((product, index) => {
    const productDiv = document.createElement('div');
    productDiv.classList.add('product');
    productDiv.innerHTML = `
      <p>Product Name: {{product.name}}</p>
      <p>Product Price: ${{product.price}}</p>
      <p>Product Quantity: {{product.quantity}}</p>
    `;

    productContainer.appendChild(productDiv);
  });
}

// Call the function to display products initially
displayProducts();

console.log('Yeahhhhh')

document.getElementById("add-product-form").addEventListener('submit', function (e) {
    e.preventDefault(); // Prevent the form from submitting normally
    console.log('go')
    addProduct(); // Call the addProduct function
});

function addProduct() {
    // Get product information from the form
    var prodName = document.getElementById("prodName").value;
    var prodPrice = document.getElementById("prodPrice").value;
    var prodQuantity = document.getElementById("prodQuantity").value;

    // Create an object to represent the product
    var product = {
        name: prodName,
        price: prodPrice,
        quantity: prodQuantity
    };

    // Check if localStorage already has products
    var products = JSON.parse(localStorage.getItem('products')) || [];

    // Add the new product to the array
    products.push(product);

    // Store the updated product list in localStorage
    localStorage.setItem('products', JSON.stringify(products));
    console.log(products);

    console.log(product);

    console.log('Done');

    // Clear the form fields
    document.getElementById("prodName").value = '';
    document.getElementById("prodPrice").value = '';
    document.getElementById("prodQuantity").value = '';

    //redirect to the product list page
    setTimeout(() => {
        window.location = 'list_product.html';
    }, 500);
}''',
            'list_product.js': '''console.log('list of products')

// Retrieve the list of products from local storage
const productList = JSON.parse(localStorage.getItem('products')) || [];

// Get the product container element
const productContainer = document.querySelector('.product-container');

// Function to display the products in the container
function displayProducts() {
  // Clear the existing content in the product container
  productContainer.innerHTML = '';

  // Loop through the list of products and create HTML elements to display them
  productList.forEach((product, index) => {
    const productDiv = document.createElement('div');
    productDiv.classList.add('product');
    productDiv.innerHTML = `
      <p>Product Name: {{product.name}}</p>
      <p>Product Price: ${{product.price}}</p>
      <p>Product Quantity: {{product.quantity}}</p>
    `;

    productContainer.appendChild(productDiv);
  });
}

// Call the function to display products initially
displayProducts()''',
        },
        'css': {
            'index.css': '''body {
    margin: 0px;
    padding: 0px;
}

nav {
    height: 60px;
    background-color: rgb(59, 143, 240);
    color: white;
    display: flex;
    align-items: center;
    justify-content: flex-start;
}

nav a {
    margin-left: 530px;
    font-size: larger;
}

.left-arrow {
    margin-left: 25px;
}

.btns {
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 30px;
}

.add-btn {
    background-color: rgb(59, 143, 240);
    color: white;
    border: 2px solid transparent;
    border-radius: 6px;
    align-items: center;
    height: 30px;
    width: 100px;
}

.add-btn a {
    text-decoration: none;
    color: white;
}

.form {
    display: flex;
    align-items: center;
    justify-content: center;
}

form input {
    height: 35px;
    width: 280px;
    margin: 25px;
    border: 2px thin gray;
    border-radius: 4px;
    padding: 7px;
}

.product-container {
    height: 70px;
    margin: 30px;
    padding: 30px;
}
'''
        }
    }
}

def create_directory_structure_with_contents(base_path, structure):
    for name, contents in structure.items():
        current_path = os.path.join(base_path, name)
        os.makedirs(current_path, exist_ok=True)
        if isinstance(contents, dict):
            create_directory_structure_with_contents(current_path, contents)
        elif isinstance(contents, str):
            with open(os.path.join(current_path, name), 'w') as f:
                f.write(contents)

# Create the directory structure with contents
create_directory_structure_with_contents('.', structure)

# Create a zip file of the directory
shutil.make_archive('store_manager_2', 'zip', '.')

print("Directory structure with contents created and zipped as 'store_manager_2.zip'")

