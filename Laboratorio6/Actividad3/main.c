#include <stdio.h>
#include "altera_avalon_pio_regs.h"
#include "system.h"

int main()
{
	while (1)
		IOWR_ALTERA_AVALON_PIO_DATA(PIO_OUT_BASE, IORD_ALTERA_AVALON_PIO_DATA(PIO_IN_BASE));
}
