#include <stdio.h>
#include <dos.h>

#define GET_SYSTEM_DATE 0x2A

int main() {
    
    int y, m, d;
    
    union REGS inreg, outreg;
    inreg.h.ah = GET_SYSTEM_DATE;
    int86(0x21, &inreg, &outreg);
    
    y = outreg.x.cx;
    m = outreg.h.dh;
    d = outreg.h.dl;

    if (m < 3 || (m == 3 && d < 21))
        y -= 622;
    else
        y -= 621;

    if (m == 1)
        if (d < 21)
            m = 10, d += 10;
        else
            m = 11, d -= 20;

    else if (m == 2)
        if (d < 20)
            m = 11, d += 11;
        else
            m = 12, d -= 19;
    
    else if (m == 3)
        if (d < 21)
            m = 12, d += 9;
        else
            m = 1, d -= 20;

    else if (m == 4)
        if (d < 21)
            m = 1, d += 11;
        else
            m = 2, d -= 20;

    else if (m == 5 || m == 6)
        if (d < 22)
            m -= 3, d += 10;
        else
            m -= 2, d -= 21;

    else if (m == 7 || m == 8 || m == 9)
        if (d < 23)
            m -= 3, d += 9;
        else
            m -=2, d -= 22;

    else if (m == 10)
        if (d < 23)
            m = 7, d += 8;
        else
            m = 8, d -= 22;
        
    else
        if (d < 22)
            m -= 3, d += 9;
        else
            m -= 2, d -= 21;

    printf("%d/%d/%d\n", y, m, d);
    
    getch();
    return 0;
}