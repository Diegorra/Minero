#pragma once
#include <iostream>
#include <fstream>
#include <conio.h>
using namespace std;
#include <ObjectArray.h>
#include "mina.h"

//TIPOS
typedef enum {ARRIBA, ABAJO, DRCHA, IZDA, SALIR, NADA, TNT } tTecla;
typedef enum {JUGANDO, ABANDONA, FIN, OVER}tEstado;
typedef struct {
	tMina mina;
	int gem = 0, numMov = 0, numTNT=0;
}tJuego;

//PROTOTIPOS
bool cargar_Juego(tJuego &juego, int &nivel);
bool hacerMovimiento(tJuego &juego, tTecla tecla);
void dibujar(const tJuego &juego, int i);
bool puede_hacer_mov(tJuego &juego, int i);
void mover(tJuego &juego, int i);
tEstado casilla_deplaza(tJuego &juego, int i);
bool movilidad_piedra(tJuego &juego, int i);
void caidaCascada(tJuego &juego, int iniX, int iniY);
void desplazamiento_horizontal(tJuego &juego, int i);
void explosionTNT(tJuego juego, tEstado estado);