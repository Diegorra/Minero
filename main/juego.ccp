#include <iostream>
#include <fstream>
#include <string>
#include <string.h>
using namespace std;
#include <ObjectArray.h>
#include "juego.h"
const int incF[4]={0, 0, 1, -1};
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
    switch(tecla){
        case 0 :{// ARRIBA
            if (puede_hacer_mov()){ //Puede hacer mov
                juego.mina.plano[juego.mina.x][juego.mina.y] = juego.mina.plano[juego.mina.x + incF[0]][juego.mina.y + incC[0]]; //MInero desplaza arriba
                juego.mina.plano[juego.mina.x][juego.mina.y] = TIERRA; // La excasilla del minero se rellena con tienrra
            }
            else
            {
                hacerlo = false;
            }
        }
        break; 
        case 1 :{// ABAJO
            if (){ //Puede hacer mov
                juego.mina.plano[juego.mina.x][juego.mina.y] = juego.mina.plano[juego.mina.x + incF[1]][juego.mina.y + incC[1]];
                juego.mina.plano[juego.mina.x][juego.mina.y] = TIERRA;
            }
            else
            {
                hacerlo = false;
            }
        }break; 
        case 2 :{ //DRCHA
            if (){ //Puede hacer mov
                juego.mina.plano[juego.mina.x][juego.mina.y] = juego.mina.plano[juego.mina.x + incF[2]][juego.mina.y + incC[2]];
                juego.mina.plano[juego.mina.x][juego.mina.y] = TIERRA;
            }
            else
            {
                hacerlo = false;
            }
        }break; 
        case 3 :{
            if(){ //Puede hacer mov
                juego.mina.plano[juego.mina.x][juego.mina.y] = juego.mina.plano[juego.mina.x + incF[3]][juego.mina.y + incC[3]];
                juego.mina.plano[juego.mina.x][juego.mina.y] = TIERRA;
            }
            else{
                hacerlo = false;
            }
        }break; // IZDA
        case 4 :{
            hacerlo = false;
        }break; //SALIR
        case 5 :{
            hacerlo = false;
        }break; //NADA
        case 6 :{}break; //TNT!!!!!!!!!!!!!
    }
}
void dibujar(const tJuego &juego){}

bool puede_hacer_mov(const tJuego &juego, tTecla tecla){
     bool puede = true;
    if (juego.mina.x + incF[0] < 0 || juego.mina.y + incC[0] < 0 || juego.mina.x + incF[0] > juego.mina.nFilas || juego.mina.y + incC[0]> juego.mina.nColumnas)
        puede = false;
    }
    return puede;
 }
tTecla leerTecla(){
    tTecla t;
    cin.sync();
    int dir;
    dir = _getch();
    if(dir == 0xe0){
        dir=_getch();
        switch(dir){
            case 72: {t = ARRIBA;}break;
            case 80:{t= ABAJO;}break;
            case 77:{t= DRCHA;}break;
            case 75:{t= IZDA;}break;
        }
    }
    else if(dir == 27){
        t= SALIR;
    }
    else if(dir == 68 || dir == 100){
        t = TNT;
    }
    else{
        t= NADA;
    }
}