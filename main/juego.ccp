#include <iostream>
#include <fstream>
#include <string>
#include <string.h>
using namespace std;
#include <ObjectArray.h>
#include "juego.h"
const int incF[8] = {0, 0, 1, -1, 1, -1, -1, 1}; //arriba, abajo, derecha, izquierda, diagonales
const int incC[8] = {1, -1, 0, 0, 1, 1, -1, -1};

bool cargar_Juego(tJuego &juego, int &nivel){
    string aux;
    tMina mina;
    bool carga = true;
    aux = to_string(nivel); // Convertir entero a string
    aux+=".txt";
    ifstream fichero(aux); 
    if(fichero.is_open()){
        cargar_Mina(fichero, mina);
    }else{
        cout <<"ERROR" << endl;
        carga = false;
    }
    fichero.close();
    nivel++;
    return carga;
}

bool hacerMovimiento(tJuego &juego, tTecla tecla){//Ve si puede hacer mov, si es asi mueve
    bool hacerlo = true;
    int i;
    tEstado estado;
    estado = JUGANDO;
    i = 0;
    switch(tecla){
        case 0 :{// ARRIBA
            if (puede_hacer_mov(juego, i) && juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]]!= PIEDRA){// Puede hacer mov y la casilla no es piedra                                                                                                                    //Puede hacer mov
                estado = casilla_deplaza(juego, i); //Valoramos casos especiales que haya una gema, salida
                mover(juego, i);
            }
            else
            {
                hacerlo = false;
            }
        }
        break; 
        case 1 :{// ABAJO
            i=1;
            if (puede_hacer_mov(juego, i) && juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] != PIEDRA){ //Puede hacer mov y la casilla no es piedra
                estado = casilla_deplaza(juego, i); //Valoramos casos especiales que haya una gema, salida
                if(juego.mina.plano[juego.mina.x + incF[0]][juego.mina.y + incC[0]] == PIEDRA){ // Si tiene una piedra encima cuando baje toda la columna cae con el
                    mover(juego, i);
                    caidaCascada(juego,juego.mina.x, juego.mina.y+2);
                }
                else{
                    mover(juego, i);
                }
            }
            else
            {
                hacerlo = false;
            }
        }break; 
        case 2 :{ //DRCHA
            i=2;
            if (puede_hacer_mov(juego, i)){ //Puede hacer mov
                estado = casilla_deplaza(juego, i); //Valoramos casos especiales que haya una gema, salida o una piedra que pueda ser empujada
                desplazamiento_horizontal(juego, i); // posibilidad minero debajo de una piedra > desplaza y piedra cae
            }
            else
            {
                hacerlo = false;
            }
        }break; 
        case 3 :{ // IZDA
            i = 3;
            if (puede_hacer_mov(juego, i)){ //Puede hacer mov
                estado = casilla_deplaza(juego, i);//Valoramos casos especiales que haya una gema, salida o una piedra que pueda ser empujada
                desplazamiento_horizontal(juego, i);
            }
            else{
                hacerlo = false;
            }
        }break; 
        case 4 :{ //SALIR
            estado = ABANDONA;
        }break; 
        case 5 :{ //NADA
            hacerlo = false;
        }break; 
        case 6 :{ //TNT
            if(juego.mina.plano[juego.mina.x + incF[1]][juego.mina.y + incC[1]] == LIBRE){ // Para poder colocar el TNT
                //El TNT cae desde la posicion del minero en vertical
                juego.mina.plano[juego.mina.x + incF[1]][juego.mina.y + incC[1]] = DINAMITA;
                caidaCascada(juego, juego.mina.x + incF[1], juego.mina.y + incC[1]); // TNT cae hasta que encuentra obstaculo
                explosionTNT(juego, estado); // explota
                juego.numTNT++;
            }
            else{
                estado = OVER; // Explota en manos de minero
            }
        }
        break;
    }
    juego.numMov++;
    return hacerlo;
}

void dibujar(const tJuego &juego, int i){// dibujamos el juego
    if(i == 1){
        dibujar1_1(juego.mina);
    }
    else if(i = 2){
        dibujar1_3(juego.mina);
    }
    cout << "Gemas totales recogidas:" << juego.gem << endl;
    cout <<"Numero de movimientos:" << juego.numMov << endl;
    cout << "Dinamitas usadas:" << juego.numTNT << endl; 
}

bool puede_hacer_mov(tJuego &juego, int i){ // puede hacer mov si no...
    bool puede = true;
    tCasilla casilla;
    //se sale del plano
    if (juego.mina.x + incF[i] < 0 || juego.mina.y + incC[i] < 0 || juego.mina.x + incF[i] > juego.mina.nFilas || juego.mina.y + incC[i]> juego.mina.nColumnas){
        puede = false;
    }
    // la casilla a la que se quiere mover es un muro
    if (juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] == MURO){
        puede = false;
    }
    // una piedra inamovible
    if(!movilidad_piedra(juego, i)){
        puede = false;
    }
    return puede;
}

void mover(tJuego &juego, int i){// mueve minero
    juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] = juego.mina.plano[juego.mina.x][juego.mina.y]; //Minero desplaza posicion
    juego.mina.plano[juego.mina.x][juego.mina.y] = LIBRE; // La excasilla del minero queda libre
    juego.mina.x = +incF[i]; //Actualizamos posicion del minero
    juego.mina.y = +incC[i];
}

tEstado casilla_deplaza(tJuego &juego, int i){// valoramos casos especiales sobre la casilla a la que se desplaza
    tEstado estado = JUGANDO;
    if (juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] == SALIDA){ // Llega a la salida
        estado = FIN;
    }
    if (juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] == GEMA){ //Llega a una gema
        juego.gem++;
    }
    if (juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] == PIEDRA && movilidad_piedra){ // Hay una piedra movible
        juego.mina.plano[juego.mina.x + 2 * incF[i]][juego.mina.y + 2 * incC[i]] = PIEDRA;
        caidaCascada(juego, juego.mina.x + 2 * incF[i], juego.mina.y + 2 * incC[i]);
    }
    return estado;
}

bool movilidad_piedra(tJuego &juego, int i){//Vemos si la piedra puede ser desplazada o no
    bool movilidad = true;
    if (juego.mina.plano[juego.mina.x + 2 * incF[i]][juego.mina.y + 2 * incC[i]] != LIBRE){
        movilidad = false;
    }
    return movilidad;
}

void caidaCascada(tJuego &juego,int iniX, int iniY){ // derrumbamiento en la mina
    int x, y; // Sirve para actualizar la caida de una casilla
    while (juego.mina.plano[iniX][iniY] != MURO && juego.mina.plano[iniX][iniY] != MINERO ){ //Mientras no tengamos un muro o el minero 
        x = iniX;
        y = iniY;
        while (juego.mina.plano[x + incF[1]][y + incC[1]] == LIBRE){ //y la casilla siguiente este libre
            juego.mina.plano[x + incF[1]][y + incC[1]] = juego.mina.plano[x][y]; //elemento baja una posicion
            juego.mina.plano[x][y] = LIBRE;// la casilla donde estaba el elemento queda libre
            x = +incF[1]; // actualizamos posicion
            y = +incC[1];
        }
        iniY++; // Pasamos al siguiente elemento de la columna
    }
    
}

void desplazamiento_horizontal(tJuego &juego, int i){ // Tenemos la posibilidad de que el minero este soportando una piedra y al desplazarse esta caiga
    if(juego.mina.plano[juego.mina.x + incF[0]][juego.mina.y + incC[0]] == PIEDRA){
        mover(juego,i);
        caidaCascada(juego,juego.mina.x- incF[i]+ incF[0], juego.mina.y - incC[i] + incC[0]);
    }
    else{
        mover(juego, i);
    }
}

void explosionTNT(tJuego juego, tEstado estado){ //Explosion TNT
    estado = JUGANDO;
    int coordX, coordY, j=1; // coordenadas TNT
    coordX =juego.mina.x + incF[1];
    coordY = juego.mina.y + incC[1];
    while(juego.mina.plano[juego.mina.x + j*incF[1]][juego.mina.y+ j*incC[1]] != DINAMITA){// Sacamos coordenadas del TNT
        coordX =+ incF[1]; // Actualizamos coordenadas
        coordY =+ incC[1];
        j++; // Contador
    }
    for(int i=0; i <= 7; i++){
        if (juego.mina.plano[coordX + incF[i]][coordY + incC[i]] == MINERO){ // Si alguna de las casilla donde alcanza la dinamita es el minero game over
            estado = OVER;
        }
        juego.mina.plano[coordX + incF[i]][coordY + incC[i]] = LIBRE;
    }
    
}