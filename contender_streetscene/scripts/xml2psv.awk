# xml2psv - awk (1) program to read the ESIS output of nsgmls (1) run
#           on an XML file, and convert it to PSV format for spreadsheets

# Copyleft 2000 Silmaril Consultants. This is GNU software, for license
# details see http://www.silmaril.ie/gnugpl.xml

# Written by Peter Flynn, Silmaril Consultants, http://www.silmaril.ie
# Version 0.1 20 February 2000 first draft
# Version 0.2 21 February 2000 revised to output attributes
# Version 0.3 21 February 2000 revised to add quotes around some fields
# Version 0.4 22 February 2000 changed attribute handling to pseudofield

# The author asserts his right to be identified as the author of this
# program.

# You may use, copy and adapt this software free of charge.
# You must not prevent others from doing likewise.
# You must not distribute it to others without similar conditions, 
# including this condition, being imposed on all subsequent users.

# WARNING: this routine is intended for handling highly structured
# database-like data, with NO mixed content. It is not intended for
# use with text documents and will probably produce suboptimal output
# in those cases.

BEGIN {

# We'll manage our own line-ends, thanks

  ORS="";

# We want to use both single and double quotes in strings

  sq=sprintf("%c",39);
  dq=sprintf("%c",34);

# p counts the field position on the output record

  p=1;
  r=1;
  k=1;
  d=0;
  print "1|1|"
    }

# ESIS output from an SGML/XML parser is ASCII records, each starting
# with a flag character in column 1:

#	(	a start-tag (element type name only)
#	)	an end-tag (element type name only)
#	-	character data content (of the last named element type)
#	A	attribute (as NAME TYPE VALUE)

# Note that attributes PRECEDE their start-tag, so they have to be
# memorised for later replication.

# First we deal with start-tags. Record the depth of markup first

/^\(/ {
  ++d;

# Extract the element type name into fname for use as a fieldname, set
# a flag (got) to zero, then go through the array n of all the element
# type names we have encountered so far, and if one matches, record
# its position in the array on the value of the flag got.

  fname=substr($0,2);
  got=0;
  for (j=1; j<=i; ++j) 
    if (n[j]==fname) got=j;
  
# If there was no match, then this is the first time we have
# encountered this element type, so increment an index i and add the
# element type name to the array n, then set the flag to this index
# value.

  if (got==0) {
    ++i; 
    n[i]=fname; 
    got=i
      }; 

# If the index position of the element type name in the array is less
# than the current output field position p, this means we have hit a
# second occurrence of an element type name encountered earlier, so
# output a newline, repeat the current output record number, include
# the subrecord count, and reset the output field position to unity.

  if (got<p) {
    ++k;
    for (v=p-1; v<i; v++)
	print "|";
    print "|\n" r "|" k "|"; 
    p=1
      };

# If the current output field position p is less than the index
# position of the element type name in the array, it means we have
# encountered some (n>1) consecutive start-tags or some elements
# without character data content since the last element type, so we
# need to skip forwards across the new output record with pipes so
# that we end up "under" the same output field position as the earlier
# occurrence[s].

  for (j=p; j<got; ++j) 
    print "|";

# In any case, set the current output field position to the counter
# just used, in case it was indeed used to skip forward.

  p=j
    }

# That finishes processing for start-tags. We ignore end-tags in this
# conversion.

# For character data content, just check if the data contains pipes,
# single quotes, or grave accents.  TODO: this should also check for
# double quotes, and if found, output in single quotes. Question: what
# if the data contains both sq and dq?  Can PSV handle this?  After
# the quotes, output the data, and then repeat the quote check
# afterwards. Set the attribute count to zero always.

/^\-/ {
  if ($0~"," || $0~sq || $0~"`")
    print dq;
  print substr($0,2);
  if ($0~"," || $0~sq || $0~"`")
    print dq
      }

# For attributes, increment a counter and record the name, type, and
# value in an array [depth,attcnt,token].

/^A/ {
 ++attlevel[d];
 a=attlevel[d];
 attrib[d,a,1]=substr($1,2);
 attrib[d,a,2]=$2;
 attrib[d,a,3]=$3
   }

# For end-tags, if there are any attributes pending from the element
# type, now is the time to output them. Treat them as element types,
# but prefix their names with the fieldname, hashed. The detail of
# what happens here is identical to that for field (element) names,
# and is explained in the comments pertaining to that. Count the
# markup depth to make sure we have the right set of attributes.

/^\)/ {

  --d;
  a=attlevel[d];
  if (a>0) {

# Go through the loop 1-->c

    for (c=1; c<=a; ++c) {

# Pick each attribute name and make it the current fieldname

      aname=substr($0,2) "#" attrib[d,c,1];

# See if we've seen it before

      got=0;
      for (j=1; j<=i; ++j)
	if (n[j]==aname) got=j;

# If not, add it to the list

      if (got==0) {
	++i; 
	n[i]=aname; 
	got=i
	  };

# If we need to start a new record before skipping forward, do so

      if (got<p) {
	++k;
	print "|\n" r "|" k "|"; 
	p=1
	  };

# Skip forward if necessary

      for (j=p; j<got; ++j) 
	print "|";
      p=j;

# And output the data
      
      aval=attrib[d,c,3];
      if (aval~"," || aval~sq || aval~"`")
	print dq;
      print aval;
      if (aval~"," || aval~sq || aval~"`")
	print dq
	  
	  }; # end of loop for attributes
    attlevel[d]=0;
  }
}

# At the end, output a newline and a dummy record value of zero,
# followed by the element type names from the array n, separated by
# pipes. This way, when the data is sorted by the first and second
# pipe-delimited fields, the last recors goes to the top of the file,
# where it stands as the column headings when imported into a
# spreadsheet. In the outer shell which runs this program, the zero is
# replaced by the dummy column names "#rec,#cnt".

END {
  print "|\n0|1"; 
  for (j=1; j<=i; ++j) 
    print "|" n[j];
  print "|\n"
    }
    
# EOF



