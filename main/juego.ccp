#include <iostream>
#include <fstream>
#include <string>
#include <string.h>
using namespace std;
#include <ObjectArray.h>
#include "juego.h"

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
    switch(tecla){

    }
}
void dibujar(const tJuego &juego){}
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