package com.shoe.controller.admin;

import com.shoe.dto.SizeDTO;
import com.shoe.service.SizeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/admin/sizes")
public class SizeController {
    @Autowired
    SizeService sizeService;

    // This method is mapped to the HTTP GET method and the URL "/admin/sizes"
    @GetMapping()
    public String dashboard(Model model, @RequestParam(value = "success", required = false) String success){
        // Retrieve all sizes from the size service
        List<SizeDTO> allSizes = sizeService.getAllSizes();

        // Add the list of sizes to the model that will be used by the view
        model.addAttribute("sizes", allSizes);
        model.addAttribute("success", success);
        // Return the name of the view that will be used to render the response
        // In this case, the view is "admin/size"
        return "admin/size";
    }

    // This method is mapped to the HTTP POST method and the URL "/admin/sizes"
    @PostMapping()
    public String addSize(
            // The "name" parameter is required
            @RequestParam(value = "name", required = true) String name,

            // The "id" parameter is optional
            @RequestParam(value = "id", required = false) String id,

            // The "action" parameter is optional
            @RequestParam(value = "action", required = false) String action
    ) {
        // Check if the "name" parameter has text
        if (StringUtils.hasText(name)) {
            // If the "action" parameter is "add", add a new size
            if (action.equals("add")) {
                sizeService.addSize(name);
            }
            // If the "action" parameter is "update" and the "id" parameter has text, update the size
            else if (action.equals("update") && StringUtils.hasText(id)) {
                sizeService.updateSize(Integer.parseInt(id), name);
            }
        }

        // Redirect to the "/admin/sizes" URL
        return "redirect:/admin/sizes?success=true";
    }
}
