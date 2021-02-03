/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

/**
 *
 * @author USER
 */
public class Integrale {

    public static double F(double x) {
        double val = Math.exp(-x * x / 2.0);
        System.err.println("\n Exp de " + x + " egal : " + val);
        return val;
    }

    public static double simpson(int N, double A, double B) {
        double X, h, Iapp0, Iapp1, Iapp2, Iapp;
        int NN, i;

        //Etape 1
        h = (B - A) / N;//pas
        System.err.println("le Pas est  : " + h);

        //Etape2
        Iapp0 = F(A) + F(B);
        Iapp1 = 0.0;
        Iapp2 = 0.0;

        //Etape 3
        NN = N - 1;

        for (i = 1; i <= NN; i++) {
            //etape 4
            X = A + i * h;
            System.err.println(" Valeur au point " + i + " Egal à " + X);

            //Etape 5
            if ((i % 2) == 0) {
                Iapp2 = Iapp2 + F(X);
            } else {
                Iapp1 = Iapp1 + F(X);
            }
            
            System.err.println(" Point pair = "+Iapp2);
            System.err.println(" Point impair = "+Iapp1);
        }

        Iapp = (Iapp0 + 2.0 * Iapp2 + 4.0 * Iapp1);

        return Iapp;

    }

    public static void main(String args[]) {
        int i, n;

        double a, b, smpthd;

        a = 102.0;
        b = 100.0;
        n = 4;
        //simpson(n, a, b);
        smpthd = simpson(n, a, b);

        System.err.println(" L integrale vaut : " + smpthd);

    }

}
