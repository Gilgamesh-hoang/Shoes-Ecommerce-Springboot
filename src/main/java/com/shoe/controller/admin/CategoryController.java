package com.shoe.controller.admin;

import com.shoe.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {
    @Autowired
    CategoryService categoryService;

    // This method is mapped to the HTTP GET method and the URL "/admin/categories"
    @GetMapping()
    public String dashboard(Model model, @RequestParam(value = "success", required = false) String success) {
        // Retrieve all categories from the category service
        model.addAttribute("categories", categoryService.getAllCategories());
        model.addAttribute("success", success);
        // Return the name of the view that will be used to render the response
        // In this case, the view is "admin/category"
        return "admin/category";
    }

    // This method is mapped to the HTTP POST method and the URL "/admin/categories"
    @PostMapping()
    public String addCategory(
            // The "name" and "code" parameters are required
            @RequestParam(value = "name", required = true) String name,
            @RequestParam(value = "code", required = true) String code,

            // The "id" and "action" parameters are optional
            @RequestParam(value = "id", required = false) String id,
            @RequestParam(value = "action", required = false) String action
    ) {
        // Check if the "name" and "code" parameters have text
        if (StringUtils.hasText(name) && StringUtils.hasText(code)) {
            // If the "action" parameter is "add", add a new category
            if (action.equals("add")) {
                categoryService.addCategory(name, code);
            }
            // If the "action" parameter is "update" and the "id" parameter has text, update the category
            else if (action.equals("update") && StringUtils.hasText(id)) {
                categoryService.updateCategory(Integer.parseInt(id), name, code);
            }
        }
        // Redirect to the "/admin/categories" URL
        return "redirect:/admin/categories?success=true";
    }
}
