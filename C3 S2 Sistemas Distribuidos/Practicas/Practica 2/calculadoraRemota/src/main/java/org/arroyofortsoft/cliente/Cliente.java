/**
 * File: Cliente.java
 * License: GNU GPL V3.0
 * Authors: Marcelo Fort Muñoz, Víctor Arroyo Marquez
 */
package org.arroyofortsoft.cliente;

import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.Scanner;

import org.arroyofortsoft.api.EnumTipoMedia;
import org.arroyofortsoft.api.IComun;
import org.arroyofortsoft.excepciones.OperacionIncorrectaException;
import org.arroyofortsoft.excepciones.OperandosIncorrectosException;

import static java.lang.Float.NaN;
import static java.lang.System.exit;
import static org.arroyofortsoft.cliente.EnumOpciones.*;

public class Cliente {
    private static final String IP = "localhost"; // Puedes cambiar a localhost
    private static final int PUERTO = 1100; //Si cambias aquí el puerto, recuerda cambiarlo en el servidor

    /**
     * Rutina privada para obtener un arreglo de números desde la entrada estándar
     *
     * @return Un vector de números flotantes ingresados por el usuario
     */
    private static float[] _obtenerNumeros(Scanner sc) {
        int cantidad;

        do {
            System.out.println("¿Cuántos números deseas introducir?");
            try {
                cantidad = Integer.parseInt(sc.nextLine());
            } catch (NumberFormatException e) {
                cantidad = 0;
            }
        } while (cantidad <= 0);

        float[] datos = new float[cantidad];
        int i = 0;

        while (i < cantidad) {
            System.out.println("Ingresa un número:");
            try {
                datos[i] = Float.parseFloat(sc.nextLine());
                i++;
            } catch (NumberFormatException e) {
                System.err.println("Entrada inválida, intenta de nuevo.");
            }
        }

        return datos;
    }

    public static void main(String[] args) {

        Registry registry = null;
        try {
            registry = LocateRegistry.getRegistry(IP, PUERTO);
        } catch (RemoteException e) {
            System.err.println("No se ha podido acceder al registro, abortando");
            exit(-1);
        }
        IComun interfaz = null; //Buscar en el registro...
        try {
            interfaz = (IComun) registry.lookup("superCalculadora");
        } catch (RemoteException | NotBoundException e) {
            System.err.println("No se ha podido encontrar la calculadora, abortando");
            exit(-2);
        }

        Scanner sc = new Scanner(System.in);
        float numero1 = NaN;
        float numero2 = NaN;
        float resultado = 0;
        String menu = """
                [SUMA]
                [SUMA_N]
                [RESTA]
                [RESTA_N]
                [MULTIPLICACIÓN]
                [MULTIPLICACIÓN_N]
                [DIVISION]
                [DIVISION_N]
                [RAIZ]
                [MEDIA]
                [SALIR]
                Elige:
                """;
        String menu_media = """
                [Aritmética]
                [Geométrica]
                [Armónica]
                Elige:
                """;

        do {

            numero1 = NaN;
            numero2 = NaN;
            float[] numeros = null;

            System.out.println(menu);

            EnumOpciones opcion;

            try {
                opcion = valueOf(sc.nextLine().toUpperCase().replace("Ó", "O"));
            } catch (IllegalArgumentException e) {
                System.out.println("Opción inválida");
                continue;
            }


            if (opcion == SUMA || opcion == RESTA || opcion == MULTIPLICACION || opcion == DIVISION || opcion == POTENCIA || opcion == RAIZ) {
                do {
                    System.out.println("Ingresa el número 1: ");
                    try {
                        numero1 = Float.parseFloat(sc.nextLine());
                    } catch (NumberFormatException e) {
                        System.err.println("Entrada inválida, por favor ingresa un número.");
                        numero1 = NaN;
                    }
                } while (Float.isNaN(numero1));


                if (opcion == SUMA || opcion == RESTA || opcion == MULTIPLICACION || opcion == DIVISION || opcion == POTENCIA) {
                    do {
                        System.out.println("Ingresa el número 2: ");
                        try {
                            numero2 = Float.parseFloat(sc.nextLine());
                        } catch (NumberFormatException e) {
                            System.err.println("Entrada inválida, por favor ingresa un número.");
                            numero2 = NaN;
                        }
                    } while (Float.isNaN(numero2));
                }
            }
            if (opcion == SUMA_N || opcion == RESTA_N || opcion == MULTIPLICACION_N || opcion == DIVISION_N || opcion == MEDIA) {
                numeros = _obtenerNumeros(sc);
            }


            switch (opcion) {
                case SUMA:
                    try {
                        resultado = interfaz.sumar(numero1, numero2);
                    } catch (RemoteException e) {
                        System.err.println("Detectado error al sumar: " + e.getMessage());
                        continue;
                    }
                    break;
                case SUMA_N:
                    try {
                        resultado = interfaz.sumarN(numeros);
                    } catch (OperandosIncorrectosException | RemoteException e) {
                        System.err.println("Detectado error al sumar: " + e.getMessage());
                        continue;
                    }
                    break;
                case RESTA:
                    try {
                        resultado = interfaz.restar(numero1, numero2);
                    } catch (RemoteException e) {
                        System.err.println("Detectado error al restar: " + e.getMessage());
                        continue;
                    }
                    break;
                case RESTA_N:
                    try {
                        resultado = interfaz.restarN(numeros);
                    } catch (OperandosIncorrectosException | RemoteException e) {
                        System.err.println("Detectado error al restar: " + e.getMessage());
                        continue;
                    }
                    break;
                case MULTIPLICACION:
                    try {
                        resultado = interfaz.multiplicar(numero1, numero2);
                    } catch (RemoteException e) {
                        System.err.println("Detectado error al multiplicar: " + e.getMessage());
                        continue;
                    }
                    break;
                case MULTIPLICACION_N:
                    try {
                        resultado = interfaz.multiplicarN(numeros);
                    } catch (OperandosIncorrectosException | RemoteException e) {
                        System.err.println("Detectado error al multiplicar: " + e.getMessage());
                        continue;
                    }
                    break;
                case DIVISION:
                    try {
                        resultado = interfaz.dividir(numero1, numero2);
                    } catch (OperacionIncorrectaException | RemoteException e) {
                        System.err.println("Detectado error al dividir: " + e.getMessage());
                        continue;
                    }
                    break;
                case DIVISION_N:
                    try {
                        resultado = interfaz.dividirN(numeros);
                    } catch (OperandosIncorrectosException | RemoteException | OperacionIncorrectaException e) {
                        System.err.println("Detectado error al multiplicar: " + e.getMessage());
                        continue;
                    }
                    break;
                case RAIZ:
                    try {
                        resultado = interfaz.raiz(numero1);
                    } catch (OperacionIncorrectaException | RemoteException e) {
                        System.err.println("Detectado error al hacer la raíz: " + e.getMessage());
                        continue;
                    }
                    break;
                case POTENCIA:
                    try {
                        resultado = interfaz.potencia(numero1, numero2);
                    } catch (RemoteException e) {
                        System.err.println("Detectado error al hacer la potencia: " + e.getMessage());
                        continue;
                    }
                    break;
                case MEDIA:
                    System.out.println(menu_media);

                    EnumTipoMedia opcion_media;

                    try {
                        opcion_media = EnumTipoMedia.valueOf(sc
                                .nextLine()
                                .toUpperCase()
                                .replace("É", "E")
                                .replace("Ó", "O"));
                    } catch (IllegalArgumentException e) {
                        System.out.println("Opción inválida");
                        continue;
                    }

                    switch (opcion_media) {
                        case ARITMETICA -> {
                            try {
                                resultado = interfaz.media(EnumTipoMedia.ARITMETICA, numeros);
                            } catch (OperandosIncorrectosException | RemoteException e) {
                                System.err.println("Detectado error al calcular la media: " + e.getMessage());
                                continue;
                            }
                        }
                        case GEOMETRICA -> {
                            try {
                                resultado = interfaz.media(EnumTipoMedia.GEOMETRICA, numeros);
                            } catch (OperandosIncorrectosException | RemoteException e) {
                                System.err.println("Detectado error al calcular la media: " + e.getMessage());
                                continue;
                            }
                        }
                        case ARMONICA -> {
                            try {
                                resultado = interfaz.media(EnumTipoMedia.ARMONICA, numeros);
                            } catch (OperandosIncorrectosException | RemoteException e) {
                                System.err.println("Detectado error al calcular la media: " + e.getMessage());
                                continue;
                            }
                        }

                    }

                    break;
                case SALIR:
                    exit(0);
            }

            System.out.println("Resultado => " + resultado);
            System.out.println("Presiona ENTER para continuar");
            sc.nextLine();

        } while (true);
    }
}
