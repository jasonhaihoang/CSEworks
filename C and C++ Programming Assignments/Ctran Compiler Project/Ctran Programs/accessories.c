#include <stdio.h>
#include <stdlib.h>
extern char *fp, *sp;

void initstack()
{
   sp = (char *) malloc(1024 * 1024);
   fp = sp;
}

printHex(unsigned int value)
{
   printf("%x",value);
}

printInt(int value)
{
   printf("%d",value);
}

printChar(char value)
{
   printf("%c",value);
}

readInt(int *value)
{
   scanf("%d",value);
}

printString(char *string)
{
   printf("%s",string);
}

printLine()
{
   printf("\n");
}

pushc(int value)
{
    *sp = value;
    sp = sp + 1;
}

pushi(int value)
{
    *sp = (int) value;
    sp = sp + 4;
}

pushf(float value)
{
    *sp = value;
    sp = sp + 4;
}

pushd(double value)
{
    *sp = value;
    sp = sp + 8;
}

