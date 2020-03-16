#pragma once
#include <iostream>
#include <fstream>
#include <conio.h>
using namespace std;
#include <ObjectArray.h>
#include "mina.h"

//TIPOS
typedef enum
{ARRIBA, ABAJO, DRCHA, IZDA, SALIR, NADA, TNT } tTecla;

typedef struct {
	tMina mina;
	int gem = 0, numMov = 0, numTNT=0;
}tJuego;

//PROTOTIPOS
bool cargar_Juego(tJuego &juego, int &nivel);
bool hacerMovimiento(tJuego &juego, tTecla tecla);
void dibujar(const tJuego &juego);
bool puede_hacer_mov(const tJuego &juego, int i);