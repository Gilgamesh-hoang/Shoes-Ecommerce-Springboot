package com.shoe.controller.user;

import com.shoe.dto.UserDTO;
import com.shoe.service.UserService;
import com.shoe.validate.Validator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SignupController {
    @Autowired
    private UserService userService;

    @GetMapping("/signup/otp")
    public String otpPage(Model model, @RequestParam(value = "error", required = false) String error
            , @RequestParam(value = "email", required = false) String email) {
        model.addAttribute("error", error);
        model.addAttribute("email", email);
        return "user/otp";
    }

    @PostMapping("/signup/otp")
    public String verify(Model model, @RequestParam(value = "otp", required = true) String otp
            , @RequestParam(value = "email", required = true) String email) {
        if (StringUtils.hasText(otp) && StringUtils.hasText(email)) {
            if (userService.verify(email, otp)) {
                return "redirect:/auth/login?verified=true";
            }
        }
        return "redirect:/signup/otp?error=true&email=" + email;
    }

    @GetMapping("/signup")
    public String signupPage(Model model, @RequestParam(value = "error", required = false) String error) {
        model.addAttribute("error", error);
        model.addAttribute("user", new UserDTO());
        return "user/signup";
    }

    @PostMapping("/signup")
    public String signUp(@ModelAttribute("user") UserDTO userDTO) {
        if (isValid(userDTO)) {
            String email = userService.signup(userDTO);
            if (email != null)
                return "redirect:/signup/otp?email=" + email;
        }
        return "redirect:/signup?error=true";
    }

    private boolean isValid(UserDTO user) {
        if (Validator.containsWhitespace(user.getUserName())) {
            return false;
        }
        if (userService.isUserNameExists(user.getUserName())) {
            return false;
        }

        if (!Validator.isValidEmail(user.getEmail()) || userService.isEmailExists(user.getEmail())) {
            return false;
        }

        if (Validator.isEmpty(user.getFullName()) ||
                Validator.containsWhitespace(user.getPassword()) || !Validator.isValidMinLength(user.getPassword(), 6)) {
            return false;
        }
        if (!user.getPassword().equals(user.getConfirmPassword()))
            return false;
        return true;
    }
}
