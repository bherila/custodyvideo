<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%><!--#include file="../Connections/MySQL.asp" --><%
Response.Clear()
Response.ContentType = "text/plain"
Response.AddHeader "content-disposition", "attachment; filename=Data.csv" 
set conn = server.CreateObject("adodb.connection")
conn.open(MM_MySQL_STRING)
set rs = conn.execute("select * from cv_db order by id asc")
i = 0
for i = 0 to rs.fields.count - 1
	response.write("""" & rs.fields(i).name & """")
	if i < rs.fields.count - 1 then response.write(",")
next
response.Write(vbNewLine)
while not rs.eof
	for i = 0 to rs.fields.count - 1
		response.write("""" & rs(i) & """")
		if i < rs.fields.count - 1 then response.write(",")
	next	
	Response.Write(vbNewLine)
	rs.moveNext
	Response.Flush()
wend
Response.Flush()
Response.End()

%>