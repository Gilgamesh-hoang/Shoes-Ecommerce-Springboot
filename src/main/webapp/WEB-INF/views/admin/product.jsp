<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="no-js" lang="en-US">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="apple-touch-icon" sizes="76x76" href="/admin/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="/admin/assets/img/favicon.png">
    <title>
        Material Dashboard 2 by Creative Tim
    </title>
    <!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css"
          href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700"/>
    <!-- Nucleo Icons -->
    <link href="/admin/assets/css/nucleo-icons.css" rel="stylesheet"/>
    <link href="/admin/assets/css/nucleo-svg.css" rel="stylesheet"/>
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <!-- Material Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
    <!-- CSS Files -->
    <link id="pagestyle" href="/admin/assets/css/material-dashboard.css?v=3.0.4" rel="stylesheet"/>
</head>

<body class="g-sidenav-show  bg-gray-200">
<%@ include file="./common/sidebar.jsp" %>
<main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
    <!-- Navbar -->
    <%@ include file="./common/header.jsp" %>
    <!-- End Navbar -->
    <div class="container-fluid py-4">
        <div class="row">
            <div class="col-12">
                <div>
                    <a href="<c:url value="/admin/products/update"/> " class="btn bg-gradient-dark mb-0"
                       data-toggle="modal" data-target="#addProduct">
                        <i class="material-icons text-sm">add</i>Add Product
                    </a>
                </div>
                <div class="row justify-content-center mt-4">
                    <c:forEach var="product_item" items="${products}">
                        <div class="col-xl-3 col-md-4 col-sm-6 col-12 mb-4">
                            <div class="card py-3">
                                <div class="card-header p-0  mx-3 border-radius-lg">
                                    <a href="<c:url value="/products/${product_item.id}"/>" style="background: rgb(171,172,171);
                                            background: linear-gradient(125deg, rgba(171,172,171,1) 35%, rgba(205,205,205,1) 100%);
                                             cursor:pointer;" class="d-block shadow-xl border-radius-lg">
                                        <img loading="lazy" src="${product_item.thumbnail}" alt="Image Shoes"
                                             class="img-fluid shadow border-radius-lg">
                                    </a>
                                </div>
                                <div class="card-body p-3">
                                    <p class="mb-0 text-sm">#${product_item.id}</p>
                                    <a href="<c:url value="/products/${product_item.id}"/>">
                                        <h5 style="
                                                line-height: 1.5em;
                                                height: 2em;
                                                overflow: hidden;
                                                white-space: nowrap;
                                                text-overflow: ellipsis;
                                                width: 100%;
                                                cursor: pointer;
                                                ">
                                                ${product_item.name}
                                        </h5>
                                    </a>
                                    <p class="mb-2 text-sm" style="
                                            line-height: 1.5em;
                                            height: 2em;
                                            overflow: hidden;
                                            white-space: nowrap;
                                            text-overflow: ellipsis;
                                            width: 100%;
                                            cursor: pointer;
                                            " data-toggle="tooltip" data-placement="top"
                                       title="${product_item.shortDescription}"
                                    >
                                            ${product_item.shortDescription}
                                    </p>
                                    <div class="d-flex align-items-center justify-content-between">
                                        <a href="/admin/products/update?id=${product_item.id}" type="button"
                                           class="btn btn-outline-primary btn-sm mb-0 mx-auto">Edit Product</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <!-- paginatation -->
                <form id="formPaging" action="<c:url value="/admin/products"/>" method="get">
                    <input type="hidden" value="" id="page" name="page"/>
                </form>
                <nav aria-label="Page navigation" style="display: flex;justify-content: center;">
                    <ul class="pagination" id="pagination">
                        <li class="page-item first disabled"><a href="#" class="page-link">&lt;&lt;</a></li>
                        <li class="page-item active"><a href="#" class="page-link">1</a></li>
                        <li class="page-item last disabled"><a href="#" class="page-link">&gt;&gt;</a></li>
                    </ul>
                </nav>
            </div>
        </div>
        <%@ include file="./common/footer.jsp" %>
    </div>
</main>
<%@ include file="./common/fixed-plugin.jsp" %>


<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<!--   Core JS Files   -->
<script src="/admin/assets/js/core/popper.min.js"></script>
<script src="/admin/assets/js/core/bootstrap.min.js"></script>
<script src="/admin/assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="/admin/assets/js/plugins/smooth-scrollbar.min.js"></script>
<!-- Github buttons -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
<!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
<script src="/admin/assets/js/material-dashboard.min.js?v=3.0.4"></script>
<script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- jQuery -->
<script type="text/javascript" src="/user/js/jquery.min.js"></script>
<script src="/paging/jquery.twbsPagination.js"></script>
<script>
    window.addEventListener("DOMContentLoaded", function () {
        $(document).ready(function () {
            //paging
            // This function is responsible for handling the pagination of the products page.
            $(function () {
                // The total number of pages is retrieved from the server-side variable 'maxPage'.
                var totalPages = ${maxPage};

                // The current page number is retrieved from the server-side variable 'page'.
                var currentPage = ${page};

                // The 'twbsPagination' plugin is initialized on the HTML element with the id 'pagination'.
                // This plugin provides a dynamic pagination system.
                window.pagObj = $('#pagination').twbsPagination({
                    // The total number of pages.
                    totalPages: totalPages,

                    // The maximum number of visible pages in the pagination system.
                    visiblePages: 10,

                    // The page to be displayed when the pagination system is first initialized.
                    startPage: currentPage,

                    // This function is triggered when a page number is clicked.
                    onPageClick: function (event, page) {
                        // If the clicked page number is not the current page number,
                        // the page number is set as the value of the hidden input field with the id 'page',
                        // and the form with the id 'formPaging' is submitted to request the corresponding page of products.
                        if (currentPage !== page) {
                            $('#page').val(page);
                            $('#formPaging').submit();
                        }
                    }
                });
            });

            (function () {
                var isSaved = '<%= request.getAttribute("isSaved") %>';
                if (isSaved === 'success') {
                    Swal.fire({
                        icon: "success",
                        title: "Success!",
                        toast: true,
                        position: "top-end",
                        showConfirmButton: false,
                        timer: 600,
                        timerProgressBar: true,
                        didOpen: (toast) => {
                            toast.onmouseenter = Swal.stopTimer;
                            toast.onmouseleave = Swal.resumeTimer;
                        }
                    });
                }
            })();
        })
    });
</script>
</body>

</html>
