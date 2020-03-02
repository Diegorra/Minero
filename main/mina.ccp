#include <iostream>
#include <fstream>
using namespace std;
#include <ObjectArray.h>
#include "mina.h"

void cargar_Mina(ifstream &fichero, tMina &mina){
    int filas, columnas, i=0, j=0;
    tCasilla casilla;
    cin >> mina.nFilas; // cargamos numero de filas y columnas de nuestra mina
    cin >> mina.nColumnas;
    while (i < mina.nFilas)
    {
        j=0;
        while (j < mina.nColumnas)
        {
            mina.plano[i][j]= casilla; // asignamos al plano lo que corresponda o un muro o una gema...
        }
    }
}
void dibujar1_1(const tMina &mina){}
void dibujar1_3(const tMina &mina){}
void dibuja3x3(tCasilla casilla, tPlanoCaracteres caracteres, tPlanoColores colores, int i, int j){}
