//Práctica del minero FP2 versión 1
//Realizada por Diego Ramón Sanchis grupo A; FP2-A56 dieramon@ucm.es
//				Diego Alvarez Carretero grupo A; FP2-A04
#pragma once
#include <iostream>
#include <fstream>
#include <conio.h>
using namespace std;
#include <ObjectArray.h>
#include "mina.h"

//TIPOS
typedef enum { ARRIBA, ABAJO, DRCHA, IZDA, SALIR, NADA, TNT } tTecla;
typedef enum { JUGANDO, ABANDONA, FIN, OVER }tEstado;
typedef struct {
	tMina mina;
	int gem = 0, numMov = 0, numTNT = 0;
}tJuego;
const int incF[8] = { -1, 1, 0, 0, 1, -1, -1, 1 }; //arriba, abajo, derecha, izquierda, diagonales
const int incC[8] = { 0, 0, 1, -1, 1, 1, -1, -1 };

//PROTOTIPOS
bool cargar_Juego(tJuego& juego, int& nivel);
tEstado hacerMovimiento(tJuego& juego, tTecla tecla, int opcion);
void dibujar(const tJuego& juego, int i);
bool puede_hacer_mov(tJuego& juego, int i);
void mover(tJuego& juego, int i);
tEstado casilla_deplaza(tJuego& juego, int i);
bool movilidad_piedra(tJuego& juego, int i);
void caidaCascada(tJuego& juego, int iniX, int iniY);
void desplazamiento_horizontal(tJuego& juego, int i);
tEstado explosionTNT(tJuego& juego);
bool dentroPlano(tJuego& juego, int x, int y);
tEstado jugar(tJuego& juego, int opcion);
tEstado jugarFichero(tJuego& juego, int opcion);
tTecla leerTecla();
tTecla extraerFichero(char c);
