package com.mysports;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class AppServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");

        ServletContext context = getServletContext();
        List<Product> productList = (List<Product>) context.getAttribute("productList");

        Product selectedProduct = null;
        for (Product p : productList) {
            if (p.getId().equals(productId)) {
                selectedProduct = p;
                break;
            }
        }

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        if (selectedProduct != null) {
            cart.addItem(selectedProduct);
        }

        response.sendRedirect("cart.jsp");
    }
}
