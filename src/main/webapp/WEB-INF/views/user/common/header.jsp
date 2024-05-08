<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@page import="com.shoe.util.SecurityUtils" %>
<header>
    <!-- Top-Header -->
    <div class="full-layer-outer-header">
        <div class="container clearfix">
            <nav>
                <ul class="primary-nav g-nav">
                    <li>
                        <a href="tel:+111444989">
                            <i class="fas fa-phone u-c-brand u-s-m-r-9"></i>
                            Telephone:+111-444-989</a>
                    </li>
                    <li>
                        <a href="mailto:contact@domain.com">
                            <i class="fas fa-envelope u-c-brand u-s-m-r-9"></i>
                            E-mail: contact@domain.com
                        </a>
                    </li>
                </ul>
            </nav>
            <nav>
                <ul class="secondary-nav g-nav">
                    <li>

                        <c:set var="principal" value="${SecurityUtils.getPrincipal()}"/>
                        <a><c:if test="${principal != null}"><c:out value="${principal.username}"/></c:if>
                            <c:if test="${principal == null }"><c:out value="Anonymous"/></c:if>
                            <i class="fas fa-chevron-down u-s-m-l-9"></i>
                        </a>
<%--                        <ul class="g-dropdown" style="width:200px">--%>
                        <ul class="g-dropdown" style="width:150px">
                            <security:authorize access="isAnonymous()">
                                <li>
                                    <a href="<c:url value="/auth/login"/>">
                                        <i class="fas fa-sign-in-alt u-s-m-r-9"></i>
                                        Login</a>
                                </li>
                                <li>
                                    <a href="<c:url value="/signup"/> ">
                                        <i class="fas fa-user-plus u-s-m-r-9"></i>
                                        Signup</a>
                                </li>
                            </security:authorize>
                            <security:authorize access="isAuthenticated()">
                                <li>
                                    <a href="<c:url value="/orders"/>">
                                        <i class="far fa-check-circle u-s-m-r-9"></i>
                                        My Orders</a>
                                </li>

                                <li>
                                    <a href="<c:url value="/auth/logout"/>">
                                        <i class="fas fa-sign-out-alt m-r-6"></i>
                                        Logout</a>
                                </li>
                            </security:authorize>
                        </ul>
                    </li>
                    <li>
                        <a>USD
                            <i class="fas fa-chevron-down u-s-m-l-9"></i>
                        </a>
                        <ul class="g-dropdown" style="width:90px">
                            <li>
                                <a href="#" class="u-c-brand">($) USD</a>
                            </li>
                            <li>
                                <a href="#">(đ) VND</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a>ENG
                            <i class="fas fa-chevron-down u-s-m-l-9"></i>
                        </a>
                        <ul class="g-dropdown" style="width:70px">
                            <li>
                                <a href="#" class="u-c-brand">ENG</a>
                            </li>
                            <li>
                                <a href="#">VI</a>
                            </li>
                        </ul>
                </ul>
            </nav>
        </div>
    </div>
    <!-- Top-Header /- -->
    <!-- Mid-Header -->
    <div class="full-layer-mid-header">
        <div class="container">
            <div class="row clearfix align-items-center">
                <div class="col-lg-3 col-md-9 col-sm-6">
                    <div class="brand-logo text-lg-center">
                        <a href="<c:url value="/"/>">
                            <img src="/user/images/main-logo/groover-branding-1.png" alt="Groover Brand Logo"
                                 class="app-brand-logo">
                        </a>
                    </div>
                </div>
                <div class="col-lg-6 u-d-none-lg">
                    <form class="form-searchbox" method="get" action="<c:url value="/filter"/> ">
                        <label class="sr-only" for="search-landscape">Search</label>
                        <input id="search-landscape" type="text" name="search" class="text-field"
                               placeholder="Search everything">
                        <button id="btn-search" type="submit" class="button button-primary fas fa-search"></button>
                    </form>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6">
                    <nav>
                        <ul class="mid-nav g-nav">
                            <li class="u-d-none-lg">
                                <a href="<c:url value="/" />">
                                    <i class="ion ion-md-home u-c-brand"></i>
                                </a>
                            </li>
                            <li class="u-d-none-lg">
                                <a href="#">
                                    <i class="far fa-heart"></i>
                                </a>
                            </li>
                            <li>
                                <a href="<c:url value="/cart"/>" id="mini-cart-trigger">
                                    <i class="ion ion-md-basket"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <!-- Mid-Header /- -->
    <!-- Responsive-Buttons -->
    <div class="fixed-responsive-container">
        <div class="fixed-responsive-wrapper">
            <button type="button" class="button fas fa-search" id="responsive-search"></button>
        </div>
        <div class="fixed-responsive-wrapper">
            <a href="wishlist.html">
                <i class="far fa-heart"></i>
                <span class="fixed-item-counter">4</span>
            </a>
        </div>
    </div>
    <!-- Responsive-Buttons /- -->
    <!-- Bottom-Header -->
    <div class="full-layer-bottom-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-3">
                    <div class="v-menu v-close">
                            <span class="v-title">
                                <i class="ion ion-md-menu"></i>
                                All Categories
                                <i class="fas fa-angle-down"></i>
                            </span>
                        <nav>
                            <div class="v-wrapper">
                                <ul class="v-list animated fadeIn">
                                </ul>
                            </div>
                        </nav>
                    </div>
                </div>
                <div class="col-lg-9">
                    <ul class="bottom-nav g-nav u-d-none-lg">
                        <li>
                        </li>
                        <li>
                            <a href="<c:url value="/products/newest"/>">New Products
                                <span class="superscript-label-new">NEW</span>
                            </a>
                        </li>
                        <li>
                            <a href="<c:url value="/filter"/>">All Products
                                <span class="superscript-label-hot">HOT</span>
                            </a>
                        </li>
                        <li>
                            <a href="<c:url value="/about"/>">About Us
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- Bottom-Header /- -->
</header>
<script>
    window.addEventListener("DOMContentLoaded", function () {
        $(document).ready(function () {
            //using ajax to get the catory list with api http://localhost:8080/api/v1/categories
            $.ajax({
                url: "<c:url value="/api/v1/categories"/>",
                type: "GET",
                success: function (data) {
                    console.log(data)
                    var html = "";
                    for (var i = 0; i < data.length; i++) {
                        html += "<li><a href='/products/category/" + data[i].id + "'><i class='fas fa-shoe-prints'></i>"
                            + data[i].name + "</a></li>";
                    }
                    $(".v-list").html(html);
                }
            });
        });
    });
</script>