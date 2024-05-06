package com.shoe.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import org.owasp.encoder.Encode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Service
public class MailService {
    /*
     * Mỗi khi gọi phương thức sendMail, một Runnable được gửi đến ExecutorService
     * để thực thi việc gửi email trên một thread riêng biệt. ExecutorService giúp
     * tạo và quản lý các thread để thực hiện công việc gửi email một cách bất
     * đồng bộ
     */
    private final ExecutorService executorService = Executors.newFixedThreadPool(3); // Số lượng thread tùy chọn

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String username;

    // This method is responsible for sending a One-Time Password (OTP) to a user's email.
    public void sendMailOTP(String to, String opt, String fullName) {
        // The subject of the email.
        String subject = "Your One-Time Password (OTP) for Account Verification";

        // The content of the email is built using a StringBuilder.
        StringBuilder content = new StringBuilder();
        content.append("<p>Dear ").append(Encode.forHtml(fullName)).append(",</p>");
        content.append("<p>Thank you for registering with us! To complete the verification process and ensure the security of ")
                .append("your account, please find your One-Time Password (OTP) below:</p>");
        content.append("<p>OTP: <b>");
        content.append(opt);
        content.append("</b></p>");
        content.append("<p>Please use this OTP to verify your account. It is valid for a single use and will expire shortly. For security reasons, please do not share this OTP with anyone</p>");
        content.append("<p>If you did not attempt to register with us, please disregard this email. However, if you have any concerns or questions, feel free to reach out to our customer support team immediately.</p>");
        content.append("<p>Thank you for choosing us. We look forward to serving you!</p>");

        // The sendMail method is called to send the email.
        sendMail(to, subject, content.toString());
    }

    // This method is responsible for sending an email.
    private void sendMail(String to, String subject, String content) {
        // A new task is submitted to the executor service to send the email asynchronously.
        executorService.submit(() -> {
            try {
                // A new MIME message is created.
                MimeMessage message = mailSender.createMimeMessage();

                // A helper is created to set the properties of the message.
                MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");

                // The sender, recipient, subject, and content of the message are set.
                helper.setFrom(new InternetAddress(username));
                helper.setTo(new InternetAddress(to));
                helper.setSubject(subject);
                helper.setText(content, true);

                // The message is sent.
                mailSender.send(message);

                // A success message is printed to the console.
                System.out.println("Message sent successfully");
            } catch (MessagingException ex) {
                // If an error occurs, the stack trace is printed to the console.
                ex.printStackTrace();
            }
        });
    }


}

