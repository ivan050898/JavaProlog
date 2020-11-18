/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyecto.pkg3;
import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.util.Arrays;
import javax.swing.*;
/**
 *
 * @author ivan-
 */
public class Interfaz {
    public JTextField[][] campos;
    public Interfaz(){
       Tablero tab = new Tablero();
       System.out.print(Arrays.deepToString(tab.board));
       JTextField[][] campos= new  JTextField[9][9] ;
        JFrame frame = new JFrame();
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	frame.setSize(900, 900);
	frame.setLayout(null);
        int size=60;
        int x=0;
        int y=0;
        for(int i=0;i<9;i++){
            for(int j=0;j<9;j++){
               campos[i][j]=new JTextField(String.valueOf(tab.board[i][j]),1);
               campos[i][j].setBounds(x,y, size, size);
               if(tab.board[i][j]==-1){
                    campos[i][j].setBackground(Color.black);
                    campos[i][j].setEditable(false);
               }
               frame.add(campos[i][j]);
               x+=size;
            }
            x=0;
            y+=size;
            
       }
       frame.setVisible(true);
       this.campos=campos;
       for(int i=0;i<9;i++){
            for(int j=0;j<9;j++){
              if(tab.board[i][j]==-1){
                 int altura=i;
                 if(altura+1<9){
                   if(tab.board[i+1][j]==-1){
                          continue; 
                   }else{
                       this.campos[i][j].setText(String.valueOf(999));
                       this.campos[i][j].setForeground(Color.white);
                       int suma=0;
                       for(int contador=i+1;contador<9;contador++){
                         if(tab.board[contador][j]==-1){break;}
                         suma+=tab.board[contador][j];
                       
                       }
                       this.campos[i][j].setText(String.valueOf(suma)+"\\");
                   }
                             
                 }else{
                     continue;
                 }
              }
            }     
        }
        for(int i=0;i<9;i++){
            for(int j=0;j<9;j++){
              if(tab.board[i][j]==-1){
                 int altura=j;
                 if(altura+j<9){
                   if(tab.board[i][j+1]==-1){
                          continue; 
                   }else{
                       int suma=0;
                       for(int contador=j+1;contador<9;contador++){
                         if(tab.board[i][contador]==-1){break;}
                         suma+=tab.board[i][contador];
                       }
                       if(!"-1".equals(this.campos[i][j].getText())){
                         this.campos[i][j].setText(this.campos[i][j].getText()+"\\"+String.valueOf(suma));
                       }else{
                          this.campos[i][j].setText("\\"+String.valueOf(suma));
                       }
                       this.campos[i][j].setForeground(Color.white);
                   }
                             
                 }else{
                     continue;
                 }
              }
            }     
        }
        for(int i=0;i<9;i++){
          for(int j=0;j<9;j++){
           if( !this.campos[i][j].getText().contains("\\")){
              this.campos[i][j].setText("");
           }
          }
        }
}
}
