//Pr�ctica del minero FP2 versi�n 1
//Realizada por Diego Ram�n Sanchis grupo A; FP2-A56 dieramon@ucm.es
//				Diego Alvarez Carretero grupo A; FP2-A04 
#pragma once
#include <iostream>
#include <fstream>
#include <string>
#include <windows.h>
using namespace std;
#include <ObjectArray.h>

//TIPOS
typedef enum { LIBRE, TIERRA, GEMA, PIEDRA, MURO, SALIDA, DINAMITA, MINERO }tCasilla;

const int MAX = 50;

typedef tCasilla tPlano[MAX][MAX];
typedef char tPlanoCaracteres[3 * MAX][3 * MAX];
typedef int tPlanoColores[3 * MAX][3 * MAX];

typedef struct {
	tPlano plano;
	int nFilas = 0, nColumnas = 0;
	int x = 0, y = 0;
}tMina;

//PROTOTIPOS
void cargar_Mina(ifstream& fichero, tMina& mina);
tCasilla char2tCasilla(char c);
char tCasilla2char(const tMina& mina, int posX, int posY);
void colorFondo(int color);
void dibujar1_1(const tMina& mina);
void dibujar1_3(const tMina& mina);
void dibuja3x3(tCasilla casilla, tPlanoCaracteres caracteres, tPlanoColores colores, int i, int j);
void nada(tPlanoCaracteres caracteres, tPlanoColores colores, int i, int j, char c, int color);
