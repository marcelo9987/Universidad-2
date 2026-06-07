/**
 * File: ServidorIT.java
 * License: GNU GPL V3.0
 * Authors: Marcelo Fort Muñoz, Víctor Arroyo Marquez
 */

package org.arroyofortsoft.test.it.servidor;

import org.arroyofortsoft.api.IComun;
import org.arroyofortsoft.servidor.ImplementacionRemota;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;
import java.util.concurrent.CountDownLatch;

public class ServidorIT {

    private Registry registry;
    private ImplementacionRemota impl;
    private IComun exported;
    private final CountDownLatch latch = new CountDownLatch(1);

    public void start(int puerto) throws Exception {
        impl = new ImplementacionRemota();
        exported = (IComun) UnicastRemoteObject.exportObject(impl, 0);
        registry = LocateRegistry.createRegistry(puerto);
        registry.rebind("calc", exported);

        new Thread(() -> {
            try {
                latch.await();
            } catch (InterruptedException ignored) {
                System.err.println("Servidor interrumpido: " + ignored.getMessage());
            }
        }).start();
    }

    public void stop() throws Exception {
        latch.countDown();
        registry.unbind("calc");
        UnicastRemoteObject.unexportObject(impl, true);
        UnicastRemoteObject.unexportObject(registry, true);
    }
}