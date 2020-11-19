/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyecto.pkg3;

import java.util.Arrays;
import org.jpl7.Query;

/**
 *
 * @author ivan-
 */
public class Tablero {
   public int[][] board; 
  
   /*Clase para crear el tablero*/
  public Tablero(){
       String con="consult('kakuro.pl')"; //se dice cual es el archivo a consultar
        Query q= new Query(con);
        System.out.println(con+" "+(q.hasSolution()?"si":"no")); //se conecta o no?
        String t2="generarTablero(X)";
        Query q2 = new Query(t2);
        String Consulta=q2.oneSolution().get("X").toString(); //se trae al tablero
        String str=Consulta.replaceAll("\\[", "").replaceAll("\\]","").replaceAll(" ",""); //se eliminan los corchetes y espacios
        String[] StrArray =str.split("[,]"); // se hace split por comas
        int [] arr = new int [StrArray.length];//se crea el arreglo de 81 digitos
        for(int i=0; i<StrArray.length; i++) { //se parsea el arreglo
         arr[i] = Integer.parseInt(StrArray[i]);
        }
        int[][] IntArray=new int[9][9];
        int i=0;
        for(int r=0; r<9; r++){ //se transforma el areglo de 1d a 2d
            for( int c=0; c<9; c++){
                IntArray[r][c]=arr[i];
                i++;             
            }
        }
        this.board=IntArray;
  }
}
