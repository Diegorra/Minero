//Pr�ctica del minero FP2 versi�n 1
//Realizada por Diego Ram�n Sanchis grupo A; FP2-A56 dieramon@ucm.es
//				Diego Alvarez Carretero grupo A; FP2-A04
#include <iostream>
#include <fstream>
#include <string>
#include <string.h>
using namespace std;
#include <ObjectArray.h>
#include "puntuaciones.h"

bool cargar_Marcador(tPuntuaciones &marcador){// funcion que carga de un archivo los perfiles de los jugadores
    int i=0;
    tPuntuaciones puntuaciones;
    string nombreJ, fin =000;
    cin >> nombreJ;
    while (nombreJ != fin) {//mientras no lleguemos al centinela...
        marcador.array_clasification[i] = new tPuntuacionesJug; //inicializamos el jugador i
        marcador.array_clasification[i]->nombre = nombreJ;
        cin >> marcador.array_clasification[i]->pun_total;
        cin >> marcador.array_clasification[i]->numMinas;
        for (int j = 0; j < marcador.array_clasification[i]->numMinas; j++){
            cin >> marcador.array_clasification[i]->vMinasRecorridas[j].Idmina;
            cin >> marcador.array_clasification[i]->vMinasRecorridas[j].numMov;
            cin >> marcador.array_clasification[i]->vMinasRecorridas[j].numGem;
            cin >> marcador.array_clasification[i]->vMinasRecorridas[j].numTNT;
            cin >> marcador.array_clasification[i]->vMinasRecorridas[j].puntos;
        }
        marcador.num_jugs = i; //en cada iteracion actualizamos nuestro num_jugs
        i++;
        if(i>=DIM){ // si excedemos el numero de jugadores que soporta nuestro array_clasification debemos ampliarlo
            ampliarDIM(marcador);
        }
    }
    
}