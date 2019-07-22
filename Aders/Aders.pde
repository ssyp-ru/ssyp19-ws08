//Импорт библиотек
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.awt.Toolkit;
import com.fasterxml.uuid.*;
import com.fasterxml.uuid.ext.*;
import com.fasterxml.uuid.impl.*;
import java.io.File;
import java.nio.file.Files;
import java.io.*;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import static java.nio.file.StandardOpenOption.WRITE;
import static java.nio.file.StandardOpenOption.CREATE_NEW;
import java.nio.file.OpenOption;
import processing.sound.*;


//Обьявление переменных
Input input;  

//Кнопки меню
Bttn exitBttn;
Bttn newBttn;
Bttn openBttn;
Bttn listBttn;

//Кнопка загрузки игры 
Bttn game1;

//Кнопка добавления нового обьекта вверху списков ниже
Bttn addSprite;
Bttn addBackground;
Bttn addCounter;
Bttn addSound;

//Списки обьектов по бокам
Bttn spriteList;
Bttn backgroundList;
Bttn charList;
Bttn soundList;

//Окно закрывающие все остальное кроме окна ввода и кнопок ниже
Bttn importSprite;
Bttn importBackground;
Bttn importCounter;
Bttn importSound;

//Кнопки подтверждения добавления обьекта
Bttn spriteAdded;
Bttn backgroundAdded;
Bttn counterAdded;
Bttn soundAdded;

//Кнопки при проигрывании новеллы
Bttn textWindow;
Bttn exitMenu;
Bttn openSettings; 
Bttn Settings;

//Кнопки звука
Bttn soundMore;
Bttn soundLess;

//Фоны и спрайт
BackGround MenuBack;
BackGround EditPlayBack;
Sprite Char;

//Переменные для выбора
Bttn choiceList;
Bttn choice1;
Bttn choice2;
Bttn choice3;
Bttn choice4;
Bttn choice5;
int numberOfChoices = 5;

//Цвета
float Red = 118;
float Green = 228;
float Blue = 105;

float RedStr = 85;
float GreenStr = 185;
float BlueStr = 90;

int bckg = #b3f049;

//Флаг выбора и состояние приложения
boolean choice = false;
int mode = 0; //0 - Menu, 1 - New, 2 - Playin

boolean click = false;
int CONST = 100;
BackGround[] bgs = new BackGround[CONST];
Sprite[] sprts = new Sprite[CONST];
Music[] sngs = new Music[CONST];
int[] cntrs = new int[CONST];

int cntBG = 0;
int cntS = 0;
int cntM = 0;
int cntC = 0;
