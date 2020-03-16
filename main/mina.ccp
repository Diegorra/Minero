#include <iostream>
#include <fstream>
#include <string>
#include <windows.h>
using namespace std;
#include <ObjectArray.h>
#include "mina.h"

void cargar_Mina(ifstream &fichero, tMina & mina){// Función que carga la mina desde un archivo de entrada
    int filas, columnas;
    tCasilla casilla;
    char c;
    fichero >> mina.nFilas; // cargamos numero de filas y columnas de nuestra mina
    fichero >> mina.nColumnas;
    fichero.get(c);
    for(int i=0;i < mina.nFilas;i++){
        for(int j = 0; j < mina.nColumnas; j++){
            fichero.get(c);
            casilla = char2tCasilla(c);
            mina.plano[i][j]= casilla;// asignamos al plano lo que corresponda o un muro o una gema...
            if(mina.plano[i][j] == MINERO){ // Si encontramos el tipo minero guardamos sus coordenadas
                mina.x = i;
                mina.y = j;
            }
        }
        fichero.get(c);
    }
}
tCasilla char2tCasilla(char c){// Conversor de un caracter al tipo tCasilla
    tCasilla cas;
     switch (c){
        case ' ':{
            cas = LIBRE;
        }
        break;
        case 'T':{
            cas = TIERRA;
        }
        break;
        case 'G':
        {
            cas = GEMA;
        }
        break;
        case 'P':
        {
            cas = PIEDRA;
        }
        break;
        case 'M':
        {
            cas = MURO;
        }
        break;
        case 'S':
        {
            cas = SALIDA;
        }
        break;
        case'D':
        {
            cas = DINAMITA;
        }
        break;
        case 'J':
        {
            cas = MINERO;
        }
        break;
    }
    return cas;
}
char tCasilla2char(const tMina &mina, int posX, int posY){// Conversor de tCasilla al caracter que tenemos que sacar por consola
    char c;
    switch(mina.plano[posX][posY]){
        case 0:{
           c = ' '; 
           colorFondo(6); 
        }break;
        case 1:{
            c = '.';
            colorFondo(6);
        }break;
        case 2:{
            c = 'G';
            colorFondo(10);
        }break;
        case 3:{
            c = '@';
            colorFondo(6);
        }break;
        case 4:{
            c = 'X';
            colorFondo(6);
        }break;
        case 5:{
            c = 'S';
            colorFondo(2);
        }break;
        case 6:{
            c = 'D';
            colorFondo(1);
        }break;
        case 7:{
            c = 'M';
            colorFondo(8);
        }break;
    }
    return c;
}
void colorFondo(int color){// Asigna un color al fondo (solo vaido para el entorno Visual)
    HANDLE handle = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleTextAttribute(handle, 15 | (color << 4));
}
void dibujar1_1(const tMina &mina){
    for(int i=0; i< mina.nFilas; i++){
        for(int j=0; j< mina.nColumnas; j++){// Recorremos nuestra matriz plano
            cout << tCasilla2char(mina, i, j); // Sacamos el caracter correspondiente
        }
        cout << endl;
    }
    cout << endl;
}
void dibujar1_3(const tMina &mina) {
    tCasilla casilla;
    tPlanoCaracteres caracteres;
    tPlanoColores colores; 
    for (int i = 0; i < mina.nFilas; i++){
        for(int j=0; j < mina.nColumnas; j++){// recorremos la matriz plano
            dibuja3x3(casilla, caracteres, colores, i, j); // dibujamos unas casilla 3x3
        }
        cout << endl;
    }
    cout << endl;
}

void dibuja3x3(tCasilla casilla, tPlanoCaracteres caracteres, tPlanoColores colores, int i, int j){
    switch (casilla)
    {
    case 0:
        //Nada
        break;
    case 1:
        //Nada
    break;
    case 2:
        //GEMA
    break;
    case 3:
        // Nada
    break;
    case 4:
        //Nada
    break;
    case 5:
        //SALIDA
    break;
    case 6:
        //Nada
    break;
    case 7:
        //MINERO
    break;
    }

}

//void nada(tMina mina, int i, int j)
