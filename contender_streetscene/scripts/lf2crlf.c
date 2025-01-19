main()
{
char c;
while((c=getchar()) != -1)
	{
	if(c=='\n') putchar('\r');
	putchar(c);
	}
}

