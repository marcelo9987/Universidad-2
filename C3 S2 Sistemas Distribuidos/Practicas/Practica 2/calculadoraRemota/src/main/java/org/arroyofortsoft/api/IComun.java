/**
 * File: IComun.java
 * License: GNU GPL V3.0
 * Authors: Marcelo Fort Muñoz, Víctor Arroyo Marquez
 */


package org.arroyofortsoft.api;

import org.arroyofortsoft.excepciones.OperacionIncorrectaException;
import org.arroyofortsoft.excepciones.OperandosIncorrectosException;

import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * Interfaz para la ejecución de métodos remotos
 */
public interface IComun extends Remote {
    /**
     * Método para verificar la conectividad entre el cliente y el servidor.
     *
     * @return true si el servidor está disponible y responde correctamente.
     * @throws RemoteException En caso de error de conectividad.
     */
    boolean ping() throws RemoteException;

    /**
     * Suma dos números.
     *
     * @param numero1 Primer número a sumar.
     * @param numero2 Segundo número a sumar.
     * @return Suma de numero1 y numero2.
     * @throws RemoteException En caso de error de conectividad.
     */
    float sumar(float numero1, float numero2) throws RemoteException;

    /**
     * Suma una cantidad indeterminada de números.
     *
     * @param numeros Números a sumar.
     * @return Suma de todos los números proporcionados.
     * @throws RemoteException               En caso de error de conectividad.
     * @throws OperandosIncorrectosException En caso de que el vector de números sea null o esté vacío.
     * @implNote En caso de haber solo un número, se devuelve ese número.
     */
    float sumarN(float... numeros) throws RemoteException, OperandosIncorrectosException;

    /**
     * Resta dos números.
     *
     * @param numero1 Primer número a restar.
     * @param numero2 Segundo número a restar.
     * @return Resta de numero1 y numero2.
     * @throws RemoteException En caso de error de conectividad.
     */
    float restar(float numero1, float numero2) throws RemoteException;

    /**
     * Resta una cantidad indeterminada de números.
     *
     * @param numeros Números a restar.
     * @return Resta de todos los números proporcionados, restando cada número al resultado de la resta anterior (es decir, numeros[0] - numeros[1] - numeros[2] - ...).
     * @throws RemoteException               En caso de error de conectividad.
     * @throws OperandosIncorrectosException En caso de que el vector de números sea null o esté vacío.
     * @implNote En caso de haber solo un número, se devuelve ese número.
     */
    float restarN(float... numeros) throws RemoteException, OperandosIncorrectosException;

    /**
     * Multiplica dos números.
     *
     * @param numero1 Primer número a multiplicar.
     * @param numero2 Segundo número a multiplicar.
     * @return Multiplicación de numero1 y numero2.
     * @throws RemoteException En caso de error de conectividad.
     */
    float multiplicar(float numero1, float numero2) throws RemoteException;

    /**
     * Multiplica una cantidad indeterminada de números.
     *
     * @param numeros Números a multiplicar.
     * @return Multiplicación de todos los números proporcionados.
     * @throws RemoteException               En caso de error de conectividad.
     * @throws OperandosIncorrectosException En caso de que el vector de números sea null o esté vacío.
     * @implNote En caso de haber solo un número, se devuelve ese número.
     */
    public float multiplicarN(float... numeros) throws RemoteException, OperandosIncorrectosException;

    /**
     * Divide dos números.
     *
     * @param numero1 Primer número a dividir.
     * @param numero2 Segundo número a dividir.
     * @return División de numero1 y numero2.
     * @throws RemoteException              En caso de error de conectividad.
     * @throws OperacionIncorrectaException En caso de intentar dividir entre cero.
     */
    float dividir(float numero1, float numero2) throws RemoteException, OperacionIncorrectaException;

    /**
     * Divide una cantidad indeterminada de números.
     *
     * @param numeros Números a dividir, dividiendo cada número al resultado de la división anterior (es decir, numeros[0] / numeros[1] / numeros[2] / ...).
     * @return División de todos los números proporcionados.
     * @throws RemoteException              En caso de error de conectividad.
     * @throws OperacionIncorrectaException En caso de intentar dividir entre cero.
     * @throws OperandosIncorrectosException En caso de que el vector de números sea null o esté vacío.
     * @implNote En caso de haber solo un número, se devuelve ese número.
     */
    float dividirN(float... numeros) throws RemoteException, OperacionIncorrectaException, OperandosIncorrectosException;

    /**
     * Calcula la raíz cuadrada de un número.
     *
     * @param numero Número del cual se desea calcular la raíz cuadrada.
     * @return Raíz cuadrada del número.
     * @throws RemoteException              En caso de error de conectividad.
     * @throws OperacionIncorrectaException En caso de intentar calcular la raíz cuadrada de un número negativo.
     */
    float raiz(float numero) throws RemoteException, OperacionIncorrectaException;






    /**
     * Eleva un número a una potencia.
     *
     * @param base      Número base que se desea elevar.
     * @param exponente Número al cual se desea elevar la base.
     * @return Resultado de elevar la base al exponente.
     * @throws RemoteException En caso de error de conectividad.
     */
    float potencia(float base, float exponente) throws RemoteException;

    /**
     * Calcula el promedio de una cantidad indeterminada de números.
     *
     * @param tipo    Tipo de media a calcular (aritmética, geométrica o armónica).
     * @param numeros Números de los cuales se desea calcular el promedio.
     * @return Promedio calculado según el tipo especificado.
     * @throws RemoteException               En caso de error de conectividad.
     * @throws OperandosIncorrectosException En caso de que el vector de números sea null o esté vacío.
     */
    float media(EnumTipoMedia tipo, float... numeros) throws RemoteException, OperandosIncorrectosException;

}
