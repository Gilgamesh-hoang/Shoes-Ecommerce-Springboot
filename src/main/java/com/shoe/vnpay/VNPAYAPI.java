package com.shoe.vnpay;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.shoe.dto.OrderDTO;
import com.shoe.service.CartDetailService;
import com.shoe.service.OrderService;
import com.shoe.util.TripleDESEncoder;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
@RequestMapping("/api/v1/vnpay-payment")
public class VNPAYAPI {
    @Autowired
    CartDetailService cartDetailService;
    @Autowired
    OrderService orderService;

    @PostMapping
    public ResponseEntity<String> checkoutHandle(@RequestBody OrderDTO orderDTO, HttpServletRequest request) {
        // Save the order and get the saved order
        OrderDTO order = orderService.saveOrderNotPayment(orderDTO);
        // Encrypt the order ID
        String encryptId = TripleDESEncoder.encrypt(String.valueOf(order.getId()));
        // Calculate the total price in VND (multiplied by 100 to convert to cents and by 24000 to convert to VND)
        long amount = ((long) cartDetailService.getTotalPrice()) * 100 * 24000;

        // Define VNPAY parameters
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "other";

        // Generate a random transaction reference number
        String vnp_TxnRef = ConfigVNPAY.getRandomNumber(8);
        // Get the client's IP address
        String vnp_IpAddr = ConfigVNPAY.getIpAddress(request);
        // Get the terminal code from the VNPAY configuration
        String vnp_TmnCode = ConfigVNPAY.vnp_TmnCode;

        // Initialize a map to hold the VNPAY parameters
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_BankCode", "");
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", ConfigVNPAY.vnp_ReturnUrl + "?id=" + encryptId);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        // Get the current date and time in the GMT+7 timezone
        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        // Add 15 minutes to the current time to get the expiry date
        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        // Sort the VNPAY parameters by key
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = vnp_Params.get(fieldName);
            if ((fieldValue != null) && (!fieldValue.isEmpty())) {
                // Build the hash data and query string
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        // Generate the secure hash
        String queryUrl = query.toString();
        String vnp_SecureHash = ConfigVNPAY.hmacSHA512(ConfigVNPAY.secretKey, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        // Build the payment URL
        String paymentUrl = ConfigVNPAY.vnp_PayUrl + "?" + queryUrl;
        com.google.gson.JsonObject job = new JsonObject();
        System.out.println(paymentUrl);
        // Build the response JSON object
        job.addProperty("code", "00");
        job.addProperty("message", "success");
        job.addProperty("data", paymentUrl);
        Gson gson = new Gson();
        // Return the response as a JSON string
        return ResponseEntity.ok(gson.toJson(job));
    }
}
