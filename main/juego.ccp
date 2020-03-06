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
    aux = to_string(nivel);
    aux+=".txt";
    ifstream fichero(aux);
    cargar_Mina(fichero, mina);
    nivel++;
}

bool hacerMovimiento(tJuego &juego, tTecla tecla){}
void dibujar(const tJuego &juego){}
