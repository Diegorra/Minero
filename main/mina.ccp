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
           colorFondo(4); 
        }break;
        case 1:{
            c = '.';
            colorFondo(4);
        }break;
        case 2:{
            c = 'G';
            colorFondo(10);
        }break;
        case 3:{
            c = '@';
            colorFondo(4);
        }break;
        case 4:{
            c = 'X';
            colorFondo(4);
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
            colorFondo(13);
        }break;
    }
    return c;
}
void colorFondo(int color){// Asigna un color al fondo (solo vaido para el entorno Visual)
    HANDLE handle = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleTextAttribute(handle, 15 | (color << 4));
}
void dibujar1_1(const tMina &mina){// Dibuja la mina escala 1:1
    for(int i=0; i< mina.nFilas; i++){
        for(int j=0; j< mina.nColumnas; j++){// Recorremos nuestra matriz plano
            cout << tCasilla2char(mina, i, j); // Sacamos el caracter correspondiente
            colorFondo(0);
        }
        cout << endl;
    }
    cout << endl;
}
void dibujar1_3(const tMina &mina) {// Dibuja la mina escala 1:3
    tCasilla casilla;
    tPlanoCaracteres caracteres;
    tPlanoColores colores;
    int auxY=0, auxX=0; 
    for (int i = 0; i < mina.nFilas; i++){
        auxY=0;
        for(int j=0; j < mina.nColumnas; j++){// recorremos la matriz plano e inicializar caracteres y colores
            casilla= mina.plano[i][j];
            dibuja3x3(casilla, caracteres, colores, i+auxX, j+auxY);
            auxY+= 2;
        }
        auxX+=2;
    }
    for(int i=0; i <3*mina.nFilas; i++){//Sacamos por pantalla el plano en verison 1:3
        for(int j=0; j <3*mina.nColumnas; j++){
            colorFondo(colores[i][j]);
            cout << caracteres[i][j];
        }
        colorFondo(0);
        cout << endl;
    }
    colorFondo(0);
    cout << endl;
}

void dibuja3x3(tCasilla casilla, tPlanoCaracteres caracteres, tPlanoColores colores, int i, int j){
    char c;
    tMina mina;
    int color, a, z;
    switch (casilla)
    {
    case 0:
        c= ' ';
        nada(caracteres, colores, i, j, c, 4);
        break;
    case 1:
        c = '.';
        nada(caracteres, colores, i, j, c, 4);
        break;
    case 2:
        //GEMA
        c = 'G';
        nada(caracteres, colores, i, j, c, 10);
        break;
    case 3:
        c = '@';
        nada(caracteres, colores, i, j, c, 4);
        break;
    case 4:
        c = 'X';
        nada(caracteres, colores, i, j, c, 4);
        break;
    case 5:
        //SALIDA
        c = 'S';
        nada(caracteres, colores, i, j, c, 2);
        break;
    case 6:
        //DINAMITA
        for(int x=0; x < 3; x++){
            for(int y=0; y < 3; y++){
                if(x== 1){
                    colores[i+x][j+y]= 12;
                }
                else{
                    caracteres[i+x][j+y]=' ';
                    colores[i+x][j+y] = 15;
                }
            }
        }
        a = 1,
        z = 1;
        caracteres[i + a][j] = 'T';
        caracteres[i + a][j + z] = 'N';
        z++;
        caracteres[i + a][j + z] = 'T';
        colorFondo(0);
    case 7:
        //MINERO
        c = 'M';
        nada(caracteres, colores, i, j, c, 13);
    break;
    }

}

void nada(tPlanoCaracteres caracteres, tPlanoColores colores, int i, int j, char c, int color){
        for (int x = 0; x < 3; x++)
        {
            for (int y = 0; y < 3; y++) //Creamos submatrices 3x3 de cada elemento del fichero
            {
                caracteres[i + x][j + y] = c; //Guardamos el valor en la matriz de caracteres
                colores[i + x][j + y] = color; //Guardamos el valor en la matriz de caracteres
            }
        }
}
