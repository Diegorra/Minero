//Pr�ctica del minero FP2 versi�n 1
//Realizada por Diego Ram�n Sanchis grupo A; FP2-A56 dieramon@ucm.es
//				Diego Alvarez Carretero grupo A; FP2-A04
#pragma once
#include <iostream>
#include <fstream>
#include <conio.h>
using namespace std;
#include <ObjectArray.h>

//TIPOS
const int TOTAL_MINAS = 5;
const int DIM=2;
typedef struct{
    int Idmina = 0, numMov = 0, numGem = 0, numTNT = 0, puntos = 0;
} tDatosMina; //informacion de una mina

typedef struct{
    string nombre;
    int punt_total=0, numMinas=0;
    tDatosMina vMinasRecorridas[TOTAL_MINAS];
}tPuntuacionesJug; //informacion de un jugador

typedef struct{
    int capacidad=2, num_jugs=0;
    tPuntuacionesJug *array_clasification;//array dinamico
}tPuntuaciones; //informacion de todos los jugadores

//PROTOTIPOS
bool cargar_Marcador(tPuntuaciones& marcador);
bool guardar_Marcador(tPuntuaciones& marcador);
void mostar_Minas_usuario(const tPuntuaciones& marcador, int cont);
void mostrar_Alfabetico(const tPuntuaciones& marcador);
void mostar_Datos_Usuario(const tPuntuaciones& marcador);
//funciones array dinamico
void inicializa_Marcador(tPuntuaciones& marcador);
void aumentar_capacidad(tPuntuaciones& marcador);
void destruir(tPuntuaciones& marcador);
bool buscar(tPuntuaciones& marcador, const string& nombre, int& pos);
void insertar(tPuntuaciones& marcador, string const& nombre, int pos);
int menuMarcador(string nombreJug);
void anadirDatos(tPuntuaciones &marcador, int Idmina, int numMov, int numGem, int numTNT, int puntos, int pos);