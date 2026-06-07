/**
 * File: ImplementacionRemota.java
 * License: GNU GPL V3.0
 * Authors: Marcelo Fort Muñoz, Víctor Arroyo Marquez
 */
package org.arroyofortsoft.servidor;


import org.arroyofortsoft.api.EnumTipoMedia;
import org.arroyofortsoft.api.IComun;
import org.arroyofortsoft.excepciones.OperacionIncorrectaException;
import org.arroyofortsoft.excepciones.OperandosIncorrectosException;

import java.rmi.RemoteException;

public class ImplementacionRemota implements IComun {

    /**
     * @see IComun#ping()
     */
    @Override
    public boolean ping() throws RemoteException {
        return true;
    }


    /**
     * @see IComun#sumar
     */
    @Override
    public float sumar(float numero1, float numero2) throws RemoteException {
        return numero1 + numero2;
    }


    /**
     * @see IComun#restar
     */
    @Override
    public float restar(float numero1, float numero2) throws RemoteException {
        return numero1 - numero2;
    }


    /**
     * @see IComun#multiplicar
     */
    @Override
    public float multiplicar(float numero1, float numero2) throws RemoteException {
        return numero1 * numero2;
    }


    @Override
    public float multiplicarN(float... numeros) throws RemoteException, OperandosIncorrectosException {
        if (numeros == null || numeros.length == 0) {
            throw new OperandosIncorrectosException("numeros no puede ser null o vacío");
        }
        float resultado = 1;
        for (float n : numeros) resultado *= n;
        return resultado;
    }


    /**
     * @see IComun#dividir
     */
    @Override
    public float dividir(float numero1, float numero2) throws RemoteException, OperacionIncorrectaException {
        if (numero2 == 0) {
            throw new OperacionIncorrectaException("No se puede dividir entre cero");
        }
        return numero1 / numero2;
    }


    /**
     * @see IComun#dividirN
     */
    public float dividirN(float... numeros) throws RemoteException, OperacionIncorrectaException, OperandosIncorrectosException {
        if (numeros == null || numeros.length == 0) {
            throw new OperandosIncorrectosException("numeros no puede ser null o vacío");
        }
        float resultado = numeros[0];
        for (int i = 1; i < numeros.length; i++) {
            if (numeros[i] == 0) {
                throw new OperacionIncorrectaException("No se puede dividir entre cero");
            }
            resultado /= numeros[i];
        }
        return resultado;
    }


    /**
     * @see IComun#raiz
     */
    @Override
    public float raiz(float numero) throws RemoteException, OperacionIncorrectaException {
        if (numero < 0) {
            throw new OperacionIncorrectaException("No se puede calcular la raíz de un número negativo");
        }
        return (float) Math.sqrt(numero);
    }


    /**
     * @see IComun#sumarN
     */
    @Override
    public float sumarN(float... numeros) throws RemoteException, OperandosIncorrectosException {
        if (numeros == null || numeros.length == 0) {
            throw new OperandosIncorrectosException("numeros no puede ser null");
        }

        if (numeros.length == 1) {
            return numeros[0];
        }

        float resultado = 0;
        for (float numeroEspecifico : numeros) {
            resultado += numeroEspecifico;
        }
        return resultado;
    }


    /**
     * @see IComun#restarN
     */
    @Override
    public float restarN(float... numeros) throws RemoteException, OperandosIncorrectosException {
        if (numeros == null || numeros.length == 0) {
            throw new OperandosIncorrectosException("numeros no puede ser null");
        }

        if (numeros.length == 1) {
            return numeros[0];
        }

        float resultado = numeros[0];
        for (int i = 1; i < numeros.length; i++) {
            resultado -= numeros[i];
        }
        return resultado;
    }

    /**
     * @see IComun#potencia
     */
    @Override
    public float potencia(float base, float exponente) throws RemoteException {
        return (float) Math.pow(base, exponente);
    }

    /**
     *  @see IComun#media
     */
    @Override
    public float media(EnumTipoMedia tipo, float... numeros) throws RemoteException, OperandosIncorrectosException {
        if (numeros == null || numeros.length == 0) {
            throw new OperandosIncorrectosException("numeros no puede ser null o vacío");
        }

        switch (tipo) {
            case ARITMETICA:
                return sumarN(numeros) / numeros.length;
            case GEOMETRICA:
                float producto = multiplicarN(numeros);
                return (float) Math.pow(producto, 1.0 / numeros.length);
            case ARMONICA:
                float sumaInversos = 0;
                for (float n : numeros) {
                    if (n == 0) {
                        throw new OperandosIncorrectosException("No se puede calcular la media armónica con un número igual a cero");
                    }
                    sumaInversos += 1 / n;
                }
                return numeros.length / sumaInversos;
        }
        return 0;
    }
}
