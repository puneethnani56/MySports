package com.mysports;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Simple register logic placeholder
        response.sendRedirect("login.jsp?registered=1");
    }
}
