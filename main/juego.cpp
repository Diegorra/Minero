//Práctica del minero FP2 versión 1
//Realizada por Diego Ramón Sanchis grupo A; FP2-A56 dieramon@ucm.es
//				Diego Alvarez Carretero grupo A; FP2-A04
#include <iostream>
#include <fstream>
#include <string>
#include <string.h>
using namespace std;
#include <ObjectArray.h>
#include "juego.h"


bool cargar_Juego(tJuego& juego, int& nivel) {
    string aux;
    tMina mina;
    bool carga = true;
    aux = to_string(nivel); // Convertir entero a string
    aux += ".txt";
    ifstream fichero(aux);
    if (fichero.is_open()){
        cargar_Mina(fichero, juego.mina);
    }
    else {
        cout << "ERROR" << endl;
        carga = false;
    }
    fichero.close();
    nivel++;
    return carga;
}

tEstado hacerMovimiento(tJuego& juego, tTecla tecla, int opcion) {//Ve si puede hacer mov, si es asi mueve
    bool hacerlo = true;
    int i = 0;;
    tEstado estado = JUGANDO;
    switch (tecla) {
    case 0: {// ARRIBA
        if (puede_hacer_mov(juego, i) && juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] != PIEDRA) {// Puede hacer mov y la casilla no es piedra                                                                                                                    //Puede hacer mov
            estado = casilla_deplaza(juego, i); //Valoramos casos especiales que haya una gema, salida
            mover(juego, i);
        }
        else
        {
            hacerlo = false;
        }
    }
          break;
    case 1: {// ABAJO
        i = 1;
        if (puede_hacer_mov(juego, i) && juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] != PIEDRA) { //Puede hacer mov y la casilla no es piedra
            estado = casilla_deplaza(juego, i); //Valoramos casos especiales que haya una gema, salida
            if (juego.mina.plano[juego.mina.x + incF[0]][juego.mina.y + incC[0]] == PIEDRA) { // Si tiene una piedra encima cuando baje toda la columna cae con el
                mover(juego, i);
                caidaCascada(juego, juego.mina.x - 2, juego.mina.y);
            }
            else {
                mover(juego, i);
            }
        }
        else
        {
            hacerlo = false;
        }
    }break;
    case 2: { //DRCHA
        i = 2;
        if (puede_hacer_mov(juego, i)) { //Puede hacer mov
            estado = casilla_deplaza(juego, i); //Valoramos casos especiales que haya una gema, salida o una piedra que pueda ser empujada
            desplazamiento_horizontal(juego, i); // posibilidad minero debajo de una piedra > desplaza y piedra cae
        }
        else
        {
            hacerlo = false;
        }
    }break;
    case 3: { // IZDA
        i = 3;
        if (puede_hacer_mov(juego, i)) { //Puede hacer mov
            estado = casilla_deplaza(juego, i);//Valoramos casos especiales que haya una gema, salida o una piedra que pueda ser empujada
            desplazamiento_horizontal(juego, i);
        }
        else {
            hacerlo = false;
        }
    }break;
    case 4: { //SALIR
        estado = ABANDONA;
    }break;
    case 5: { //NADA
        hacerlo = false;
    }break;
    case 6: { //TNT
        if (juego.mina.plano[juego.mina.x + incF[1]][juego.mina.y + incC[1]] == LIBRE) { // Para poder colocar el TNT
            //El TNT cae desde la posicion del minero en vertical
            juego.mina.plano[juego.mina.x + incF[1]][juego.mina.y + incC[1]] = DINAMITA;
            caidaCascada(juego, juego.mina.x + incF[1], juego.mina.y + incC[1]); // TNT cae hasta que encuentra obstaculo
            system("CLS");
            dibujar(juego, opcion);
            system("pause");
            estado = explosionTNT(juego); // explota
            juego.numTNT++;
        }
        else {
            estado = OVER; // Explota en manos de minero
        }
    }
          break;
    }
    juego.numMov++;
    return estado;
}

void dibujar(const tJuego& juego, int i) {// dibujamos el juego
    if (i == 1) {
        dibujar1_1(juego.mina);
    }
    else if (i == 2) {
        dibujar1_3(juego.mina);
    }
    cout << "Gemas totales recogidas:" << juego.gem << endl;
    cout << "Numero de movimientos:" << juego.numMov << endl;
    cout << "Dinamitas usadas:" << juego.numTNT << endl;
}

bool puede_hacer_mov(tJuego& juego, int i) { // puede hacer mov si no...
    bool puede = true;
    //se sale del plano
    if (!dentroPlano(juego, juego.mina.x + incF[i], juego.mina.y + incC[i])) {
        puede = false;
    }
    // la casilla a la que se quiere mover es un muro
    if (juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] == MURO) {
        puede = false;
    }
    // una piedra inamovible
    if (juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] == PIEDRA && !movilidad_piedra(juego, i)) {
        puede = false;
    }
    return puede;
}

void mover(tJuego& juego, int i) {// mueve minero
    juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] = juego.mina.plano[juego.mina.x][juego.mina.y]; //Minero desplaza posicion
    juego.mina.plano[juego.mina.x][juego.mina.y] = LIBRE; // La excasilla del minero queda libre
    juego.mina.x += incF[i]; //Actualizamos posicion del minero
    juego.mina.y += incC[i];
}

tEstado casilla_deplaza(tJuego& juego, int i) {// valoramos casos especiales sobre la casilla a la que se desplaza
    tEstado estado = JUGANDO;
    if (juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] == SALIDA) { // Llega a la salida
        estado = FIN;
    }
    if (juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] == GEMA) { //Llega a una gema
        juego.gem++;
    }
    if (juego.mina.plano[juego.mina.x + incF[i]][juego.mina.y + incC[i]] == PIEDRA && movilidad_piedra) { // Hay una piedra movible
        juego.mina.plano[juego.mina.x + 2 * incF[i]][juego.mina.y + 2 * incC[i]] = PIEDRA;
        caidaCascada(juego, juego.mina.x + 2 * incF[i], juego.mina.y + 2 * incC[i]);
    }
    return estado;
}

bool movilidad_piedra(tJuego& juego, int i) {//Vemos si la piedra puede ser desplazada o no
    bool movilidad = true;
    if (juego.mina.plano[juego.mina.x + 2 * incF[i]][juego.mina.y + 2 * incC[i]] != LIBRE) {
        movilidad = false;
    }
    return movilidad;
}

void caidaCascada(tJuego& juego, int iniX, int iniY) { // derrumbamiento en la mina
    int x=0, y=0; // Sirve para actualizar la caida de una casilla
    while ((juego.mina.plano[iniX][iniY] == LIBRE || juego.mina.plano[iniX][iniY] == PIEDRA || juego.mina.plano[iniX][iniY] == DINAMITA) && dentroPlano(juego, iniX, iniY)){ //Mientras no tengamos un muro o el minero  y no se salga del plano
        x = iniX;
        y = iniY;
        while (juego.mina.plano[x + incF[1]][y + incC[1]] == LIBRE && dentroPlano(juego, x + incF[1], y + incC[1])){ //y la casilla siguiente este libre y dentro del plano
            juego.mina.plano[x + incF[1]][y + incC[1]] = juego.mina.plano[x][y]; //elemento baja una posicion
            juego.mina.plano[x][y] = LIBRE;// la casilla donde estaba el elemento queda libre
            x += incF[1]; // actualizamos posicion
            y += incC[1];
        }
        iniX--; // Pasamos al siguiente elemento de la columna
    }

}

void desplazamiento_horizontal(tJuego& juego, int i) { // Tenemos la posibilidad de que el minero este soportando una piedra y al desplazarse esta caiga
    if (juego.mina.plano[juego.mina.x + incF[0]][juego.mina.y + incC[0]] == PIEDRA) {
        mover(juego, i);
        caidaCascada(juego, juego.mina.x - incF[i] + incF[0], juego.mina.y - incC[i] + incC[0]);
    }
    else {
        mover(juego, i);
    }
}

tEstado explosionTNT(tJuego &juego) { //Explosion TNT
    tEstado estado = JUGANDO;
    int coordX, coordY, j = 1; // coordenadas TNT
    coordX = juego.mina.x + incF[1];
    coordY = juego.mina.y + incC[1];
    while (juego.mina.plano[juego.mina.x + j * incF[1]][juego.mina.y + j * incC[1]] != DINAMITA) {// Sacamos coordenadas del TNT
        coordX += incF[1]; // Actualizamos coordenadas
        coordY += incC[1];
        j++; // Contador
    }
    for (int i = 0; i <= 7; i++) {
        if (juego.mina.plano[coordX + incF[i]][coordY + incC[i]] == MINERO) { // Si alguna de las casilla donde alcanza la dinamita es el minero game over
            estado = OVER;
        }
        else if (dentroPlano(juego, coordX + incF[i], coordY + incC[i])) {
            juego.mina.plano[coordX + incF[i]][coordY + incC[i]] = LIBRE;
        }
    }
    juego.mina.plano[coordX][coordY] = LIBRE;//Dinamita desaparece
    for (int i = 0; i <= 7; i++) {//en este for comprovamos si debido a la explosion se produce un desprendimiento en la mina
        caidaCascada(juego, coordX + incF[i], coordY + incC[i]);
    }
    return estado;
}

bool dentroPlano(tJuego& juego, int x, int y) {
    if (x >= 0 && x < juego.mina.nFilas && y >= 0 && y < juego.mina.nColumnas) {
        return true;
    }
    else {
        return false;
    }
}

tEstado jugar(tJuego& juego, int opcion){
    tEstado estado = JUGANDO;
    tTecla tecla = NADA;
    dibujar(juego, opcion);
    tecla = leerTecla();
    estado = hacerMovimiento(juego, tecla, opcion);
    system("CLS");
    while (estado == JUGANDO) {
        dibujar(juego, opcion);
        tecla = leerTecla();
        estado = hacerMovimiento(juego, tecla, opcion);
        system("CLS");
    }
    return estado;
}

tEstado jugarFichero(tJuego& juego, int opcion) {
    //Extraer tecla de fichero
    tEstado estado = JUGANDO;
    ifstream ficheroMOV;
    tTecla tecla = NADA;
    char c;
    string nombre;
    cout << "Introduzca el nombre del fichero: ";
    cin >> nombre;
    nombre += ".txt";
    ficheroMOV.open(nombre);
    if (ficheroMOV.is_open()) {
        dibujar(juego, opcion);
        system("pause");
        ficheroMOV.get(c);
        tecla = extraerFichero(c);
        estado = hacerMovimiento(juego, tecla, opcion);
        system("CLS");
        while (estado == JUGANDO && tecla != NADA) { // Mientras pueda jugar y no llegue al final del fichero
            dibujar(juego, opcion);
            system("pause");
            ficheroMOV.get(c);
            tecla = extraerFichero(c);
            estado = hacerMovimiento(juego, tecla, opcion);
            system("CLS");
        }
        if (estado == JUGANDO) {
            cout << "No has completado el nivel" << endl;
            system("pause");
            estado = ABANDONA;
        }
    }
    else {
        cout << "ERROR" << endl;
        ficheroMOV.close();
    }
    return estado;
}

tTecla leerTecla() {
    tTecla t = NADA;
    cin.sync();
    int dir;
    dir = _getch();
    if (dir == 0xe0) {
        dir = _getch();
        switch (dir) {
        case 72: {t = ARRIBA; }break;
        case 80: {t = ABAJO; }break;
        case 77: {t = DRCHA; }break;
        case 75: {t = IZDA; }break;
        }
    }
    else if (dir == 27) {
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

tTecla extraerFichero(char c) {
    tTecla t = NADA;
    switch (c) {
    case 'A': {t = ARRIBA; }break;
    case 'Z': {t = ABAJO; }break;
    case 'N': {t = IZDA; }break;
    case 'M': {t = DRCHA; }break;
    case ' ': {t = NADA; }break; //Si acaba el fichero
    }
    return t;
}

