#include <iostream>
#include <fstream>
#include <string>
using namespace std;
#include <ObjectArray.h>
#include "mina.h"

void cargar_Mina(ifstream &fichero, tMina & mina){//He añadido el nombre debido a que es el nombre de nuestro archivo!
    int filas, columnas;
    tCasilla casilla;
    char c;
    fichero >> mina.nFilas; // cargamos numero de filas y columnas de nuestra mina
    fichero >> mina.nColumnas;
    fichero.get(c);
    for(int i=0;i < mina.nFilas;i++){
        for(int j = 0; j < mina.nColumnas; j++){
            fichero.get(c); 
            mina.plano[i][j]= conversion_tipos(c);// asignamos al plano lo que corresponda o un muro o una gema...
            if(mina.plano[i][j] == MINERO){ // Si encontramos el tipo minero guardamos sus coordenadas
                i= mina.x;
                j= mina.y;
            }
        }
        fichero.get(c);
    }
}
tCasilla char2tCasilla(char c){
    tCasilla cas;
     switch (c){
        case " ":{
            cas = LIBRE;
        }
        break;
        case "T":{
            cas = TIERRA;
        }
        break;
        case "G":
        {
            cas = GEMA;
        }
        break;
        case "P":
        {
            cas = PIEDRA;
        }
        break;
        case "M":
        {
            cas = MURO;
        }
        break;
        case "S":
        {
            cas = SALIDA;
        }
        break;
        case "D":
        {
            cas = DINAMITA;
        }
        break;
        case "":
        {
            cas = MINERO;
        }
        break;
    }
    return cas;
}
void dibujar1_1(const tMina &mina){}
void dibujar1_3(const tMina &mina){}
void dibuja3x3(tCasilla casilla, tPlanoCaracteres caracteres, tPlanoColores colores, int i, int j){}
