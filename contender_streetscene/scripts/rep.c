/* uptolo.c */
#include <stdio.h>
main()
{
        int c;
        while (( c = getchar()) != EOF )
        {
		putchar (c == ','?'|' : c);
                if ( c == '"' )
                        {
                        while (( c=getchar() ) != '"')
                        putchar(c);
                        putchar(c);
                        }
        }
}
