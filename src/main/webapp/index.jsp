<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Home" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<main>

<!-- Hero -->
<section class="hero">
    <div class="container">
        <h1>Beauty. Production. You.</h1>
        <p>Discover skincare and cosmetics that celebrate your natural glow — curated with love, delivered with care.</p>
        <div class="hero-buttons">
            <a href="${pageContext.request.contextPath}/products" class="btn btn-white">Shop Now</a>
            <a href="${pageContext.request.contextPath}/about.jsp" class="btn btn-outline" style="border-color:#fff;color:#fff;">Our Story</a>
        </div>
    </div>
</section>

<!-- Featured Products -->
<section style="padding:50px 20px;">
    <div class="container">
        <h2 class="section-title">Featured Products</h2>
        <div class="product-grid">
            <c:forEach var="p" items="${featuredProducts}">
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
                        <div class="product-card-actions">
                            <a href="${pageContext.request.contextPath}/products?action=detail&id=${p.productId}" class="btn btn-secondary btn-sm">View</a>
                            <form action="${pageContext.request.contextPath}/user/order" method="post" style="flex:1;">
                                <input type="hidden" name="action" value="addToCart">
                                <input type="hidden" name="productId" value="${p.productId}">
                                <input type="hidden" name="qty" value="1">
                                <button type="submit" class="btn btn-primary btn-sm" style="width:100%;">Add to Cart</button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty featuredProducts}">
                <p class="text-muted">No products available. <a href="${pageContext.request.contextPath}/products">Browse all</a></p>
            </c:if>
        </div>
        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">View All Products</a>
        </div>
    </div>
</section>

<!-- Brand highlights -->
<section style="background:var(--green-pale);padding:50px 20px;">
    <div class="container">
        <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:28px;text-align:center;">
            <div>
                <div style="font-size:2.5rem;">🌿</div>
                <h3 style="margin:10px 0 6px;">Natural Ingredients</h3>
                <p class="text-muted">Formulas inspired by nature, gentle on every skin type.</p>
            </div>
            <div>
                <div style="font-size:2.5rem;">🐰</div>
                <h3 style="margin:10px 0 6px;">Cruelty Free</h3>
                <p class="text-muted">We never test on animals — ever.</p>
            </div>
            <div>
                <div style="font-size:2.5rem;">♻️</div>
                <h3 style="margin:10px 0 6px;">Sustainable</h3>
                <p class="text-muted">Eco-conscious packaging and responsible sourcing.</p>
            </div>
            <div>
                <div style="font-size:2.5rem;">💚</div>
                <h3 style="margin:10px 0 6px;">Made with Love</h3>
                <p class="text-muted">Each product crafted to make you feel beautiful.</p>
            </div>
        </div>
    </div>
</section>

</main>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
