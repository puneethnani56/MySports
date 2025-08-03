<%@ page import="java.util.*, com.mysports.Product" %>
<html>
<head><title>My-Sports Store</title></head>
<body>

<h2>Welcome to My-Sports Online Store</h2>

<table border="1">
<tr><th>ID</th><th>Name</th><th>Price</th><th>Action</th></tr>
<%
    List<Product> productList = (List<Product>) application.getAttribute("productList");
    for(Product product : productList) {
%>
<tr>
    <td><%= product.getId() %></td>
    <td><%= product.getName() %></td>
    <td>₹<%= product.getPrice() %></td>
    <td>
        <form action="add" method="post">
            <input type="hidden" name="productId" value="<%= product.getId() %>">
            <input type="submit" value="Add to Cart">
        </form>
    </td>
</tr>
<% } %>
</table>

<p><a href="cart.jsp">🛒 View Cart</a></p>

</body>
</html>
