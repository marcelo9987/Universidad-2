package com.marceSoft.miniMicroServicio.controlador;

import com.marceSoft.miniMicroServicio.DAO.ServicioCotizaciones;
import com.marceSoft.miniMicroServicio.modelo.FrankfurterResponse;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestClient;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class CotizacionEuroDolarController {

    private final ServicioCotizaciones service;

    public CotizacionEuroDolarController(ServicioCotizaciones service) {
        this.service = service;
    }


    @GetMapping("/eur-usd")
    public Map<String, String> getEurUsd(@RequestParam(required = false, defaultValue = "0") int cantidad) {
        if(cantidad==0) {
            return Map.of("cotizacion", String.valueOf(service.getEurUsd()));
        }
        return Map.of("valor_de_cambio", String.valueOf(service.getEurUsd() * cantidad));
    }

}
