<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="no-js" lang="en-US">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="apple-touch-icon" sizes="76x76" href="/admin/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="/admin/assets/img/favicon.png">
    <title>
        Material Dashboard 2 by Creative Tim
    </title>
    <!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
    <!-- Nucleo Icons -->
    <link href="/admin/assets/css/nucleo-icons.css" rel="stylesheet" />
    <link href="/admin/assets/css/nucleo-svg.css" rel="stylesheet" />
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <!-- Material Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
    <!-- CSS Files -->
    <link id="pagestyle" href="/admin/assets/css/material-dashboard.css?v=3.0.4" rel="stylesheet" />
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
                                <form method="POST" enctype="multipart/form-data">
                                    <div class="input-group input-group-outline my-3">
                                        <label class="form-label">Title</label>
                                        <input type="text" class="form-control" name="name" required>
                                    </div>
                                    <div class="my-3">
                                        <label>Description</label>
                                        <textarea type="text" class="" rows="10" style="height: 200px" name="description" id="description"></textarea>
                                        <p class="text-sm">Content cannot contain characters <code style="color:red;">'</code></p>
                                    </div>
                                    <div class="input-group input-group-outline my-3">
                                        <label class="form-label">Short Description</label>
                                        <input type="text" class="form-control" name="shortDescription" required />
                                    </div>
                                    <div class="input-group input-group-outline my-3">
                                        <label class="form-label">Price</label>
                                        <input type="number" step="0.01" class="form-control" name="price" required>
                                    </div>
                                    <div class="input-group input-group-static mb-4">
                                        <label for="category" class="ms-0">Category</label>
                                        <select class="form-control" id="category" name="categoryId" required>
                                            <option value="" selected>-- Select category --</option>
                                            <c:forEach var="category_item" items="${categories}">
                                                <option value="${category_item.id}">${category_item.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="input-group input-group-static mb-4">
                                        <label for="size" class="ms-0">Size</label>
                                        <select multiple class="form-control" id="size" name="sizeId" required>
                                            <c:forEach var="size_item" items="${sizes}">
                                                <option value="${size_item.id}">${size_item.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="input-group input-group-static mb-4">
                                        <label for="thumbnailProduct" class="me-2">Thumbnail:</label>
                                        <input type="file" accept="image/*" id="thumbnailProduct" name="thumbnailProduct" required />
                                    </div>
<%--                                    <div id="preview-thumbnail-product" class="row">--%>
<%--                                        <c:if test="${product.thumbnail != null}">--%>
<%--                                            <div class="col-xl-2 col-md-3 col-4">--%>
<%--                                                <img style="width: 100%;" src="<c:url value="/images/products/${product.thumbnail}"/>">--%>
<%--                                            </div>--%>
<%--                                        </c:if>--%>
<%--                                    </div>--%>
                                    <div class="row preview-thumbnail-product">
                                            <c:if test="${product.thumbnail != null}">
                                                <div class="col-xl-2 col-md-3 col-4">
                                                    <img style="width: 100%;" src="${product.thumbnail}">
                                                </div>
                                            </c:if>
                                    </div>
                                    <div class="input-group input-group-static mb-4">
                                        <label for="imageProduct" class="me-2">Other Image</label>
                                        <input type="file" multiple accept="image/*" id="imageProduct" name="imageProduct" required />
                                    </div>
                                    <div class="row preview-img-product">
                                        <c:if test="${product.images != null && !product.images.isEmpty()}">
                                            <c:forEach var="image" items="${product.images}" varStatus="index">
                                                <div class="col-xl-2 col-md-3 col-4">
                                                    <img style="width: 100%;" src="${image}">
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                    </div>

                                    <button class="btn btn-primary" type="submit">Save</button>
                                    <c:if test="${product != null}">
                                        <button class="btn btn-primary" type="button">Delete Product</button>
                                    </c:if>

                                </form>
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
        window.addEventListener("DOMContentLoaded",function (){
            $(document).ready(function(){
                ClassicEditor.create(document.querySelector('#description'))
                    .catch(error => {
                        console.error(error);
                    });


                async function getBase64FromFile(file) {
                    return new Promise((resolve, reject) => {
                        fetch(window.URL.createObjectURL(file))
                            .then(res => res.blob())
                            .then(blob => {
                                let reader = new FileReader();
                                reader.onload = function () {
                                    let base64 = reader.result;
                                    resolve(base64);
                                };
                                reader.onerror = function (error) {
                                    reject(error);
                                };
                                reader.readAsDataURL(blob);
                            })
                            .catch(error => reject(error));
                    });
                }
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
                                <img style="width: 100%;" src="`+ urlShowImg + `" class="card-body"/>
                            </div>
                        `;
                        $(".preview-thumbnail-product").append(imgThumbnailHtml);
                    }
                });

                // open image selected
                // $('#thumbnailProduct').change(function (event) {
                //     var imageBase64 = '';
                //     var imageName = '';
                //     var reader = new FileReader();
                //     var file = $(this)[0].files[0];
                //     reader.onload = function (e) {
                //         imageBase64 = e.target.result;
                //         imageName = file.name;
                //     };
                //     reader.readAsDataURL(file);
                //     openImage(this);
                // });
                //
                // function openImage(input) {
                //     if (input.files && input.files[0]) {
                //         var reader = new FileReader();
                //         reader.onload = function (e) {
                //             reader.result
                //             var srcData = reader.result;
                //             var newImage = document.createElement('img');
                //             newImage.src = srcData;
                //             document.getElementById('mainImgDiv').innerHTML = newImage.outerHTML;
                //         }
                //         reader.readAsDataURL(input.files[0]);
                //     }
                // }
                //
                // // open image selected
                // function uploadSecondImg() {
                //     $('#secondImgDiv').text('');
                //     var fileSelected = document.getElementById('secondImg').files;
                //     if (fileSelected.length > 0) {
                //         for (var i = 0; i < fileSelected.length; i++) {
                //             var fileToLoad = fileSelected[i];
                //             var fileReader = new FileReader();
                //             fileReader.onload = function (fileLoaderEvent) {
                //                 var srcData = fileLoaderEvent.target.result;
                //                 var newImage = document.createElement('img');
                //                 newImage.src = srcData;
                //                 document.getElementById('secondImgDiv').innerHTML += newImage.outerHTML;
                //             }
                //             fileReader.readAsDataURL(fileToLoad);
                //         }
                //
                //     }
                // }
            })
        });
    </script>
</body>

</html>
