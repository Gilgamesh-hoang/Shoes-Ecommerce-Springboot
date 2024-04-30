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

    <!-- Cart-Page -->
    <div class="page-cart u-s-p-t-80">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <!-- Products-List-Wrapper -->
                    <div class="table-wrapper u-s-m-b-60">
                        <table>
                            <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${items}" var="item">
                                    <tr>
                                        <td>
                                            <div class="cart-anchor-image">
                                                <a href="<c:url value="/products/${item.productSize.product.id}"/> ">
                                                    <img style="width: 70px;height: 70px" src="${item.productSize.product.thumbnail}" alt="Product">
                                                    <h6 style="font-size:15px;" >${item.productSize.product.name}</h6>
                                                    <span style="font-size: 15px;">- Size:
                                                        <span>${item.productSize.size.name}</span></span>
                                                </a>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="cart-price">
                                                 <fmt:formatNumber type="number" pattern="$#,##0.0"
                                                      value="${item.productSize.product.price * (1 - item.productSize.product.discount) * item.quantity}" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="cart-quantity">
                                                <div class="quantity">
                                                    <input type="text" data-id="${item.id}" data-max="${item.productSize.product.quantity}"
                                                           class="quantity-text-field " value="${item.quantity}">
                                                    <a class="plus-a" data-max="${item.productSize.product.quantity}">&#43;</a>
                                                    <a class="minus-a" data-min="1">&#45;</a>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="action-wrapper">
                                                <button class="button button-outline-secondary fas fa-sync btnUpdate"
                                                        data-id="${item.id}" ></button>
                                                <button class="button button-outline-secondary fas fa-trash btnDelete"
                                                        data-id="${item.id}"></button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <!-- Products-List-Wrapper /- -->
                    <!-- Coupon -->
                    <div class="coupon-continue-checkout u-s-m-b-60">
                        <div class="button-area">
                            <a href="<c:url value="/"/> " class="continue">Continue Shopping</a>
                            <a href="<c:url value="/checkout"/>" class="checkout">Proceed to Checkout</a>
                        </div>
                    </div>
                    <!-- Coupon /- -->
                    <!-- Billing -->
                    <div class="calculation u-s-m-b-60">
                        <div class="table-wrapper-2">
                            <table>
                                <thead>
                                <tr>
                                    <th colspan="2">Cart Totals</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>
                                        <h3 class="calc-h3 u-s-m-b-0">Subtotal</h3>
                                    </td>
                                    <td>
                                        <span class="calc-text">
                                            <fmt:formatNumber type="number" pattern="$#,##0.0" value="${totalPrice}" />
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h3 class="calc-h3 u-s-m-b-0" id="tax-heading">Tax</h3>
                                        <span> (estimated for your country)</span>
                                    </td>
                                    <td>
                                        <span class="calc-text">$0.00</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h3 class="calc-h3 u-s-m-b-0">Total</h3>
                                    </td>
                                    <td>
                                        <span class="calc-text">
                                            <fmt:formatNumber type="number" pattern="$#,##0.0" value="${totalPrice}" />
                                        </span>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- Billing /- -->
                </div>
            </div>
        </div>
    </div>
    <!-- Cart-Page /- -->

    <!-- Footer -->
    <%@ include file="./common/footer.jsp" %>
    <!-- Footer /- -->

</div>

<!-- app /- -->
<script type="text/javascript" src="/user/js/jquery.min.js"></script>
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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    $(document).ready(function () {

        // Attach a click event handler to the elements with class 'btnDelete'
        $('.btnDelete').on('click', function () {
            // Retrieve the 'id' data attribute of the current element
            const cartItemId = $(this).data('id');

            // Make an AJAX request to the server
            $.ajax({
                url: '<c:url value="/api/v1/cart/items"/>',
                type: 'DELETE',
                contentType: 'application/json',
                data: JSON.stringify(cartItemId),
                success: function () {
                    showSuccessMessage();
                },
                error: function () {
                    showFailMessage();
                }
            });
        });

        // Attach a click event handler to the elements with class 'btnUpdate'
        $('.btnUpdate').on('click', function () {
            // Retrieve the 'id' data attribute of the current element
            let id = $(this).data('id');

            // Retrieve the current value of the element with the corresponding 'id' data attribute
            let quantity = $('.quantity-text-field[data-id="'+id+'"]').val();

            // Make an AJAX request to the server
            $.ajax({
                url: '<c:url value="/api/v1/cart/items"/>',
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify({
                    cartItemId: id,
                    quantity: quantity
                }),
                success: function () {
                    showSuccessMessage();
                },
                error: function () {
                    showFailMessage();
                }
            });
        });

        function showSuccessMessage(timeout = true) {
            // Display a success message using Swal.fire
            Swal.fire({
                icon: "success",
                title: "Success",
                toast: true,
                position: "top-end",
                showConfirmButton: false,
                timer: 500,
                timerProgressBar: true,
                didOpen: (toast) => {
                    toast.onmouseenter = Swal.stopTimer;
                    toast.onmouseleave = Swal.resumeTimer;
                }
            });
            if (timeout) {
                setTimeout(function () {
                    location.reload();
                }, 500);
            }
        }

        function showFailMessage() {
            // Display a warning message using Swal.fire
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

        // Attach a change event handler to the elements with class 'quantity-text-field'
        $('.quantity-text-field').change(function () {
            // Retrieve the 'id' data attribute of the current element
            let id = $(this).data('id');

            // Retrieve the 'max' data attribute of the current element and convert it to an integer
            const maxQuantity = parseInt($(this).data('max'));

            // Retrieve the current value of the element and convert it to an integer
            const quantity = parseInt($(this).val());

            // If the quantity is not a number or less than 1
            if (isNaN(quantity) || quantity < 1) {
                // Set the value of the element with the corresponding 'id' data attribute to 1
                $('.quantity-text-field[data-id="'+id+'"]').val(1);
            }
            // If the quantity is greater than the maximum quantity
            else if (quantity > maxQuantity) {
                // Set the value of the element with the corresponding 'id' data attribute to the maximum quantity
                $('.quantity-text-field[data-id="'+id+'"]').val(maxQuantity);
            }
        });
    });
</script>
</body>
</html>
