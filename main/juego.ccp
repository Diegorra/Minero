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
    aux = to_string(nivel); // Convertir entero a string
    aux+=".txt";
    ifstream fichero(aux); 
    cargar_Mina(fichero, mina);
    nivel++;
}

bool hacerMovimiento(tJuego &juego, tTecla tecla){
    bool hacerlo = true;
    int i=0;
    string opcion;
    switch(tecla){
        case 0 :{// ARRIBA
            if (puede_hacer_mov(juego, i)){ //Puede hacer mov
                juego.mina.plano[juego.mina.x + incF[0]][juego.mina.y + incC[0]] = juego.mina.plano[juego.mina.x][juego.mina.y]; //Minero desplaza arriba
                juego.mina.plano[juego.mina.x][juego.mina.y] = TIERRA; // La excasilla del minero se rellena con tienrra
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
            }
            else{
                hacerlo = false;
            }
        }break; 
        case 4 :{ //SALIR
            cout << "Seguro que quieres salir?(SI/NO)";
            cin << opcion;
            if(opcion == "SI"){
                system("clear");
            }
            else{
                hacerlo = false;
            }
        }break; 
        case 5 :{ //NADA
            hacerlo = false;
        }break; 
        case 6 :{}break; //TNT!!!!!!!!!!!!!
    }
}

void dibujar(const tJuego &juego){}

bool puede_hacer_mov(const tJuego &juego, int i){
    bool puede = true;
    if (juego.mina.x + incF[i] < 0 || juego.mina.y + incC[i] < 0 || juego.mina.x + incF[i] > juego.mina.nFilas || juego.mina.y + incC[i]> juego.mina.nColumnas){
        puede = false;
    }
    return puede;
}
