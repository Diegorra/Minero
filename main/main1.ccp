//Práctica del minero FP2 versión 1
#include <iostream>;
#include <fstream>
using namespace std;
#include "juego.h"
//TIPOS
typedef enum { ARRIBA, ABAJO, DRCHA, IZDA, SALIR, NADA, TNT }tTecla;
//PROTOTIPOS
int menu1();
int menu2();
int menu3();
tTecla leerTecla();
void colorFondo(int color);

int main()
{
	int opcion1;
	opcion1 = menu1();
	switch(opcion1){
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
			system("EXIT");
		}break;
	}
}

int menu1()
{
	int opcion;
	cout << "1. Jugar a escala 1:1" << endl;
	cout << "2. Jugar a escala 1:3" << endl;
	cout << "3. Salir" << endl;
	cin >> opcion;
	while (opcion < 0 && opcion > 3)
	{
		cout << "ERROR debe introducir un numero entre 0 y 3" << endl;
		cin >> opcion;
	}
	return opcion;
}

int menu2()
{
	int opcion;
	cout << "1. Introducir movimientos por teclado" << endl;
	cout << "2. Introducir movimientos por fichero" << endl;
	cout << "3. Salir" << endl;
	cin >> opcion;
	while (opcion < 0 && opcion > 3)
	{
		cout << "ERROR debe introducir un numero entre 0 y 3" << endl;
		cin >> opcion;
	}
	return opcion;
}

int menu3()
{
	int opcion;
	cout << "1. Jugar siguiente nivel" << endl;
	cout << "0. Salir" << endl;
	cin >> opcion;
	while (opcion < 0 && opcion > 1)
	{
		cout << "ERROR debe introducir un numero entre 0 y 3" << endl;
		cin >> opcion;
	}
	return opcion;
}

