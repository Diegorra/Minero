//Práctica del minero FP2 versión 1
#include <iostream>;
#include <fstream>
using namespace std;
#include "juego.h"
//TIPOS
typedef enum { ARRIBA, ABAJO, DRCHA, IZDA, SALIR, NADA, TNT }tTeca;
//PROTOTIPOS
int menu();

int menu() {
	int opcion;
	cout << "1. Jugar a escala 1:1" << endl;
	cout << "2. Jugar a escala 1:3" << endl;
	cout << "3. Salir" << endl;
	cin >> opcion;
	while (opcion < 0 && opcion > 3) {
		cout << "ERROR debe introducir un numero entre 0 y 3" <<  endl;
		cin >> opcion;
	}
	system("CLEAR");
	
	return opcion;
}

int main(){
	int opcion;
	opcion = menu();
	switch(opcion){
		case 1:
		{
			///
		}
		break;
		case 2:
		{
			///
		}break;
		case 0:
		{
			///
		}break;
	}
}