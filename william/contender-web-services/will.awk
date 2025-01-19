BEGIN {}

{
  print "        <sql:getColumn position=\"" NR "\" to=\"" $1 "\" />"
  print "        <sql:wasNull>"
  print "            <% pageContext.setAttribute(\"" $1 "\",\"\"); %>"
  print "        </sql:wasNull>"
  print ""
}

END {}