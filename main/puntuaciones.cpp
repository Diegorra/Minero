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

bool cargar_Marcador(tPuntuaciones& marcador) {// funcion que carga de un archivo los perfiles de los jugadores
    int j=0;
    tPuntuaciones puntuaciones;
    string nombreJ;
    ifstream fichero;
    bool cargar = true;
    fichero.open("puntuaciones.txt");
    if (fichero.is_open()) {
        inicializa_Marcador(marcador);//solo inicializamos el puntero en caso de poder acceder al archivo
        fichero >> nombreJ;
        while(nombreJ != "000") { //mientras no lleguemos al centinela...
            if (marcador.num_jugs == marcador.capacidad)
            { // si excedemos el numero de jugadores que soporta nuestro array_clasification debemos ampliarlo
                aumentar_capacidad(marcador);
            }
            marcador.array_clasification[marcador.num_jugs].nombre = nombreJ;
            fichero >> marcador.array_clasification[marcador.num_jugs].punt_total;
            fichero >> marcador.array_clasification[marcador.num_jugs].numMinas;
            for(int k=0; k < marcador.array_clasification[marcador.num_jugs].numMinas; k++){
                fichero >> j; //sacamos la mina
                marcador.array_clasification[marcador.num_jugs].vMinasRecorridas[j].Idmina = j;//cargamos el valor de la mina en el Idmina
                fichero >> marcador.array_clasification[marcador.num_jugs].vMinasRecorridas[j].numMov;
                fichero >> marcador.array_clasification[marcador.num_jugs].vMinasRecorridas[j].numGem;
                fichero >> marcador.array_clasification[marcador.num_jugs].vMinasRecorridas[j].numTNT;
                fichero >> marcador.array_clasification[marcador.num_jugs].vMinasRecorridas[j].puntos;
            }
            marcador.num_jugs++; //en cada iteracion actualizamos nuestro num_jugs
            fichero >> nombreJ;
        }
    }
    else
    {
        cargar = false; //si no se pudo abrir el archivo retornamos false
    }
    fichero.close();
    return cargar;
}

bool guardar_Marcador(tPuntuaciones& marcador) {// cargamos en un fichero el marcador
    ofstream fichero;
    bool guardar = true;
    fichero.open("Puntuaciones.txt");
    if (fichero.is_open()) {
        for (int i = 0; i < marcador.num_jugs; i++) {//cargamos los datos 
            fichero << marcador.array_clasification[i].nombre << endl;
            fichero << marcador.array_clasification[i].punt_total << endl;
            fichero << marcador.array_clasification[i].numMinas << endl;
            for (int j = 1; j <= 5; j++) {
                if(marcador.array_clasification[i].vMinasRecorridas[j].numMov != 0){//de esta forma evitamos cargar minas vacias
                    fichero << marcador.array_clasification[i].vMinasRecorridas[j].Idmina << " " << marcador.array_clasification[i].vMinasRecorridas[j].numMov << " " << marcador.array_clasification[i].vMinasRecorridas[j].numGem << " " << marcador.array_clasification[i].vMinasRecorridas[j].numTNT << " " << marcador.array_clasification[i].vMinasRecorridas[j].puntos << endl;
                }
            }
        }
        fichero << "000" << endl; //escribimios nuestro centinela al terminar de cargar los datos
    }
    else {
        guardar = false; //si no conseguimos abrir el archivo retornamos false
    }
    fichero.close();
    return guardar;
}

void mostar_Minas_usuario(const tPuntuaciones& marcador, int cont) {//sacamos por pantalla la informacion de un usuario
    bool mostrar1 = true;
    cout << endl;
    cout << marcador.array_clasification[cont].nombre << " " << "Movimientos " << "Gemas " << "Dinamita " << "Puntos " << "Puntos en total " << endl;
    for (int i = 1; i <= 5; i++) {
        if(marcador.array_clasification[cont].vMinasRecorridas[i].numMov != 0){//de esta forma solo sacamos por pantalla minas inicializadas
            cout << "Mina " << marcador.array_clasification[cont].vMinasRecorridas[i].Idmina << setw(10) << marcador.array_clasification[cont].vMinasRecorridas[i].numMov << setw(8) << marcador.array_clasification[cont].vMinasRecorridas[i].numGem << setw(6) << marcador.array_clasification[cont].vMinasRecorridas[i].numTNT << setw(10) << marcador.array_clasification[cont].vMinasRecorridas[i].puntos;
            if (mostrar1) { //solo entra en la primera entrada del bucle
                cout << setw(12) << marcador.array_clasification[cont].punt_total << endl;
                mostrar1 = false;
            }
            else {
                cout << endl;
            }
        }
    }
}

void mostrar_Alfabetico(const tPuntuaciones& marcador) {//sacamos la puntuacion de los usuarios ordenados alfabeticamente
    cout << "------------------- LISTA DE JUGADORES -------------------" << endl;
    for (int i = 0; i < marcador.num_jugs; i++) {
        cout << setw(28)  << marcador.array_clasification[i].nombre << " " << marcador.array_clasification[i].punt_total << endl;
    }
}

void mostar_Datos_Usuario(const tPuntuaciones& marcador) { //mostramos toda la informacion de todos los usuarios
    cout << "------------------- JUGADORES ORDENADOS POR NOMBRE -------------------" << endl;
    for (int i = 0; i < marcador.num_jugs; i++) {
        mostar_Minas_usuario(marcador, i);
        cout << endl;
    }
    system("pause");
}

void inicializa_Marcador(tPuntuaciones& marcador) {//funcion que inicializa el array dinamico
    marcador.array_clasification = new tPuntuacionesJug[marcador.capacidad];
}

void aumentar_capacidad(tPuntuaciones& marcador) {//funcion que duplica la capacidad del array
    tPuntuacionesJug* aux = new tPuntuacionesJug[2 * marcador.capacidad]; //inicializamos un nuevo array dinamico con el doble de capacidad
    for (int i = 0; i < marcador.capacidad; i++) {
        aux[i] = marcador.array_clasification[i];//copiamos los datos
    }
    destruir(marcador); //liberamos el array dinamico
    marcador.capacidad *= 2; //duplicamos la capacidad del array
    marcador.array_clasification = aux; //volvemos a cargar los datos en el array
    aux = nullptr; //eliminamos el array aux creado
}

void destruir(tPuntuaciones& marcador) {//liberar la memoria
    delete[] marcador.array_clasification;
}

bool buscar(tPuntuaciones& marcador, const string& nombre, int& pos) {//debido a que contamos con una lista ordenada busqueda binaria
    bool encontrado = false;
    int ini = 0, fin = marcador.num_jugs-1, mitad; //para preservar los valores
    while (!encontrado && (ini <= fin)) {
        mitad = (ini + fin) / 2; //de esta forma vamos acotando el rango de valores
        if (nombre == marcador.array_clasification[mitad].nombre) {
            encontrado = true;
            pos = mitad;
        }
        else if (nombre < marcador.array_clasification[mitad].nombre) {
            fin = mitad - 1;
        }
        else {
            ini = mitad + 1;
        }
    }
    if (!encontrado) { //si no lo encuentra retorna la posicion donde deberia estar
        pos = ini;
    }
    return encontrado;
}

void insertar(tPuntuaciones& marcador, string const& nombre, int& pos) {// realizaremos la insercion de un usuario preservando el orden
    int i = 0;
    if (marcador.num_jugs == marcador.capacidad) { //si tenemos un array completo ampliamos
        aumentar_capacidad(marcador);
    }
    for (int j = marcador.num_jugs-1; j >= pos; j--) {//corremos desde la posicion todos los elementos una casilla
        marcador.array_clasification[j+1] = marcador.array_clasification[j];
    }
    inicializa(marcador, pos);//evitamos que queden dato en la posicion inicializando a 0
    marcador.array_clasification[pos].nombre = nombre; //insertamos
    marcador.num_jugs++; //actualizamos contador
}

int menuMarcador(string nombreJug) { //desarrollo de marcador
    int num = 0;
    system("pause");
    cout << nombreJug << ", Que mina quieres explorar?" << endl;
    cout << "Introduce un numero entre 1 y 5 para explorar la mina o 0 para salir : ";
    cin >> num;
    while (num > 5 || num < 0) {
        system("clear");
        cout << "ERROR, el numero introducido no es valido" << endl;
        cin >> num;
    }
    return num;
}

void anadirDatos(tPuntuaciones& marcador, int Idmina, int numMov, int numGem, int numTNT, int puntos, int pos) {
    if (marcador.array_clasification[pos].vMinasRecorridas[Idmina].numMov == 0) { //recorrera una nueva mina en el caso de que no estuviera recorrida
        marcador.array_clasification[pos].numMinas++;
    }
    else { //si vuelve a recorre la mina restamos la puntuacion
        marcador.array_clasification[pos].punt_total -= marcador.array_clasification[pos].vMinasRecorridas[Idmina].puntos; //de esta manera evitamos contar dos veces la puntuacion de una mina
    }
    marcador.array_clasification[pos].vMinasRecorridas[Idmina].Idmina = Idmina;
    marcador.array_clasification[pos].vMinasRecorridas[Idmina].numMov = numMov;
    marcador.array_clasification[pos].vMinasRecorridas[Idmina].numGem = numGem;
    marcador.array_clasification[pos].vMinasRecorridas[Idmina].numTNT = numTNT;
    marcador.array_clasification[pos].vMinasRecorridas[Idmina].puntos = puntos;
    marcador.array_clasification[pos].punt_total += marcador.array_clasification[pos].vMinasRecorridas[Idmina].puntos = puntos;
}

void inicializa(tPuntuaciones& marcador, int pos){//funcion que inicializa una determinada posicion del marcador
    marcador.array_clasification[pos].numMinas = 0;
    marcador.array_clasification[pos].punt_total = 0;
    for (int i = 0; i <= 5; i++) {
        marcador.array_clasification[pos].vMinasRecorridas[i].numMov = 0;
        marcador.array_clasification[pos].vMinasRecorridas[i].numGem = 0;
        marcador.array_clasification[pos].vMinasRecorridas[i].numTNT = 0;
        marcador.array_clasification[pos].vMinasRecorridas[i].puntos = 0;
    }
}