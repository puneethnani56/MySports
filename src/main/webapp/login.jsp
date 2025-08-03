<html>
<body>
<h2>Login Page</h2>

<% if (request.getParameter("error") != null) { %>
  <p style="color:red;">❌ Invalid username or password</p>
<% } %>

<% if (request.getParameter("registered") != null) { %>
  <p style="color:green;">✅ Registration successful! Please login.</p>
<% } %>

<form method="post" action="login">
  Username: <input type="text" name="username"><br>
  Password: <input type="password" name="password"><br>
  <input type="submit" value="Login">
</form>

</body>
</html>
