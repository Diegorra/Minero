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

bool hacerMovimiento(tJuego &juego, tTecla tecla){
    bool hacerlo = true;
    int i=0;
    tEstado estado;
    string opcion;
    estado = JUGANDO;
    switch(tecla){
        case 0 :{// ARRIBA
            if (puede_hacer_mov(juego, i)){ //Puede hacer mov
                juego.mina.plano[juego.mina.x + incF[0]][juego.mina.y + incC[0]] = juego.mina.plano[juego.mina.x][juego.mina.y]; //Minero desplaza arriba
                juego.mina.plano[juego.mina.x][juego.mina.y] = TIERRA; // La excasilla del minero se rellena con tienrra
                juego.numMov++;
            }
            else
            {
                hacerlo = false;
            }
        }
        break; 
        case 1 :{// ABAJO
            i=1;
            if (puede_hacer_mov(juego, i)){ //Puede hacer mov
                juego.mina.plano[juego.mina.x + incF[1]][juego.mina.y + incC[1]] = juego.mina.plano[juego.mina.x][juego.mina.y];
                juego.mina.plano[juego.mina.x][juego.mina.y] = TIERRA;
                juego.numMov++;
            }
            else
            {
                hacerlo = false;
            }
        }break; 
        case 2 :{ //DRCHA
            i=2;
            if (puede_hacer_mov(juego, i)){ //Puede hacer mov
                juego.mina.plano[juego.mina.x + incF[2]][juego.mina.y + incC[2]] = juego.mina.plano[juego.mina.x][juego.mina.y];
                juego.mina.plano[juego.mina.x][juego.mina.y] = TIERRA;
                juego.numMov++;
            }
            else
            {
                hacerlo = false;
            }
        }break; 
        case 3 :{ // IZDA
            i = 3;
            if (puede_hacer_mov(juego, i)){ //Puede hacer mov
                juego.mina.plano[juego.mina.x + incF[3]][juego.mina.y + incC[3]] = juego.mina.plano[juego.mina.x][juego.mina.y];
                juego.mina.plano[juego.mina.x][juego.mina.y] = TIERRA;
                juego.numMov++;
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
            juego.numMov++;
        }break; 
        case 6 :{

        }break; //TNT!!!!!!!!!!!!!
    }
    if (juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] == SALIDA){ // Llega a la salida
        estado = FIN;
    }
    if (juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] == GEMA){ //Llega a una gema
        juego.gem++;
    }
    if (juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] == PIEDRA){ // Hay una roca
        // GRAVEDAD CAE
    }
    return hacerlo;
}

void dibujar(const tJuego &juego, int opcion){
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

bool puede_hacer_mov(const tJuego &juego, int i){
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
    //OJO si PIEDRA arriba o abajo no puede hacer mov;
    return puede;
}
