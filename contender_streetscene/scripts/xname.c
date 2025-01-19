main()
{
	char c;
	int x=0;

	while((c=getchar()) != -1)
	{
	if(c=='<')
	{
		x=1;
		putchar(c);
	}
	else if(c=='>')
	{
		x=0;
		putchar(c);
	}
	else if(c=='_')
	{
		if(x==0)
		{
			putchar(c);
		}
		else
		{
			putchar('U');
			putchar('U');
		}
	}
	else if(c=='.')
	{
		if(x==0)
		{
			putchar(c);
		}
		else
		{
			putchar('D');
			putchar('D');
		}
	}
	else putchar(c);
	}
}
