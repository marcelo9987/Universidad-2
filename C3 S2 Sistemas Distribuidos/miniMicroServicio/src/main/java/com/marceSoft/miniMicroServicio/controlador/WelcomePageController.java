package com.marceSoft.miniMicroServicio.controlador;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class WelcomePageController {
    @GetMapping("/api")
    public Map<String, String> welcome() {
        Map<String, String> response = new HashMap<>();
        response.put("mensaje", "¡Bienvenido al microservicio!");
        return response;
    }
}
