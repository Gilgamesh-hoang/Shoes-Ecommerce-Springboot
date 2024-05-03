<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="no-js" lang="en-US">

<head>
    <meta charset="UTF-8">
    <!--[if IE]>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <![endif]-->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>Groover - Online Shopping for Electronics, Apparel, Computers, Books, DVDs & more</title>
    <!-- Standard Favicon -->
    <link href="/user/images/favicon.ico" rel="shortcut icon">
    <!-- Base Google Font for Web-app -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">
    <!-- Google Fonts for Banners only -->
    <link href="https://fonts.googleapis.com/css?family=Raleway:400,800" rel="stylesheet">
    <!-- Bootstrap 4 -->
    <link rel="stylesheet" href="/user/css/bootstrap.min.css">
    <!-- Font Awesome 5 -->
    <link rel="stylesheet" href="/user/css/fontawesome.min.css">
    <!-- Ion-Icons 4 -->
    <link rel="stylesheet" href="/user/css/ionicons.min.css">
    <!-- Animate CSS -->
    <link rel="stylesheet" href="/user/css/animate.min.css">
    <!-- Owl-Carousel -->
    <link rel="stylesheet" href="/user/css/owl.carousel.min.css">
    <!-- Jquery-Ui-Range-Slider -->
    <link rel="stylesheet" href="/user/css/jquery-ui-range-slider.min.css">
    <!-- Utility -->
    <link rel="stylesheet" href="/user/css/utility.css">
    <!-- Main -->
    <link rel="stylesheet" href="/user/css/bundle.css">

</head>

<body>

<!-- app -->
<div id="app">
    <!-- Header -->
    <%@ include file="./common/header.jsp" %>
    <!-- Header /- -->
    <!-- Main-Slider -->
    <div class="default-height ph-item">
        <div class="slider-main owl-carousel">
            <div class="bg-image one">
            </div>
            <div class="bg-image two">
            </div>
            <div class="bg-image three">
            </div>
        </div>
    </div>
    <!-- Main-Slider /- -->


    <section class="section-maker">
        <div class="container">
            <div class="sec-maker-header text-center">
                <h3 class="sec-maker-h3 u-s-m-b-22">Hot Deals</h3>
                <span class="sec-maker-span-text">Ends in</span>
                <!-- Timing-Box -->
                <div class="section-timing-wrapper dynamic">
                    <span class="fictitious-seconds" style="display:none;">18000</span>
                    <div class="section-box-wrapper box-days">
                        <div class="section-box">
                            <span class="section-key">120</span>
                            <span class="section-value">Days</span>
                        </div>
                    </div>
                    <div class="section-box-wrapper box-hrs">
                        <div class="section-box">
                            <span class="section-key">54</span>
                            <span class="section-value">HRS</span>
                        </div>
                    </div>
                    <div class="section-box-wrapper box-mins">
                        <div class="section-box">
                            <span class="section-key">3</span>
                            <span class="section-value">MINS</span>
                        </div>
                    </div>
                    <div class="section-box-wrapper box-secs">
                        <div class="section-box">
                            <span class="section-key">32</span>
                            <span class="section-value">SEC</span>
                        </div>
                    </div>
                </div>
                <!-- Timing-Box /- -->
            </div>
            <!-- Carousel -->
            <div class="slider-fouc">
                <div class="products-slider owl-carousel" data-item="4">
                    <c:forEach var="item" items="${hotProducts}">
                        <div class="item">
                            <div class="image-container">
                                <a class="item-img-wrapper-link" href="<c:url value="/products/${item.id}"/>">
                                    <img class="img-fluid" src="${item.thumbnail}" alt="Product">
                                </a>

                                <div class="item-action-behaviors">
                                    <a class="item-quick-look" href="<c:url value="/products/${item.id}"/>">Quick Look</a>
                                    <a class="item-addwishlist" href="javascript:void(0)">Add to Wishlist</a>
                                    <a class="item-mail" href="javascript:void(0)">Mail</a>
                                </div>
                            </div>
                            <div class="item-content">
                                <div class="what-product-is">
                                    <ul class="bread-crumb">
                                        <li class="has-separator">
                                            <a >${item.category.name}</a>
                                        </li>
                                    </ul>
                                    <h6 class="item-title">
                                        <a href="<c:url value="/products/${item.id}"/>">${item.name}</a>
                                    </h6>
                                    <div class="item-stars">
                                        <div class='star' title="0 out of 5 - based on 0 Reviews">
                                            <span style='width:0'></span>
                                        </div>
                                        <span>(0)</span>
                                    </div>
                                </div>
                                <div class="price-template">
                                    <div class="item-new-price">
                                        <fmt:formatNumber type="number" pattern="$#,##0.0" value="${item.price * (1 - item.discount)}" />
                                    </div>
                                    <div class="item-old-price"><fmt:formatNumber type="number" pattern="$#,##0.0" value="${item.price}" />
                                    </div>
                                </div>
                            </div>
                            <div class="tag hot">
                                <span>HOT</span>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>
            <!-- Carousel /- -->
        </div>
    </section>
    <!-- Men-Clothing-Timing-Section /- -->
    <!-- Banner-Layer -->
    <div class="banner-layer">
        <div class="container">
            <div class="image-banner">
                <div class="mx-auto banner-hover">
                    <img class="img-fluid" src="/user/images/banners/maxresdefault.jpg" alt="Winter Season Banner">
                </div>
            </div>
        </div>
    </div>
    <!-- Banner-Layer /- -->

    <!-- Men-Clothing -->
    <section class="section-maker">
        <div class="container">
            <div class="sec-maker-header text-center">
                <h3 class="sec-maker-h3">Newest Products</h3>
            </div>
            <div class="wrapper-content">
                <div class="outer-area-tab">
                    <div class="tab-content">
                        <div class="tab-pane active show fade" id="men-latest-products">
                            <div class="slider-fouc">
                                <div class="products-slider owl-carousel" data-item="4">
                                    <c:forEach items="${newestProducts}" var="item">
                                        <div class="item">
                                            <div class="image-container">
                                                <a class="item-img-wrapper-link" href="<c:url value="/products/${item.id}"/>">
                                                    <img class="img-fluid" src="${item.thumbnail}" alt="Product">
                                                </a>
                                                <div class="item-action-behaviors">
                                                    <a class="item-quick-look" href="<c:url value="/products/${item.id}"/>">Quick Look</a>
                                                    <a class="item-addwishlist" href="javascript:void(0)">Add to Wishlist</a>
                                                    <a class="item-mail" href="javascript:void(0)">Mail</a>
                                                </div>
                                            </div>
                                            <div class="item-content">
                                                <div class="what-product-is">
                                                    <ul class="bread-crumb">
                                                        <li class="has-separator">
                                                            <a >${item.category.name}</a>
                                                        </li>
                                                    </ul>
                                                    <h6 class="item-title">
                                                        <a href="<c:url value="/products/${item.id}"/>">${item.name}</a>
                                                    </h6>
                                                    <div class="item-stars">
                                                        <div class='star' title="0 out of 5 - based on 0 Reviews">
                                                            <span style='width:0'></span>
                                                        </div>
                                                        <span>(0)</span>
                                                    </div>
                                                </div>
                                                <div class="price-template">
                                                    <div class="item-new-price">
                                                        <fmt:formatNumber type="number" pattern="$#,##0.0" value="${item.price}" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tag new">
                                                <span>NEW</span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="men-best-selling-products">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Men-Clothing-Timing-Section -->

    <!-- Continue-Link -->
    <div class="continue-link-wrapper u-s-p-b-80">
        <a class="continue-link" href="<c:url value="/products/newest"/> " title="View all products on site">
            <i class="ion ion-ios-more"></i>
        </a>
    </div>
    <!-- Continue-Link /- -->
    <!-- Site-Priorities -->
    <section class="app-priority">
        <div class="container">
            <div class="priority-wrapper u-s-p-b-80">
                <div class="row">
                    <div class="col-lg-3 col-md-3 col-sm-3">
                        <div class="single-item-wrapper">
                            <div class="single-item-icon">
                                <i class="ion ion-md-star"></i>
                            </div>
                            <h2>
                                Great Value
                            </h2>
                            <p>We offer competitive prices on our 100 million plus product range</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3">
                        <div class="single-item-wrapper">
                            <div class="single-item-icon">
                                <i class="ion ion-md-cash"></i>
                            </div>
                            <h2>
                                Shop with Confidence
                            </h2>
                            <p>Our Protection covers your purchase from click to delivery</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3">
                        <div class="single-item-wrapper">
                            <div class="single-item-icon">
                                <i class="ion ion-ios-card"></i>
                            </div>
                            <h2>
                                Safe Payment
                            </h2>
                            <p>Pay with the world’s most popular and secure payment methods</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3">
                        <div class="single-item-wrapper">
                            <div class="single-item-icon">
                                <i class="ion ion-md-contacts"></i>
                            </div>
                            <h2>
                                24/7 Help Center
                            </h2>
                            <p>Round-the-clock assistance for a smooth shopping experience</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Site-Priorities /- -->
    <!-- Footer -->
    <%@ include file="./common/footer.jsp" %>
    <!-- Footer /- -->
</div>
<!-- app /- -->

<!-- Modernizr-JS -->
<script type="text/javascript" src="/user/js/vendor/modernizr-custom.min.js"></script>
<!-- NProgress -->
<script type="text/javascript" src="/user/js/nprogress.min.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="/user/js/jquery.min.js"></script>
<!-- Bootstrap JS -->
<script type="text/javascript" src="/user/js/bootstrap.min.js"></script>
<!-- Popper -->
<script type="text/javascript" src="/user/js/popper.min.js"></script>
<!-- ScrollUp -->
<script type="text/javascript" src="/user/js/jquery.scrollUp.min.js"></script>
<!-- Elevate Zoom -->
<script type="text/javascript" src="/user/js/jquery.elevatezoom.min.js"></script>
<!-- jquery-ui-range-slider -->
<script type="text/javascript" src="/user/js/jquery-ui.range-slider.min.js"></script>
<!-- jQuery Slim-Scroll -->
<script type="text/javascript" src="/user/js/jquery.slimscroll.min.js"></script>
<!-- jQuery Resize-Select -->
<script type="text/javascript" src="/user/js/jquery.resize-select.min.js"></script>
<!-- jQuery Custom Mega Menu -->
<script type="text/javascript" src="/user/js/jquery.custom-megamenu.min.js"></script>
<!-- jQuery Countdown -->
<script type="text/javascript" src="/user/js/jquery.custom-countdown.min.js"></script>
<!-- Owl Carousel -->
<script type="text/javascript" src="/user/js/owl.carousel.min.js"></script>
<!-- Main -->
<script type="text/javascript" src="/user/js/app.js"></script>

</body>
</html>
