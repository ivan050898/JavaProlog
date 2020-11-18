/**
  E:Lista, posici�n, valor, variable temporal y resultado
  S:Lista con la posici�n indicada reemplazada por el valor recibido
  R:Ninguna
  O:Sustituir facilmente valores de una lista
 */

sustituirPos([],_,_,Res,C):-C=Res.
sustituirPos([_|Tail],Pos,Val,Res,C):-Pos =:= 0,Pos2 is Pos-1,append(Res,[Val],X),sustituirPos(Tail,Pos2,Val,X,C).
sustituirPos([Head|Tail],Pos,Val,Res,C):-Pos \= 0,Pos2 is Pos-1,append(Res,[Head],X),sustituirPos(Tail,Pos2,Val,X,C).



/**
  E:Las dos filas anteriores, la fila actual a validar, y contador
  S:True si no hay cadenas de resultados de una fila
  R:Ninguna
  O:Verificar que un tablero creado es v�lido
 */

verificarColumna([],_,_,_).
verificarColumna([H1|T1],[H2|T2],[H3|T3],8):-not((H3 =:= 0, H2 =:= -1)),not((H1 =:= -1, H2 =:= 0, H3 =:= -1)),verificarColumna(T1,T2,T3,8).
verificarColumna([H1|T1],[H2|T2],[H3|T3],Cont):-Cont \= 8,not((H1 =:= -1, H2 =:= 0, H3 =:= -1)),verificarColumna(T1,T2,T3,Cont).



verificarFila(Ant,[Actual|[Sig|[]]]):- (Actual =:= -1;(Ant \= -1;Sig \= -1)),not((Sig =:=0,Actual =:= -1)).
verificarFila(Ant,[Actual|[Sig|T]]):- (Actual =:= -1;(Ant \= -1;Sig \= -1)),verificarFila(Actual,[Sig|T]).



/**
  E:Variable X
  S:Estructura de una matriz de kakuro asignada a la variable X
  R:Ninguna
  O:Crear una matriz de kakuro de acuerdo a las reglas de juego
 */

estructuraAux([],Res,_,Val,_,_):-Val=Res.



estructuraAux([H|T],Res,Cont,Val,FilAnt,FilAnt2):-repeat,random_between(1,8,Rand1),random_between(1,8,Rand2),random_between(1,8,Rand3),random_between(1,8,Rand4),random_between(1,8,Rand5),sustituirPos(H,Rand1,-1,[],Y),sustituirPos(Y,Rand2,-1,[],G),sustituirPos(G,Rand3,-1,[],P),sustituirPos(P,Rand5,-1,[],F),sustituirPos(F,Rand4,-1,[],W),verificarFila(-1,W),verificarColumna(FilAnt2,FilAnt,W,Cont),append(Res,[W],D),Cont2 is Cont+1,estructuraAux(T,D,Cont2,Val,W,FilAnt).


estructuraTab(X):-estructuraAux([[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,0,0,0,0,0,0,0,0],[-1,0,0,0,0,0,0,0,0],[-1,0,0,0,0,0,0,0,0],[-1,0,0,0,0,0,0,0,0],[-1,0,0,0,0,0,0,0,0],[-1,0,0,0,0,0,0,0,0],[-1,0,0,0,0,0,0,0,0],[-1,0,0,0,0,0,0,0,0]],[],0,X,[],[]).

/**
  E:Variable X
  S:Random del 1 al 9
  R:Ninguna
  O:Obtener valores random para las casillas de un tablero
 */
obtenerRandom(X):-random_between(1,9,X).

/**
  E:Lista, Posici�n y Variable X
  S:Variable X convertida en el elemento de la lista en la posici�nindicada
  R:Posici�n dentro del tama�o de la lista
  O:Facilitar la obtenci�n de valores de una lista
 */
nesimaAux([Head|_],0,X):- X is Head.
nesimaAux([_|Tail],Pos,X):-Pos2 is Pos-1,nesimaAux(Tail,Pos2,X).
nesima(Var,Pos,X):-nesimaAux(Var,Pos,X).


/**
  E:Fila y valor
  S:True si la fila no contiene el valor
  R:Ninguna
  O:Verificar si una lista contiene un valor indicado
 */
verifFila([],_).
verifFila([H|T],V):- H \= V,verifFila(T,V).


/**
  E:Matriz, posici�n y valor
  S:True si la matriz no contiene el valor en la posici�n indicada de
  alguna de sus filas
  R: Ninguna
  O: Verificar si una matriz repite valores en una misma columna
 */
verifCol([],_,_).
verifCol([Head|Tail],Pos,Val):-nesima(Head,Pos,X),X \= Val,verifCol(Tail,Pos,Val).





/**
  E:Lista, Resultado, posici�n actual, matriz completa y resultado final
  S:Lista llenada con numeros aleatorios sin repetir en filas ni
  columnas
  R:Ninguna
  O:Llenar una fila de un tablero por completo
 */
llenarFila([],Res,_,_,W):- W = Res.
llenarFila([H|T],Res,Pos,Mat,W):-H =:= 0,repeat,obtenerRandom(Y),verifFila(Res,Y),verifCol(Mat,Pos,Y),append(Res,[Y],X),Pos2 is Pos+1,llenarFila(T,X,Pos2,Mat,W).
llenarFila([H|T],Res,Pos,Mat,W):-H \= 0,Pos2 is Pos+1,append(Res,[H],X),llenarFila(T,X,Pos2,Mat,W).


/**
  E:Estructura del tablero, matriz vac�a, posici�n actual y variable
  resultado
  S:Tablero de kakuro asignado a la variable X
  R:Ninguna
  O:Llenar un tablero de kakuro con numeros aleatorios sin repetir
 */
llenarMat(_,Mat,9,G):- G = Mat.
llenarMat([H|T],Mat,Cont,G):-llenarFila(H,[],0,Mat,X),append(Mat,[X],R),Cont2 is Cont+1,llenarMat(T,R,Cont2,G).

/**
  E:Variable X
  S:Tablero creado y asignado a variable X
  R:Ninguna
  O:Crear un tablero aleatorio de Kakuro
 */
crearTablero(X):- estructuraTab(Y),llenarMat(Y,[],0,X).


/**
  E:Dos listas de enteros
  S:Diferencias de valores entre una lista y la otra
  R:Las listas deben ser del mismo tama�o
  O:Contar la cantidad de digitos distintos entre una lista y la otra
 */
diferenciasFila([],[],Res,X):-Res = X.
diferenciasFila([H1|T1],[H2|T2],Res,X):-H1 \= H2,X2 is X+1,diferenciasFila(T1,T2,Res,X2).
diferenciasFila([H1|T1],[H1|T2],Res,X):-diferenciasFila(T1,T2,Res,X).


/**
  E:Lista de numeros, resultado actual, resultado final X
  S:Cantidad de Ceros en la lista asignado a variable X
  R:Ninguna
  O:Contar los ceros de una lista
 */
cantCeros([],Res,X):-Res = X.
cantCeros([0|T],Res,X):-X2 is X+1,cantCeros(T,Res,X2).
cantCeros([H|T],Res,X):-H \= 0,cantCeros(T,Res,X).


/**
  E:Tablero original, tablero del usuario, Variable X y Y
  S:Variables X y Y indicando la cantidad de ceros y valores distintos
  R:Ninguna
  O:Validar un resultado
 */
verificarTab([],[],Q,A,X,Y):-Q is X-Y, A = Y.
verificarTab([H|T],[HU|TU],Q,A,X,Y):- diferenciasFila(H,HU,W,0),cantCeros(HU,Z,0),G is W+X,L is Z+Y,verificarTab(T,TU,Q,A,G,L).
verificar(Res,User,X,Y):-verificarTab(Res,User,X,Y,0,0).

