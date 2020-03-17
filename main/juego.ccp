#include <iostream>
#include <fstream>
#include <string>
#include <string.h>
using namespace std;
#include <ObjectArray.h>
#include "juego.h"
const int incF[4]={0, 0, 1, -1}; //arriba, abajo, derecha, izquierda
const int incC[4]={1, -1, 0, 0};

bool cargar_Juego(tJuego &juego, int &nivel){
    string aux;
    tMina mina;
    bool carga = true;
    aux = to_string(nivel); // Convertir entero a string
    aux+=".txt";
    ifstream fichero(aux); 
    if(fichero.is_open){
        cargar_Mina(fichero, mina);
    }else{
        cout <<"ERROR" << endl;
        carga = false;
    }
    nivel++;
    return carga;
}

bool hacerMovimiento(tJuego &juego, tTecla tecla){//Ve si puede hacer mov, si es asi mueve
    bool hacerlo = true;
    int i=0;
    tEstado estado;
    estado = JUGANDO;
    switch(tecla){
        case 0 :{// ARRIBA
            if (puede_hacer_mov(juego, i) && juego.mina.plano[juego.mina.x + incF[0]][juego.mina.y + incC[0]]!= PIEDRA){// Puede hacer mov y la casilla no es piedra                                                                                                                    //Puede hacer mov
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
            if (puede_hacer_mov(juego, i) && juego.mina.plano[juego.mina.x + incF[1]][juego.mina.y + incC[1]] != PIEDRA){ //Puede hacer mov y la casilla no es piedra
                estado = casilla_deplaza(juego, i); //Valoramos casos especiales que haya una gema, salida
                mover(juego, i);
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
                mover(juego, i);
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
                mover(juego, i);
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
        case 6 :{ //TNT!!!!!!!!!!!!!
            //...
        }
        break;
    }
    juego.numMov++;
    return hacerlo;
}

void dibujar(const tJuego &juego, int opcion){// dibujamos el juego
    if(opcion == 1){
        dibujar1_1(juego.mina);
    }
    else{
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
    juego.mina.plano[juego.mina.x][juego.mina.y] = TIERRA; // La excasilla del minero se rellena con tierra
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
        gravedad(juego);
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

void consecuencias_mov(tJuego &juego, int i){// Consecuencias del movimiento que ha hecho
    //Habia una piedra encima > cae cascada
}
void gravedad(tJuego &juego){ // caida de un objeto hasta encontrar un obstaculo

}