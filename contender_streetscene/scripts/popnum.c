#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define FILE_NAME_LEN	255
#define FILE_LINE_LEN	2000

void main(int argc, char *argv[])
{
FILE	*InFp;
FILE	*OutFp;
char	InName[FILE_NAME_LEN];
char	OutName[FILE_NAME_LEN];
char	InLine[FILE_LINE_LEN];
char	Delimiter[5];
char	Msg[255];
int		Index;

	if(argc != 3 && argc != 4)
	{
		printf("Usage : popnum infile outfile [delimiter]\n");
		exit(1);
	}
	else if(argc == 4)
	{
		strcpy(Delimiter, argv[3]);
	}
	else
	{
		strcpy(Delimiter, "|");
	}

	strcpy(InName, argv[1]);
	InFp = fopen(InName, "r");
	if(InFp == NULL)
	{
		sprintf(Msg, "Failed to open input file : %s\n", InName);
		printf(Msg);
		exit(1);
	}
	strcpy(OutName, argv[2]);
	OutFp = fopen(OutName, "w");
	if(OutFp == NULL)
	{
		sprintf(Msg, "Failed to open input file : %s\n", InName);
		printf(Msg);
		exit(1);
	}

	Index = 1;
	while(fgets(InLine, FILE_LINE_LEN, InFp) != NULL)
	{
		fprintf(OutFp, "%d%s%s", Index, Delimiter, InLine);
		Index++;
	}

	fclose(InFp);
	fclose(OutFp);
}
