package com.shoe.controller.user;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/auth")
public class AuthController {

    // This method handles the GET request for the "/auth/login" endpoint.
    @GetMapping("/login")
    public String loginPage(
            // The Model object is used to pass attributes to the view.
            Model model,
            // The "verified" parameter indicates whether the user has been verified. It is not required.
            @RequestParam(value = "verified", required = false) String verified,
            // The "error" parameter indicates whether there was an error during the login process. It is not required.
            @RequestParam(value = "error", required = false) String error
    ) {
        // Add the "verified" parameter to the model.
        model.addAttribute("verified", verified);
        // Add the "error" parameter to the model.
        model.addAttribute("error", error);
        // Return the name of the view to be rendered.
        return "user/login";
    }

    // This method handles the GET request for the "/auth/logout" endpoint.
    @GetMapping("/logout")
    public void logout(HttpServletRequest request, HttpServletResponse response) {
        // Get the Authentication object from the SecurityContext.
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // If the user is authenticated,
        if (authentication != null) {
            // Log out the user.
            new SecurityContextLogoutHandler().logout(request, response, authentication);
        }
    }
}
