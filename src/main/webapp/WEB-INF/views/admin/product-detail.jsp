<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
                <div class="mb-2 ps-3">
                    <div class=" my-3" id="formNewProduct">
                        <div class="card py-2 px-4">
                            <form:form role="form" method="POST" action='/admin/products/update'
                                       enctype="multipart/form-data" modelAttribute="product">
                                <form:input path="id" type="hidden"/>
                                <div class="input-group input-group-outline my-3">
                                    <label class="form-label">Title</label>
                                    <form:input path="name" type="text" class="form-control" required="required"/>
                                </div>
                                <div class="my-3">
                                    <label>Description</label>
                                    <form:textarea type="text" class="" rows="10" style="height: 200px"
                                                   path="description" id="description"/>
                                    <p class="text-sm">Content cannot contain characters <code
                                            style="color:red;">'</code></p>
                                </div>
                                <div class="input-group input-group-outline my-3">
                                    <label class="form-label">Short Description</label>
                                    <form:input type="text" class="form-control" path="shortDescription"
                                                required="required"/>
                                </div>
                                <div class="input-group input-group-outline my-3">
                                    <label class="form-label">Price</label>
                                    <form:input id="price" type="number" step="0.01" min="0" max="10000000"
                                                class="form-control" path="price" required="required"/>
                                </div>
                                <div class="input-group input-group-static mb-4">
                                    <label for="category" class="ms-0">Category</label>
                                    <form:select path="category.id" id="category" class="form-control"
                                                 required="required">
                                        <form:options items="${categories}" itemValue="id" itemLabel="name"/>
                                    </form:select>
                                </div>
                                <div class="input-group input-group-static mb-4">
                                    <label for="size" class="ms-0">Size</label>
                                    <select multiple class="form-control" id="size" name="sizeIds" required>
                                        <c:forEach var="size_item" items="${sizes}">
                                            <option value="${size_item.id}">${size_item.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="input-group input-group-static mb-4">
                                    <label for="thumbnailProduct" class="me-2">Thumbnail:</label>
                                    <input type="file" accept="image/*" id="thumbnailProduct" name="thumbnailProduct"/>
                                </div>
                                <div class="row preview-thumbnail-product">
                                    <c:if test="${product.thumbnail != null}">
                                        <div class="col-xl-2 col-md-3 col-4">
                                            <img style="width: 100%;" src="${product.thumbnail}">
                                        </div>
                                    </c:if>
                                </div>
                                <div class="input-group input-group-static mb-4">
                                    <label for="imageProduct" class="me-2">Other Image</label>
                                    <input type="file" multiple accept="image/*" id="imageProduct" name="imageProduct"/>
                                </div>
                                <div class="row preview-img-product">
                                    <c:if test="${product.images != null && !product.images.isEmpty()}">
                                        <c:forEach var="image" items="${product.images}" varStatus="index">
                                            <div class="col-xl-2 col-md-3 col-4">
                                                <img style="width: 100%;" src="${image.imageUrl}">
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>

                                <div class="mt-3">
                                    <button class="btn btn-primary" type="submit">Save</button>
                                    <c:if test="${product.id != 0}">
                                        <button id="btnDelete" data-id="${product.id}" class="btn btn-primary"
                                                type="button">Delete Product
                                        </button>
                                    </c:if>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
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
<script src="https://cdn.ckeditor.com/ckeditor5/40.2.0/classic/ckeditor.js"></script>
<script>
    window.addEventListener("DOMContentLoaded", function () {
        $(document).ready(function () {
            <c:if test="${error eq 'error'}">
                showError("Fail!");
            </c:if>
            <c:if test="${error eq 'sizeError'}">
                showError("Please select at least one size!");
            </c:if>

            // Initialize the ClassicEditor on the HTML element with the id 'description'.
            // The ClassicEditor is a rich text editor provided by CKEditor.
            ClassicEditor.create(document.querySelector('#description'))
                .catch(error => {
                    // If an error occurs during the initialization of the ClassicEditor, log the error to the console.
                    console.error(error);
                });

            // Attach an event handler to the 'change' event of the HTML element with the id 'price'.
            // This event is triggered whenever the value of the 'price' element changes.
            $('#price').change(function () {
                // Retrieve the minimum and maximum allowed values for the 'price' element.
                const min = parseInt($(this).attr('min'));
                const max = parseInt($(this).attr('max'));

                // Retrieve the current value of the 'price' element.
                var price = $(this).val();

                // If the current value is not a number or is less than the minimum allowed value,
                // set the value of the 'price' element to the minimum allowed value.
                if (isNaN(price) || price < min) {
                    $(this).val(min);
                }
                // If the current value is greater than the maximum allowed value,
                // set the value of the 'price' element to the maximum allowed value.
                else if (price > max) {
                    $(this).val(max);
                }
            })

            // Render preview image product
            $("#imageProduct").change(async function () {
                $(".preview-img-product").empty();
                // Convert FileList to an array
                const filesArray = Array.from($("#imageProduct").prop("files"));
                for (let file of filesArray) {
                    const urlShowImg = URL.createObjectURL(file);
                    const imgHtml = `
                            <div class="col-xl-2 col-md-3 col-4">

                                <img style="width: 100%;" src="` + urlShowImg + `" class="card-body"/>
                            </div>
                        `;
                    $(".preview-img-product").append(imgHtml);
                }
            });
            //   Render preview thumbnail product
            $("#thumbnailProduct").change(async function () {
                $(".preview-thumbnail-product").empty();
                const filesArray = Array.from($("#thumbnailProduct").prop("files"));
                for (let file of filesArray) {
                    const urlShowImg = URL.createObjectURL(file);
                    const imgThumbnailHtml = `
                            <div class="col-xl-2 col-md-3 col-4">
                                <img style="width: 100%;" src="` + urlShowImg + `" class="card-body"/>
                            </div>
                        `;
                    $(".preview-thumbnail-product").append(imgThumbnailHtml);
                }
            });

            //   Delete product
            $('#btnDelete').on('click', function () {
                Swal.fire({
                    title: "Delete Product?",
                    text: "Do you want to delete this product?",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#3085d6",
                    cancelButtonColor: "#d33",
                    cancelButtonText: "Cancel",
                    confirmButtonText: "Delete"
                }).then((result) => {
                    if (result.isConfirmed) {
                        const id = $(this).data('id');
                        console.log(id)
                        $.ajax({
                            url: '<c:url value="/api/v1/admin/products"/>',
                            method: 'DELETE',
                            data: {id: id},
                            success: function (response) {
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
                                setTimeout(function () {
                                    window.location.href = "<c:url value="/admin/products"/>";
                                }, 700);
                            },
                            error: function (error) {
                                console.log('that bai')
                                showError("Fail!");
                            }
                        })

                    }
                });
            });

            function showError(message) {
                Swal.fire({
                    icon: "warning",
                    title: message,
                    toast: true,
                    position: "top-end",
                    showConfirmButton: false,
                    timer: 1000,
                    timerProgressBar: true,
                    didOpen: (toast) => {
                        toast.onmouseenter = Swal.stopTimer;
                        toast.onmouseleave = Swal.resumeTimer;
                    }
                });
            }
        })
    });
</script>
</body>

</html>
