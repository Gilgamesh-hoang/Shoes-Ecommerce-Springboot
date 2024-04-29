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
                    <!-- Add new size -->
                    <div class="mb-5 ps-3">
                        <a class="btn bg-gradient-dark mb-0" data-bs-toggle="collapse" href="#formNewSize"><i class="material-icons text-sm">add</i>&nbsp;&nbsp;Add New Size</a>
                        <div class="collapse multi-collapse my-3" id="formNewSize">
                            <div class="card py-2 px-4" >
                                <form id="saveNewSize" method="POST" action="<c:url value="/admin/sizes"/> ">
                                    <div class="input-group input-group-outline my-3">
                                        <label class="form-label">Size Name</label>
                                        <input type="text" class="form-control" name="name">
                                    </div>
                                    <input type="hidden" name="action" value="add">
                                    <button class="btn btn-primary" type="submit">Save</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- End add new categorys -->

                    <div class="card my-4">
                        <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                            <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                                <h6 class="text-white text-capitalize ps-3">Sizes table</h6>
                            </div>
                        </div>

                        <div class="card-body px-0 pb-2">
                            <div class="table-responsive p-0">
                                <div class="d-flex justify-content-end me-4">
                                    <button id="btnDelete" type="button" class="btnDelete" data-toggle="tooltip" title='Delete Sizes'
                                        style="border: none;background: none;">
                                        <span><i class="fas fa-trash"></i></span>
                                    </button>
                                </div>
                                <table class="table align-items-center mb-0" id="dataTable">
                                    <thead>
                                    <tr>
                                        <th class="text-center" style="width: 150px;">
                                            <label class="pos-rel">
                                                <input type="checkbox" class="form-check-input checkbox" id="checkAll"
                                                       style="border: 1px solid #ccc;"/>
                                                <span class="lbl"></span>
                                            </label>
                                        </th>
                                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7" style="width: 380px;">ID</th>
                                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Size name</th>
                                        <th class="text-secondary opacity-7"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${not empty sizes}">
                                        <c:forEach var="item" items="${sizes}">
                                            <tr>
                                                <td class="text-center">
                                                    <label class="pos-rel">
                                                        <input type="checkbox" class="form-check-input checkbox" value="${item.id}"
                                                               style="border: 1px solid #ccc;"/>
                                                        <span class="lbl"></span>
                                                    </label>
                                                </td>
                                                <!-- Id -->
                                                <td>
                                                    <div class="d-flex text-center">
                                                        <p class="text-xs font-weight-bold mx-auto mb-0">${item.id}</p>
                                                    </div>
                                                </td>
                                                <!-- End Id -->
                                                <!-- Category Name -->
                                                <td>
                                                    <div class="d-flex px-2 py-1">
                                                        <div class="d-flex flex-column justify-content-center">
                                                            <p class="text-xs font-weight-bold mx-auto mb-0">${item.name}</p>
                                                        </div>
                                                    </div>
                                                </td>
                                                <!-- Action -->
                                                <td class="align-middle">
                                                    <a class="btn btn-link text-dark px-1 mb-0" data-bs-toggle="modal" href="#updateModal"
                                                       onclick="setIdUpdate(${item.id},'${item.name}')">
                                                        <i class="material-icons text-sm me-1">edit</i>Update</a>
                                                </td>
                                                <!-- End action -->
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file="./common/footer.jsp" %>
        </div>
    </main>
    <%--    Modal update--%>
    <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title font-weight-normal" id="updateModalLabel"></h5>
                    <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form method="POST"  action="<c:url value="/admin/sizes"/> ">
                    <div class="modal-body">
                        <div class="input-group input-group-outline my-3">
                            <label class="form-label">Size Name</label>
                            <input type="text" class="form-control" name="name" id="sizeNameUpdate">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-block btn-light" data-bs-dismiss="modal">Close</button>
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" id="idUpdate">
                        <button type="submit" class="btn bg-gradient-danger">Save</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
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
    <script>
        const setIdUpdate = (id,name) => {
            $("#updateModalLabel").text("Update for "+name);
            $("#idUpdate").val(id);
            $("#sizeNameUpdate").val(name);
        }

        window.addEventListener("DOMContentLoaded",function (){
            $(document).ready(function(){
                //check all
                $("#checkAll").change(function() {
                    $(".checkbox").prop('checked', $(this).prop("checked"));
                });

                $('#btnDelete').on('click', function () {
                    Swal.fire({
                        title: "Delete Size?",
                        text: "Do you want to delete this size?",
                        icon: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#3085d6",
                        cancelButtonColor: "#d33",
                        cancelButtonText: "Cancel",
                        confirmButtonText: "Delete"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            var ids = [];
                            $('input[type="checkbox"].checkbox:checked').each(function() {
                                if ($(this).attr('id') !== 'checkAll') {
                                    ids.push($(this).val()); // Thêm giá trị của checkbox được chọn vào mảng
                                }
                            });
                            if (ids.length === 0)
                                return;
                            console.log(ids)
                            $.ajax({
                                url: '<c:url value="/api/v1/admin/sizes"/>',
                                method: 'DELETE',
                                contentType: "application/json; charset=utf-8",
                                // dataType: "json",
                                data: JSON.stringify(ids),
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
                                        window.location.href = "<c:url value="/admin/sizes"/>";
                                    }, 700);
                                },
                                error: function (error) {
                                    console.log('that bai')
                                    Swal.fire({
                                        icon: "warning",
                                        title: "Fail!",
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
                            })

                        }
                    });
                });
            })
        });
    </script>
</body>

</html>
