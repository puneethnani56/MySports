<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.mysports.Product, com.mysports.Cart" %>
<%@ page session="true" %>

<%
    response.setCharacterEncoding("UTF-8");
    Cart cart = (Cart) session.getAttribute("cart");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
</head>
<body>

<h2>🛒 Your Cart</h2>

<% if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) { %>
    <p>No items in cart.</p>
<% } else { %>
    <table border="1">
        <tr><th>Name</th><th>Price</th></tr>
        <% for (Product p : cart.getItems()) { %>
            <tr>
                <td><%= p.getName() %></td>
                <td>&#8377;<%= p.getPrice() %></td>
            </tr>
        <% } %>
    </table>
    <p><strong>Total: &#8377;<%= cart.getTotal() %></strong></p>
<% } %>

<br>
<a href="store">⬅️ Back to Store</a>

</body>
</html>
