package com.blissandglow.controller;

import com.blissandglow.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("featuredProducts", productService.getPaginated(1, 8, 0, null));
        } catch (Exception e) {
            // Serve page without products rather than crashing
        }
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
}
