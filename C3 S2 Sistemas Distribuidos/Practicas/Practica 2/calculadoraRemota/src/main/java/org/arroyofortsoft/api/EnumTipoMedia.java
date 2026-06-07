/**
 * File: ImplementacionRemota.java
 * License: GNU GPL V3.0
 * Authors: Marcelo Fort Muñoz, Víctor Arroyo Marquez
 */
package org.arroyofortsoft.api;

/**
 * Enum para representar los tipos de promedios disponibles en la aplicación.
 * Cada tipo de promedio tiene una descripción asociada para facilitar su identificación.
 */
public enum EnumTipoMedia
{

    ARITMETICA("Aritmética"),
    GEOMETRICA("Geométrica"),
    ARMONICA("Armónica");

    private final String descripcion;

    EnumTipoMedia(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getDescripcion() {
        return descripcion;
    }
}
