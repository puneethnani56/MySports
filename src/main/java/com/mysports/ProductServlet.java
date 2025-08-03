package com.mysports;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class ProductServlet extends HttpServlet {

    public void init() throws ServletException {
        List<Product> productList = new ArrayList<>();
        
        productList.add(new Product("S001", "Football", 500));
        productList.add(new Product("S002", "Tennis Racket", 1200));
        productList.add(new Product("S003", "Cricket Bat", 2500));
        productList.add(new Product("S004", "Badminton Shuttle", 200));
        productList.add(new Product("S005", "Hockey Stick", 1500));
        productList.add(new Product("S006", "Basketball", 700));
        productList.add(new Product("S007", "Table Tennis Bat", 900));
        productList.add(new Product("S008", "Boxing Gloves", 1300));


        getServletContext().setAttribute("productList", productList);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }
}
