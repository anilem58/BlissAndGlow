<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Shop" />
<%@ include file="../common/header.jsp" %>
<main>
<div class="page-header">
    <div class="container">
        <h1>Shop All Products</h1>
    </div>
</div>

<div class="container" style="padding:20px;">
    <!-- Filter bar -->
    <form class="filter-bar" action="${pageContext.request.contextPath}/products" method="get">
        <div class="form-group" style="margin-bottom:0;">
            <label>Category</label>
            <select name="category" class="form-control">
                <option value="0">All Categories</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.categoryId}" ${cat.categoryId == selectedCategory ? 'selected' : ''}>${cat.name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group" style="margin-bottom:0;">
            <label>Sort By</label>
            <select name="sort" class="form-control">
                <option value="" ${empty selectedSort ? 'selected' : ''}>Newest</option>
                <option value="price_asc"  ${selectedSort == 'price_asc'  ? 'selected' : ''}>Price: Low to High</option>
                <option value="price_desc" ${selectedSort == 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
                <option value="name_asc"   ${selectedSort == 'name_asc'   ? 'selected' : ''}>Name A–Z</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Filter</button>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">Reset</a>
    </form>

    <!-- Product Grid -->
    <c:choose>
        <c:when test="${not empty products}">
            <div class="product-grid">
                <c:forEach var="p" items="${products}">
                    <div class="product-card">
                        <img class="product-card-img"
                             src="${pageContext.request.contextPath}${p.imagePath}"
                             alt="${p.name}">
                        <div class="product-card-body">
                            <div class="product-card-brand">${p.brand}</div>
                            <div class="product-card-name">${p.name}</div>
                            <div class="product-card-price">
                                NPR <fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0"/>
                            </div>
                            <c:if test="${p.stockQuantity == 0}">
                                <span class="badge-out">Out of Stock</span>
                            </c:if>
                            <div class="product-card-actions mt-1">
                                <a href="${pageContext.request.contextPath}/products?action=detail&id=${p.productId}"
                                   class="btn btn-secondary btn-sm">View</a>
                                <c:if test="${p.stockQuantity > 0 and not empty sessionScope.loggedInUser and sessionScope.loggedInUser.role == 'CUSTOMER'}">
                                    <form action="${pageContext.request.contextPath}/user/order" method="post" style="flex:1;">
                                        <input type="hidden" name="action" value="addToCart">
                                        <input type="hidden" name="productId" value="${p.productId}">
                                        <input type="hidden" name="qty" value="1">
                                        <button type="submit" class="btn btn-primary btn-sm" style="width:100%;">Cart</button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="?page=${currentPage-1}&category=${selectedCategory}&sort=${selectedSort}">&laquo; Prev</a>
                    </c:if>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}"><span class="active">${i}</span></c:when>
                            <c:otherwise><a href="?page=${i}&category=${selectedCategory}&sort=${selectedSort}">${i}</a></c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <a href="?page=${currentPage+1}&category=${selectedCategory}&sort=${selectedSort}">Next &raquo;</a>
                    </c:if>
                </div>
            </c:if>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info">No products found.</div>
        </c:otherwise>
    </c:choose>
</div>
</main>
<%@ include file="../common/footer.jsp" %>
