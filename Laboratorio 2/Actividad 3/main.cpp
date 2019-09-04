#include <stdbool.h>
#include <LiquidCrystal.h>
#include <stdint.h>
#include "Arduino.h"
#include "teclado.h"
#include "fnqueue.h"

char m[64] = "Sistemas Embebidos, 2do Cuatrimestre - Laboratorio 2, comision 8";


volatile int16_t tiempos_guardados [10];

volatile int16_t segundos_absoluto = 0,
                 segundos_display = 0,
                 ultimo_reset = -1,
                 tiempo_pressed_down = 0;

volatile int8_t ciclos = 0,
                tiempo_seleccionado = 0,
                brillo_seleccionado = 80,
                cantidad_tiempos = 0,
                tiempo_sin_hacer_nada = 0;

volatile bool en_mca = false,
              en_mp = true,
              en_mad = false,
              input = false,
              logged = false;

LiquidCrystal lcd(8, 9, 4, 5, 6, 7);

void imprimir_tiempo_seleccionado()
{
    lcd.clear();
    lcd.print("Tiempo ");
    lcd.print(tiempo_seleccionado+1);
    lcd.print(": ");
    if ( tiempos_guardados[tiempo_seleccionado] != -1 )
    {
        lcd.print(tiempos_guardados[tiempo_seleccionado]);
        lcd.print("s");
    }
    else
        lcd.print("-");
}

void imprimir_brillo_seleccionado()
{
    lcd.clear();
    lcd.print("Brillo: ");
    lcd.print(brillo_seleccionado);
    lcd.print("%");
    lcd.setCursor(0,1);
    lcd.print("Cuenta: ");
    lcd.print(segundos_display);
    lcd.print("s");
    lcd.setCursor(0,0);
}

// ----------------------------------- mca -------------------------------------

void pasar_a_mp()
{
    // acción de up en mca, select en mvt y select en mad.
    // TCCR2B = 0;
    en_mad = false;
    en_mca = false;
    en_mp = true;
    cambiar_modo(&up_mp, &down_mp, &select_mp_up, &select_mp_down);
}
void down_mca()
{
    tiempos_guardados[cantidad_tiempos] = segundos_display;
    // si ya guardé 10, sobrescribir los primeros
    if ( cantidad_tiempos == 9 )
        cantidad_tiempos = 0;
    else
        cantidad_tiempos++;
}
void select_mca()
{
}

// ----------------------------------- mp --------------------------------------

// mostrar en tiempo real el tiempo que pasa entre reset y ahora?
void up_mp()
{
    en_mca = true;
    en_mp = false;
    TCCR2B |= (1 << CS22) | (1 << CS21) | (1 << CS20);
    cambiar_modo(&pasar_a_mp, &down_mca, &select_mca, &select_mca);
}
void down_mp()
{
    down_mca();
    GTCCR |= (1 << PSRASY);
    cli();
    segundos_display = 0;
    ultimo_reset = segundos_absoluto;
    sei();
}
void select_mp_up()
{
    cli();
    int16_t copia_segundos = segundos_absoluto;
    logged = false;
    sei();
    en_mp = false;
    if ( copia_segundos - tiempo_pressed_down < 3 )
    {
        imprimir_tiempo_seleccionado();
        cambiar_modo(&up_mvt, &down_mvt, &pasar_a_mp, &select_mca);
    }
    else
    {
        imprimir_brillo_seleccionado();
        lcd.setCursor(0,1);
        lcd.print("Cuenta: ");
        lcd.print(segundos_display);
        lcd.print("s");
        lcd.setCursor(0,0);
        en_mad = true;
        cambiar_modo(&up_mad, &down_mad, &select_mca, &select_mca);
    }
    tiempo_pressed_down = 0;
}
void select_mp_down()
{
    cli();
    if ( !logged )
    {
        tiempo_pressed_down = segundos_absoluto;
        logged = true;
    }
    sei();
}

// ----------------------------------- mvt -------------------------------------

void up_mvt()
{
    if ( tiempo_seleccionado == 9 )
        tiempo_seleccionado = 0;
    else
        tiempo_seleccionado++;
    imprimir_tiempo_seleccionado();
}
void down_mvt()
{
    if ( tiempo_seleccionado == 0 )
        tiempo_seleccionado = 9;
    else
        tiempo_seleccionado--;
    imprimir_tiempo_seleccionado();
}

// ----------------------------------- mad -------------------------------------

void up_mad()
{
    if ( brillo_seleccionado < 100 )
        brillo_seleccionado += 20;
    analogWrite(10, 255*brillo_seleccionado/100);
    imprimir_brillo_seleccionado();
}
void down_mad()
{
    if ( brillo_seleccionado > 20 )
        brillo_seleccionado -= 20;
    analogWrite(10, 255*brillo_seleccionado/100);
    imprimir_brillo_seleccionado();
}

// -----------------------------------------------------------------------------

void inicio()
{
    input = true;
    en_mp = true;
    en_mca = false;
    lcd.setCursor(0,0);
    lcd.clear();
    lcd.print("Reset hace: 0s");
    cambiar_modo(&up_mp, &down_mp, &select_mp_up, &select_mp_down);
}

void cambiar_modo(void (*up)(), void (*down)(), void (*selu)(), void (*seld)())
{
    key_up_callback(up, TECLA_UP);
    key_up_callback(down, TECLA_DOWN);
    key_up_callback(selu, TECLA_SELECT);
    key_down_callback(seld, TECLA_SELECT);
}

void mensaje_bienvenida()
{
    int8_t i;
    lcd.autoscroll();
    lcd.setCursor(16,0);

    for ( i = 0; i < 24; i++)
    {
        lcd.print(m[i]);
        delay(300);
    }
    lcd.setCursor(0,0);
    for ( i = 24; i < 64; i++)
    {
        lcd.print(m[i]);
        delay(300);
    }

    lcd.noAutoscroll();
    delay(1000);
    lcd.clear();
}

ISR(TIMER2_OVF_vect)
{
    ciclos++;
    if ( ciclos == 62 )
    {
        ciclos = 0;
        segundos_absoluto++;

        if ( en_mca )
        {
            segundos_display++;
            lcd.clear();
            lcd.print("Cuenta: ");
            lcd.print(segundos_display);
            lcd.print("s");
        }
        else if ( en_mp )
        {
            lcd.clear();
            lcd.print("Reset hace: ");
            if ( ultimo_reset == -1 )
                lcd.print(0);
            else
                lcd.print(segundos_absoluto - ultimo_reset);
            lcd.print("s");
        }
        else if ( en_mad )
        {
            tiempo_sin_hacer_nada++;
            if ( tiempo_sin_hacer_nada == 5 )
            {
                tiempo_sin_hacer_nada = 0;
                pasar_a_mp();
            }
        }
    }
}

void callback_vacias()
{
    key_down_callback(&select_mca, TECLA_UP);
    key_down_callback(&select_mca, TECLA_DOWN);
    key_down_callback(&select_mca, TECLA_SELECT);
    key_up_callback(&select_mca, TECLA_RIGHT);
    key_down_callback(&select_mca, TECLA_RIGHT);
    key_up_callback(&select_mca, TECLA_LEFT);
    key_down_callback(&select_mca, TECLA_LEFT);
}

int main()
{
	init();
	// inicializar pin 10 como salida
	pinMode(10, OUTPUT);

    for ( int8_t i = 0; i < 10; i++ )
        tiempos_guardados[i] = -1;

	// set up the LCD's number of columns and rows:
	lcd.begin(16,2);
	analogWrite(10, 255*brillo_seleccionado/100);

    TCCR2A = 0;
    TCCR2B = 0;

    TIMSK2 |= (1 << TOIE2);

	teclado_init();
    callback_vacias();
    cambiar_modo(&inicio, &inicio, &inicio, &inicio);

    // while ( !input )
    //     mensaje_bienvenida();

	while (1)
		fnqueue_run();
	return 0;
}
