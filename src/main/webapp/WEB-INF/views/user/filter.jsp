<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <%--    <div class="page-style-a">--%>
    <%--        <div class="container">--%>
    <%--            <div class="page-intro">--%>
    <%--                <h2>Shop</h2>--%>
    <%--                <ul class="bread-crumb">--%>
    <%--                    <li class="has-separator">--%>
    <%--                        <i class="ion ion-md-home"></i>--%>
    <%--                        <a href="<c:url value="/"/> ">Home</a>--%>
    <%--                    </li>--%>
    <%--                    <li class="is-marked">--%>
    <%--                        <a>Search</a>--%>
    <%--                    </li>--%>
    <%--                </ul>--%>
    <%--            </div>--%>
    <%--        </div>--%>
    <%--    </div>--%>
    <!-- Page Introduction Wrapper /- -->
    <!-- Shop-Page -->
    <div class="page-shop u-s-p-t-80">
        <div class="container">
            <%--            <h4>WE FOUND <span>${totalResult}</span> RESULTS FOR--%>
            <%--                <i>“${search}”</i>--%>
            <%--            </h4>--%>
            <div class="row">
                <!-- Shop-Left-Side-Bar-Wrapper -->
                <div class="col-lg-3 col-md-3 col-sm-12">
                    <!-- Fetch-Categories-from-Root-Category  -->
                    <div class="facet-filter-associates">
                        <h3 class="title-name">Browse Categories</h3>
                        <div class="associate-wrapper">
                            <c:forEach var="category" items="${categories}">
                                <input type="checkbox" class="check-box category-checkbox" value="${category.id}"
                                       id="category-${category.id}">
                                <label for="category-${category.id}" class="label-text">${category.name}</label>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="facet-filter-associates">
                        <h3 class="title-name">Size</h3>
                        <div class="associate-wrapper">
                            <c:forEach var="size" items="${sizes}">
                                <input type="checkbox" class="check-box size-checkbox" value="${size.id}"
                                       id="size-${size.id}">
                                <label for="size-${size.id}" class="label-text">${size.name}</label>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Filter-Size -->
                    <button type="submit" class="button button-primary" id="filter-btn" style="width: 100%">Filter
                    </button>
                    <!-- Filters /- -->
                </div>
                <!-- Shop-Left-Side-Bar-Wrapper /- -->
                <!-- Shop-Right-Wrapper -->
                <div class="col-lg-9 col-md-9 col-sm-12">
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
                                    <option value="latest"
                                            <c:if test="${sortBy != null && sortBy.equals('latest')}">selected</c:if>>
                                        Sort By: Latest
                                    </option>
                                    <option value="oldest"
                                            <c:if test="${sortBy != null && 'oldest' eq sortBy}">selected</c:if>>Sort
                                        By: Oldest
                                    </option>
                                    <option value="lowest"
                                            <c:if test="${sortBy != null && 'lowest' eq sortBy}">selected</c:if>>Sort
                                        By: Lowest Price
                                    </option>
                                    <option value="highest"
                                            <c:if test="${sortBy != null && 'highest' eq sortBy}">selected</c:if>>Sort
                                        By: Highest Price
                                    </option>
                                </select>
                            </div>
                        </div>
                        <!-- //end Toolbar Sorter 1  -->

                    </div>
                    <!-- Page-Bar /- -->
                    <!-- Row-of-Product-Container -->
                    <div class="row product-container list-style">
                        <c:forEach var="product" items="${products}">
                            <div class="product-item col-lg-4 col-md-6 col-sm-6">
                                <div class="item" style="width: 100%">
                                    <div class="image-container">
                                        <a class="item-img-wrapper-link"
                                           href="<c:url value="/products/${product.id}"/> ">
                                            <img class="img-fluid" src="${product.thumbnail}" alt="Product">
                                        </a>
                                        <div class="item-action-behaviors">
                                            <a class="item-quick-look" data-toggle="modal"
                                               href="<c:url value="/products/${product.id}"/>">Quick Look</a>
                                            <a class="item-mail" href="javascript:void(0)">Mail</a>
                                            <a class="item-addwishlist" href="javascript:void(0)">Add to Wishlist</a>
                                        </div>
                                    </div>
                                    <div class="item-content">
                                        <div class="what-product-is">
                                            <ul class="bread-crumb">
                                                <li class="has-separator">
                                                    <a>${product.category.name}</a>
                                                </li>
                                            </ul>
                                            <h6 class="item-title">
                                                <a href="<c:url value="/products/${product.id}"/>">${product.name}</a>
                                            </h6>
                                            <div class="item-description">
                                                <p>${product.shortDescription}</p>
                                            </div>
                                            <div class="item-stars">
                                                <div class='star' title="4.5 out of 5 - based on 23 Reviews">
                                                    <span style='width:67px'></span>
                                                </div>
                                                <span>(23)</span>
                                            </div>
                                        </div>
                                        <div class="price-template">
                                            <c:if test="${product.discount != 0}">
                                                <div class="item-new-price">
                                                    <fmt:formatNumber type="number" pattern="$#,##0.0"
                                                                      value="${product.price * (1 - product.discount)}"/>
                                                </div>
                                                <div class="item-old-price">
                                                    <fmt:formatNumber type="number" pattern="$#,##0.0"
                                                                      value="${product.price}"/>
                                                </div>
                                            </c:if>
                                            <c:if test="${product.discount == 0}">
                                                <div class="item-new-price">
                                                    <fmt:formatNumber type="number" pattern="$#,##0.0"
                                                                      value="${product.price}"/>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </c:forEach>

                    </div>
                    <!-- Row-of-Product-Container /- -->
                </div>
                <!-- Shop-Right-Wrapper /- -->
                <div class="pagination-area">
                    <!-- paginatation -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination" id="pagination"></ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <!-- Shop-Page /- -->

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
<script src="/paging/jquery.twbsPagination.js"></script>
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
    window.addEventListener("DOMContentLoaded", function () {
        $(document).ready(function () {
            var totalPages = ${maxPage};
            var currentPage = ${page};
            var search = "${search}";
            var sortBy = "${sortBy}";

            // When the document is ready, setup pagination, sort by change, and filter button click
            $(function () {
                setupPagination();
                setupSortByChange();
                setupFilterButtonClick();
            });

            // Function to setup pagination
            function setupPagination() {
                // Initialize pagination with total pages, visible pages, start page and page click event
                window.pagObj = $('#pagination').twbsPagination({
                    totalPages: totalPages,
                    visiblePages: 5,
                    startPage: currentPage,
                    onPageClick: function (event, page) {
                        // If the current page is not the clicked page, set the current page to the clicked page and filter products
                        if (currentPage !== page) {
                            currentPage = page;
                            filterProducts();
                        }
                    }
                });
            }

            // Function to setup sort by change
            function setupSortByChange() {
                // When the sort by select box changes, set the sort by value and current page, then filter products
                $('select[name="sortBy"]').change(function () {
                    sortBy = $(this).val();
                    currentPage = 1;
                    filterProducts();
                });
            }

            // Function to setup filter button click
            function setupFilterButtonClick() {
                // When the filter button is clicked, set the current page and filter products
                $("#filter-btn").click(function () {
                    currentPage = 1;
                    filterProducts();
                });
            }

            // Function to filter products
            function filterProducts() {
                // Get the checked values of category and size checkboxes
                var categoryIds = getCheckedValues(".category-checkbox");
                var sizeIds = getCheckedValues(".size-checkbox");

                // Send a POST request to the filter API with the category IDs, size IDs, search term, sort by value, and current page
                $.ajax({
                    url: "http://localhost:8080/api/v1/filter",
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify({
                        categoryIds: categoryIds,
                        sizeIds: sizeIds,
                        search: search,
                        sortBy: sortBy,
                        page: currentPage
                    }),
                    success: function (data) {
                        // On success, update the product container with the list of products
                        updateProductContainer(data.list);
                    },
                    error: function (error) {
                        // On error, log the error
                        console.log(error);
                    }
                });
            }

            // Function to get checked values
            function getCheckedValues(selector) {
                var values = [];
                // For each checked checkbox with the given selector, push its value to the values array
                $(selector + ":checked").each(function () {
                    values.push($(this).val());
                });
                return values;
            }

            // Function to update product container
            function updateProductContainer(list) {
                let html = '';
                // For each product in the list, generate its HTML and append it to the html string
                for (let i = 0; i < list.length; i++) {
                    html += generateProductHTML(list[i]);
                }
                // Empty the product container and set its HTML to the generated html string
                $(".product-container").empty();
                $('.product-container').html(html);
            }

            // $(function () {
            //     window.pagObj = $('#pagination').twbsPagination({
            //         totalPages: totalPages,
            //         visiblePages: 5,
            //         startPage: currentPage,
            //         onPageClick: function (event, page) {
            //             if (currentPage !== page) {
            //                 currentPage = page;
            //                 var categoryIds = [];
            //                 var sizeIds = [];
            //
            //                 $(".category-checkbox:checked").each(function () {
            //                     categoryIds.push($(this).val());
            //                 });
            //                 $(".size-checkbox:checked").each(function () {
            //                     sizeIds.push($(this).val());
            //                 });
            //                 $.ajax({
            //                     url: "http://localhost:8080/api/v1/filter",
            //                     type: "POST",
            //                     contentType: "application/json",
            //                     dataType: "json",
            //                     data: JSON.stringify({
            //                         categoryIds: categoryIds,
            //                         sizeIds: sizeIds,
            //                         search: search,
            //                         sortBy: sortBy,
            //                         page: currentPage
            //                     }),
            //                     success: function (data) {
            //                         let html = '';
            //                         for (let i = 0; i < data.list.length; i++) {
            //                             html += generateProductHTML(data.list[i]);
            //                         }
            //                         $(".product-container").empty();
            //                         $('.product-container').html(html);
            //                     },
            //                     error: function (error) {
            //                         console.log(error);
            //                     }
            //                 });
            //             }
            //         }
            //     });
            // });
            // $('select[name="sortBy"]').change(function() {
            //     sortBy = $(this).val(); // Lấy giá trị được chọn trong select
            //     var categoryIds = [];
            //     var sizeIds = [];
            //
            //
            //     $(".category-checkbox:checked").each(function () {
            //         categoryIds.push($(this).val());
            //     });
            //     $(".size-checkbox:checked").each(function () {
            //         sizeIds.push($(this).val());
            //     });
            //     $.ajax({
            //         url: "http://localhost:8080/api/v1/filter",
            //         type: "POST",
            //         contentType: "application/json",
            //         dataType: "json",
            //         data: JSON.stringify({
            //             categoryIds: categoryIds,
            //             sizeIds: sizeIds,
            //             search: search,
            //             sortBy: sortBy,
            //             page: 1
            //         }),
            //         success: function (data) {
            //             currentPage = 1;
            //             let html = '';
            //             for (let i = 0; i < data.list.length; i++) {
            //                 html += generateProductHTML(data.list[i]);
            //             }
            //             $(".product-container").empty();
            //             $('.product-container').html(html);
            //         },
            //         error: function (error) {
            //             console.log(error);
            //         }
            //     });
            // });
            //
            // $("#filter-btn").click(function () {
            //     var categoryIds = [];
            //     var sizeIds = [];
            //
            //
            //     $(".category-checkbox:checked").each(function () {
            //         categoryIds.push($(this).val());
            //     });
            //     $(".size-checkbox:checked").each(function () {
            //         sizeIds.push($(this).val());
            //     });
            //     $.ajax({
            //         url: "http://localhost:8080/api/v1/filter",
            //         type: "POST",
            //         contentType: "application/json",
            //         dataType: "json",
            //         data: JSON.stringify({
            //             categoryIds: categoryIds,
            //             sizeIds: sizeIds,
            //             search: search,
            //             sortBy: sortBy,
            //             page: currentPage
            //         }),
            //         success: function (data) {
            //             let html = '';
            //             for (let i = 0; i < data.list.length; i++) {
            //                 html += generateProductHTML(data.list[i]);
            //             }
            //             $(".product-container").empty();
            //             $('.product-container').html(html);
            //         },
            //         error: function (error) {
            //             console.log(error);
            //         }
            //     });
            // });
            function generateProductHTML(product) {
                let html = '';
                html += '<div class="product-item col-lg-4 col-md-6 col-sm-6">';
                html += '<div class="item" style="width: 100%">';
                html += '<div class="image-container">';
                html += '<a class="item-img-wrapper-link" href="/products/' + product.id + '">';
                html += '<img class="img-fluid" src="' + product.thumbnail + '" alt="Product">';
                html += '</a>';
                html += '<div class="item-action-behaviors">';
                html += '<a class="item-quick-look" data-toggle="modal" href="/products/' + product.id + '">Quick Look</a>';
                html += '<a class="item-mail" href="javascript:void(0)">Mail</a>';
                html += '<a class="item-addwishlist" href="javascript:void(0)">Add to Wishlist</a>';
                html += '</div></div>';
                html += '<div class="item-content">';
                html += '<div class="what-product-is">';
                html += '<ul class="bread-crumb">';
                html += '<li class="has-separator">';
                html += '<a>' + product.category.name + '</a>';
                html += '</li></ul>';
                html += '<h6 class="item-title">';
                html += '<a href="/products/' + product.id + '">' + product.name + '</a>';
                html += '</h6>';
                html += '<div class="item-description">';
                html += '<p>' + product.shortDescription + '</p>';
                html += '</div>';
                html += '<div class="item-stars">';
                html += '<div class="star" title="4.5 out of 5 - based on 23 Reviews">';
                html += '<span style="width:67px"></span>';
                html += '</div>';
                html += '<span>(23)</span>';
                html += '</div></div>';
                html += '<div class="price-template">';
                if (product.discount != 0) {
                    html += '<div class="item-new-price">$' + (product.price * (1 - product.discount)).toFixed(1) + '</div>';
                    html += '<div class="item-old-price">$' + product.price.toFixed(1) + '</div>';
                } else {
                    html += '<div class="item-new-price">$' + product.price.toFixed(1) + '</div>';
                }
                html += '</div></div></div></div>';
                return html;
            }

        });
    });

</script>
</html>
