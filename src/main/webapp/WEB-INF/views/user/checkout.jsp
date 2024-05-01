<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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

    <!-- Checkout-Page -->
    <div class="page-checkout u-s-p-t-80">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12">
                    <form:form role="form" modelAttribute="order" id="checkout-form">
                        <div class="row">
                            <!-- Billing-&-Shipping-Details -->
                            <div class="col-lg-6">
                                <h4 class="section-h4">Billing Details</h4>
                                <!-- Form-Fields -->
                                <div class="u-s-m-b-13">
                                    <label for="fullName">Full Name
                                        <span class="astk">*</span>
                                    </label>
                                    <form:input type="text" id="fullName" class="text-field" path="fullName" value=""
                                                required="required"/>
                                </div>
                                <div class="street-address u-s-m-b-13">
                                    <label for="req-st-address">Street Address
                                        <span class="astk">*</span>
                                    </label>
                                    <form:input type="text" path="address" id="req-st-address" class="text-field"
                                                placeholder="House name and street name" required="required"/>
                                </div>
                                <div class="group-inline u-s-m-b-13">
                                    <div class="group-1 u-s-p-r-16">
                                        <label for="email">Email address
                                            <span class="astk">*</span>
                                        </label>
                                        <form:input type="email" id="email" path="email" class="text-field"
                                                    required="required"/>
                                    </div>
                                    <div class="group-2">
                                        <label for="phone">Phone
                                            <span class="astk">*</span>
                                        </label>
                                        <form:input type="text" path="phoneNumber" id="phone" class="text-field"
                                                    required="required"/>
                                    </div>
                                </div>
                                <h4 class="section-h4">Shipping Details</h4>
                                <div>
                                    <label for="order-notes">Order Notes</label>
                                    <form:textarea path="note" class="text-area" id="order-notes"
                                                   placeholder="Notes about your order, e.g. special notes for delivery."/>
                                </div>
                            </div>
                            <!-- Billing-&-Shipping-Details /- -->
                            <!-- Checkout -->
                            <div class="col-lg-6">
                                <h4 class="section-h4">Your Order</h4>
                                <div class="order-table">
                                    <table class="u-s-m-b-13">
                                        <thead>
                                        <tr>
                                            <th>Product</th>
                                            <th>Total</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${items}" var="item">
                                            <tr>
                                                <td>
                                                    <h6 class="order-h6">${item.productSize.product.name}</h6>
                                                    <span class="order-h6">(Size:
                                                        <span>${item.productSize.size.name}</span>)</span>
                                                    <span class="order-span-quantity">x ${item.quantity}</span>
                                                </td>
                                                <td>
                                                    <h6 class="order-h6">
                                                        <fmt:formatNumber type="number" pattern="$#,##0.0"
                                                                          value="${item.productSize.product.price * (1 - item.productSize.product.discount) * item.quantity}"/>
                                                    </h6>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <tr>
                                            <td>
                                                <h3 class="order-h3">Subtotal</h3>
                                            </td>
                                            <td>
                                                <h3 class="order-h3">
                                                    <fmt:formatNumber type="number" pattern="$#,##0.0"
                                                                      value="${totalPrice}"/>
                                                </h3>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <h3 class="order-h3">Shipping</h3>
                                            </td>
                                            <td>
                                                <h3 class="order-h3">$0.00</h3>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <h3 class="order-h3">Total</h3>
                                            </td>
                                            <td>
                                                <h3 class="order-h3"><fmt:formatNumber type="number" pattern="$#,##0.0"
                                                                                       value="${totalPrice}"/></h3>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <div class="u-s-m-b-13">
                                        <form:radiobutton path="paymentMethod" value="COD" class="radio-box"
                                                          id="cash-on-delivery" checked="checked"/>
                                        <label class="label-text" for="cash-on-delivery">Cash on Delivery</label>
                                    </div>
                                    <div class="u-s-m-b-13">
                                        <form:radiobutton path="paymentMethod" value="VNPAY" class="radio-box"
                                                          id="vnpay"/>
                                        <label class="label-text" for="vnpay">VNPAY</label>
                                    </div>

                                    <button type="submit" class="button button-outline-secondary">Place Order</button>
                                </div>
                            </div>
                            <!-- Checkout /- -->
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
    <!-- Checkout-Page /- -->

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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    $(document).ready(function () {
        // Function to convert form data to JSON
        function formToJson(formElement) {
            // Create a new FormData object from the form element
            let formData = new FormData(formElement);
            // Initialize an empty object to hold the form data
            let jsonObject = {};

            // Iterate over each entry in the FormData object
            for (const [key, value]  of formData.entries()) {
                // Add the entry to the jsonObject
                jsonObject[key] = value;
            }

            // Convert the jsonObject to a JSON string and return it
            return JSON.stringify(jsonObject);
        }

        // Event handler for the form submit event
        $('#checkout-form').on('submit', async function (event) {
            // Prevent the form from submitting normally
            event.preventDefault();
            // Convert the form data to JSON
            var formData = formToJson(this);
            // Check if the 'vnpay' radio button is selected
            var isVnPaySelected = $('#vnpay').is(':checked');
            // Set the paymentUrl based on whether 'vnpay' is selected
            var paymentUrl = isVnPaySelected ? '<c:url value="/api/v1/vnpay-payment"/>' : '<c:url value="/api/v1/checkout"/>';

            // Configure the AJAX request
            var ajaxConfig = {
                type: 'POST', // HTTP method
                url: paymentUrl, // URL to send the request to
                contentType: 'application/json', // Content type of the request
                data: formData, // Data to send in the request
            };

            // Send the AJAX request
            $.ajax(ajaxConfig)
                .then(function(response) {
                    // If 'vnpay' is selected, handle the payment response
                    if (isVnPaySelected) {
                        handlePaymentResponse(response);
                    } else {
                        // Otherwise, show a success message and redirect to the cart page
                        handlePaymentMessage("success", "Checkout Success", '<c:url value="/cart"/>');
                    }
                    // Log the successful response
                    console.log("Request successful:", response);
                })
                .catch(function(error) {
                    // If the request fails, show a warning message
                    handlePaymentMessage("warning", "Checkout Failed!", null);
                    // Log the error
                    console.error("Request failed:", error);
                });
        });

        function handlePaymentResponse(response) {
            const resp = JSON.parse(response);
            if (resp.code === "00") {
                window.location.href = resp.data;
            } else {
                handlePaymentMessage("warning", "Checkout Failed!", null);
            }
        }

        function handlePaymentMessage(icon, message, url) {
            Swal.fire({
                icon: icon,
                title: message,
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

            if (url !== null && icon === "success") {
                setTimeout(function () {
                    window.location.href = url;
                }, 700);
            }
        }
    });
</script>
</body>

</html>
