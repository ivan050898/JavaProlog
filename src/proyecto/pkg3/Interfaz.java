/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyecto.pkg3;
import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Random;
import javax.swing.*;
import org.jpl7.Query;
/**
 *
 * @author ivan-
 */
public class Interfaz {
    public JTextField[][] campos;
    public int pistas=5;
    public JButton BotonPista;
    public JButton BotonVerificar;
    public JButton BotonSolucion;
    public JButton BotonReiniciar;
    public JButton BotonNuevo;
    public Tablero tab;
    ArrayList<String> PistasArray = new ArrayList<String>(); // Create an ArrayList object

    public Interfaz(){
     NuevoJuego();
    }
    
   public  void NuevoJuego(){
       this.tab = new Tablero();
       this.pistas=5;
       this.PistasArray.clear();
       JTextField[][] campos= new  JTextField[9][9] ;
        JFrame frame = new JFrame();
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	frame.setSize(900, 900);
	frame.setLayout(null);
        this.BotonPista=new JButton("Usar una pista");
        this.BotonPista.setBounds(700,100,170,30);
        frame.add(this.BotonPista);
        this.BotonPista.addActionListener((ActionEvent e) -> {
           Pista();
        });  
        this.BotonVerificar=new JButton("Verificar mi solución");
        this.BotonVerificar.setBounds(700,150,170,30);
        this.BotonVerificar.addActionListener((ActionEvent e) -> {
            Verificar();
        });  
        frame.add(this.BotonVerificar);
        this.BotonSolucion=new JButton("Mostrar solución");
        this.BotonSolucion.setBounds(700,200,170,30);
        this.BotonSolucion.addActionListener((ActionEvent e) -> {
            MostrarSolucion();
        }); 
        frame.add(this.BotonSolucion);
        this.BotonReiniciar=new JButton("Reiniciar");
        this.BotonReiniciar.setBounds(700,250,170,30);
        this.BotonReiniciar.addActionListener((ActionEvent e) -> {
            Reiniciar();
        });
        frame.add(this.BotonReiniciar);
        this.BotonNuevo=new JButton("Nuevo juego");
        this.BotonNuevo.setBounds(700,300,170,30);
        this.BotonNuevo.addActionListener((ActionEvent e) -> {
            frame.dispose();
            NuevoJuego();
        });
        frame.add(this.BotonNuevo);
        int size=60;
        int x=0;
        int y=0;
        for(int i=0;i<9;i++){
            for(int j=0;j<9;j++){
               campos[i][j]=new JTextField(String.valueOf(this.tab.board[i][j]),1);
               campos[i][j].setBounds(x,y, size, size);
               
               if(this.tab.board[i][j]==-1){
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
              if(this.tab.board[i][j]==-1){
                 int altura=i;
                 if(altura+1<9){
                   if(this.tab.board[i+1][j]==-1){
                          continue; 
                   }else{
                       this.campos[i][j].setText(String.valueOf(999));
                       this.campos[i][j].setForeground(Color.white);
                       int suma=0;
                       for(int contador=i+1;contador<9;contador++){
                         if(this.tab.board[contador][j]==-1){break;}
                         suma+=this.tab.board[contador][j];
                       
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
              if(this.tab.board[i][j]==-1){
                 int altura=j;
                 if(altura+j<9){
                   if(this.tab.board[i][j+1]==-1){
                          continue; 
                   }else{
                       int suma=0;
                       for(int contador=j+1;contador<9;contador++){
                         if(this.tab.board[i][contador]==-1){break;}
                         suma+=this.tab.board[i][contador];
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
   public static boolean isIntegerDigit(String str) { 
        try {
          if(str.length()==1){
            Integer.parseInt(str);  
            return true;
          }else{
            return false;  
          }           
        } catch(NumberFormatException e){  
          return false;  
        }  
   }
   public int contarCasilasJugables(){
    int negras=0;
    for(int i=0;i<9;i++){
       for(int j=0;j<9;j++){
          if(this.tab.board[i][j]==-1){
           negras++;
          }
       }
    }
    
    return 81-negras;
   }
   
   public void Verificar(){
     for(int i=0;i<9;i++){
      for(int j=0;j<9;j++){
          if(this.campos[i][j].getBackground()==Color.red){
             this.campos[i][j].setBackground(Color.white);
         }
      }
     }
    boolean rojas=false;
    int[][] SolucionUsuario=new int[9][9];
    for(int i=0;i<9;i++){
      for(int j=0;j<9;j++){
         if(this.campos[i][j].getBackground()==Color.black){
             SolucionUsuario[i][j]=-1;
         }else{
            if(isIntegerDigit(this.campos[i][j].getText())){
              SolucionUsuario[i][j]=Integer.parseInt(this.campos[i][j].getText());
            }else{
              if(this.campos[i][j].getText().length()==0){
                SolucionUsuario[i][j]=0;
              }else{
                 this.campos[i][j].setBackground(Color.red);
                 rojas=true;
              }  
            }
         }
       }
    }
    if(rojas) JOptionPane.showMessageDialog (null, "¡En las casillas rojas hay entradas inválidas, cambie sus entradas y verifique de nuevo!", "ERROR!", JOptionPane.ERROR_MESSAGE);
    else{
      String arregloUsuario=Arrays.deepToString(SolucionUsuario);
      String arregloRespuestas=Arrays.deepToString(this.tab.board);
      String con="consult('kakuro.pl')";
      Query q= new Query(con);
      System.out.println(con+" "+(q.hasSolution()?"Conexion establecida":"no"));
      String t2="verificar("+arregloRespuestas+","+arregloUsuario+",X,K)";
      Query q2 = new Query(t2);
      Integer X=Integer.parseInt(q2.oneSolution().get("X").toString());
      Integer K=Integer.parseInt(q2.oneSolution().get("K").toString());
      Integer casillas=contarCasilasJugables();
      if(K==0 && X==0){
        JOptionPane.showMessageDialog (null, "juego finalizado exitosamente, felicidades!!", "Felicidades!", JOptionPane.INFORMATION_MESSAGE);
      }else{
         if(X==0 && K>0){
          JOptionPane.showMessageDialog (null, "No hay digitos incorrectos pero si "+K.toString()+" casillas vacias de "+casillas.toString(), "ERROR!", JOptionPane.ERROR_MESSAGE);
         }else{
          JOptionPane.showMessageDialog (null, "Hay  " + X.toString()  +" digitos incorrectos  y "+K.toString()+" casillas vacias de "+casillas.toString(), "ERROR!", JOptionPane.ERROR_MESSAGE);
         }
      }
    }

   }
   
   public void MostrarSolucion(){
     for(int i=0;i<9;i++){
       for(int j=0;j<9;j++){
         if(this.tab.board[i][j]!=-1){
          this.campos[i][j].setText(String.valueOf(this.tab.board[i][j]));
         }   
       }
     }
     this.BotonPista.setEnabled(false);
     this.BotonVerificar.setEnabled(false);
     this.BotonReiniciar.setEnabled(false);
     this.BotonSolucion.setEnabled(false);

   }
   
   public void Pista(){
       if(this.pistas==0){
        JOptionPane.showMessageDialog (null,"Ya no tienes pistas disponibles", "ERROR!", JOptionPane.ERROR_MESSAGE);
       }else{
           while(true){
              int x=  new Random().nextInt(8 + 1) ;
              int y=  new Random().nextInt(8 + 1) ;
              String posicion=String.valueOf(x)+","+String.valueOf(y);
              if(this.tab.board[x][y]!=-1 && !this.PistasArray.contains(posicion)){
                  this.campos[x][y].setText(String.valueOf(this.tab.board[x][y]));
                  this.PistasArray.add(posicion);
                  this.pistas--;
                  break;
              }
            }
        }
   }
   
   public void Reiniciar(){
     this.pistas=5;
     this.PistasArray.clear();
     for(int i=0;i<9;i++){
          for(int j=0;j<9;j++){
           if(this.tab.board[i][j]!=-1){
              this.campos[i][j].setText("");
           }
          }
     }
   }
   
   
}