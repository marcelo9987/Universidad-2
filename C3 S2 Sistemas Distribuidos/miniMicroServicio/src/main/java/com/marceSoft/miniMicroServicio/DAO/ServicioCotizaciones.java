package com.marceSoft.miniMicroServicio.DAO;

import com.marceSoft.miniMicroServicio.modelo.FrankfurterResponse;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;

@Service
public class ServicioCotizaciones
{
    private RestClient client;

    public ServicioCotizaciones() {
        this.client  = RestClient.builder()
                .baseUrl("https://api.frankfurter.dev/v1")
                .build();
    }

    public Double getEurUsd() {

        FrankfurterResponse response = client.get()
                .uri("/latest?from=EUR&to=USD")
                .retrieve()
                .body(FrankfurterResponse.class);

        return response.rates.get("USD");
    }
}
