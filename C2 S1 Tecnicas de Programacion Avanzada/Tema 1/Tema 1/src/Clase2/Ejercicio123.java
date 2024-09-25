package Clase2;

import java.util.ArrayList;
import java.util.Scanner;

public class Ejercicio123 {

    ArrayList<Integer> numeros;

    String palabra = null;

    Ejercicio123(){
        numeros = new ArrayList<>();
    }

    private void agregarNumero(int numero){
        numeros.add(numero);
    }

    public void ej1() {
        obtenerNumeros();
        enumerarPorComas();
    }

    public void ej2() {
        obtenerNumeros();
        enumerarPorComasV2();
    }

    public void ej3() {
        obtenerPalabra();
        imprimirPalabra();
    }

    private void imprimirPalabra() {
        // Imprimir la palabra al revés
        for (int i = palabra.length()-1; i >= 0; i--) {
            System.out.print(palabra.charAt(i));
        }
        System.out.println();
        // Estadisticas de la palabra
        System.out.println("Longitud: " + palabra.length());
        System.out.println("Vocales: " + contarVocales());
        System.out.println("Consonantes: " + contarConsonantes());

        // carente de vocales
        // usando regex le quitamos las vocales
        System.out.println(palabra.replaceAll("[aeiouAEIOU]", ""));

    }

    private byte contarVocales() {

        if(this.palabra == null){
            System.err.println("No se ha ingresado una palabra");
            return 0;
        }

        byte vocales = 0;
        for(int letras = 0; letras < this.palabra.length(); letras++){
            if(this.palabra.charAt(letras) == 'a' || this.palabra.charAt(letras) == 'e' || this.palabra.charAt(letras) == 'i' || this.palabra.charAt(letras) == 'o' || this.palabra.charAt(letras) == 'u'){
                vocales++;
            }
        }
        return vocales;
    }

    private byte contarConsonantes() {

        if(this.palabra == null){
            System.err.println("No se ha ingresado una palabra");
            return 0;
        }

        byte consonantes = 0;
        for(int letras = 0; letras < this.palabra.length(); letras++){
            if(this.palabra.charAt(letras) != 'a' && this.palabra.charAt(letras) != 'e' && this.palabra.charAt(letras) != 'i' && this.palabra.charAt(letras) != 'o' && this.palabra.charAt(letras) != 'u'){
                consonantes++;
            }
        }
        return consonantes;
    }

    private void obtenerPalabra() {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Introduzca la palabra: ");

        scanner.reset();

        this.palabra = scanner.next();
    }

    private void obtenerNumeros() {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Introduzca la guarda: ");

        scanner.reset();

        String guarda = scanner.next();



        for(;;) {
            System.out.print("Introduzca un número: ");
            String numeroStr = scanner.next();

            // si la entrada es igual a la guarda, se termina el programa
            if(numeroStr.equals(String.valueOf(guarda))){
                break;
            }
            else {

                int numero = Integer.parseInt(numeroStr);
                agregarNumero(numero);
            }
        }
 //       scanner.close();
    }

    private void enumerarPorComas() {
        for (int i = 0; i < numeros.size(); i++) {
            if(i==0){
                System.out.print(numeros.get(i));
                continue;
            }
            System.out.print(","+numeros.get(i));
        }
        System.out.println();
    }
    private void enumerarPorComasV2() {
        int i = 0;
        for (int Numero : numeros) {
            System.out.print((i==0?"":",") + Numero);
            i++;
        }
        System.out.println();
    }
}


