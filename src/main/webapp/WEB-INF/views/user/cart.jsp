<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Shopping Cart" />
<%@ include file="../common/header.jsp" %>
<main>
<div class="page-header"><div class="container"><h1>Shopping Cart</h1></div></div>
<div class="container" style="padding:24px 20px;">

    <c:if test="${not empty cartError}">
        <div class="alert alert-danger">${cartError}</div>
    </c:if>

    <c:set var="cart" value="${sessionScope.cart}" />
    <c:choose>
        <c:when test="${not empty cart}">
            <div class="cart-layout">

                <%-- ── Left column: cart items ── --%>
                <div class="cart-items-col">
                    <div class="card">
                        <div class="card-header d-flex align-center justify-between">
                            <h3>Cart Items</h3>
                            <span class="text-muted">${cart.size()} item<c:if test="${cart.size() != 1}">s</c:if></span>
                        </div>

                        <c:set var="total" value="0" />
                        <c:forEach var="item" items="${cart}">
                            <c:set var="total" value="${total + item.unitPrice * item.quantity}" />
                            <div class="cart-item">
                                <img class="cart-item-img"
                                     src="${pageContext.request.contextPath}${item.imagePath}"
                                     alt="${item.productName}">

                                <div class="cart-item-info">
                                    <div class="cart-item-name">${item.productName}</div>
                                    <div class="text-muted">
                                        NPR <fmt:formatNumber value="${item.unitPrice}" type="number" maxFractionDigits="2"/> each
                                    </div>

                                    <%-- Quantity stepper --%>
                                    <form action="${pageContext.request.contextPath}/user/order" method="post"
                                          class="qty-form mt-1">
                                        <input type="hidden" name="action" value="updateQty">
                                        <input type="hidden" name="productId" value="${item.productId}">
                                        <div class="qty-stepper">
                                            <button type="button" class="qty-btn" data-dir="down">&#8722;</button>
                                            <input type="number" name="qty" value="${item.quantity}"
                                                   min="1" max="99" class="qty-input">
                                            <button type="button" class="qty-btn" data-dir="up">&#43;</button>
                                        </div>
                                        <button type="submit" class="btn btn-secondary btn-sm" style="margin-left:8px;">
                                            Update
                                        </button>
                                    </form>
                                </div>

                                <div class="cart-item-right">
                                    <div class="cart-item-price">
                                        NPR <fmt:formatNumber value="${item.unitPrice * item.quantity}"
                                                              type="number" maxFractionDigits="2"/>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/user/order" method="post"
                                          class="mt-1">
                                        <input type="hidden" name="action" value="removeCart">
                                        <input type="hidden" name="productId" value="${item.productId}">
                                        <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="mt-2">
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">
                            &#8592; Continue Shopping
                        </a>
                    </div>
                </div>

                <%-- ── Right column: order summary ── --%>
                <div class="cart-summary-col">
                    <div class="cart-summary">
                        <h3 style="margin-bottom:16px;">Order Summary</h3>

                        <div class="d-flex justify-between mb-1">
                            <span>Subtotal (${cart.size()} items)</span>
                            <span>NPR <fmt:formatNumber value="${total}" type="number" maxFractionDigits="2"/></span>
                        </div>
                        <div class="d-flex justify-between mb-1">
                            <span>Shipping</span>
                            <span class="text-green fw-bold">Free</span>
                        </div>
                        <hr style="border:none;border-top:1px solid var(--border);margin:12px 0;">
                        <div class="cart-total d-flex justify-between mb-2">
                            <span>Total</span>
                            <span>NPR <fmt:formatNumber value="${total}" type="number" maxFractionDigits="2"/></span>
                        </div>

                        <form action="${pageContext.request.contextPath}/user/order" method="post">
                            <input type="hidden" name="action" value="checkout">
                            <div class="form-group">
                                <label for="shippingAddress">Shipping Address <span style="color:#dc3545">*</span></label>
                                <textarea id="shippingAddress" name="shippingAddress" class="form-control"
                                          rows="3" required
                                          placeholder="Enter your full delivery address">${sessionScope.loggedInUser.address}</textarea>
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">
                                Place Order &#8594;
                            </button>
                        </form>
                    </div>
                </div>

            </div><%-- .cart-layout --%>
        </c:when>

        <c:otherwise>
            <div class="cart-empty-state">
                <div style="font-size:4rem; margin-bottom:16px;">&#128722;</div>
                <h3>Your cart is empty</h3>
                <p class="text-muted mt-1">Browse our products and add some items to your cart.</p>
                <div class="mt-2">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
                        Shop Now
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</main>
<%@ include file="../common/footer.jsp" %>
