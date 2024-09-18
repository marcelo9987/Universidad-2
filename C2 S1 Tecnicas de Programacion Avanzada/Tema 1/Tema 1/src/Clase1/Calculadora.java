package Clase1;

public class Calculadora
{
    private int x = 0;
    private int y = 0;

    public int sumar()
    {
        return x + y;
    }

    public boolean esPrimo()
    {
        if(x<=1)
        {
            return false;
        }
        if( x==2)
        {
            return true;
        }
        for(int i = 2; i < x; i++)
        {
            if( x%i == 0) {
                return false;
            }
        }
        return true;

    }

    public void calcularFibonacci()
    {
        int numero = 1;
        for(int i = 0; (i+2*numero)<x;)
        {
            i=i+numero;

            numero = i-numero;
            System.out.println(i+numero);

        }
    }

    public int getX() {
        return x;
    }

    public void setX(int x) {
        this.x = x;
    }

    public int getY() {
        return y;
    }

    public void setY(int y) {
        this.y = y;
    }
}
