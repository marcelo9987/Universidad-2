package Clase1;




import java.util.Arrays;
import java.util.Scanner;

public class Main
{

    public static void main(String[] Args)
    {
        ej1();
        System.out.println();

        ej2();
        System.out.println();

        ej3();
        System.out.println();

        ej4();
    }

    public static void ej1()
    {

        int x, y;

        Scanner entrada = new Scanner(System.in);

        System.out.print("Introduzca x: ");
        x = entrada.nextInt();

        System.out.print("Introduzca y: ");
        y = entrada.nextInt();

        Calculadora calculadora = new Calculadora();

        calculadora.setX(x);
        calculadora.setY(y);

        System.out.println("Resultado: " + calculadora.sumar());
    }

    public static void ej2()
    {

        int x;

        Scanner entrada = new Scanner(System.in);

        System.out.print("Introduzca el número a comprobar: ");
        x = entrada.nextInt();

        Calculadora calculadora = new Calculadora();

        calculadora.setX(x);

        if(calculadora.esPrimo())
        {
            System.out.println("Es Primo");
        }else
        {
            System.out.println("No es Primo");
        }
    }

    public static void ej3()
    {

        int x;

        Scanner entrada = new Scanner(System.in);

        System.out.print("Introduzca el número máximo: ");
        x = entrada.nextInt();

        Calculadora calculadora = new Calculadora();

        calculadora.setX(x);

        calculadora.calcularFibonacci();
    }
    public static void ej4()
    {
        int tope = 10;
        int aumentoTope=10;
        double[] listaNumeros = new double[tope];
        double[] listTemp;
        Scanner entrada = new Scanner(System.in);
        
        for(int num = 0; true; num++)
        {
            System.out.print("Introduce el número: ");
            double numeroInsertado = entrada.nextDouble();

            if(numeroInsertado==-1)
            {
                break;
            }

            if((tope-1)==num)
            {
                listTemp = listaNumeros.clone();
                tope += aumentoTope;
                listaNumeros=new double[tope];
                System.arraycopy(listTemp, 0, listaNumeros, 0, tope - aumentoTope);

            }

            listaNumeros[num]=numeroInsertado;
            
        }

        System.out.println("La suma es: "+ Arrays.stream(listaNumeros).sum());
        
    }

}
