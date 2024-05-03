<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    <link href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap4.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/user/css/dash-my-order.css">
</head>

<body>
<div id="app">
    <!--====== Main Header ======-->
    <%@ include file="./common/header.jsp" %>
    <!--====== End - Main Header ======-->
    <!--========= Main-Content ===========-->
    <div class="container-content mt-5">

        <!--====== Section 1 ======-->
        <div class="u-s-p-b-60">

            <!--====== Section Content ======-->
            <div class="section__content">
                <div class="dash">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 ">
                                <table class="dash__table" id="dataTable">
                                    <thead>
                                    <tr>
                                        <th class="text-center">#</th>
                                        <th class="text-center">Time</th>
                                        <th class="text-center">Status</th>
                                        <th class="text-center">Total</th>
                                        <th class="text-center"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="order" items="${requestScope.orders}">
                                        <tr>
                                            <td class="text-center">${order.id}</td>
                                            <td class="text-center">
                                                <fmt:formatDate value="${order.createdAt}"
                                                                pattern=" YYYY-MM-dd hh:mma"/>
                                            </td>
                                            <td class="text-center">
                                                <div class="dash__table-img-wrap">

                                                    <span>Preparing</span></div>
                                            </td>
                                            <td class="text-center">
                                                <div class="dash__table-total">
                                                    <span><fmt:formatNumber value="${order.total}" type="currency"/></span>
                                                </div>
                                            </td>
                                            <td class="text-center">
                                                <div class="dash__link dash__link--brand">
                                                    <a style="font-weight: 700;" href="<c:url value="/orders/${order.id}"/>">Detail</a></div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="./common/footer.jsp" %>
</div>
</body>

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
<script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap4.min.js"></script>

<script>
    window.addEventListener("DOMContentLoaded", function () {
        $(document).ready(function () {
            new DataTable('#dataTable', {
                pagingType: 'simple_numbers',
                language: {
                    paginate: {
                        previous: '<',
                        next: '>'
                    }
                }

            });
        });
    });
</script>
</html>