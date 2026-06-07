package com.marceSoft.miniMicroServicio;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class SaludosController
{
    @GetMapping("/api/saludo")
    public Map<String, String> saludo() {
        Map<String, String> response = new HashMap<>();
        response.put("mensaje", "Bienvenido al microservicio!");
        return response;
    }
}
