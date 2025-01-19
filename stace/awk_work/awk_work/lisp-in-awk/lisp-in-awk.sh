#! /bin/sh
# This is a shell archive, meaning:
# 1. Remove everything above the #! /bin/sh line.
# 2. Save the resulting text in a file.
# 3. Execute the file with /bin/sh (not csh) to create:
#	walk
#	compile.w
#	numbers.w
#	sets.w
#	walk.w
#	walk.ms
#	p
# This archive created: Mon Jul 23 14:46:16 1990
export PATH; PATH=/bin:/usr/bin:$PATH
if test -f 'walk'
then
	echo shar: "will not over-write existing file 'walk'"
else
sed 's/^X//' << \SHAR_EOF > 'walk'
X#!/bin/awk -f
X#
X# walk -- LISP in awk
X#
X# An interpreter for LISP, written in awk(1).
X# Copyright (c) 1988, 1990 Roger Rohrbach
X
XBEGIN {
X
X    # interpreter constants:
X
X    stdin = "-";
X    true = 1;
X    false = 0;
X    constant = "#";		    # flags literal atoms
X    alist = -10000;		    # head of bound variable list
X
X    # global variables:
X
X    atom = -1;			    # atoms are allocated down from -1
X    cell = 1;			    # list cells are allocated up from 1
X
X    environment = alist;	    # pointer to current evaluation context;
X				    # saved in context[] before evaluating body
X				    # of lambda expression, restored afterwards
X
X    # LISP constants:
X
X    nil = intern["nil"] = atom--;   # intern[x] is the LISP atom named by x
X    name[nil] = "()";		    # name[s] is the print name of atom s
X
X    value[nil] = constant;	    # if x < alist, value[x] is the local
X				    # binding of the atom `symbol[x]'; otherwise
X				    # it is the top-level binding of the atom x.
X
X    t = intern["t"] = atom--;
X    name[t] = "t";
X    value[t] = constant;
X
X    lambda = intern["lambda"] = atom--;
X    name[lambda] = "lambda";
X    value[lambda] = constant;
X
X    # install the intrinsic functions:
X
X    split("cons cdr car eq atom set eval error quote cond and or list", \
X	 intrinsics);
X
X    for (i in intrinsics)
X    {
X	id = intrinsics[i];
X	intern[id] = atom--;
X	name[intern[id]] = id;
X	value[intern[id]] = sprintf("@%d", i);
X	name[value[intern[id]]] = sprintf("<intrinsic #%d>", i);
X    }
X
X    # these constants speed things up a bit
X
X    CONS = value[intern["cons"]];
X    CDR = value[intern["cdr"]];
X    CAR = value[intern["car"]];
X    EQ = value[intern["eq"]];
X    ATOM = value[intern["atom"]];
X    SET = value[intern["set"]];
X    EVAL = value[intern["eval"]];
X    ERROR = value[intern["error"]];
X    QUOTE = value[intern["quote"]];
X    COND = value[intern["cond"]];
X    AND = value[intern["and"]];
X    OR = value[intern["or"]];
X    LIST = value[intern["list"]];
X
X    # messages:
X
X    TYPE_ERROR = "invalid argument to %s: %s\n";
X    REDEF_ERROR = "can't redefine intrinsic function %s\n";
X    UNDEF_ERROR = "undefined function: %s\n";
X
X    HELLO = "walk (LISP in awk)\tCopyright (c) 1988, 1990 Roger Rohrbach\n";
X    GOODBYE = "%d atoms, %d list cells.\n";
X
X
X    # interpreter is ready
X
X    if (FILENAME == stdin)
X    {
X	print HELLO;
X	printf("-> ");
X    }
X}
X
X# interpreter loop:
X
X{
X    pos = 0;		# current input character position
X    eol = length + 1;	# read past last char for endquote, below
X
X    while (++pos <= eol)
X    {
X	#########
X	# read  #
X	#########
X
X	if (endquote)
X	{
X	    # close a quoted expr by inserting a right parenthesis
X	    endquote = false;
X	    c = ")";  
X	    --pos;    # if at eol, c is null; push back on input
X	}
X	else
X	    c = substr($0, pos, 1);
X
X	if (c == " " || c == "\t")
X	    continue;
X	else if (c == "" || c == ";")
X	{
X	    # eol or comment
X	    break;
X	}
X	else if (c == "'")
X	{
X	    # expand 's to (quote s)
X	    if (level > 0 && level != rp)
X		read[++rp] = CONS;
X	    read[++rp] = CONS;
X	    quotes[++qp] = ++level;
X	    read[++rp] = intern["quote"];
X	}
X	else if (c == "\"")
X	{
X	    string = true;
X	}
X	else if (c == "(")
X	{
X	    # begin a list
X	    read[++rp] = CONS;
X	    ++level;
X	}
X	else if (c == ")")
X	{
X	    if (level == 0)
X	    {
X		printf("ignored extra right parenthesis\n");
X		continue;
X	    }
X	    else if (rp == level && read[rp] == CONS)
X		--rp;	 # empty list read in
X
X	    # have just read a list
X	    read[++rp] = nil;
X	    --level;
X
X	    if (qp > 0 && quotes[qp] == level)
X	    {
X		# finish quoting this list
X		--qp;
X		endquote = true;
X	    }
X
X	    # actually construct the list
X	    while (read[rp - 2] == CONS && read[rp - 1] != CONS)
X	    {
X		cdr[cell] = read[rp];
X		car[cell] = read[--rp];
X		read[--rp] = cell++;
X	    }
X	}
X	else if (c ~ /[0-9]/)
X	{
X	    # read a number (integer)
X	    n = c;
X	    while ((c = substr($0, ++pos, 1)) ~ /[0-9]/)
X		n = n c;
X	    --pos; 
X	    if (level > 0 && level != rp)
X		read[++rp] = CONS;
X	    if (!intern[n])
X	    {
X		intern[n] = atom--;
X		name[intern[n]] = n;
X		value[intern[n]] = constant;
X	    }
X	    read[++rp] = intern[n];
X	    if (qp > 0 && quotes[qp] == level)
X	    {
X		--qp;
X		endquote = true;
X	    }
X	}
X	else if (c ~ /[_A-Za-z]/ || string)
X	{
X	    # read an identifier
X	    id = c;
X	    if (string)
X	    {
X		while ((c = substr($0, ++pos, 1)) != "\"")
X		    id = id c;
X		string = false;
X	    }
X	    else
X	    {
X		while ((c = substr($0, ++pos, 1)) ~ /[-A-Za-z_0-9]/)
X		    id = id c;
X		--pos;
X	    }
X	    if (level > 0 && level != rp)
X		read[++rp] = CONS;
X	    if (!intern[id])
X	    {
X		intern[id] = atom--;
X		name[intern[id]] = id;
X		value[intern[id]] = nil;
X	    }
X	    read[++rp] = intern[id];
X	    if (qp > 0 && quotes[qp] == level)
X	    {
X		--qp;
X		endquote = true;
X	    }
X
X	}
X	else if (c == "%")
X	{
X	    # refer to objects by `address'
X	    lispval = "";
X	    while ((c = substr($0, ++pos, 1)) ~ /[-0-9]/)
X		lispval = lispval c;
X	    if (!length(lispval))
X		lispval = nil;
X	    --pos;
X	    if (level > 0 && level != rp)
X		read[++rp] = CONS;
X	    read[++rp] = lispval;
X	    if (qp > 0 && quotes[qp] == level)
X	    {
X		--qp;
X		endquote = true;
X	    }
X	}
X	else
X	    printf("illegal character: %s\n", c);
X
X
X	if (rp && level == 0)	# have read an s-expression
X	{
X	    #########
X	    # eval  #
X	    #########
X
X	    eval[++ep] = read[rp--];
X
X	    while (ep > 0)
X	    {
X		s = eval[ep];
X
X		if (s < 0)
X		{
X		    # atomic s-expression
X
X		    if (s == lambda && fp)
X		    {
X			environment = context[fp--];	# restore environment
X		    }
X		    else if (value[s] == constant)
X			arg[++ap] = s;
X		    else
X		    {
X			# look up value of s in environment:
X			bound = false;
X			for (i = environment; i < alist; ++i)
X			{
X			    if (symbol[i] == s)
X			    {
X				bound = true;
X				break;
X			    }
X			}
X			if (bound)
X			    arg[++ap] = value[i];
X			else	# use value cell
X			    arg[++ap] = value[s];
X		    }
X		    --ep;
X		}
X		else if (index(s, "@"))
X		{
X		    # intrinsic function application:
X
X		    if (s == CONS)
X		    {
X			car[cell] = arg[ap];
X			cdr[cell] = arg[--ap];
X			if (cdr[cell] < 0 && cdr[cell] != nil)
X			{
X			    printf(TYPE_ERROR, "cons", name[cdr[cell]]);
X			    arg[ap = ep = 1] = nil; # stop evaluation
X			}
X			else
X			    arg[ap] = cell++;
X		    }
X		    else if (s == CDR)
X		    {
X			if (arg[ap] < 0)
X			{
X			    printf(TYPE_ERROR, "cdr", name[arg[ap]]);
X			    arg[ap = ep = 1] = nil;
X			}
X			else
X			    arg[ap] = cdr[arg[ap]];
X		    }
X		    else if (s == CAR)
X		    {
X			if (arg[ap] < 0)
X			{
X			    printf(TYPE_ERROR, "car", name[arg[ap]]);
X			    arg[ap = ep = 1] = nil;
X			}
X			else
X			    arg[ap] = car[arg[ap]];
X		    }
X		    else if (s == EQ)
X		    {
X			arg1 = arg[ap];
X			if (arg[--ap] == arg1)
X			    arg[ap] = t;
X			else
X			    arg[ap] = nil;
X		    }
X		    else if (s == ATOM)
X		    {
X			if (arg[ap] < 0)
X			    arg[ap] = t;
X			else
X			    arg[ap] = nil;
X		    }
X		    else if (s == SET)
X		    {
X			if ((arg1 = arg[ap]) > 0)
X			{
X			    printf(TYPE_ERROR, "set", "must be atomic");
X			    arg[ap = ep = 1] = nil;
X			}
X			else if (value[arg1] == constant)
X			{
X			    printf(TYPE_ERROR, "set", name[arg1]);
X			    arg[ap = ep = 1] = nil;
X			}
X			else if (index(value[arg1], "@"))
X			{
X			    printf(REDEF_ERROR, name[arg1]);
X			    arg[ap = ep = 1] = nil;
X			}
X			else
X			{
X			    bound = false;
X			    for (i = environment; i < alist; ++i)
X			    {
X				if (symbol[i] == arg1)
X				{
X				    bound = true;
X				    break;
X				}
X			    }
X			    arg2 = arg[--ap];
X
X			    if (bound)	# replace binding
X				arg[ap] = value[i] = arg2;
X			    else	# set value
X				arg[ap] = value[arg1] = arg2;
X			}
X		    }
X		    else if (s == EVAL)
X		    {
X			eval[ep++] = arg[ap--];
X		    }
X		    else if (s == ERROR)
X		    {
X			if (arg[ap] > 0)
X			    printf(TYPE_ERROR, "error", "must be atomic");
X			else
X			    printf("%s\n", name[arg[ap]]);
X			arg[ap = ep = 1] = nil;
X		    }
X		    --ep;
X		}
X		else if (car[s] == lambda)
X		{
X		    # lambda function application:
X
X		    formals = car[cdr[s]];
X		    context[++fp] = environment;    # save environment
X		    while (formals != nil)
X		    {
X			# bind lambda variables
X			symbol[--environment] = car[formals];
X			value[environment] = arg[ap--];
X			formals = cdr[formals];
X		    }
X		    eval[ep] = lambda;		    # closure
X		    eval[++ep] = car[cdr[cdr[s]]];  # push body of expr.
X		}
X		else if (car[s] < 0)
X		{
X		    # s is a form (f args)
X
X		    evlis[cdr[s]] = true;   # don't treat cdr as a form
X
X		    # special forms:
X
X		    f = value[car[s]];
X
X		    if (index(f, "@"))
X		    {
X			if (f == QUOTE)
X			{
X			    arg[++ap] = car[cdr[s]];
X			    --ep;
X			}
X			else if (f == COND)
X			{
X			    if (cdr[s] == nil)
X			    {
X				arg[++ap] = nil;
X				--ep;
X			    }
X			    else
X			    {
X				# save clauses, push first antecedent
X				clauses[++cp] = cdr[s];
X				eval[ep] = f;
X				eval[++ep] = car[car[clauses[cp]]];
X			    }
X			}
X			else if (f == AND)
X			{
X			    if (cdr[s] == nil)
X			    {
X				arg[++ap] = t;
X				--ep;
X			    }
X			    else
X			    {
X				# save predicates, push first
X				preds[++dp] = cdr[s];
X				eval[ep] = f;
X				eval[++ep] = car[preds[dp]];
X			    }
X			}
X			else if (f == OR)
X			{
X			    if (cdr[s] == nil)
X			    {
X				arg[++ap] = nil;
X				--ep;
X			    }
X			    else
X			    {
X				preds[++dp] = cdr[s];
X				eval[ep] = f;
X				eval[++ep] = car[preds[dp]];
X			    }
X			}
X			else if (f == LIST)
X			{
X			    # translate to (cons e1 e2 .. eN)
X			    for (e = cdr[s]; e != nil; e = cdr[e])
X			    {
X				eval[ep++] = CONS;
X				eval[ep++] = car[e];
X			    }
X			    eval[ep] = nil;
X			}
X			else
X			{
X			    # f takes evaluated arguments- push (f args)
X			    eval[ep] = f;
X			    eval[++ep] = cdr[s];
X			}
X		    }
X		    else if (car[f] == lambda)
X		    {
X			# push lambda function, arglist
X			eval[ep] = f;
X			if (cdr[s] != nil)
X			    eval[++ep] = cdr[s];
X		    }
X		    else if (evlis[s])
X		    {
X			eval[ep] = car[s];
X			if (cdr[s] != nil)
X			{
X			    eval[++ep] = cdr[s];
X			    evlis[cdr[s]] = true;
X			}
X		    }
X		    else
X		    {
X			# f is not a function
X			printf(UNDEF_ERROR, name[car[s]]);
X			arg[ap = 1] = nil;
X			ep = 0;
X		    }
X		}
X		else
X		{
X		    # evaluate car[s], cdr[s]
X
X		    eval[ep] = car[s];
X		    if (cdr[s] != nil)
X		    {
X			eval[++ep] = cdr[s];
X			if (evlis[s])
X			    evlis[cdr[s]] = true;
X		    }
X		}
X
X		# get next unevaluated argument (cond, and, or):
X
X		while (true)
X		{
X		    s = eval[ep];
X
X		    if (s == COND)
X		    {
X			if (arg[ap] == nil)
X			{
X			    # last antecedent was nil
X			    # push antecedent of next clause
X			    if ((clauses[cp] = cdr[clauses[cp]]) != nil)
X			    {
X				eval[++ep] = car[car[clauses[cp]]];
X				--ap;
X			    }
X			    else
X			    {
X				# no more clauses, return nil
X				--ep;
X				--cp;
X			    }
X			}
X			else
X			{
X			    # last antecedent was non-nil
X			    # push consequent
X			    if (cdr[car[clauses[cp]]] != nil)
X			    {
X				eval[ep] = car[cdr[car[clauses[cp]]]];
X				--ap;
X				--cp;
X			    }
X			    else
X			    {
X				# no consequent, return antecedent
X				--ep;
X				--cp;
X			    }
X			}
X		    }
X		    else if (s == AND)
X		    {
X			if (arg[ap] != nil)
X			{
X			    # last predicate non-nil
X			    # push next predicate if there is one
X			    if ((preds[dp] = cdr[preds[dp]]) != nil)
X			    {
X				eval[++ep] = car[preds[dp]];
X				--ap;
X			    }
X			    else
X			    {
X				# return value of last predicate
X				--ep;
X				--dp;
X			    }
X			}
X			else
X			{
X			    # return nil
X			    --ep;
X			    --dp;
X			}
X		    }
X		    else if (s == OR)
X		    {
X			if (arg[ap] == nil)
X			{
X			    # last predicate was nil
X			    # push next predicate if there is one
X			    if ((preds[dp] = cdr[preds[dp]]) != nil)
X			    {
X				eval[++ep] = car[preds[dp]];
X				--ap;
X			    }
X			    else
X			    {
X				# return nil
X				--ep;
X				--dp;
X			    }
X			}
X			else
X			{
X			    # return value of last predicate
X			    --ep;
X			    --dp;
X			}
X		    }
X		    else
X			break;
X		}
X	    }
X
X	    # throw away unused contexts (happens on errors):
X	    fp = 0;
X	    environment = alist;
X
X
X	    #########
X	    # print #
X	    #########
X
X	    space = false;
X	    s = arg[ap--];
X
X	    if (s < 0 || index(s, "@"))
X	    {
X		# print atom
X		printf("%s", name[s]);
X	    }
X	    else
X	    {
X		# print list
X
X		printf("(");
X		Print[++pp] = s;    # push s onto stack of exprs to print
X
X		while (pp > 0)
X		{
X		    s = Print[pp];
X
X		    if (s == nil)
X		    {
X			printf(")");
X			--pp;
X		    }
X		    else
X		    {
X			if (space)
X			    printf(" ");
X
X			Print[pp] = cdr[s]; # push cdr[s]
X
X			if (car[s] < 0)
X			{
X			    printf("%s", name[car[s]]);
X			    space = true;
X			}
X			else
X			{
X			    printf("(");
X			    space = false;
X			    Print[++pp] = car[s];   # recursively expand
X			}
X		    }
X		}
X	    }
X
X	    printf("\n");
X	}
X    }
X
X    if (FILENAME == stdin || FILENAME == "p")
X    {
X	if ((n = level - qp) > 0)
X	    printf("%d> ", n);
X	else
X	    printf("-> ");
X    }
X}
X
XEND {
X
X    if (FILENAME == stdin)
X	printf(GOODBYE, -atom - 1, cell - 1);
X
X    exit(0);
X}
SHAR_EOF
if test 12892 -ne "`wc -c < 'walk'`"
then
	echo shar: "error transmitting 'walk'" '(should have been 12892 characters)'
fi
chmod 550 'walk'
fi
if test -f 'compile.w'
then
	echo shar: "will not over-write existing file 'compile.w'"
else
sed 's/^X//' << \SHAR_EOF > 'compile.w'
X; LISP subset compiler
X;
X; compiles function applications with constant
X; or nested function call arguments
X;
X; see B.A. Pumplin, "Compiling LISP Procedures"
X; ACM SIGART Newsletter 99, January, 1987
X
X; primary functions
X
X(set 'compexp
X    '(lambda (exp)
X	(cond ((isconst exp) (list (mksend 1 exp)))
X	    (t (compapply (func exp)
X		    (complis (arglist exp))
X		    (length (arglist exp)))))))
X
X(set 'complis
X    '(lambda (u)
X	(cond ((null u) '())
X	    ((null (rest u)) (compexp (first u)))
X	    (t (append-3 (compexp (first u))
X		    (list (mkalloc 1))
X		    (complis (rest u)))))))
X
X(set 'compapply
X    '(lambda (fn vals n)
X	(append-3 vals (mklink n) (list (mkcall fn)))))
X
X
X; recognizer function
X
X(set 'isconst
X    '(lambda (x)
X	(or (numberp x) (eq x t) (eq x nil)
X	    (and (not (atom x)) (eq (first x) 'quote)))))
X
X
X; selector functions
X(set 'func '(lambda (x) (first x)))
X(set 'arglist '(lambda (x) (rest x)))
X
X
X; constructor functions
X; (code generator)
X(set 'mksend '(lambda (dest val) (list 'MOVEI dest val)))
X(set 'mkalloc '(lambda (dest) (list 'PUSH 'sp dest)))
X(set 'mkcall '(lambda (fn) (list 'CALL fn)))
X(set 'mklink
X    '(lambda (n) 
X	(cond ((eqn n 1) '())
X	    (t (concat (mkmove n 1) (mklink1 (sub1 n)))))))
X(set 'mklink1
X    '(lambda (n)
X	(cond ((zerop n) '())
X	    (t (concat (mkpop n) (mklink1 (sub1 n)))))))
X(set 'mkpop '(lambda (n) (list 'POP 'sp n)))
X(set 'mkmove '(lambda (dest val) (list 'MOVE dest val)))
X
X
X; auxiliary functions
X(set 'first '(lambda (x) (car x)))
X(set 'rest '(lambda (x) (cdr x)))
X(set 'concat
X    '(lambda (element sequence)
X	(cond ((listp sequence) (cons element sequence))
X	    (t '()))))
X(set 'append-3
X    '(lambda (l1 l2 l3)
X	(append l1 (append l2 l3))))
X(set 'listp
X    '(lambda (x)
X	(cond ((consp x) t) ((null x) t) (t nil))))
X
X; not built in to walk
X(set 'consp '(lambda (e) (not (atom e))))
X(set 'eqn '(lambda (x y) (eq x y)))
SHAR_EOF
if test 1880 -ne "`wc -c < 'compile.w'`"
then
	echo shar: "error transmitting 'compile.w'" '(should have been 1880 characters)'
fi
chmod 440 'compile.w'
fi
if test -f 'numbers.w'
then
	echo shar: "will not over-write existing file 'numbers.w'"
else
sed 's/^X//' << \SHAR_EOF > 'numbers.w'
X; numeric functions
X; 
X; This is all symbol manipulation- walk has no built-in math!
X; It's too slow to be of much use.
X
X; error conditions
X(set 'NOADD '"addition undefined for given arguments")
X(set 'NOSUB '"subtraction undefined for given arguments")
X
X(set '_integers_ '(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16))
X
X; increment a number by 1
X(set 'add1 '(lambda (n) (or (succ n _integers_) (error NOADD))))
X
X; decrement by 1
X(set 'sub1 '(lambda (n) (or (pred n _integers_) (error NOSUB))))
X
X; t if x is 0
X(set 'zerop '(lambda (x) (eq x 0)))
X
X; t if x is a number
X(set 'numberp '(lambda (x) (member x _integers_)))
X
X; t if x > y
X(set 'greaterp '(lambda (x y) (member x (after _integers_ y))))
X
X; t if x < y
X(set 'lessp '(lambda (x y) (member y (after _integers_ x))))
X
X; subtraction
X(set 'difference
X    '(lambda (x y)
X	(cond ((zerop y) x)
X	    (t (difference (sub1 x) (sub1 y))))))
X
X; take the length of a list
X(set 'length
X    '(lambda (s)
X	(cond ((atom s) 0)  ; or (null s)
X	    ((null (cdr s)) 1)
X	    (t (add1 (length (cdr s)))))))
X
X; addition (forget about actually using this)
X(set 'plus
X    '(lambda (x y)
X	(length (append (before _integers_ x) (before _integers_ y)))))
SHAR_EOF
if test 1179 -ne "`wc -c < 'numbers.w'`"
then
	echo shar: "error transmitting 'numbers.w'" '(should have been 1179 characters)'
fi
chmod 440 'numbers.w'
fi
if test -f 'sets.w'
then
	echo shar: "will not over-write existing file 'sets.w'"
else
sed 's/^X//' << \SHAR_EOF > 'sets.w'
X; set operations on lists
X
X(set 'union
X    '(lambda (x y)
X	(cond ((null x) y)
X	    ((member (car x) y) (union (cdr x) y))
X	    (t (cons (car x) (union (cdr x) y))))))
X
X(set 'intersection
X    '(lambda (x y)
X	(cond ((null x) nil)
X	    ((member (car x) y)
X		(cons (car x) (intersection (cdr x) y)))
X	    (t (intersection (cdr x) y)))))
X
X(set 'ldifference
X    '(lambda (in out)
X	(cond ((null in) nil)
X	    ((member (car in) out) (ldifference (cdr in) out))
X	    (t (cons (car in) (ldifference (cdr in) out))))))
X
X(set 'subsetp
X    '(lambda (a b)
X	(cond ((null a) t)
X	    ((member (car a) b) (subsetp (cdr a) b))
X	    (t nil))))
X
X(set 'samesetp
X    '(lambda (a b)
X	(and (subsetp a b) (subsetp b a))))
SHAR_EOF
if test 696 -ne "`wc -c < 'sets.w'`"
then
	echo shar: "error transmitting 'sets.w'" '(should have been 696 characters)'
fi
chmod 440 'sets.w'
fi
if test -f 'walk.w'
then
	echo shar: "will not over-write existing file 'walk.w'"
else
sed 's/^X//' << \SHAR_EOF > 'walk.w'
X; walk.w - extensions to simple interpreter in LISP
X;
X; Portions copyright (c) 1988, 1990 Roger Rohrbach
X
X; compositions of car, cdr
X
X(set 'cadr '(lambda (e) (car (cdr e))))
X(set 'cddr '(lambda (e) (cdr (cdr e))))
X(set 'caar '(lambda (e) (car (car e))))
X(set 'cdar '(lambda (e) (cdr (car e))))
X(set 'cadar '(lambda (e) (car (cdr (car e)))))
X(set 'caddr '(lambda (e) (car (cdr (cdr e)))))
X(set 'cddar '(lambda (e) (cdr (cdr (car e)))))
X(set 'cdadr '(lambda (e) (cdr (car (cdr e)))))
X
X; basic predicates
X
X(set 'null '(lambda (e) (eq e nil)))
X(set 'not '(lambda (e) (eq e nil)))
X
X; recursively defined functions
X
X; return the first atomic element of s
X(set 'ff
X    '(lambda (s)
X	(cond ((atom s) s) (t (ff (car s))))))
X
X; substitute x for all occurrences of the atom y in z
X(set 'subst
X    '(lambda (x y z)
X	(cond ((atom z) (cond ((eq z y) x) (t z)))
X	    (t (cons (subst x y (car z)) (subst x y (cdr z)))))))
X
X; compare two s-expressions for equality
X(set 'equal
X    '(lambda (x y)
X	(or (and (atom x) (atom y) (eq x y))
X	    (and (not (atom x))
X		(not (atom y))
X		(equal (car x) (car y))
X		(equal (cdr x) (cdr y))))))
X
X; create a new list containing the elements of x and y
X(set 'append
X    '(lambda (x y)
X	(cond ((null x) y)
X	    (t (cons (car x) (append (cdr x) y))))))
X
X; McCarthy's `among' function (returns t or nil)
X(set 'member
X    '(lambda (x y)
X	(and (not (null y))
X	    (or (equal x (car y)) (member x (cdr y))))))
X
X; pair the corresponding elements of two lists
X(set 'pair
X    '(lambda (x y)
X	(cond ((and (null x) (null y)) nil)
X	    ((and (not (atom x)) (not (atom y)))
X		(cons (list (car x) (car y))
X		    (pair (cdr x) (cdr y)))))))
X
X; association list selector function
X; y is a list of the form ((u1 v1) ... (uN vN))
X; x is one of the u's (an atom)
X; here we return the pair (u v) as in most modern Lisps
X(set 'assoc
X    '(lambda (x y)
X	(cond ((null y) nil)
X	    ((eq caar y x) (car y))
X	    (t (assoc x (cdr y))))))
X
X; x is an association list
X; (sublis x y) substitutes the values in x for the keys in y
X(set 'sublis
X    '(lambda (x y)
X	(cond ((atom y) (_sublis x y))
X	    (t (cons (sublis x (car y)) (sublis x (cdr y)))))))
X
X(set '_sublis
X    '(lambda (x z)
X	(cond ((null x) z)
X	    ((eq (caar x) z) (cadar x))
X	    (t (_sublis (cdr x) z)))))
X
X; return the last element of list e
X(set 'last
X    '(lambda (e)
X	(cond ((atom e) nil)
X	    ((null (cdr e)) (car e))
X	    (t (last (cdr e))))))
X
X; reverse a list
X(set 'reverse '(lambda (x) (_reverse x nil)))
X(set '_reverse
X    '(lambda (x y)
X	(cond ((null x) y)
X	    (t (_reverse (cdr x) (cons (car x) y))))))
X
X; remove an element from a list
X(set 'remove
X    '(lambda (e l)
X	(cond ((null l) nil)
X	    ((equal e (car l)) (remove e (cdr l)))
X	    (t (cons (car l) (remove e (cdr l)))))))
X
X; find the successor of the atom x in y
X(set 'succ
X    '(lambda (x y)
X	(cond ((or (null y) (null (cdr y))) nil)
X	    ((eq (car y) x) (cadr y))
X	    (t (succ x (cdr y))))))
X
X; find the predecessor of the atom x in y
X(set 'pred
X    '(lambda (x y)
X	(cond ((or (null y) (null (cdr y))) nil)
X	    ((eq (cadr y) x) (car y))
X	    (t (pred x (cdr y))))))
X
X; return the elements in x up to y
X(set 'before
X    '(lambda (x y)
X	(cond ((atom x) nil)
X	    ((null (cdr x)) nil)
X	    ((equal (car x) y) nil)
X	    ((equal (cadr x) y) (cons (car x) nil))
X	    (t (cons (car x) (before (cdr x) y))))))
X
X; return the elements in x after y
X(set 'after
X    '(lambda (x y)
X	(cond ((atom x) nil)
X	    ((equal (car x) y) (cdr x))
X	    (t (after (cdr x) y)))))
X
X; return the property list of atom x
X(set 'plist '(lambda (x) (succ x Properties)))
X
X; get the value stored on x's property list under i
X(set 'get
X    '(lambda (x i)
X	((lambda (pr)
X	    (cond ((null pr) nil)
X		(t (cadr pr)))) (assoc i (plist x)))))
X
X; store v on x's property list under i
X(set 'putprop
X    '(lambda (x v i)
X	(and (or (plist x)
X		; add a slot
X		(set 'Properties (cons x (cons nil Properties))))
X	    (and (set 'Properties
X		    (append (before Properties x)
X			(append
X			    (list x
X				(cons (list i v)    ; new plist
X				    ((lambda (l)
X					(remove (assoc i l) l)) (plist x))))
X			    (cdr (after Properties x))))) v))))
X
X; remove a property and value from x's plist
X(set 'remprop
X    '(lambda (x i)
X	(and (get x i)	; if property exists
X	    (set 'Properties
X		(append (before Properties x)
X		    (append
X			(list x
X			    ((lambda (l)
X				(remove (assoc i l) l)) (plist x)))
X			(cdr (after Properties x))))) i)))
X
X; map f onto each element of l, return the list of results
X(set 'mapcar
X    '(lambda (f l)
X	(cond ((null l) nil)
X	    (t (cons (eval (list f (list 'quote (car l))))
X		(mapcar f (cdr l)))))))
X
X; call f with args, i.e., (apply 'cons '(a (b))) <-> (cons 'a '(b))
X(set 'apply
X    '(lambda (f args)
X	(cond ((null args) nil)
X	(t (eval (cons f (mapcar '(lambda (a) (list 'quote a)) args)))))))
SHAR_EOF
if test 4806 -ne "`wc -c < 'walk.w'`"
then
	echo shar: "error transmitting 'walk.w'" '(should have been 4806 characters)'
fi
chmod 440 'walk.w'
fi
if test -f 'walk.ms'
then
	echo shar: "will not over-write existing file 'walk.ms'"
else
sed 's/^X//' << \SHAR_EOF > 'walk.ms'
X.\" troff -ms
X.\" ...if no CW font available, change CW to B globally
X.de ZB
X.DS
X.ft CW
X.nf
X..
X.de ZE
X.DE
X.ft R
X.fi
X.br
X..
X.TL 
XA LISP interpreter in Awk
X.AU
XRoger Rohrbach
X.AI
X1592 Union St.,  #94
XSan Francisco,  CA 94123
X.ND
XJanuary 3,  1989
X.AB ABSTRACT
X.PP
XThis note describes a simple interpreter for the LISP programming
Xlanguage,  written in \fBawk\fR.  It provides
Xintrinsic versions of the basic functions on s-expressions,  and many others
Xwritten in LISP.  It is compatible with the commonly
Xavailable version of \fBawk\fR that is
Xsupplied with most UNIX systems.  The interpreter serves to illustrate
Xthe use of \fBawk\fR for prototyping or implementing language
Xtranslators,  as well as providing a simple example of LISP
Ximplementation techniques.
X.AE
X.SH
XIntrinsic functions.
X.PP
XThe interpreter has thirteen built-in functions.
XThese include the five elementary functions on s-expressions defined
Xby McCarthy [1];  some conditional expression operators;  an
Xassignment operator,  and some functions to control the evaluation process.
X.PP
XThe intrinsic functions are summarized below.
XFamiliarity with existing LISP systems is assumed in the
Xdescriptions of these functions.
X.IP "\f(CW(car \fIl\fP)\fR"
X.br
XReturns the first element of the list \fIl\fR.
XAn error occurs if \fIl\fR is atomic.
X.IP "\f(CW(cdr \fIl\fP)\fR"
X.br
XReturns the remainder of the list \fIl\fR,  \fIi.e.\fR,
Xthe sublist containing the second through the last
Xelements.  If \fIl\fR has only one element,  \fBnil\fR is
Xreturned.  \fBcdr\fR is undefined on atoms.
X.IP "\f(CW(cons \fIe l\fP)\fR"
X.br
XConstructs a new list whose \fBcar\fR is \fIe\fR
Xand whose \fBcdr\fR is \fIl\fR.
X.IP "\f(CW(eq \fIx y\fP)\fR"
X.br
XReturns \fBt\fR if \fIx\fR and \fIy\fR
Xare the same LISP object,  \fIi.e.\fR,  are either atomic and
Xhave the same print name,  or evaluate to the same
Xlist cell.  Otherwise,  \fBnil\fR is returned.
X.IP "\f(CW(atom \fIs\fP)\fR"
X.br
XReturns \fBt\fR if \fIs\fR is an atom,  otherwise \fBnil\fR.
X.IP "\f(CW(set \fIx y\fP)\fR"
X.br
XAssigns the value \fIy\fR to \fIx\fR and returns \fIy\fR.
X\fIx\fR must be atomic,  and may not be a constant
Xor name an intrinsic function.
X.IP "\f(CW(eval \fIs\fP)\fR"
X.br
XEvaluates \fIs\fR and returns the result.
X.IP "\f(CW(error \fIs\fP)\fR"
X.br
XHalts evaluation and returns \fBnil\fR.
XThe atom \fIs\fR is printed.
X.IP "\f(CW(quote \fIs\fP)\fR"
X.br
XReturns \fIs\fR,  unevaluated.  The form
X.ZB
X\'\fIexpr\fP
X.ZE
Xis an abbreviation for
X.ZB
X(quote \fIexpr\fP)
X.ZE
X.IP "\f(CW(cond (\fIp1 \f(CW[\fIe1\f(CW]) \fI...\fP (\fIpN \f(CW[\fIeN\f(CW]))\fR"
X.br
XEvaluates each \fIp\fR from left to right.  If any
Xevaluate to a value other than \fBnil\fR,  the
Xcorresponding \fIe\fR is evaluated and the result is returned.
XIf there is no corresponding \fIe\fR,  the value of the \fIp\fR
Xitself is returned instead.
XIf no \fIp\fR has a non-null value,  \fBnil\fR is returned.
X.IP "\f(CW(and \fIe1 ...  eN\fP)\fR"
X.br
XEvaluates each \fIe\fR and returns \fBnil\fR if any evaluate to \fBnil\fR.
XOtherwise  the value of the last \fIe\fR is returned.
X.IP "\f(CW(or \fIe1 ...  eN\fP)\fR"
X.br
XEvaluates each \fIe\fR and returns the first whose
Xvalue is non-null.  If no such \fIe\fR is found,  \fBnil\fR is returned.
X.IP "\f(CW(list \fIe1 ...  eN\fP)\fR"
X.br
XConstructs a new list with elements \fIe1 ...  eN\fR.
XEquivalent to
X.br
X\f(CW(cons \fIe1\fP (cons \fI...\fP (cons \fIeN\fP nil)\fR.
X.SH
XLambda functions.
X.PP
XThe following functions are written in LISP and are
Xdefined in the file \fBwalk.w\fR.  Most of
Xthese are commonly supplied with LISP systems.
X.IP "\f(CW(cadr \fIs\fP)\fR"
X.IP "\f(CW(cddr \fIs\fP)\fR"
X.IP "\f(CW(caar \fIs\fP)\fR"
X.IP "\f(CW(cdar \fIs\fP)\fR"
X.IP "\f(CW(cadar \fIs\fP)\fR"
X.IP "\f(CW(caddr \fIs\fP)\fR"
X.IP "\f(CW(cddar \fIs\fP)\fR"
X.IP "\f(CW(cdadr \fIs\fP)\fR"
X.br
XThese correspond to various compositions of
X\fBcar\fR and \fBcdr\fR,  \fIe.g.\fR,
X.br
X\f(CW(cadr \fIs\fP)\fR \(-> \f(CW(car (cdr \fIs\fP))\fR.
X.IP "\f(CW(null \fIs\fP)\fR"
X.br
XEquivalent to \f(CW(eq \fIs\fP nil)\fR.
X.IP "\f(CW(not \fIs\fP)\fR"
X.br
XSame as \fBnull\fR.
X.IP "\f(CW(ff \fIs\fP)\fR"
X.br
XReturns the first atomic symbol in \fIs\fR.
X.IP "\f(CW(subst \fIx y z\fP)\fR"
X.br
XSubstitutes \fIx\fR for all occurrences of the atom \fIy\fR in \fIz\fR.
X\fIx\fR and \fIz\fR are arbitrary s-expressions.
X.IP "\f(CW(equal \fIx y\fP)\fR"
X.br
XReturns \fBt\fR if \fIx\fR and \fIy\fR are
Xthe same s-expression,  otherwise \fBnil\fR.
X.IP "\f(CW(append \fIx y\fP)\fR"
X.br
XCreates a new list containing the elements of x and y,
Xwhich must both be lists.
X.IP "\f(CW(member \fIx y\fP)\fR"
X.br
XReturns \fBt\fR if \fIx\fR is an element of the list \fIy\fR,
Xotherwise \fBnil\fR.
X.IP "\f(CW(pair \fIx y\fP)\fR"
X.br
XPairs each element of the lists \fIx\fR and \fIy\fR,
Xand returns a list of the resulting pairs.  The number
Xof pairs in the result will equal the length of the
Xshorter of the two input lists.
X.IP "\f(CW(assoc \fIx y\fP)\fR"
X.br
XAssociation list selector function.
X\fIy\fR is a list of the
Xform \f(CW((\fIu1\fP \fIv1\fP) \fI...\fP (\fIuN\fP \fIvN\fP))\fR
Xwhere the \fIu\fR's are atomic.  If \fIx\fR is
Xone of these,  the corresponding pair \f(CW(\fIu\fP \fIv\fP)\fR
Xis returned,  otherwise \fBnil\fR.
X.IP "\f(CW(sublis \fIx y\fP)\fR"
X.br
X\fIx\fR is an association list.
XSubstitutes the values in \fIx\fR for the keys in \fIy\fR.
X.IP "\f(CW(last \fIl\fP)\fR"
X.br
XReturns the last element of \fIl\fR.
X.IP "\f(CW(reverse \fIl\fP)\fR"
X.br
XReturns a list that contains the elements in \fIl\fR,
Xin reverse order.
X.IP "\f(CW(remove \fIe l\fP)\fR"
X.br
XReturns a copy of \fIl\fR with all
Xoccurrences of the element \fIe\fR removed.
X.IP "\f(CW(succ \fIx y\fP)\fR"
X.br
XReturns the element that immediately follows the atom \fIx\fR
Xin the list \fIy\fR.  If \fIx\fR does not occur in \fIy\fR
Xor is the last element,  \fBnil\fR is returned.
X.IP "\f(CW(pred \fIx y\fP)\fR"
X.br
XReturns the element that immediately precedes the atom \fIx\fR
Xin the list \fIy\fR.  If \fIx\fR does not occur in \fIy\fR
Xor is the first element,  \fBnil\fR is returned.
X.IP "\f(CW(before \fIx y\fP)\fR"
X.br
XReturns the list of elements occurring before y in x.
XIf \fIy\fR does not occur in \fIx\fR
Xor is the first element,  \fBnil\fR is returned.
X.IP "\f(CW(after \fIx y\fP)\fR"
X.br
XReturns the list of elements occurring after y in x.
XIf \fIy\fR does not occur in \fIx\fR
Xor is the last element,  \fBnil\fR is returned.
X.IP "\f(CW(plist \fIx\fP)\fR"
X.br
XReturns the property list for the atom \fIx\fR.
X.IP "\f(CW(get \fIx i\fP)\fR"
X.br
XReturns the value stored on \fIx\fR's property list
Xunder the indicator \fIi\fR.
X.IP "\f(CW(putprop \fIx v i\fP)\fR"
X.br
XStores the value \fIv\fR on \fIx\fR's property list under
Xthe indicator \fIi\fR.
X.IP "\f(CW(remprop \fIx i\fP)\fR"
X.br
XRemove the indicator \fIi\fR
Xand any associated value from \fIx\fR's property list.
X.IP "\f(CW(mapcar \fIf l\fP)\fR"
X.br
XApplies the function \fIf\fR to each element of \fIl\fR and returns
Xthe list of results.
X.IP "\f(CW(apply \fIf args\fP)\fR"
X.br
XCalls \fIf\fR with the arguments \fIargs\fR,  \fIe.g.\fR,
X.ZB
X(apply 'cons '(a (b)))
X.ZE
Xis equivalent to
X.ZB
X(cons 'a '(b))
X.ZE
X.SH
XSyntactic conventions.
X.LP
XAtoms take the following forms:
X.IP "\fIRegular identifiers\fR"
X.br
XAtoms matching the regular expression
X.br
X.sp
X.nf
X    \f(CW[_A-Za-z][-A-Za-z_0-9]*\fR
X.fi
X.sp
XThe initial value of an identifier is \fBnil\fR.
X.IP "\fIIntegers\fR"
X.br
XAtoms matching the regular expression \f(CW[0-9][0-9]*\fR.
XIntegers are constants,  \fIi.e.\fR,  evaluate to themselves.
X.IP "\fIWeird atoms\fR"
X.br
XIdentifiers matching the regular expression \f(CW".*"\fR.  Weird
Xatoms are not constants.
X.LP
XA semicolon introduces a comment,  which continues for the rest
Xof the line.
X.SH
XUsage.
X.LP
XThe command for running the interpreter is
X.ZB
Xwalk [ \fIfiles\fP ]
X.ZE
Xon BSD UNIX and derivative systems,  or
X.ZB
Xawk -f walk [ \fIfiles\fP ]
X.ZE
Xon UNIX System V.
XThe file name \f(CW\-\fR represents the standard input.
XThis can be omitted if no other files are being read in,  or
Xif the interpreter is being run non-interactively.
X.PP
XNormally,  the interpreter is used interactively,  augmented
Xwith the functions defined in \fBwalk.w\fR,  and,  perhaps,  other files.
XThe command line to use for this purpose is
X.ZB
Xwalk walk.w [ \fIother files\fP ] p -
X.ZE
XThe interpreter will first read \fBwalk.w\fR,  printing
Xthe results of evaluating the function definitions
Xtherein.  Then it will read \fBp\fR.  This file
Xcontains no LISP definitions;  the interpreter recognizes
Xit by name and prints a prompt to signal the user that all
Xthe prerequisite files have been read and that the interpreter
Xis waiting for input.  (This is the only way to get \fBawk\fR
Xto do this;  this can be hidden from the user
Xwith a shell program that invokes the interpreter if desired.)
XThereafter,  it will evaluate expressions typed in by
Xthe user,  printing a prompt after each one.
XNormally the prompt is \f(CW\->\fR;  the first character of the
Xprompt changes when appropriate to an integer that represents the number
Xof unmatched left parentheses read in so far.
X.PP
XThe interpreter exits when it encounters the end of its last input file.
XIf this file is the standard input,  the number of LISP objects
Xcreated is reported.
X.PP
XSeveral files defining auxiliary functions are provided.
X.SH
XImplementation.
X.PP
XSo that it can run on any UNIX system,  The
XLISP interpreter has been written using the UNIX V7 version
Xof \fBawk\fR,  which
Xpredates the version described in \fIThe Awk Programming Language\fR [2].
XThe only complex data type provided by this language is the array.
XData that in C might be stored in structures is
Xrepresented,  therefore, using
Xmultiple arrays,  one for each field.  For example,  the C code
X.ZB
X	p = allocate_cell();
X	p->car = s;
X	p->cdr = NIL;
X.ZE
Xcan be approximated with:
X.ZB
X	p = ++cell;
X	car[p] = s;
X	cdr[p] = nil;
X.ZE
XLists (using nested array references)
Xand stacks are also simulated with arrays.  The most important data
Xstructures are explained in the program and in the following description.
X.PP
XAs is usual for LISP implementations,  the interpreter is constructed as a
Xloop that reads an s-expression,  evaluates it,  and prints the
Xresult.  The reader collects an s-expression,  reading multiple
Xinput lines if necessary.  Like the other two phases of the
Xinterpreter,  this is a recursive procedure and
Xin \fBawk\fR this must be managed explicitly.
XWhen an s-expression is read,  its internal representation in
Xlist structure is formed using the stack \fBread[]\fR.  Atoms and
X\fBcons\fR operators are pushed onto the read stack and periodically
X`reduced' or replaced
Xwith list cells when a complete list has been read;  the reader returns
Xan atom or list on the top of the stack.
XThe reader must
Xbe able to return an s-expression in the middle of an input line,  so the
Xentire interpreter is enclosed in a loop that allows the
Xcurrent input line to be completely scanned before the next
Xinput record is read.  The general outline is:
X.ZB
XBEGIN {
X.ft I
X	initialize interpreter 
X	say hello if interactive
X.ft R
X.ft CW
X}
X
X{
X.ft I
X	initialize reader variables
X.ft R
X.ft CW
X
X	while (\fIchars left on this line\fR\f(CW)
X	{
X.ft I
X		read
X.ft R
X.ft CW
X
X		if (\fIhave read an s-expression\fR\f(CW)
X		{
X.ft I
X			eval
X
X			print
X.ft R
X.ft CW
X		}
X	}
X
X.ft I
X	prompt if interactive
X.ft R
X.ft CW
X}
X
XEND {
X.ft I
X	say goodbye if interactive
X	exit
X.ft R
X.ft CW
X}
X.ZE
X.PP
XThe evaluator maintains two stacks,  one for input and one for output.
XThe result returned by the reader is copied onto the input stack
X(\fBeval[]\fR),  and evaluated according to the usual LISP rules.
XEvaluated s-expressions are placed on the output stack,  \fBarg[]\fR.
XWhen an intrinsic function that takes evaluated arguments appears on
Xthe top of the evaluation stack,  its arguments are popped from the
Xargument stack.  Functions (like \fBcond\fR) that take unevaluated
Xarguments are handled as special forms before their arguments have been
Xpushed onto \fBeval[]\fR.  The arguments are handled differently
Xdepending on the
Xsemantics of the function.  Lambda (user-defined) functions are evaluated
Xby temporarily binding the formal parameters in the function
Xdefinition to the results of evaluating the actual arguments with which
Xthe function was called,  and then evaluating the body of the function.
XTemporary bindings only are kept on a special
Xpushdown list (the \fIalist\fR).  Atoms have a global value that is
Xstored separately;  this keeps the alist small.
X.LP
XThe evaluation procedure is sketched below:
X.ZB
X.ft I
Xatom?
X.ft CW
X	lambda
X.ft R
X		restore previous environment (lambda function
X		body has been evaluated already)
X.ft I
X	constant?
X.ft R
X		return
X.ft I
X	bound?
X.ft R
X		look up local value
X.ft I
X	otherwise
X.ft R
X		return global value
X
X.ft I
Xintrinsic function?
X.ft R
X	apply to already evaluated arguments
X
X.ft I
Xlambda function?
X.ft R
X	bind formal parameters to already evaluated arguments
X	evaluate function body
X
X.ft I
Xform?
X	intrinsic function application?
X.ft R
X.ft CW
X		quote
X.ft R
X			return unevaluated argument
X.ft CW
X		cond
X		and
X		or
X.ft R
X			begin evaluating arguments according to operator semantics
X.ft CW
X		list
X.ft R
X			expand to repeated applications of cons
X.ft I
X	other?
X.ft R
X		push function variable,  arguments
X	
X.ft I
Xlambda function application?
X.ft R
X	push lambda function,  body
X.ft I
Xother?
X.ft R
X	eval \fBcar\fR,  \fBcdr\fR
X.ZE
X.PP
XWhen the evaluation stack is emptied,  the result
Xis popped from the argument stack and printed.  A stack is again
Xused to manage recursion.
X.SH
XConclusion.
X.PP
XThe goal of writing a small LISP interpreter and extending it
Xin LISP has been realized.  Though it was not my original intention,  it
Xwould be easy to incorporate the
XLISP functions as intrinsics,  and many other extensions (such as
Xnumeric functions) could be made,  in which case the interpreter
Xmight fulfill more than a pedagogic function.
XEven so,  it can be used as is for an introduction to LISP programming
Xand implementation concepts.  I hope it also inspires more of us to
Xlearn how to program in \fBawk\fR!
X.SH
XReferences.
X.IP "[1]"
X.br
XMcCarthy, J.  Recursive Functions of Symbolic Expressions
Xand their Computation by Machine,  Part
XI.  \fIComm. ACM\fR,  3,  4,  pp. 185-195
XApril 1960
X.IP "[2]"
X.br
XAho, A.,  Weinberger,  P.,  & Kernighan,  B.W.  \fIThe
XAwk Programming Language\fR.  Addison-Wesley,  Reading,  MA 1988
SHAR_EOF
if test 14383 -ne "`wc -c < 'walk.ms'`"
then
	echo shar: "error transmitting 'walk.ms'" '(should have been 14383 characters)'
fi
chmod 440 'walk.ms'
fi
if test -f 'p'
then
	echo shar: "will not over-write existing file 'p'"
else
sed 's/^X//' << \SHAR_EOF > 'p'
X; Reading this file forces a prompt.
SHAR_EOF
if test 37 -ne "`wc -c < 'p'`"
then
	echo shar: "error transmitting 'p'" '(should have been 37 characters)'
fi
chmod 440 'p'
fi
exit 0
#	End of shell archive
----------------------------------cut--here-------------------------------------
