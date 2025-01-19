#include <stdio.h>

#define	TRUE	1
#define FALSE	0

void RemoveBackslash( char * );

void main( int argc, char *argv[] )
{
char	FileName[ 255 ];
char	TempFileName[ 255 ];
char	Line[ 1024 ];
FILE	*InFp;
FILE	*OutFp;

	if( argc != 2 )
	{
		printf( "Usage convpsv filename\n" );
		exit( 0 );
	}

	strcpy( FileName, argv[ 1 ] );
	strcpy( TempFileName, argv[ 1 ] );
	strcat( TempFileName, "d" );

	rename( FileName, TempFileName );

	InFp = fopen( TempFileName, "r" );
	if( InFp == NULL )
	{
		printf( "Failed to open input file\n" );
		exit( 0 );
	}
	OutFp = fopen( FileName, "wb" );
	if( OutFp == NULL )
	{
		printf( "Failed create new file\n" );
		exit( 0 );
	}

	while( fgets( Line, 1024, InFp ) != NULL )
	{
		Line[ strlen(Line) - 2 ] = 0;
		RemoveBackslash( Line );
		if( feof( InFp ) )
		{
			fprintf( OutFp, "%s", Line );
		}
		else
		{
			fprintf( OutFp, "%s\r\n", Line );
		}
	}

	fclose( InFp );
	fclose( OutFp );

	unlink( TempFileName );
}

void RemoveBackslash( char *InLine )
{
char	*Ptr;
char	TmpLine[1024];
int		Add 			= TRUE;
int		Index			= 0;

	Ptr = InLine;
	while( *Ptr != '\0' )
	{
		if( *Ptr == '\\' )
		{
			if( Add == TRUE )
			{
				TmpLine[Index] = *Ptr;
				Index++;
				Add = FALSE;
			}
			else
			{
				Add = TRUE;
			}
		}
		else
		{
			TmpLine[Index] = *Ptr;
			Index++;
		}
		Ptr++;
	}
	TmpLine[Index] = '\0';
	strcpy( InLine, TmpLine );
}
