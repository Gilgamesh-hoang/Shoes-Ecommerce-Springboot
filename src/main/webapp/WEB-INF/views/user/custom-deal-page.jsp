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
    <!-- Page Introduction Wrapper -->
    <div class="page-style-a">
        <div class="container">
            <div class="page-intro">
                <h2>${pageCategory}</h2>
                <ul class="bread-crumb">
                    <li class="has-separator">
                        <i class="ion ion-md-home"></i>
                        <a href="<c:url value="/"/> ">Home</a>
                    </li>
                    <li class="is-marked">
                        <a href="#">${pageCategory}</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <!-- Page Introduction Wrapper /- -->
    <!-- Custom-Deal-Page -->
    <div class="page-deal u-s-p-t-80">
        <div class="container">
            <!-- Page-Bar -->
            <div class="page-bar clearfix">
                <div class="shop-settings">
                    <a id="list-anchor">
                        <i class="fas fa-th-list"></i>
                    </a>
                    <a id="grid-anchor" class="active">
                        <i class="fas fa-th"></i>
                    </a>
                </div>
                <!-- Toolbar Sorter 1  -->
                <div class="toolbar-sorter">
                    <div class="select-box-wrapper">
                        <label class="sr-only" for="sort-by">Sort By</label>
                        <select class="select-box" id="sort-by" name="sortBy">
                            <option value="latest" <c:if test="${sortBy != null && sortBy.equals('latest')}">selected</c:if>>Sort By: Latest</option>
                            <option value="oldest" <c:if test="${sortBy != null && 'oldest' eq sortBy}">selected</c:if>>Sort By: Oldest</option>
                            <option value="lowest" <c:if test="${sortBy != null && 'lowest' eq sortBy}">selected</c:if>>Sort By: Lowest Price</option>
                            <option value="highest" <c:if test="${sortBy != null && 'highest' eq sortBy}">selected</c:if>>Sort By: Highest Price</option>
                        </select>
                    </div>
                </div>
                <!-- //end Toolbar Sorter 1  -->
            </div>
            <!-- Page-Bar /- -->
            <!-- Row-of-Product-Container -->
            <div class="row product-container grid-style">
                <c:forEach var="item" items="${products}" >
                    <div class="product-item col-lg-3 col-md-6 col-sm-6">
                        <div class="item" style="width: 100%">
                            <div class="image-container">
                                <a class="item-img-wrapper-link" href="<c:url value="/products/${item.id}"/>">
                                    <img class="img-fluid" src="${item.thumbnail}" alt="Product">
                                </a>
                                <div class="item-action-behaviors">
                                    <a class="item-quick-look" data-toggle="modal" href="<c:url value="/products/${item.id}"/>">Quick Look</a>
                                    <a class="item-mail" href="javascript:void(0)">Mail</a>
                                    <a class="item-addwishlist" href="javascript:void(0)">Add to Wishlist</a>
                                </div>
                            </div>
                            <div class="item-content">
                                <div class="what-product-is">
                                    <ul class="bread-crumb">
                                        <li class="has-separator">
                                            <a>${item.category.name}</a>
                                        </li>

                                    </ul>
                                    <h6 class="item-title">
                                        <a href="<c:url value="/products/${item.id}"/>">${item.name}</a>
                                    </h6>
                                    <div class="item-description">
                                        <p>${item.shortDescription}</p>
                                    </div>
                                    <div class="item-stars">
                                        <div class='star' title="4.5 out of 5 - based on 23 Reviews">
                                            <span style='width:67px'></span>
                                        </div>
                                        <span>(23)</span>
                                    </div>
                                </div>
                                <div class="price-template">
                                    <c:if test="${item.discount != 0}">
                                        <div class="item-new-price">
                                            <fmt:formatNumber type="number" pattern="$#,##0.0" value="${item.price * (1 - item.discount)}" />
                                        </div>
                                        <div class="item-old-price">
                                            <fmt:formatNumber type="number" pattern="$#,##0.0" value="${item.price}" />
                                        </div>
                                    </c:if>
                                    <c:if test="${item.discount == 0}">
                                        <div class="item-new-price">
                                            <fmt:formatNumber type="number" pattern="$#,##0.0" value="${item.price}" />
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                            <div class="tag new">
                                <span>NEW</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>

            </div>
            <!-- Row-of-Product-Container /- -->
            <!-- Shop-Pagination -->
            <div class="pagination-area">
                <!-- paginatation -->
                <form id="formPaging" action="<c:url value="/products/newest"/>" method="get">
                    <input type="hidden" value="" id="page" name="page"/>
                    <input type="hidden" value="${sortBy}" id="sortBy" name="sortBy"/>
                </form>
                <nav aria-label="Page navigation">
                    <ul class="pagination" id="pagination"></ul>
                </nav>
            </div>
            <!-- Shop-Pagination /- -->
        </div>
    </div>
    <!-- Custom-Deal-Page -->
    <!-- Footer -->
    <%@ include file="./common/footer.jsp" %>
    <!-- Footer /- -->

</div>
<!-- app /- -->
<!-- jQuery -->
<script type="text/javascript" src="/user/js/jquery.min.js"></script>
<script src="/paging/jquery.twbsPagination.js"></script>
<!-- Modernizr-JS -->
<script type="text/javascript" src="/user/js/vendor/modernizr-custom.min.js"></script>
<!-- NProgress -->
<script type="text/javascript" src="/user/js/nprogress.min.js"></script>

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
<script>
    window.addEventListener("DOMContentLoaded",function () {
        $(document).ready(function () {
            $(function () {
                var totalPages = ${maxPage};
                var currentPage = ${page};
                window.pagObj = $('#pagination').twbsPagination({
                    totalPages: totalPages,
                    visiblePages: 5,
                    startPage: currentPage,
                    onPageClick: function (event, page) {
                        // console.info(page + ' (from options)');
                        if (currentPage !== page) {
                            $('#page').val(page);
                            $('#formPaging').submit();
                        }
                    }
                });
            });

            $('select[name="sortBy"]').change(function() {
                var selectedValue = $(this).val(); // Lấy giá trị được chọn trong select
                $('input[name="sortBy"]').val(selectedValue); // Gán giá trị vào thẻ input hidden
                $('#formPaging').submit(); // Submit form
            });
        });
    });

</script>
</html>
