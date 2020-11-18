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
    
  public Tablero(){
       String con="consult('kakuro.pl')";
        Query q= new Query(con);
        System.out.println(con+" "+(q.hasSolution()?"si":"no"));
        String t2="crearTablero(X)";
        Query q2 = new Query(t2);
        String Consulta=q2.oneSolution().get("X").toString();
        String str=Consulta.replaceAll("\\[", "").replaceAll("\\]","").replaceAll(" ","");
        String[] StrArray =str.split("[,]");
        int [] arr = new int [StrArray.length];
        for(int i=0; i<StrArray.length; i++) {
         arr[i] = Integer.parseInt(StrArray[i]);
        }
        int[][] IntArray=new int[9][9];
        int i=0;
        for(int r=0; r<9; r++){
            for( int c=0; c<9; c++){
                IntArray[r][c]=arr[i];
                i++;             
            }
        }
        this.board=IntArray;
  }
}
