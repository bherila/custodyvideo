<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../Connections/MySQL.asp" --><%
function isMemberOf(group)
	isMemberOf = false
	gss = session("mm_groups")
	if len(gss) < 1 then gss = ":Everyone:"
	gss = lcase(gss)
	groups = split(gss, ":")
	groupz = split(group, ":")
	i = 0
	j = 0
	for j = lbound(groupz) to ubound(groupz)
		if isMemberOf = false then
			for i = lbound(groups) to ubound(groups)
				if len(groups(i)) > 1 then
					if lcase(groupz(j)) = lcase(groups(i)) then isMemberOf = true 
				end if
			next
		end if
	next
	erase groups
	erase groupz
end function
%>
<%
Dim Recordset1__xxx
Recordset1__xxx = "%"
If (Replace(Replace(Replace(Request("search"), "'", "''"), "*", "%"), " ", "%") <> "") Then 
  Recordset1__xxx = Replace(Replace(Replace(Request("search"), "'", "''"), "*", "%"), " ", "%")
End If
%>
<%
Dim Recordset1
Dim Recordset1_numRows

Set Recordset1 = Server.CreateObject("ADODB.Recordset")
Recordset1.ActiveConnection = MM_MySQL_STRING
Recordset1.Source = "SELECT category, id, name  FROM cv_invoice_products  WHERE length(category) > 0 and length(name) > 1 and name like '%" + (Recordset1__xxx) + "%' or description like '%" + (Recordset1__xxx) + "%' ORDER BY category asc, name asc"
Recordset1.CursorType = 0
Recordset1.CursorLocation = 2
Recordset1.LockType = 1
Recordset1.Open()

Recordset1_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
Recordset1_numRows = Recordset1_numRows + Repeat1__numRows
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Product Selector</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" type="text/javascript">
function sel(id, name)
{
	window.opener.document.getElementById('pid_text').innerHTML = name;
	window.opener.document.getElementById('subbtn').disabled = false;
	window.opener.document.getElementById('pid').value = id;
	window.close();
}
</script>
</head>
<body>
<form action="prod-sel.asp" method="post" name="form1">
  <em>  Search: 
    <input name="search" type="text" id="search" value="<%= Request("search") %>">
    <input type="submit" name="Submit" value="Go">
  </em>
</form>
<hr width="100%" size="1" noshade>
<p><strong>Click on a product to select it.<% if isMemberOf("Administrators") then %><a href="new-prod.asp" target="_blank">Admin Add New Product</a><% end if %></strong></p>
<ul>
  <% 
lc = ""
While ((Repeat1__numRows <> 0) AND (NOT Recordset1.EOF)) 
cat = Recordset1.Fields.Item("category").Value 
if cat <> lc then
if lc <> "" then Response.Write("</ul>")
lc = cat
Response.Write("<li>" & cat & "</li><ul>")
end if
%>
  <li>    <a href="javascript:sel('<%= Recordset1.Fields.Item("id").Value %>', '<%
  
  mn = Recordset1.Fields.Item("name").Value
  if len(mn) > 8 then mn = left(mn, 5) & "..."
  Response.Write(Replace(mn, "'", "\'"))
  
  %>');"><%=(Recordset1.Fields.Item("name").Value)%></a></li><% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  Recordset1.MoveNext()
Wend
%>
</ul><%= "</ul>" %>
<p><a href="javascript:window.close();">Cancel</a></p>
</body>
</html>
<%
Recordset1.Close()
Set Recordset1 = Nothing
%>
