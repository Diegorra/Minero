#include <iostream>
#include <fstream>
using namespace std;
#include <ObjectArray.h>
#include "mina.h"

void cargar_Mina(ifstream &fichero, string nombre, tMina & mina){//He añadido el nombre debido a que es el nombre de nuestro archivo!
    int filas, columnas, i=0, j=0;
    tCasilla casilla;
    fichero.open(nombre);
    if(fichero.is_open){
        cin >> mina.nFilas; // cargamos numero de filas y columnas de nuestra mina
        cin >> mina.nColumnas;
        while (i < mina.nFilas){
            j = 0;
            while (j < mina.nColumnas){
                mina.plano[i][j] = casilla; // asignamos al plano lo que corresponda o un muro o una gema...
                if(casilla == MINERO){ // Si encontramos el tipo minero guardamos sus coordenadas
                    i= mina.x;
                    j= mina.y;
                }
                j++;
            }
            i++;
        }
    }
    else{
        cout << "ERROR al abrir el archivo" << endl;
    }
}
void dibujar1_1(const tMina &mina){}
void dibujar1_3(const tMina &mina){}
void dibuja3x3(tCasilla casilla, tPlanoCaracteres caracteres, tPlanoColores colores, int i, int j){}
