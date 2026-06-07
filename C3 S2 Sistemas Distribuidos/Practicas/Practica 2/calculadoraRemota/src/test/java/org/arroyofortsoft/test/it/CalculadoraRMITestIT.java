/**
 * File: CalculadoraRMITestIT.java
 * License: GNU GPL V3.0
 * Authors: Marcelo Fort Muñoz, Víctor Arroyo Marquez
 */

package org.arroyofortsoft.test.it;

import org.arroyofortsoft.api.EnumTipoMedia;
import org.arroyofortsoft.api.IComun;
import org.arroyofortsoft.test.it.servidor.ServidorIT;
import org.junit.jupiter.api.*;

import java.rmi.registry.LocateRegistry;

import static org.junit.jupiter.api.Assertions.*;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class CalculadoraRMITestIT {

    private ServidorIT servidor;
    private IComun stub;
    private static final int PUERTO = 1101;

    @BeforeAll
    void startServer() throws Exception {
        servidor = new ServidorIT();
        servidor.start(PUERTO);

        long start = System.currentTimeMillis();
        long timeout = 3000; // 3 segundos
        while (true) {
            try {
                var registry = LocateRegistry.getRegistry("localhost", PUERTO);
                stub = (IComun) registry.lookup("calc");
                break;
            } catch (Exception e) {
                if (System.currentTimeMillis() - start > timeout) {
                    throw new RuntimeException("Servidor RMI non respondeu a tempo", e);
                }
                Thread.sleep(50);
            }
        }
    }

    @AfterAll
    void stopServer() throws Exception {
        servidor.stop();
    }


    @Test
    void sumar() throws Exception {
        assertEquals(5f, stub.sumar(2, 3), 0.001);
    }


    @Test
    void sumarN() throws Exception {
        assertEquals(10f, stub.sumarN(1, 2, 3, 4), 0.001);
    }


    @Test
    void restar() throws Exception {
        assertEquals(2f, stub.restar(5, 3), 0.001);
    }

    @Test
    void restarNegativo() throws Exception {
        assertEquals(-2f, stub.restar(3, 5), 0.001);
    }


    @Test
    void restarN() throws Exception {
        assertEquals(-8f, stub.restarN(1, 2, 3, 4), 0.001);
    }


    @Test
    void multiplicar() throws Exception {
        assertEquals(6f, stub.multiplicar(2, 3), 0.001);
    }

    @Test
    void multiplicarN() throws Exception {
        assertEquals(24f, stub.multiplicarN(1, 2, 3, 4), 0.001);
    }

    @Test
    void multiplicarNVacio() {
        assertThrows(Exception.class, () -> stub.multiplicarN());
    }

    @Test
    void multiplicarNVNulo() {
        assertThrows(Exception.class, () -> stub.multiplicarN(null));
    }

    @Test
    void multiplicarNNegativo() throws Exception {
        assertEquals(-24f, stub.multiplicarN(-1, 2, 3, 4), 0.001);
    }


    @Test
    void dividir() throws Exception {
        assertEquals(5f, stub.dividir(10, 2), 0.001);
    }

    @Test
    void dividirN() throws Exception {
        assertEquals(2f, stub.dividirN(100, 5, 10), 0.001);
    }

    @Test
    void dividirNVacio() {
        assertThrows(Exception.class, () -> stub.dividirN());
    }

    @Test
    void dividirNVNulo() {
        assertThrows(Exception.class, () -> stub.dividirN(null));
    }

    @Test
    void dividirEntreNegativo() throws Exception {
        assertEquals(-2f, stub.dividirN(100, -5, 10), 0.001);
    }



    @Test
    void raiz() throws Exception {
        assertEquals(3f, stub.raiz(9), 0.001);
    }


    @Test
    void testMediaAritmetica() throws Exception {
        assertEquals(2.5f, stub.media(EnumTipoMedia.ARITMETICA,1, 2, 3, 4), 0.001);
    }

    @Test
    void testMediaGeometrica() throws Exception {
        assertEquals(2.213f, stub.media(EnumTipoMedia.GEOMETRICA,1, 2, 3, 4), 0.001);
    }

    @Test
    void testMediaArmonica() throws Exception {
        assertEquals(1.92f, stub.media(EnumTipoMedia.ARMONICA,1, 2, 3, 4), 0.001);
    }


    @Test
    void dividirEntreCeroFalla() {
        assertThrows(Exception.class, () -> stub.dividir(1, 0));
    }


    @Test
    void raizNegativaFalla() {
        assertThrows(Exception.class, () -> stub.raiz(-4));
    }


    @Test
    void potenciaPositiva() throws Exception {
        assertEquals(8f, stub.potencia(2, 3), 0.001);
    }

    @Test
    void potenciaNegativa() throws Exception {
        assertEquals(0.125f, stub.potencia(2, -3), 0.001);
    }

    @Test
    void potenciaCero() throws Exception {
        assertEquals(1f, stub.potencia(2, 0), 0.001);
    }

}
