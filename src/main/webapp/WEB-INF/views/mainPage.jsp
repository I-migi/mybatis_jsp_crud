<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Main Page</title>
      <style>
        .container {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }
        table {
            border-collapse: collapse;
            width: 45%;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
    
</head>
<body>
    <h1>Welcome to the Main Page (JSP)</h1>
   

<div class="container">
<div>
	<h2>상품 목록</h2>
    <table border="1">
        <thead>
            <tr>
            	<th>Id</th>
                <th>Name</th>
                <th>Price</th>
                <th>Actions</th>
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
    </div>
    <div>
    	<h2>뉴스 목록</h2>
    	<table>
    		<thead>
    			<tr>
    				<th>Title</th>
    				<th>Link</th>
    			</tr>
    		</thead>
    		<tbody id="newsTable">
    			
    		</tbody>
    	</table>	
    </div>
</div>

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
                        
                        const idCell = document.createElement("td");
                        idCell.textContent = product.productId;
                        row.appendChild(idCell);

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
                        
                        const updateCell = document.createElement("td");
                        const updateButton = document.createElement("button");
                        updateButton.textContent = "Update";
                        
                        updateButton.onclick = () => updateProduct(product.id);
                        updateCell.appendChild(updateButton);
                        row.appendChild(updateCell);

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
        
        function loadNews() {
        	fetch("/products/news")
        		.then(response => response.json())
        		.then(data => {
        			const tableBody = document.getElementById("newsTable");
        			tableBody.innerHTML = "";
        			
        			data.forEach(news => {
        				const row = document.createElement("tr");
        				
        				const titleCell = document.createElement("td");
        				titleCell.textContent = news.title;
        				row.appendChild(titleCell);
        				
        				const linkCell = document.createElement("td");
        				const link = document.createElement("a");
        				link.href = news.link;
        				link.textContent = "View";
        				link.target = "_blank";
        				linkCell.appendChild(link);
        				row.appendChild(linkCell);
        				
        				tableBody.appendChild(row);
        			});
        		})
        		.catch(error => console.error("Error fetching news", error));
        }

        document.getElementById("addButton").addEventListener("click", addProduct);

        window.onload = function() {
            console.log("Page Loaded. Fetching Products...");
            loadProducts();
            loadNews();
        };
        

    </script>
</body>
</html>
