package com.shoe.controller.user;

import com.shoe.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/orders")
public class OrderController {
    @Autowired
    OrderService orderService;

    @GetMapping
    public String myOrderPage(Model model) {
        // Retrieve all orders using the order service and add them to the model
        model.addAttribute("orders", orderService.findAll());
        // Return the name of the view to be rendered (user/dash-my-order)
        return "user/dash-my-order";
    }

    @GetMapping("/{id}")
    public String orderDetailPage(Model model, @PathVariable(value = "id", required = true) Integer id) {
        // Retrieve the order with the given ID using the order service and add it to the model
        model.addAttribute("order", orderService.findById(id));
        // Return the name of the view to be rendered (user/dash-manage-order)
        return "user/dash-manage-order";
    }
}
