/**
  E:Lista, posici�n, valor, variable temporal y resultado
  S:Lista con la posici�n indicada reemplazada por el valor recibido
  R:Ninguna
  O:Sustituir facilmente valores de una lista
 */

sustituirPosicion([],_,_,Res,C):-C=Res.
sustituirPosicion([_|Cola],Pos,Val,Res,C):-Pos =:= 0,Pos2 is Pos-1,append(Res,[Val],X),sustituirPosicion(Cola,Pos2,Val,X,C).
sustituirPosicion([Cabeza|Cola],Pos,Val,Res,C):-Pos \= 0,Pos2 is Pos-1,append(Res,[Cabeza],X),sustituirPosicion(Cola,Pos2,Val,X,C).



/**
  E:Las dos filas anteriores, la fila actual a validar, y contador
  S:True si no hay cadenas de resultados de una fila
  R:Ninguna
  O:validar que un tablero creado es v�lido
 */

validarColumna([],_,_,_).
validarColumna([H1|T1],[H2|T2],[H3|T3],8):-not((H3 =:= 0, H2 =:= -1)),not((H1 =:= -1, H2 =:= 0, H3 =:= -1)),validarColumna(T1,T2,T3,8).
validarColumna([H1|T1],[H2|T2],[H3|T3],Cont):-Cont \= 8,not((H1 =:= -1, H2 =:= 0, H3 =:= -1)),validarColumna(T1,T2,T3,Cont).



validarFila(Ant,[Actual|[Sig|[]]]):- (Actual =:= -1;(Ant \= -1;Sig \= -1)),not((Sig =:=0,Actual =:= -1)).
validarFila(Ant,[Actual|[Sig|T]]):- (Actual =:= -1;(Ant \= -1;Sig \= -1)),validarFila(Actual,[Sig|T]).



/**
  E:Variable X
  S:Estructura de una matriz de kakuro asignada a la variable X
  R:Ninguna
  O:Crear una matriz de kakuro de acuerdo a las reglas de juego
 */

crearEstucturaTab([],Res,_,Val,_,_):-Val=Res.

crearEstucturaTab([H|T],Res,Cont,Val,FilAnt,FilAnt2):-repeat,random_between(1,8,Rand1),random_between(1,8,Rand2),random_between(1,8,Rand3),random_between(1,8,Rand4),random_between(1,8,Rand5),sustituirPosicion(H,Rand1,-1,[],Y),sustituirPosicion(Y,Rand2,-1,[],G),sustituirPosicion(G,Rand3,-1,[],P),sustituirPosicion(P,Rand5,-1,[],F),sustituirPosicion(F,Rand4,-1,[],W),validarFila(-1,W),validarColumna(FilAnt2,FilAnt,W,Cont),append(Res,[W],D),Cont2 is Cont+1,crearEstucturaTab(T,D,Cont2,Val,W,FilAnt).

crearEstructuraTab(X):-crearEstucturaTab([[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,0,0,0,0,0,0,0,0],[-1,0,0,0,0,0,0,0,0],[-1,0,0,0,0,0,0,0,0],[-1,0,0,0,0,0,0,0,0],[-1,0,0,0,0,0,0,0,0],[-1,0,0,0,0,0,0,0,0],[-1,0,0,0,0,0,0,0,0],[-1,0,0,0,0,0,0,0,0]],[],0,X,[],[]).

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
nesimaAux([Cabeza|_],0,X):- X is Cabeza.
nesimaAux([_|Cola],Pos,X):-Pos2 is Pos-1,nesimaAux(Cola,Pos2,X).
nesima(Var,Pos,X):-nesimaAux(Var,Pos,X).


/**
  E:Fila y valor
  S:True si la fila no contiene el valor
  R:Ninguna
  O:validar si una lista contiene un valor indicado
 */
verificarFila([],_).
verificarFila([H|T],V):- H \= V,verificarFila(T,V).


/**
  E:Matriz, posici�n y valor
  S:True si la matriz no contiene el valor en la posici�n indicada de
  alguna de sus filas
  R: Ninguna
  O: validar si una matriz repite valores en una misma columna
 */
verificarColumna([],_,_).
verificarColumna([Cabeza|Cola],Pos,Val):-nesima(Cabeza,Pos,X),X \= Val,verificarColumna(Cola,Pos,Val).





/**
  E:Lista, Resultado, posici�n actual, matriz completa y resultado final
  S:Lista llenada con numeros aleatorios sin repetir en filas ni
  columnas
  R:Ninguna
  O:Llenar una fila de un tablero por completo
 */
llenarFila([],Res,_,_,W):- W = Res.
llenarFila([H|T],Res,Pos,Mat,W):-H =:= 0,repeat,obtenerRandom(Y),verificarFila(Res,Y),verificarColumna(Mat,Pos,Y),append(Res,[Y],X),Pos2 is Pos+1,llenarFila(T,X,Pos2,Mat,W).
llenarFila([H|T],Res,Pos,Mat,W):-H \= 0,Pos2 is Pos+1,append(Res,[H],X),llenarFila(T,X,Pos2,Mat,W).


/**
  E:Estructura del tablero, matriz vac�a, posici�n actual y variable
  resultado
  S:Tablero de kakuro asignado a la variable X
  R:Ninguna
  O:Llenar un tablero de kakuro con numeros aleatorios sin repetir
 */
llenarTablero(_,Mat,9,G):- G = Mat.
llenarTablero([H|T],Mat,Cont,G):-llenarFila(H,[],0,Mat,X),append(Mat,[X],R),Cont2 is Cont+1,llenarTablero(T,R,Cont2,G).



/**
  E:Lista de numeros, resultado actual, resultado final X
  S:Cantidad de Ceros en la lista asignado a variable X
  R:Ninguna
  O:Contar los ceros de una lista
 */
camposVacios([],Res,X):-Res = X.
camposVacios([0|T],Res,X):-X2 is X+1,camposVacios(T,Res,X2).
camposVacios([H|T],Res,X):-H \= 0,camposVacios(T,Res,X).

/**
  E:Dos listas de enteros
  S:Diferencias de valores entre una lista y la otra
  R:Las listas deben ser del mismo tama�o
  O:Contar la cantidad de digitos distintos entre una lista y la otra
 */
camposErroneos([],[],Res,X):-Res = X.
camposErroneos([H1|T1],[H2|T2],Res,X):-H1 \= H2,X2 is X+1,camposErroneos(T1,T2,Res,X2).
camposErroneos([H1|T1],[H1|T2],Res,X):-camposErroneos(T1,T2,Res,X).

/**
  E:Tablero original, tablero del usuario, Variable X y Y
  S:Variables X y Y indicando la cantidad de ceros y valores distintos
  R:Ninguna
  O:Validar un resultado
 */
validarTablero([],[],Q,A,X,Y):-Q is X-Y, A = Y.
validarTablero([H|T],[HU|TU],Q,A,X,Y):- camposErroneos(H,HU,W,0),camposVacios(HU,Z,0),G is W+X,L is Z+Y,validarTablero(T,TU,Q,A,G,L).
validar(Res,User,X,Y):-validarTablero(Res,User,X,Y,0,0).


/**
  E:Variable X
  S:Tablero creado y asignado a variable X
  R:Ninguna
  O:Crear un tablero aleatorio de Kakuro
 */

generarTablero(X):- crearEstructuraTab(Y),llenarTablero(Y,[],0,X).

