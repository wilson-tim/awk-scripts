#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

#define FILE_NAME_LEN	255
#define FILE_LINE_LEN	2000
#define TRUE			1
#define FALSE			0

long GetFileLen(FILE *);
void InsertField(char *, char *, char *);

void main(int argc, char *argv[])
{
FILE			*InFp;
FILE			*OutFp;
unsigned long	FileLen;
int				Slash;
int				BadFile = FALSE;
int				RepPos;
char			InName[FILE_NAME_LEN];
char			OutName[FILE_NAME_LEN];
char			*InBuffer;
char			*BufferEnd;
char			*InPtr;
char			*OutPtr;
char			*SearchPtr;
char			OutLine[FILE_LINE_LEN];
char			TimeStr[30];
time_t			Now;
struct tm		*TimeInfo;

	if(argc != 3)
	{
		printf("Usage : crm_convert InFile OutFile\n");
		exit(1);
	}
	strcpy(InName, argv[1]);
	strcpy(OutName, argv[2]);

	InFp = fopen(InName, "rb");
	if(InFp == NULL)
	{
		printf("Failed to open input file %s\n", InName);
		exit(1);
	}
	OutFp = fopen(OutName, "w");
	if(OutFp == NULL)
	{
		printf("Failed to open output file %s\n", OutName);
		fclose(InFp);
		exit(1);
	}

	FileLen = GetFileLen(InFp);
	InBuffer = malloc(FileLen);
	if(InBuffer == NULL)
	{
		printf("Failed to allocate memory\n");
		fclose(InFp);
		fclose(OutFp);
		exit(1);
	}
	if(fread(InBuffer, 1, FileLen, InFp) != FileLen)
	{
		printf("Failed to read input file\n");
		fclose(InFp);
		fclose(OutFp);
		free(InBuffer);
		exit(1);
	}

	InPtr = InBuffer;
	OutPtr = OutLine;
	BufferEnd = InPtr + FileLen;

	/*
	 * Remove control codes from start of file
	 */

	while(*InPtr != '<' && InPtr < BufferEnd)
	{
		InPtr++;
	}

	/*
	 * Add a new line unless there is a ">[x]</" combo
	 */

	Slash = FALSE;
	while(InPtr < BufferEnd)
	{
		if(*InPtr == '\n')
		{
			*OutPtr = ' ';
		}
		else
		{
			*OutPtr = *InPtr;
		}
		if(*InPtr == '>')
		{
			SearchPtr = InPtr;
			while(*SearchPtr != '<' && SearchPtr < BufferEnd)
			{
				SearchPtr++;
			}
			if(*SearchPtr == '<')
			{
				SearchPtr++;
				if(*SearchPtr != '/' || Slash == TRUE)
				{
					if(*SearchPtr == '/')
					{
						Slash = TRUE;
					}
					else
					{
						Slash = FALSE;
					}
					OutPtr++;
					*OutPtr = '\0';
					if(strstr(OutLine, "<item_ref><item_ref>"))
					{
						BadFile = TRUE;
						break;
					}
					if
					(
						strstr
						(
							OutLine, 
							"<transaction_source></transaction_source>"
						)
					)
					{
						InsertField(OutLine, "<transaction_source>", "E");
					}
					else if
					(
						strstr
						(
							OutLine, 
							"<transaction_type></transaction_type>"
						)
					)
					{
						InsertField(OutLine, "<transaction_type>", "C");
					}
					else if
					(
						strstr
						(
							OutLine, 
							"<transaction_date></transaction_date>"
						)
					)
					{
						time( &Now );
						TimeInfo = localtime( &Now );
						sprintf
						(
							TimeStr, "%02d/%02d/%04d %02d:%02d",
							TimeInfo->tm_mday,
							TimeInfo->tm_mon + 1,
							TimeInfo->tm_year + 1900,
							TimeInfo->tm_hour,
							TimeInfo->tm_min
						);
						InsertField(OutLine, "<transaction_date>", TimeStr);
					}
					else if
					(
						strstr
						(
							OutLine, 
							"<transaction_type>U</transaction_type>"
						)
					)
					{
						RepPos = strstr(OutLine, "U</t") - OutLine;
						OutLine[RepPos] = 'C';
					}
					else if
					(
						strstr
						(
							OutLine, 
							"<customer_no>0</customer_no>"
						)
					)
					{
						InsertField(OutLine, "<customer_no>", "");
					}
					else if
					(
						strstr
						(
							OutLine, 
							"<customer_ext_id>0</customer_ext_id>"
						)
					)
					{
						InsertField(OutLine, "<customer_ext_id>", "");
					}
					fprintf(OutFp, "%s\n", OutLine);
					OutPtr = OutLine - 1;
				}
				else
				{
					Slash = TRUE;
				}
			}
		}
		OutPtr++;
		InPtr++;
	}
	*OutPtr = '\0';
	fprintf(OutFp, "%s", OutLine);

	free(InBuffer);
	fclose(InFp);
	fclose(OutFp);

	if(BadFile == TRUE)
	{
		unlink(OutName);
	}

	exit(0);
}

long GetFileLen(FILE *Fp)
{
long	CurrPos;
long	FileLen;

	CurrPos = ftell(Fp);
	fseek(Fp, 0, SEEK_END);
	FileLen = ftell(Fp);
	fseek(Fp, CurrPos, SEEK_SET);

	return(FileLen);
}

void InsertField(char *Line, char *FieldName, char *Value)
{
int		Length;
int		Pos;
char	LineStart[1000];
char	LineEnd[1000];

	Length = (Line - strstr(Line, FieldName)) + strlen(FieldName);
	memcpy(LineStart, Line, Length);
	LineStart[Length] = '\0';

	Pos = Length;
	while(Line[Pos] != '<')
	{
		Pos++;
	}

	strcpy(LineEnd, Line + Pos);

	sprintf(Line, "%s%s%s", LineStart, Value, LineEnd);
}
