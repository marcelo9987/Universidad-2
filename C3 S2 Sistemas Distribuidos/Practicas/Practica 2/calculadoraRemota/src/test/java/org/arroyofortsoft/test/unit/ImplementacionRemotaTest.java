/**
 * File: ImplementacionRemotaTest.java
 * License: GNU GPL V3.0
 * Authors: Marcelo Fort Muñoz, Víctor Arroyo Marquez
 */

package org.arroyofortsoft.test.unit;

import org.arroyofortsoft.api.EnumTipoMedia;
import org.arroyofortsoft.excepciones.OperacionIncorrectaException;
import org.arroyofortsoft.excepciones.OperandosIncorrectosException;
import org.arroyofortsoft.servidor.ImplementacionRemota;
import org.junit.jupiter.api.Test;

import java.rmi.RemoteException;

import static org.junit.jupiter.api.Assertions.*;

class ImplementacionRemotaTest {


    @Test
    void pingTest() throws RemoteException {
        var impl = new ImplementacionRemota();
        assertTrue(impl.ping());
    }


    @Test
    void suma() throws RemoteException {
        var impl = new ImplementacionRemota();
        assertEquals(5f, impl.sumar(2, 3), 0.001);
    }


    @Test
    void sumaN() throws RemoteException, OperandosIncorrectosException {
        var impl = new ImplementacionRemota();
        assertEquals(10f, impl.sumarN(1, 2, 3, 4), 0.001);
    }

    @Test
    void sumaNVNulo() {
        var impl = new ImplementacionRemota();
        assertThrows(Exception.class, () -> impl.sumarN(null));
    }

    @Test
    void sumaNVVacio() {
        var impl = new ImplementacionRemota();
        assertThrows(Exception.class, impl::sumarN);
    }

    @Test
    void sumaNUno() throws RemoteException, OperandosIncorrectosException {
        var impl = new ImplementacionRemota();
        assertEquals(5f, impl.sumarN(5), 0.001);
    }


    @Test
    void resta() throws RemoteException {
        var impl = new ImplementacionRemota();
        assertEquals(1f, impl.restar(3, 2), 0.001);
    }


    @Test
    void restaN() throws RemoteException, OperandosIncorrectosException {
        var impl = new ImplementacionRemota();
        assertEquals(-8f, impl.restarN(1, 2, 3, 4), 0.001);
    }

    @Test
    void restaNVNulo() {
        var impl = new ImplementacionRemota();
        assertThrows(Exception.class, () -> impl.restarN(null));
    }

    @Test
    void restaNVVacio() {
        var impl = new ImplementacionRemota();
        assertThrows(Exception.class, impl::restarN);
    }

    @Test
    void restaNUno() throws RemoteException, OperandosIncorrectosException {
        var impl = new ImplementacionRemota();
        assertEquals(5f, impl.restarN(5), 0.001);
    }


    @Test
    void multiplicacion() throws RemoteException {
        var impl = new ImplementacionRemota();
        assertEquals(6f, impl.multiplicar(2, 3), 0.001);
    }


    @Test
    void multiplicacionN() throws RemoteException, OperandosIncorrectosException {
        var impl = new ImplementacionRemota();
        assertEquals(24f, impl.multiplicarN(1, 2, 3, 4), 0.001);
    }

    @Test
    void multiplicacionNVNulo() {
        var impl = new ImplementacionRemota();
        assertThrows(Exception.class, () -> impl.multiplicarN(null));
    }

    @Test
    void multiplicacionNVVacio() {
        var impl = new ImplementacionRemota();
        assertThrows(Exception.class, impl::multiplicarN);
    }

    @Test
    void multiplicacionNNegativo() throws RemoteException, OperandosIncorrectosException {
        var impl = new ImplementacionRemota();
        assertEquals(-24f, impl.multiplicarN(-1, 2, 3, 4), 0.001);
    }

    @Test
    void multiplicacionNNegativo2() throws RemoteException, OperandosIncorrectosException {
        var impl = new ImplementacionRemota();
        assertEquals(-24f, impl.multiplicarN(1, -2, 3, 4), 0.001);
    }

    @Test
    void multiplicacionNUnico() throws RemoteException, OperandosIncorrectosException {
        var impl = new ImplementacionRemota();
        assertEquals(5f, impl.multiplicarN(5), 0.001);
    }

    @Test
    void multiplicacionNCero() throws RemoteException, OperandosIncorrectosException {
        var impl = new ImplementacionRemota();
        assertEquals(0f, impl.multiplicarN(1, 2, 0, 4), 0.001);
    }


    @Test
    void division() throws RemoteException, OperacionIncorrectaException {
        var impl = new ImplementacionRemota();
        assertEquals(2f, impl.dividir(6, 3), 0.001);
    }

    @Test
    void dividirEntreCeroFalla() {
        var impl = new ImplementacionRemota();
        assertThrows(Exception.class, () -> impl.dividir(1, 0));
    }

    @Test
    void dividirN() throws RemoteException, OperacionIncorrectaException, OperandosIncorrectosException {
        var impl = new ImplementacionRemota();
        assertEquals(2f, impl.dividirN(100, 5, 10), 0.001);
    }

    @Test
    void dividirNVNulo() {
        var impl = new ImplementacionRemota();
        assertThrows(Exception.class, () -> impl.dividirN(null));
    }

    @Test
    void dividirNVVacio() {
        var impl = new ImplementacionRemota();
        assertThrows(Exception.class, impl::dividirN);
    }

    @Test
    void dividirEntreNegativo() throws RemoteException, OperacionIncorrectaException, OperandosIncorrectosException {
        var impl = new ImplementacionRemota();
        assertEquals(-2f, impl.dividirN(100, -5, 10), 0.001);
    }

    @Test
    void dividirNCero() {
        var impl = new ImplementacionRemota();
        assertThrows(Exception.class, ()->impl.dividirN(1,0,4));
        assertThrows(Exception.class, ()->impl.dividirN(1,0,4));
    }


    @Test
    void raizCuadrada() throws RemoteException, OperacionIncorrectaException {
        var impl = new ImplementacionRemota();
        assertEquals(3f, impl.raiz(9), 0.001);
    }

    @Test
    void raizNegativaFalla() {
        var impl = new ImplementacionRemota();
        assertThrows(Exception.class, () -> impl.raiz(-4));
    }


    @Test
    void potenciaPositiva() throws RemoteException {
        var impl = new ImplementacionRemota();
        assertEquals(8f, impl.potencia(2, 3), 0.001);
    }

    @Test
    void potenciaNegativa() throws RemoteException {
        var impl = new ImplementacionRemota();
        assertEquals(0.125f, impl.potencia(2, -3), 0.001);
    }

    @Test
    void potenciaCero() throws RemoteException {
        var impl = new ImplementacionRemota();
        assertEquals(1f, impl.potencia(2, 0), 0.001);
    }

    @Test
    void testMediaAritmetica() throws Exception {
        var impl = new ImplementacionRemota();
        assertEquals(2.5f, impl.media(EnumTipoMedia.ARITMETICA,1, 2, 3, 4), 0.001);
    }

    @Test
    void testMediaGeometrica() throws Exception {
        var impl = new ImplementacionRemota();
        assertEquals(2.213f, impl.media(EnumTipoMedia.GEOMETRICA,1, 2, 3, 4), 0.001);
    }

    @Test
    void testMediaArmonica() throws Exception {
        var impl = new ImplementacionRemota();
        assertEquals(1.92f, impl.media(EnumTipoMedia.ARMONICA,1, 2, 3, 4), 0.001);
    }

    @Test
    void mediaOperandosNulos() {
        var impl = new ImplementacionRemota();
        assertThrows(Exception.class, () -> impl.media(EnumTipoMedia.ARITMETICA, null));
    }

    @Test
    void mediaOperandosVacios() {
        var impl = new ImplementacionRemota();
        assertThrows(Exception.class, () -> impl.media(EnumTipoMedia.ARITMETICA));
    }

    @Test
    void mediaArmonicaOperandoCero(){
        var impl = new ImplementacionRemota();
        assertThrows(Exception.class, () -> impl.media(EnumTipoMedia.ARMONICA,1, 2, 0, 4));
    }


}
