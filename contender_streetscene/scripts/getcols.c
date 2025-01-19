#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define FILE_NAME_LEN	255
#define FILE_LINE_LEN	2000

void GetCol(char *, int, char *, char *);

void main(int argc, char *argv[])
{
FILE	*InFp;
char	InName[FILE_NAME_LEN];
char	InLine[FILE_LINE_LEN];
char	OutLine[FILE_LINE_LEN];
char	InDelimiter[2];
char	OutDelimiter[2];
char	ColumnText[255];
char	Msg[255];
char	DispSeq[2];
char	StripHdr[2];
int		Index;
int		ColNo;
int		LineNo;
int		Column;

	if(argc < 6)
	{
		printf
		(
			"Usage : getcols striphdr_yn seqno_yn infile indelimiter outdelimiter columnno....\n"
		);
		exit(1);
	}

	strcpy(StripHdr, argv[1]);
	strcpy(DispSeq, argv[2]);
	strcpy(InName, argv[3]);
	strcpy(InDelimiter, argv[4]);
	strcpy(OutDelimiter, argv[5]);

	InFp = fopen(InName, "r");
	if(InFp == NULL)
	{
		sprintf(Msg, "Failed to open input file : %s\n", InName);
		printf(Msg);
		exit(1);
	}

	Index = 1;
	LineNo = 1;
	while(fgets(InLine, FILE_LINE_LEN, InFp) != NULL)
	{
		if
		(
			Index > 1 ||
			strcmp(StripHdr, "N") == 0 ||
			strcmp(StripHdr, "n") == 0
		)
		{
			OutLine[0] = '\0';
			for(ColNo = 6; ColNo < argc; ColNo++)
			{
				Column = atol(argv[ColNo]);
				GetCol(InLine, Column, InDelimiter, ColumnText);
				strcat(OutLine, ColumnText);
				strcat(OutLine, OutDelimiter);
			}
			if(strcmp(DispSeq, "Y") == 0 || strcmp(DispSeq, "y") == 0)
			{
				printf("%d%s%s\n", LineNo, OutDelimiter, OutLine);
			}
			else
			{
				printf("%s\n", OutLine);
			}
			LineNo++;
		}
		Index++;
	}

	fclose(InFp);
}

void GetCol(char *InLine, int ColNo, char *Delimiter, char *OutCol)
{
char	*Ptr;
int		Index;

	ColNo--;
	Index = 1;
	Ptr = InLine;
	while(*Ptr != '\0')
	{
		if(ColNo == 0)
		{
			break;
		} 
		else
		{
			if(*Ptr == Delimiter[0])
			{
				if(Index == ColNo)
				{
					Ptr++;
					break;
				}
				else
				{
					Index++;
				}
			}
		}
		Ptr++;
	}

	Index = 0;
	while(*Ptr != '\0' && *Ptr != Delimiter[0])
	{
		OutCol[Index] = *Ptr;
		Ptr++;
		Index++;
	}
	OutCol[Index] = '\0';
}
