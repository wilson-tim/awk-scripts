#include <stdio.h>
#include <string.h>

#define TRUE    1
#define FALSE   0

char *strupper(char *);
char *GetIndexName(char *);
char *GetTableName(char *);
int TableValid(char *);

void main(int argc, char *argv[])
{
char	FileName[ 255 ];
char	Line[ 1024 ];
char	*IndexName;
char	*TableName;
FILE	*InFp;
FILE	*OutFp;

	if(argc != 3)
	{
		printf("Usage : recoverv7index schemafile outputfile\n");
		exit(0);
	}

	strcpy(FileName, argv[1]);
	InFp = fopen(FileName, "r");
	if( InFp == NULL )
	{
		printf( "Failed open input file\n" );
		exit( 0 );
	}

	strcpy(FileName, argv[2]);
	OutFp = fopen(FileName, "w");
	if( OutFp == NULL )
	{
		printf( "Failed open output file\n" );
		exit( 0 );
	}

	fprintf(OutFp, "database universe\n\n");
	fprintf(OutFp, "main\n\n");
	fprintf(OutFp, "define vl_database like\tkeys.c_field\n\n");
	fprintf(OutFp, "\tselect c_field into vl_database from keys\n");
	fprintf(OutFp, "\t\twhere keyname = 'DATABASE_TYPE'\n\n");
	fprintf(OutFp, "\twhenever error continue\n\n");

	while( fgets( Line, 1024, InFp ) != NULL )
	{
		if
		(
			strstr(strupper(Line), "CREATE INDEX") != NULL ||
			strstr(strupper(Line), "CREATE UNIQUE INDEX") != NULL
		)
		{
			IndexName = GetIndexName(Line);
			TableName = GetTableName(Line);
			if(strlen(IndexName) > 0)
			{
				printf
				(
					"Processing Table : %s Index : %s\n",
					TableName,
					IndexName
				);
				fprintf
				(
					OutFp,
					"\tdisplay \"Processing Table : %s Index : %s\"\n\n",
					TableName,
					IndexName
				);
				fprintf(OutFp, "\tcase vl_database\n\n");
				fprintf(OutFp, "\t\twhen \"SQLSERVER\"\n\n");

				fprintf(OutFp, "\t\t\tsql\n");
				fprintf
				(
					OutFp,
					"\t\t\tdrop index %s.%s;\n",
					TableName,
					IndexName
				);
				fprintf(OutFp, "\t\t\tend sql\n\n");

				fprintf(OutFp, "\t\totherwise\n\n");

				fprintf(OutFp, "\t\t\tsql\n");
				fprintf(OutFp, "\t\t\tdrop index %s;\n", IndexName);
				fprintf(OutFp, "\t\t\tend sql\n\n");

				fprintf(OutFp, "\tend case\n\n");
			}
			fprintf(OutFp, "\tsql\n");
			fprintf(OutFp, "\t%s", Line);
			while(strstr(Line, ";") == NULL)
			{
				if( fgets( Line, 1024, InFp ) != NULL )
				{
					fprintf(OutFp, "\t%s", Line);
				}
			}
			fprintf(OutFp, "\tend sql\n\n");
		}
	}

	fprintf(OutFp, "\twhenever error stop\n\n");
	fprintf(OutFp, "\tdisplay \"COMPLETE\"\n\n");
	fprintf(OutFp, "end main\n");

	fclose(InFp);
	fclose(OutFp);

	printf("\nComplete : dont forget to compile %s\n", FileName);
}

char *strupper(char *InLine)
{
char	OutLine[1024];
char	*InPtr;
char	*OutPtr;

	InPtr = InLine;
	OutPtr = OutLine;
	while(*InPtr != '\0')
	{
		*OutPtr = toupper(*InPtr);
		InPtr++;
		OutPtr++;
	}
	(*OutPtr) = '\0';

	return(OutLine);
}

char *GetIndexName(char *InLine)
{
static char	OutLine[1024];
char		*InPtr;
char		*OutPtr;

	InPtr = InLine;
	OutPtr = OutLine;
	OutLine[0] = '\0';
	while(*InPtr != '.' && *InPtr != '\0')
	{
		InPtr++;
	}
	if(*InPtr == '.')
	{
		InPtr++;
		while(*InPtr != ' ')
		{
			*OutPtr = *InPtr;
			InPtr++;
			OutPtr++;
		}
		(*OutPtr) = '\0';
	}
	return(OutLine);
}

char *GetTableName(char *InLine)
{
static char	OutLine[1024];
char		*InPtr;
char		*OutPtr;

	InPtr = InLine;
	OutPtr = OutLine;
	OutLine[0] = '\0';
	while(*InPtr != '.' && *InPtr != '\0')
	{
		InPtr++;
	}
	InPtr++;
	while(*InPtr != '.' && *InPtr != '\0')
	{
		InPtr++;
	}
	if(*InPtr == '.')
	{
		InPtr++;
		while(*InPtr != ' ')
		{
			*OutPtr = *InPtr;
			InPtr++;
			OutPtr++;
		}
		(*OutPtr) = '\0';
	}
	return(OutLine);
}
