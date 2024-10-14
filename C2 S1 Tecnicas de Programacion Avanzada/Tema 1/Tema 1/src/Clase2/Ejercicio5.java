package Clase2;

public class Ejercicio5 {
    public static void main(String[] args) {
// Working with Strings
        System.out.println("Working with Strings:");
        String s1 = "HELLO";
        String s2 = "HELLO"; // String from String Pool
        String s3 = new String("HELLO"); // This creates always a new string, goes to a new allocated memory
        String s4 = s1; // aliasing "&s4 <-- &s1"

        System.out.println("s1 == s2, is \t" + (s1 == s2));
        // TRUE

        System.out.println("s1 == s3, is \t" + (s1 == s3));
        //FALSE

        System.out.println("s1 == s4, is \t" + (s1 == s4));
        //TRUE
        System.out.println("s1 equals s2, is " + (s1.equals(s2)));
        //TRUE
        System.out.println("s1 equals s3, is " + (s1.equals(s3)));
        //TRUE
        System.out.println("s1 equals s4, is " + (s1.equals(s4)));
        //TRUE
        System.out.println("Adress s1: " + System.identityHashCode(s1));
        System.out.println("Adress s2: " + System.identityHashCode(s2));
        System.out.println("Adress s3: " + System.identityHashCode(s3));
        System.out.println("Adress s4: " + System.identityHashCode(s4));

        // Working with int
        System.out.println("Working with int (primitive type):");
        int a = 5;
        int b = 5;
        int c = a;
        System.out.println("\na == b, is \t" + (a == b));
        //TRUE
        System.out.println("a == c, is \t" + (a == c));
        //TRUE
//System.out.println(a.equals(b)); ERROR: can not invoke that method for primitive types
        System.out.println("Adress a: " + System.identityHashCode(a));
        System.out.println("Adress b: " + System.identityHashCode(b));
        System.out.println("Adress c: " + System.identityHashCode(c));


        // Working with Integers
        System.out.println("\n\nWorking with Integers (class Integer):");
        Integer d = 5;
        Integer e = 5; //Integer constant pool
        Integer f = new Integer(5); // deprecated
        Integer g = Integer.valueOf(5); // New way
        Integer h = d;
        System.out.println("d == e, is \t" + (d == e));
        System.out.println("d == f, is \t" + (d == f));
        System.out.println("d == g, is \t" + (d == g));
        System.out.println("d == h, is \t" + (d == h));
        System.out.println("d equals e, is \t" + (d.equals(e)));
        System.out.println("d equals f, is \t" + (d.equals(f)));
        System.out.println("d equals g, is \t" + (d.equals(g)));
        System.out.println("d equals h, is \t" + (d.equals(h)));
        System.out.println("Adress d: " + System.identityHashCode(d));
        System.out.println("Adress e: " + System.identityHashCode(e));
        System.out.println("Adress f: " + System.identityHashCode(f));
        System.out.println("Adress g: " + System.identityHashCode(g));
        System.out.println("Adress h: " + System.identityHashCode(h));
    }
}
