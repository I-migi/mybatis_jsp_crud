<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Main Page</title>
</head>
<body>
    <h1>Welcome to the Main Page (JSP)</h1>

    <table border="1">
        <thead>
            <tr>
                <th>Name</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody id="productTable">
        </tbody>
    </table>

    <h2>Add Product</h2>
    <input type="text" id="productName" placeholder="Product Name">
    <input type="number" id="productPrice" placeholder="Product Price">
    <button id="addButton">Add</button>

    <script>
        function loadProducts() {
            fetch("/products")
                .then(response => response.json())
                .then(data => {
                    console.log("Received Data:", data);
                    const tableBody = document.getElementById("productTable");
                    tableBody.innerHTML = "";

                    data.forEach(product => {
                        console.log("Product Name:", product.productName);
                        console.log("Product Price:", product.productPrice);

                        const row = document.createElement("tr");

                        const nameCell = document.createElement("td");
                        nameCell.textContent = product.productName;
                        row.appendChild(nameCell);

                        const priceCell = document.createElement("td");
                        priceCell.textContent = product.productPrice;
                        row.appendChild(priceCell);

                        const actionCell = document.createElement("td");
                        const deleteButton = document.createElement("button");
                        deleteButton.textContent = "Delete";
                        
                        deleteButton.onclick = () => deleteProduct(product.id);
                        actionCell.appendChild(deleteButton);
                        row.appendChild(actionCell);

                        tableBody.appendChild(row);
                    });
                })
                .catch(error => console.error("Error fetching products", error));
        }


        function addProduct() {
            const name = document.getElementById("productName").value.trim();
            const price = document.getElementById("productPrice").value.trim();

            if (!name || !price) {
                alert("Product name and price are required!");
                return;
            }

            const newProduct = { productName: name, productPrice: parseFloat(price) };

            fetch("/products", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(newProduct)
            })
            .then(response => {
                if (response.ok) {
                    alert("Product added successfully");
                    loadProducts(); // 테이블 다시 불러오기
                    document.getElementById("productName").value = "";
                    document.getElementById("productPrice").value = "";
                } else {
                    console.error("Failed to add product", response);
                }
            })
            .catch(error => console.error("Error adding product", error));
        }

        function deleteProduct(id) {
            fetch(`/products/${id}`, {
                method: "DELETE"
            })
            .then(response => {
                if (response.ok) {
                    alert("Product deleted successfully!");
                    loadProducts();
                } else {
                    console.error("Failed to delete product", response);
                }
            })
            .catch(error => console.error("Error deleting product", error));
        }

        document.getElementById("addButton").addEventListener("click", addProduct);

        window.onload = function() {
            console.log("Page Loaded. Fetching Products...");
            loadProducts();
        };
    </script>
</body>
</html>
