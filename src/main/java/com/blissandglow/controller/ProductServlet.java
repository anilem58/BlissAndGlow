package com.blissandglow.controller;

import com.blissandglow.model.Product;
import com.blissandglow.service.ProductService;
import com.blissandglow.service.WishlistService;
import com.blissandglow.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private final ProductService  productService  = new ProductService();
    private final WishlistService wishlistService = new WishlistService();

    private static final int PAGE_SIZE = 12;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("detail".equals(action)) {
            showDetail(req, resp);
        } else if ("search".equals(action)) {
            showSearch(req, resp);
        } else {
            showList(req, resp);
        }
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int page       = parseIntParam(req.getParameter("page"), 1);
            int categoryId = parseIntParam(req.getParameter("category"), 0);
            String sort    = req.getParameter("sort");

            int total      = productService.getTotalCount(categoryId);
            int totalPages = (int) Math.ceil((double) total / PAGE_SIZE);
            if (page < 1) page = 1;
            if (page > totalPages && totalPages > 0) page = totalPages;

            req.setAttribute("products",   productService.getPaginated(page, PAGE_SIZE, categoryId, sort));
            req.setAttribute("categories", productService.getAllCategories());
            req.setAttribute("currentPage",  page);
            req.setAttribute("totalPages",   totalPages);
            req.setAttribute("selectedCategory", categoryId);
            req.setAttribute("selectedSort", sort);
            req.getRequestDispatcher("/WEB-INF/views/user/products.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int productId = parseIntParam(req.getParameter("id"), 0);
            Product product = productService.getById(productId);
            if (product == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            req.setAttribute("product", product);

            HttpSession session = req.getSession(false);
            if (SessionUtil.isLoggedIn(session)) {
                int userId = SessionUtil.getUser(session).getUserId();
                req.setAttribute("inWishlist", wishlistService.isInWishlist(userId, productId));
            }
            req.getRequestDispatcher("/WEB-INF/views/user/productDetails.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showSearch(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String keyword = req.getParameter("q");
            req.setAttribute("products", productService.search(keyword));
            req.setAttribute("keyword",  keyword);
            req.getRequestDispatcher("/WEB-INF/views/user/search.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private int parseIntParam(String value, int defaultValue) {
        try { return Integer.parseInt(value); }
        catch (Exception e) { return defaultValue; }
    }
}
