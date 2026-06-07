package com.marceSoft.miniMicroServicio.controlador;

import com.marceSoft.miniMicroServicio.modelo.FrankfurterResponse;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@RestController
public class CotizacionEuroDolarController {


    private final WebClient webClient = WebClient.create("https://api.frankfurter.app");

    @GetMapping("/api/eur-usd")
    public Mono<Double> getEurUsd() {

        return webClient.get()
                .uri("/latest?from=EUR&to=USD")
                .retrieve()
                .bodyToMono(FrankfurterResponse.class)
                .map(r -> r.rates.get("USD"));
    }

}
