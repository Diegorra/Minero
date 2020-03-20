// Práctica del minero FP2 versión 1
#include <iostream>;
#include <fstream>
using namespace std;
#include "juego.h"

//PROTOTIPOS
int menu1();
int menu2();
int menu3();
tTecla leerTecla();
tTecla extraerFichero(char c);

int main()
{
	int opcion1, opcion2, opcion3;
	tEstado estado;
	tJuego juego;
	tTecla tecla;
	ifstream ficheroMOV;
	char c;
	int nivel = 1;
	opcion1 = menu1();
	estado = JUGANDO;
	while (estado == JUGANDO)
	{
		switch (opcion1)
		{
			cargar_Juego(juego, nivel);
		case 1:
		{
			opcion2 = menu2();
			switch (opcion2)
			{
			case 1:
			{
				tecla = leerTecla();
				dibujar(juego, 1);
				while (estado == JUGANDO)
				{
					hacerMovimiento(juego, tecla);
					dibujar(juego, 1);
				}
			}
			break;
			case 2:
			{
				//Extraer tecla de fichero
				ficheroMOV.open("movimientos.txt");
				if (ficheroMOV.is_open())
				{
					dibujar(juego, 1);
					while (estado == JUGANDO && tecla != NADA)
					{ // Mientras pueda jugar y no llegue al final del fichero
						ficheroMOV.get(c);
						tecla = extraerFichero(c);
						hacerMovimiento(juego, tecla);
						dibujar(juego, 1);
					}
				}
				else
				{
					cout << "ERROR" << endl;
					ficheroMOV.close();
				}
				break;
			case 3:
			{
				estado = ABANDONA;
			}
			}
			}
			break;
		}
		break;
		case 2:
		{
			opcion2 = menu2();
			switch (opcion2)
			{
			case 1:
			{
				tecla = leerTecla();
				dibujar(juego, 2);
				while (estado == JUGANDO)
				{
					hacerMovimiento(juego, tecla);
					dibujar(juego, 2);
				}
			}
			break;
			case 2:
			{
				//Extraer tecla de fichero
				ficheroMOV.open("movimientos.txt");
				if (ficheroMOV.is_open())
				{
					dibujar(juego, 2);
					while (estado == JUGANDO && tecla != NADA)
					{ // Mientras pueda jugar y no llegue al final del fichero
						ficheroMOV.get(c);
						tecla = extraerFichero(c);
						hacerMovimiento(juego, tecla);
						dibujar(juego, 2);
					}
				}
				else
				{
					cout << "ERROR" << endl;
					ficheroMOV.close();
				}
			}
			break;
			case 3:
			{
				estado = ABANDONA;
			}
			}
			break;
		}
		break;
		case 0:
		{
			estado = ABANDONA;
		}
		break;
		}
		if (estado = FIN)
		{
			opcion3 = menu3();
			switch (opcion3)
			{
			case 1:
			{
				estado = JUGANDO;
			}
			break;
			case 0:
			{
				estado = ABANDONA;
			}
			break;
			}
		}
		if (estado == ABANDONA)
		{
			system("exit");
		}
		if (estado == OVER)
		{
			cout << "Moriste enterrado :(" << endl;
		}
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

tTecla leerTecla()
{
	tTecla t;
	cin.sync();
	int dir;
	dir = _getch();
	if (dir == 0xe0)
	{
		dir = _getch();
		switch (dir)
		{
		case 72:
		{
			t = ARRIBA;
		}
		break;
		case 80:
		{
			t = ABAJO;
		}
		break;
		case 77:
		{
			t = DRCHA;
		}
		break;
		case 75:
		{
			t = IZDA;
		}
		break;
		}
	}
	else if (dir == 27)
	{
		t = SALIR;
	}
	else if (dir == 68 || dir == 100)
	{
		t = TNT;
	}
	else
	{
		t = NADA;
	}
	return t;
}

tTecla extraerFichero(char c)
{
	tTecla t;
	switch (c)
	{
	case 'A':
	{
		t = ARRIBA;
	}
	break;
	case 'z':
	{
		t = ABAJO;
	}
	break;
	case 'N':
	{
		t = DRCHA;
	}
	break;
	case 'M':
	{
		t = IZDA;
	}
	break;
	case ' ':
	{
		t = NADA;
	}
	break; //Si acaba el fichero
	}
	return t;
}
