//Pr�ctica del minero FP2 versi�n 1
//Realizada por Diego Ram�n Sanchis grupo A; FP2-A56 dieramon@ucm.es
//				Diego Alvarez Carretero grupo A; FP2-A04
#include <iostream>
#include <fstream>
#include <string>
#include <string.h>
#include <iomanip>
using namespace std;
#include <ObjectArray.h>
#include "puntuaciones.h"

//OJO considerar ordenar en aquella funciones que asi lo precisen

bool cargar_Marcador(tPuntuaciones &marcador){// funcion que carga de un archivo los perfiles de los jugadores
    int i=0;
    tPuntuaciones puntuaciones;
    string nombreJ, fin =000;
    ifstream fichero;
    bool cargar = true;
    fichero.open("Puntuaciones.txt");
    if (fichero.is_open()){
        inicializa_Marcador(marcador);//solo inicializamos el puntero en caso de poder acceder al archivo
        fichero >> nombreJ;
        while (nombreJ != fin){ //mientras no lleguemos al centinela...
            marcador.array_clasification[i].nombre = nombreJ;
            fichero >> marcador.array_clasification[i].punt_total;
            fichero >> marcador.array_clasification[i].numMinas;
            for (int j = 0; j < marcador.array_clasification[i].numMinas; j++){
                fichero >> marcador.array_clasification[i].vMinasRecorridas[j].Idmina;
                fichero >> marcador.array_clasification[i].vMinasRecorridas[j].numMov;
                fichero >> marcador.array_clasification[i].vMinasRecorridas[j].numGem;
                fichero >> marcador.array_clasification[i].vMinasRecorridas[j].numTNT;
                fichero >> marcador.array_clasification[i].vMinasRecorridas[j].puntos;
            }
            marcador.num_jugs = i; //en cada iteracion actualizamos nuestro num_jugs
            i++;
            if (i >= marcador.capacidad)
            { // si excedemos el numero de jugadores que soporta nuestro array_clasification debemos ampliarlo
                aumentar_capacidad(marcador);
            }
        }
    }
    else
    {
        cargar = false; //si no se pudo abrir el archivo retornamos false
    }
    return cargar;  
}

bool guardar_Marcador(tPuntuaciones &marcador){// cargamos en un fichero el marcador
    ofstream fichero;
    bool guardar=true;
    fichero.open("Puntuaciones.txt");
    if(fichero.is_open()){
        for(int i=0; i < DIM; i++){//cargamos los datos 
            fichero << marcador.array_clasification[i].nombre << endl;
            fichero << marcador.array_clasification[i].punt_total << endl;
            fichero << marcador.array_clasification[i].numMinas << endl;
            for (int j = 0; j < marcador.array_clasification[i].numMinas; j++){
                fichero << marcador.array_clasification[i].vMinasRecorridas[j].Idmina << " " << marcador.array_clasification[i].vMinasRecorridas[j].numMov << " " << marcador.array_clasification[i].vMinasRecorridas[j].numGem << " " << marcador.array_clasification[i].vMinasRecorridas[j].numTNT << " " << marcador.array_clasification[i].vMinasRecorridas[j].puntos << endl;
            }
        }
        fichero << "000" <<endl; //escribimios nuestro centinela al terminar de cargar los datos
        destruir(marcador); //una vez guardado en un archivo liberamos memoria
    }
    else{
        guardar = false; //si no conseguimos abrir el archivo retornamos false
    }
    return guardar;
}

void mostar_Minas_usuario(const tPuntuaciones &marcador, int cont){//sacamos por pantalla la informacion de un usuario
    cout << marcador.array_clasification[cont].nombre << " " << "Movimientos " << "Gemas " << "Dinamita " << "Puntos " << "Puntos en total " << endl;
    for(int i=0; i< marcador.array_clasification[cont].numMinas;i++){ 
        cout << "Mina " << marcador.array_clasification[cont].vMinasRecorridas[i].Idmina << "   " << marcador.array_clasification[cont].vMinasRecorridas[i].numMov << "   " << marcador.array_clasification[cont].vMinasRecorridas[i].numGem << "   " << marcador.array_clasification[cont].vMinasRecorridas[i].numTNT << "   " << marcador.array_clasification[cont].vMinasRecorridas[i].puntos << "   " << marcador.array_clasification[cont].punt_total << endl;
    }
}

void mostrar_Alfabetico(const tPuntuaciones &marcador){//sacamos la puntuacion de los usuarios ordenados alfabeticamente
    cout << "------------------- LISTA DE JUGADORES -------------------" << endl;
    for(int i=0; i<= marcador.num_jugs; i++){
        cout << setw(22)<< marcador.array_clasification[i].punt_total << endl;
    }
}

void mostar_Datos_Usuario(const tPuntuaciones &marcador){ //mostramos toda la informacion de todos los usuarios
    cout << "------------------- JUGADORES ORDENADOS POR NOMBRE -------------------" << endl;
    for (int i=0; i < marcador.num_jugs; i++){
        mostar_Minas_usuario(marcador, i);
    }
}

void inicializa_Marcador(tPuntuaciones &marcador){//funcion que inicializa el array dinamico
    marcador.array_clasification = new tPuntuacionesJug[marcador.capacidad]; 
}

void aumentar_capacidad(tPuntuaciones &marcador){//funcion que duplica la capacidad del array
    tPuntuacionesJug *aux = new tPuntuacionesJug[2 * marcador.capacidad]; //inicializamos un nuevo array dinamico con el doble de capacidad
    for(int i=0; i < marcador.capacidad; i++){
        aux[i] = marcador.array_clasification[i];//copiamos los datos
    }
    destruir(marcador); //liberamos el array dinamico
    marcador.capacidad *= 2; //duplicamos la capacidad del array
    marcador.array_clasification = aux; //volvemos a cargar los datos en el array
    aux = nullptr; //eliminamos el array aux creado
}

void destruir(tPuntuaciones &marcador){//liberar la memoria
    delete [] marcador.array_clasification;
}
