//Práctica del minero FP2 versión 1
//Realizada por Diego Ramón Sanchis grupo A; FP2-A56 dieramon@ucm.es
//				Diego Alvarez Carretero grupo A; FP2-A04
#include <iostream>;
#include <fstream>
using namespace std;
#include "juego.h"
//TIPOS
const int nivelM = 5;
//PROTOTIPOS
int menu1();
int menu2();
int menu3();

int main(){
	int opcion1=0, opcion2=0, opcion3=0;
	tEstado estado = JUGANDO;
	tJuego juego;
	int nivel = 1;
	while (estado == JUGANDO) {
		cargar_Juego(juego, nivel);
		opcion1 = menu1();
		system("CLS");
		switch (opcion1) {
		case 1: {
			opcion2 = menu2();
			system("CLS");
			switch (opcion2) {
			case 1: {
				estado = jugar(juego, 1);
			}break;
			case 2: {
				estado = jugarFichero(juego, 1);
			}break;
			case 3: {estado = ABANDONA; }break;
			}
		}break;
		case 2: {
			opcion2 = menu2();
			switch (opcion2){
			case 1: {
				estado = jugar(juego, 2);
			}break;
			case 2: {
				estado = jugarFichero(juego, 2);
			}break;
			case 3: {estado = ABANDONA; }break;
			}
		}break;
		case 3: {estado = ABANDONA;}break;
		}
		system("CLS");
		if (estado == FIN){
			if (nivel == nivelM) {
				estado = ABANDONA;
				cout << "Fin del juego" << endl;
				system("pause");
			}
			else {
				opcion3 = menu3();
				system("CLS");
				switch (opcion3) {
				case 1: {estado = JUGANDO; }break;
				case 0: {estado = ABANDONA; }break;
				}
			}
		}
		if (estado == ABANDONA){
			system("exit");
		}
		if (estado == OVER){
			cout << "Moriste enterrado :(" << endl;
			system("pause");
		}
		system("CLS");
	}
}

int menu1() {
	int opcion = 0;
	cout << "1. Jugar a escala 1:1" << endl;
	cout << "2. Jugar a escala 1:3" << endl;
	cout << "3. Salir" << endl;
	cin >> opcion;
	while (opcion < 0 || opcion > 3) {
		cout << "ERROR debe introducir un numero entre 0 y 3" << endl;
		cin >> opcion;
	}
	return opcion;
}

int menu2() {
	int opcion = 0;
	cout << "1. Introducir movimientos por teclado" << endl;
	cout << "2. Introducir movimientos por fichero" << endl;
	cout << "3. Salir" << endl;
	cin >> opcion;
	while (opcion < 0 || opcion > 3)
	{
		cout << "ERROR debe introducir un numero entre 0 y 3" << endl;
		cin >> opcion;
	}
	return opcion;
}

int menu3() {
	int opcion = 0;
	cout << "1. Jugar siguiente nivel" << endl;
	cout << "0. Salir" << endl;
	cin >> opcion;
	while (opcion < 0 || opcion > 1)
	{
		cout << "ERROR debe introducir un numero entre 0 y 3" << endl;
		cin >> opcion;
	}
	return opcion;
}


