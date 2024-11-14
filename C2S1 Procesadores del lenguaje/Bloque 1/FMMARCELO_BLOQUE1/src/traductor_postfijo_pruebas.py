import unittest
from traductor_postfijo import TraductorExpresionPostfijo
from lexico import Lexico

# Clase que implementa las pruebas unitarias, en principio me parece que cubre si no todos, la mayoría de los casos posibles

class TestTraductorExpresionPostfijo(unittest.TestCase):

    def test_postfijo_simple(self):
        expresion = "3 + 4"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "3 4 +")

    def test_postfijo_complejo(self):
        expresion = "(25 * (2 + 2)) / 2 * 3"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "25 2 2 + * 2 / 3 *")

    def test_calcular_simple(self):
        expresion = "3 + 4"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 7)

    def test_calcular_complejo(self):
        expresion = "(25 * (2 + 2)) / 2 * 3"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 150)

    # Tests adicionales
    def test_postfijo_adicional_1(self):
        expresion = "5 - 2"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "5 2 -")

    def test_postfijo_adicional_2(self):
        expresion = "10 / 2"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "10 2 /")

    def test_postfijo_adicional_3(self):
        expresion = "8 * 3"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "8 3 *")

    def test_postfijo_adicional_4(self):
        expresion = "7 + 2 * 5"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "7 2 5 * +")

    def test_postfijo_adicional_5(self):
        expresion = "(3 + 4) * 2"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "3 4 + 2 *")

    def test_calcular_adicional_1(self):
        expresion = "5 - 2"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 3)

    def test_calcular_adicional_2(self):
        expresion = "10 / 2"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 5)

    def test_calcular_adicional_3(self):
        expresion = "8 * 3"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 24)

    def test_calcular_adicional_4(self):
        expresion = "7 + 2 * 5"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 17)

    def test_calcular_adicional_5(self):
        expresion = "(3 + 4) * 2"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 14)

    def test_postfijo_adicional_6(self):
        expresion = "1 + 2 + 3"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "1 2 + 3 +")

    def test_postfijo_adicional_7(self):
        expresion = "4 * 5 / 2"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "4 5 * 2 /")

    def test_postfijo_adicional_8(self):
        expresion = "6 - 3 + 2"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "6 3 - 2 +")

    def test_postfijo_adicional_9(self):
        expresion = "7 * (8 + 2)"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "7 8 2 + *")

    def test_postfijo_adicional_10(self):
        expresion = "9 / (3 + 6)"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "9 3 6 + /")

    def test_calcular_adicional_6(self):
        expresion = "1 + 2 + 3"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 6)

    def test_calcular_adicional_7(self):
        expresion = "4 * 5 / 2"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 10)

    def test_calcular_adicional_8(self):
        expresion = "6 - 3 + 2"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 5)

    def test_calcular_adicional_9(self):
        expresion = "7 * (8 + 2)"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 70)

    def test_calcular_adicional_10(self):
        expresion = "9 / (3 + 6)"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 1)

    def test_postfijo_adicional_11(self):
        expresion = "2 + 3 * 4"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "2 3 4 * +")

    def test_postfijo_adicional_12(self):
        expresion = "5 * 6 - 7"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "5 6 * 7 -")

    def test_postfijo_adicional_13(self):
        expresion = "8 / 4 + 2"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "8 4 / 2 +")

    def test_postfijo_adicional_14(self):
        expresion = "9 - 3 * 2"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "9 3 2 * -")

    def test_postfijo_adicional_15(self):
        expresion = "(1 + 2) * (3 + 4)"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        self.assertEqual(traductor.postfijo(), "1 2 + 3 4 + *")

    def test_calcular_adicional_11(self):
        expresion = "2 + 3 * 4"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 14)

    def test_calcular_adicional_12(self):
        expresion = "5 * 6 - 7"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 23)

    def test_calcular_adicional_13(self):
        expresion = "8 / 4 + 2"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 4)

    def test_calcular_adicional_14(self):
        expresion = "9 - 3 * 2"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 3)

    def test_calcular_adicional_15(self):
        expresion = "(1 + 2) * (3 + 4)"
        lexico = Lexico(expresion)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.calculate(), 21)

    def test_postfijo_adicional_16(self):
        expression= "(5*(7/(6+5)/9*8))"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.postfijo(), "5 7 6 5 + / 9 / 8 * *")

        # Flotantes
    def test_postfijo_adicional_17(self):
        expression= "1.5 + 2.5"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.postfijo(), "1.5 2.5 +")

    def test_postfijo_adicional_18(self):
        expression= "1.5 * 2.5"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.postfijo(), "1.5 2.5 *")

    def test_postfijo_adicional_19(self):
        expression= "1.5 - 2.5"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.postfijo(), "1.5 2.5 -")

    def test_postfijo_adicional_20(self):
        expression= "1.5 / 2.5"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertEqual(traductor.postfijo(), "1.5 2.5 /")

        # Tests de cálculo. Flotantes y enteros.
    def test_calcular_adicional_16(self):
        expression= "(5*(7/(6+5)/9*8))"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertAlmostEqual(traductor.calculate(),2.828282828)

    def test_calcular_adicional_17(self):
        expression= "1.5 + 2.5"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertAlmostEqual(traductor.calculate(), 4.0)


    def test_calcular_adicional_18(self):
        expression= "1.5 * 2.5"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertAlmostEqual(traductor.calculate(), 3.75)

    def test_calcular_adicional_19(self):
        expression= "1.5 - 2.5"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertAlmostEqual(traductor.calculate(), -1.0)

    def test_calcular_adicional_20(self):
        expression= "1.5 / 2.5"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertAlmostEqual(traductor.calculate(), 0.6)

    def test_calcular_adicional_21(self):
        expression= "1.5 + 2"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertAlmostEqual(traductor.calculate(), 3.5)

    def test_calcular_adicional_22(self):
        expression= "1.5 * 2"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertAlmostEqual(traductor.calculate(), 3.0)

    def test_calcular_adicional_23(self):
        expression= "1.5 - 2"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertAlmostEqual(traductor.calculate(), -0.5)

    def test_calcular_adicional_24(self):
        expression= "1.5 / 2"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertAlmostEqual(traductor.calculate(), 0.75)

    def test_calcular_adicional_25(self):
        expression= "1 + 2.5"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertAlmostEqual(traductor.calculate(), 3.5)

    def test_calcular_adicional_26(self):
        expression= "1 * 2.5"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertAlmostEqual(traductor.calculate(), 2.5)

    def test_postfijo_adicional_27(self):
        expression="16/(4*4)"
        lexico =Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        self.assertAlmostEqual(traductor.calculate(), 1)

    def test_divporcero(self):
        expression= "1 / 0"
        lexico = Lexico(expression)
        traductor = TraductorExpresionPostfijo(lexico)
        traductor.postfijo()
        with self.assertRaises(ZeroDivisionError):
            traductor.calculate()

if __name__ == "__main__":
    unittest.main()
