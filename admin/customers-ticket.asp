<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../Connections/MySQL.asp" -->
<%
' *** Edit Operations: declare variables

Dim MM_editAction
Dim MM_abortEdit
Dim MM_editQuery
Dim MM_editCmd

Dim MM_editConnection
Dim MM_editTable
Dim MM_editRedirectUrl
Dim MM_editColumn
Dim MM_recordId

Dim MM_fieldsStr
Dim MM_columnsStr
Dim MM_fields
Dim MM_columns
Dim MM_typeArray
Dim MM_formVal
Dim MM_delim
Dim MM_altVal
Dim MM_emptyVal
Dim MM_i

MM_editAction = CStr(Request.ServerVariables("SCRIPT_NAME"))
If (Request.QueryString <> "") Then
  MM_editAction = MM_editAction & "?" & Server.HTMLEncode(Request.QueryString)
End If

' boolean to abort record edit
MM_abortEdit = false

' query string to execute
MM_editQuery = ""
%>
<%
' *** Update Record: set variables

If (CStr(Request("MM_update")) = "form1" And CStr(Request("MM_recordId")) <> "") Then

  MM_editConnection = MM_MySQL_STRING
  MM_editTable = "cv_invoices"
  MM_editColumn = "id"
  MM_recordId = "" + Request.Form("MM_recordId") + ""
  MM_editRedirectUrl = ""
  MM_fieldsStr  = "memo|value"
  MM_columnsStr = "memo|',none,''"

  ' create the MM_fields and MM_columns arrays
  MM_fields = Split(MM_fieldsStr, "|")
  MM_columns = Split(MM_columnsStr, "|")
  
  ' set the form values
  For MM_i = LBound(MM_fields) To UBound(MM_fields) Step 2
    MM_fields(MM_i+1) = CStr(Request.Form(MM_fields(MM_i)))
  Next

  ' append the query string to the redirect URL
  If (MM_editRedirectUrl <> "" And Request.QueryString <> "") Then
    If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0 And Request.QueryString <> "") Then
      MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
    Else
      MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
    End If
  End If

End If
%>
<%
' *** Update Record: construct a sql update statement and execute it

If (CStr(Request("MM_update")) <> "" And CStr(Request("MM_recordId")) <> "") Then

  ' create the sql update statement
  MM_editQuery = "update " & MM_editTable & " set "
  For MM_i = LBound(MM_fields) To UBound(MM_fields) Step 2
    MM_formVal = MM_fields(MM_i+1)
    MM_typeArray = Split(MM_columns(MM_i+1),",")
    MM_delim = MM_typeArray(0)
    If (MM_delim = "none") Then MM_delim = ""
    MM_altVal = MM_typeArray(1)
    If (MM_altVal = "none") Then MM_altVal = ""
    MM_emptyVal = MM_typeArray(2)
    If (MM_emptyVal = "none") Then MM_emptyVal = ""
    If (MM_formVal = "") Then
      MM_formVal = MM_emptyVal
    Else
      If (MM_altVal <> "") Then
        MM_formVal = MM_altVal
      ElseIf (MM_delim = "'") Then  ' escape quotes
        MM_formVal = "'" & Replace(MM_formVal,"'","''") & "'"
      Else
        MM_formVal = MM_delim + MM_formVal + MM_delim
      End If
    End If
    If (MM_i <> LBound(MM_fields)) Then
      MM_editQuery = MM_editQuery & ","
    End If
    MM_editQuery = MM_editQuery & MM_columns(MM_i) & " = " & MM_formVal
  Next
  MM_editQuery = MM_editQuery & " where " & MM_editColumn & " = " & MM_recordId

  If (Not MM_abortEdit) Then
    ' execute the update
    Set MM_editCmd = Server.CreateObject("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_editConnection
    MM_editCmd.CommandText = MM_editQuery
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    If (MM_editRedirectUrl <> "") Then
      Response.Redirect(MM_editRedirectUrl)
    End If
  End If

End If
%>
<%
set Conn = Server.CreateObject("adodb.connection")
Conn.Open(MM_MySQL_STRING)

if Request("submit") = "Add" then

set rs = Conn.Execute("select id from cv_invoice_items where tid = " & ccur(request("id")) & " and pid = " & ccur(request("pid")) & " limit 1")
if (rs.bof and rs.eof) then
	'Add the Item
	Conn.Execute("insert into cv_invoice_items (tid, pid, quantity) values ('" & ccur(Request("id")) & "', " & ccur(Request("pid")) & ", " & ccur(Request("quantity")) & ")")
	a = true
else
	'Only Increment the Quantity
	sql = "update cv_invoice_items set quantity = quantity + " & ccur(Request("quantity")) & " where id = " & rs(0)
	Conn.Execute(sql)
	a = true
end if
rs.close
set rs = nothing
end if

If Request("submit") = "Apply" and isMemberOf("Administrators") then
	Conn.Execute("insert into cv_invoice_discounts (tid, description, amount) values (" & ccur(Request("id")) & ", '" & Request("description") & "', " & cdbl(Request("amount")) & ")")
	a = true
End If

if Len(Request("remove")) > 0 then
	Conn.Execute("delete from cv_invoice_items where id = " & ccur(Request("remove")))
	a = true
end if
if Len(Request("unapply")) > 0 and isMemberOf("Administrators") then
	Conn.Execute("delete from cv_invoice_discounts where id = " & ccur(Request("unapply")))
	a = true
end if
if (Request("submit")) = "Set" then
	Conn.Execute("update cv_invoices set shipping = '" & Request("shipping") & "' where id = " & ccur(Request("id")))
	a = true
end if
if (Request("submit")) = "Submit" then
	Conn.Execute("update cv_invoices set approved = 1 where id = " & ccur(Request("id")))
	a = true
end if
if (Request("submit")) = "Approve" and isMemberOf("Administrators") then
	Conn.Execute("update cv_invoices set approved = 2 where id = " & ccur(Request("id")))
	a = true
end if
if (Request("submit")) = "Reject" and isMemberOf("Administrators") then
	Conn.Execute("update cv_invoices set approved = 0 where id = " & ccur(Request("id")))
	a = true
end if

if a then
	Conn.Close
	Set Conn = Nothing
	Set Rs = Nothing
	Randomize
	Response.Redirect("customers-ticket.asp?id=" & Request("id") & "&cid=" & Request("cid") & "&rnd=" & rnd)
	Response.End()
end if

%>
<%
Dim Recordset2__xxx
Recordset2__xxx = "1"
If (Request("id") <> "") Then 
  Recordset2__xxx = Request("id")
End If
%>
<%
Dim Recordset2
Dim Recordset2_numRows

Set Recordset2 = Server.CreateObject("ADODB.Recordset")
Recordset2.ActiveConnection = MM_MySQL_STRING
Recordset2.Source = "select * from cv_invoice_items where tid = " & ccur(Request("id")) & " order by id asc"
Recordset2.CursorType = 0
Recordset2.CursorLocation = 2
Recordset2.LockType = 1
Recordset2.Open()

Recordset2_numRows = 0
%>
<%
Dim Recordset3__xxxxx
Recordset3__xxxxx = "1"
If (ccur(Request("id")) <> "") Then 
  Recordset3__xxxxx = ccur(Request("id"))
End If
%>
<%
Dim Recordset3
Dim Recordset3_numRows

Set Recordset3 = Server.CreateObject("ADODB.Recordset")
Recordset3.ActiveConnection = MM_MySQL_STRING
Recordset3.Source = "SELECT id, memo  FROM cv_invoices  WHERE id = " + Replace(Recordset3__xxxxx, "'", "''") + ""
Recordset3.CursorType = 0
Recordset3.CursorLocation = 2
Recordset3.LockType = 1
Recordset3.Open()

Recordset3_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
Recordset2_numRows = Recordset2_numRows + Repeat1__numRows
%>
<html><!-- InstanceBegin template="/Templates/layout.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<%
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
<title>Custody Video: Law Enforcement Grade, patrol car, police, video surveillance, Crown Vic, laser, police radar guns.</title>
<meta name=description content="Custody Video, Marietta,GA.  Manufacturer of public safety equipment, video surveillance, and law enforcement products.">
<meta name=keywords content="Custody Video, Evidence Bank, Evidence Video, Patrol Car Video System, Mobile Digital Video, dash mounted video, dashcam, interview room view, interrogation video,  Evidence Video, Digital Media Management, Hand held radar, handheld radar, highway patrol,  in car mobile video, in car video, In-car video,   laser radar gun, lazer, law enforcement equipment, law enforcement products, law enforcement supplies,  photo radar equipment, police cameras, police car video system, police equipment, police traffic safety,   public safety equipment, radar, radar gun, radar software, school zone trailers, security consultants, security surveillance,  speed devices, speed enforcement equipment, speed laser, Speed monitoring, speed tracking, speed trailer,  Surveillance, Talon, Talon Radar, traffic enforcement, traffic safety, traffic safety equipment, traffic safety radar, Traffic statistics, Traffic statistics tracking, Trooper, Video surveillance">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!--Fireworks MX 2004 Dreamweaver MX 2004 target.  Created Thu Oct 28 20:34:50 GMT-0400 (Eastern Standard Time) 2004-->
<script language="JavaScript">
<!--
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}
function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
 var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
   var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
   if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function mmLoadMenus() {
  if (window.mm_menu_1028200032_0) return;
  window.mm_menu_1028200032_0 = new Menu("root",140,20,"Arial, Times New Roman, Times, serif",14,"#000000","#ffffff","#d4d0c8","#000084","left","middle",3,0,1000,-5,7,true,true,true,0,false,true);
  mm_menu_1028200032_0.addMenuItem("About&nbsp;Us","location='/cv/about.asp'");
  mm_menu_1028200032_0.addMenuItem("Company&nbsp;Profile","location='/cv/profile.asp'");
  mm_menu_1028200032_0.addMenuItem("Careers","location='/cv/careers.asp'");
  mm_menu_1028200032_0.addMenuItem("News","location='/cv/news.asp'");
   mm_menu_1028200032_0.hideOnMouseOut=true;
   mm_menu_1028200032_0.menuBorder=1;
   mm_menu_1028200032_0.menuLiteBgColor='#ffffff';
   mm_menu_1028200032_0.menuBorderBgColor='#555555';
   mm_menu_1028200032_0.bgColor='#555555';
    window.mm_menu_1028200418_1_1 = new Menu("All Products",140,20,"Arial, Times New Roman, Times, serif",14,"#000000","#ffffff","#d4d0c8","#000084","left","middle",3,0,1000,-5,7,true,true,true,0,false,true);
<%
on error resume next
conn.close
set conn = nothing
on error goto 0
set conn = server.createobject("adodb.connection")
conn.open("Driver={MySQL ODBC 3.51 Driver};Server=localhost;uid=root;pwd=eggbert;database=custody;")
set rs = conn.execute("select name, id from cv_categories where parent = 0 order by name asc")
while not rs.eof 
%>
    mm_menu_1028200418_1_1.addMenuItem("<%= Replace(rs("name"), """", "'") %>","location='/cv/catalog.asp?id=<%= rs("id") %>'");
<%
rs.movenext
wend
%>
     mm_menu_1028200418_1_1.hideOnMouseOut=true;
     mm_menu_1028200418_1_1.menuBorder=1;
     mm_menu_1028200418_1_1.menuLiteBgColor='#ffffff';
     mm_menu_1028200418_1_1.menuBorderBgColor='#555555';
     mm_menu_1028200418_1_1.bgColor='#555555';
  window.mm_menu_1028200418_1 = new Menu("root",140,20,"Arial, Times New Roman, Times, serif",14,"#000000","#ffffff","#d4d0c8","#000084","left","middle",3,0,1000,-5,7,true,true,true,0,false,true);
  mm_menu_1028200418_1.addMenuItem(mm_menu_1028200418_1_1,"location='/cv/products.asp'");
  mm_menu_1028200418_1.addMenuItem("Specifications","location='/cv/specifications.asp'");
  mm_menu_1028200418_1.addMenuItem("Features","location='/cv/features.asp'");
  mm_menu_1028200418_1.addMenuItem("Pricing","location='/cv/pricing.asp'");
  mm_menu_1028200418_1.addMenuItem("Warranties","location='/cv/warranty.asp'");
  mm_menu_1028200418_1.addMenuItem("Leasing","location='/cv/leasing.asp'");
   mm_menu_1028200418_1.hideOnMouseOut=true;
   mm_menu_1028200418_1.childMenuIcon="/cv/images/arrows.gif";
   mm_menu_1028200418_1.menuBorder=1;
   mm_menu_1028200418_1.menuLiteBgColor='#ffffff';
   mm_menu_1028200418_1.menuBorderBgColor='#555555';
   mm_menu_1028200418_1.bgColor='#555555';
  window.mm_menu_1028200427_2 = new Menu("root",140,20,"Arial, Times New Roman, Times, serif",14,"#000000","#ffffff","#d4d0c8","#000084","left","middle",3,0,1000,-5,7,true,true,true,0,false,true);
  mm_menu_1028200427_2.addMenuItem("One-Day&nbsp;Service","location='/cv/service.asp'");
  mm_menu_1028200427_2.addMenuItem("Warranties","location='/cv/warranty.asp'");
  mm_menu_1028200427_2.addMenuItem("Leasing","location='/cv/leasing.asp'");
   mm_menu_1028200427_2.hideOnMouseOut=true;
   mm_menu_1028200427_2.menuBorder=1;
   mm_menu_1028200427_2.menuLiteBgColor='#ffffff';
   mm_menu_1028200427_2.menuBorderBgColor='#555555';
   mm_menu_1028200427_2.bgColor='#555555';
  window.mm_menu_1028200430_3 = new Menu("root",140,20,"Arial, Times New Roman, Times, serif",14,"#000000","#ffffff","#d4d0c8","#000084","left","middle",3,0,1000,-5,7,true,true,true,0,false,true);
  mm_menu_1028200430_3.addMenuItem("Downloads","location='/cv/downloads.asp'");
  mm_menu_1028200430_3.addMenuItem("Contact&nbsp;Us","location='/cv/contact.asp'");
   mm_menu_1028200430_3.hideOnMouseOut=true;
   mm_menu_1028200430_3.menuBorder=1;
   mm_menu_1028200430_3.menuLiteBgColor='#ffffff';
   mm_menu_1028200430_3.menuBorderBgColor='#555555';
   mm_menu_1028200430_3.bgColor='#555555';

  mm_menu_1028200430_3.writeMenus();
} // mmLoadMenus()

//-->
</script><script language="JavaScript1.2" src="../layout/mm_menu.js"></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #4A0000;
}
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10pt;
	color: #000000;
}
h1,h2,h3,h4,h5,h6 {
	font-family: Franklin Gothic Medium, Arial, sans-serif;
}
h1 {
	font-size: 16pt;
}
h2 {
	font-family: Franklin Gothic Book, Franklin Gothic Medium, Arial, sans-serif;
	font-size: 14pt;
	border-bottom: 1px solid #CCCCCC;
	width: 100%;
	font-weight:normal;
}
-->
</style>
<!-- InstanceBeginEditable name="head" -->
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
<!-- InstanceEndEditable -->
</head>
<body onLoad="MM_preloadImages('../layout/mf2.gif','../layout/nf2.gif','../layout/of2.gif','../layout/pf2.gif','../layout/qf2.gif')">
<script language="JavaScript1.2">mmLoadMenus();</script>

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="right" valign="top" background="../layout/f.gif" style="background-repeat: repeat-y; background-position:right;"><img name="b" src="../layout/b.gif" width="7" height="13" border="0" alt=""></td>
    <td width="800"><table width="800" height="300" border="0" cellpadding="0" cellspacing="0" bgcolor="#4a0000">
<!-- fwtable fwsrc="layout-source.png" fwbase="layout.gif" fwstyle="Dreamweaver" fwdocid = "2085802691" fwnested="0" -->

  <tr>
   <td height="13" colspan="8"><img name="c" src="../layout/c.gif" width="800" height="13" border="0" alt=""></td>
   </tr>
  <tr>
   <td width="139" height="95"><a href="../default.asp"><img name="g" src="../layout/g.jpg" width="139" height="95" border="0" alt=""></a></td>
   <td width="664" height="95" colspan="6" background="../layout/h.jpg"><!--#include virtual="/cv/include.asp"--></td>
   </tr>
  <tr>
   <td height="49" colspan="8"><table width="800"  border="0" cellpadding="0" cellspacing="0" background="../layout/s.gif">
       <tr valign="top">
         <td><img name="l" src="../layout/l.gif" width="22" height="49" border="0" alt=""><a href="../default.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('m','','../layout/mf2.gif',1)"><img name="m" src="../layout/m.gif" width="96" height="49" border="0" alt="Home"></a><a href="#" onMouseOut="MM_swapImgRestore();MM_startTimeout()" onMouseOver="MM_showMenu(window.mm_menu_1028200032_0,6,32,null,'n');MM_swapImage('n','','../layout/nf2.gif',1)"><img name="n" src="../layout/n.gif" width="100" height="49" border="0" alt="Company"></a><a href="#" onMouseOut="MM_swapImgRestore();MM_startTimeout()" onMouseOver="MM_showMenu(window.mm_menu_1028200418_1,6,32,null,'o');MM_swapImage('o','','../layout/of2.gif',1)"><img name="o" src="../layout/o.gif" width="100" height="49" border="0" alt="Products"></a><a href="#" onMouseOut="MM_swapImgRestore();MM_startTimeout()" onMouseOver="MM_showMenu(window.mm_menu_1028200427_2,6,32,null,'p');MM_swapImage('p','','../layout/pf2.gif',1)"><img name="p" src="../layout/p.gif" width="100" height="49" border="0" alt="Services"></a><a href="#" onMouseOut="MM_swapImgRestore();MM_startTimeout()" onMouseOver="MM_showMenu(window.mm_menu_1028200430_3,6,32,null,'q');MM_swapImage('q','','../layout/qf2.gif',1)"><img name="q" src="../layout/q.gif" width="100" height="49" border="0" alt="Support"></a><img src="../layout/spacer.gif" width="1" height="49" border="0" alt=""></td>
         <td align="right"><a href="../contact_.asp"><img name="t" src="../layout/t.gif" width="116" height="49" border="0" alt="Contact"></a></td>
       </tr>
     </table></td>
   </tr>
  <tr>
   <td height="14" colspan="8"><img name="u" src="../layout/u.gif" width="800" height="14" border="0" alt=""></td>
   </tr>
  <tr>
   <td background="../layout/v.gif" height="100%" colspan="8" style="padding-left: 20px; padding-right: 20px; padding-bottom: 30px; padding-top: 0px; background-repeat: repeat-y;">
     <!-- InstanceBeginEditable name="Content" -->
     <h1>Edit Sales Proposal        </h1>
       <a href="customers-edit.asp?id=<%= Request("cid") %>"><img src="../tab-a.gif" width="104" height="32" hspace="3" vspace="0" border="0"></a><a href="customers-notes.asp?id=<%= Request("cid") %>"><img src="../tab-b.gif" width="104" height="32" hspace="3" vspace="0" border="0"></a><a href="customers-sales.asp?id=<%= Request("cid") %>"><img src="../tab-c.gif" width="104" height="32" hspace="3" vspace="0" border="0"></a>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td align="left" valign="top"><table width="100%" border="0" cellpadding="5" cellspacing="0" Style="border: 1px solid gray;">
             <tr bgcolor="#DADADA">
               <td>&nbsp;</td>
               <td><strong>Product</strong></td>
               <td><strong>Unit Price </strong></td>
               <td><strong>Quantity</strong></td>
               <td><strong>Extended</strong></td>
             </tr>
             <% 
SubTotal = 0.00
While ((Repeat1__numRows <> 0) AND (NOT Recordset2.EOF)) 
%>
<%
ProductID = (Recordset2.Fields.Item("pid").Value)
UnitPrice = 0
ProductName = ""

set rs = Conn.Execute("select price, name, description from cv_invoice_products where id = " & ProductID & " limit 1")
UnitPrice = rs(0)
ProductName = rs(1)
ProductDesc = rs(2)
rs.close

Quantity = (Recordset2.Fields.Item("quantity").Value)

SubTotal = SubTotal + (Quantity * UnitPrice)

%>
             <tr>
                 <td bgcolor="#EEEEEE"><a href="?id=<%= Request("id") %>&remove=<%= Recordset2.Fields.Item("id").Value %>&cid=<%= Request("cid") %>">Del</a></td>
                 <td><%= ProductName %><br><small><%= ProductDesc %></small></td>
                 <td bgcolor="#EEEEEE"><%= FormatCurrency(UnitPrice, 2) %></td>
                 <td><%= quantity %></td>
                 <td bgcolor="#EEEEEE"><%= FormatCurrency(UnitPrice * ccur(Quantity), 2) %></td>
             </tr>
             <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  Recordset2.MoveNext()
Wend
%>
             <tr bgcolor="#F2FFDF">
               <td colspan="4" align="right" style="border-top: 1px solid silver; border-bottom: 1px solid silver;">Subtotal:</td>
               <td style="border-top: 1px solid silver; border-bottom: 1px solid silver;"><%= FormatCurrency(SubTotal, 2) %></td></tr>
<%
set rs = conn.execute("select id, description, amount from cv_invoice_discounts where tid = " & ccur(Request("id")))
discounts = 0.00
if not (rs.eof and rs.bof) then
%>
             <tr bgcolor="#DADADA">
               <td>&nbsp;</td>
               <td colspan="3" align="left" valign="middle"><strong>Discounts</strong></td>
               <td align="left" valign="middle"><strong>Amount</strong></td>
             </tr>
<% while not rs.eof %>
             <tr bgcolor="#FFF4F4">
               <td bgcolor="#EEEEEE"><a href="?id=<%= Request("id") %>&unapply=<%= rs("id") %>&cid=<%= Request("cid") %>">Del</a></td>
               <td colspan="3" align="left" valign="middle"><%= rs("description") %></td>
               <td align="left" valign="middle" bgcolor="#EEEEEE"><%= FormatCurrency(rs("amount"), 2) %></td>
             </tr>
<%
discounts = discounts + rs("amount")
rs.movenext
wend 
%>
             <tr bgcolor="#EBE9ED">
               <td colspan="4" align="right" style="border-top: 1px solid silver;">Discount Total:</td>
               <td style="border-top: 1px solid silver;"><%= FormatCurrency(discounts, 2) %></td>
             </tr>
<%
end if
shipping = 0.00
approved = 0
repID = 0
sql = "select shipping, approved, rep from cv_invoices where id = '" & Replace(Request("id"), "'", "''") & "' limit 1"
'Response.Write(sql)
set rs22 = conn.execute(sql)
	shipping = rs22(0)
	approved = rs22(1)
	repID = rs22(2)
rs22.close
set rs22 = nothing

%>
             <tr bgcolor="#EBE9ED">
               <td colspan="4" align="right">Shipping Charges:</td>
               <td><%= FormatCurrency(shipping, 2) %></td>
             </tr>
<%
total = SubTotal - Discounts + shipping
%>
             <tr bgcolor="#F2FFDF">
               <td colspan="4" align="right" style="border-top: 1px solid gray;">Grand Total: </td>
               <td style="border-top: 1px solid gray;"><%= FormatCurrency(total, 2) %></td>
             </tr>
</table>
             <p><strong>Memo<br>
             </strong><em>This field will NOT be printed on the resulting PDF form.</em></p>
             <form name="form1" method="POST" action="<%=MM_editAction%>">
               <p>
                 <textarea name="memo" wrap="VIRTUAL" id="memo" style="font-family: Arial; font-size: 10pt; width: 100%; height: 150px;"><%=(Recordset3.Fields.Item("memo").Value)%></textarea>
               </p>
               <p>
                 <input type="submit" name="Submit" value="Save Memo">
<input type="hidden" name="MM_update" value="form1">
               <input type="hidden" name="MM_recordId" value="<%= Recordset3.Fields.Item("id").Value %>">
</p>
             
</form>             <p>All orders require a 33% deposit upon issuance of the purchase order balance is due upon reciept of order. Delivery will occur within 45 days after receipt of purchase order.
                 <%
set rs = nothing
sql = "update cv_invoices set buffer_total = " & cstr(total) & " where id = " & ccur(Request("id"))
Conn.Execute(sql)
%>
             </p>
             <p><strong><a href="pdf.asp?id=<%= Request("id") %>" target="_blank">Generate PDF File</a> </strong></p></td>
           <td width="200" align="center" valign="top">
<% if approved = 0 then %><form action="customers-ticket.asp" method="get" name="tx" id="tx">
           <table width="175" border="0" align="center" cellpadding="5" cellspacing="0" style="border: 1px solid gray;">
             <tr align="center" valign="middle" bgcolor="#EBE9ED">
               <td colspan="3" nowrap><strong>Add Item </strong></td>
             </tr>
             <tr align="left" valign="middle">
               <td width="53" nowrap>Product:</td>
               <td><strong><div id="pid_text">NA</div></strong></td>
               <td width="45" align="right">[<a href="javascript:void(0);" onClick="MM_openBrWindow('prod-sel.asp','ps','status=yes,scrollbars=yes,resizable=yes,width=500,height=400')">Select</a>]</td>
             </tr>
             <tr align="left" valign="middle">
               <td nowrap>Quantity:</td>
               <td colspan="2">
                 <input type="text" name="quantity" value="1" size="10">
               </td>
             </tr>
             <tr align="left" valign="middle">
               <td nowrap><input type="hidden" name="id" value="<%= Request("id") %>" size="32">
                 <input type="hidden" name="cid" value="<%= Request("cid") %>" size="32"></td>
               <td colspan="2">
                 <input name="submit" type="submit" id="subbtn" value="Add" disabled="true">
                 <input name="pid" type="hidden" id="pid">
               </td>
             </tr>
           </table>
           <br>
           </form><% end if %><table width="175" border="0" align="center" cellpadding="5" cellspacing="0" style="border: 1px solid gray;">
                 <tr align="center" valign="middle" bgcolor="#EBE9ED">
                   <td colspan="2" nowrap><strong>Commission</strong></td>
                 </tr>
                 <tr align="left" valign="middle">
                   <td width="40" bgcolor="#EFEFEF"><%
				   
				   set rs = conn.execute("select commission from cv_users where id = " & RepID & " limit 1")
				   commission = rs(0)
				   rs.close
				   set rs = nothing
				   
				   %></td>
                   <td width="113"><%= FormatCurrency(SubTotal * commission, 2) %></td>
                 </tr>
               </table>
<% if isMemberOf("Administrators") then %>
<% if approved < 2 then
%>                            <br>
                            <form action="customers-ticket.asp" method="get">
                              <table width="175" border="0" align="center" cellpadding="5" cellspacing="0" style="border: 1px solid gray;">
                 <tr align="center" valign="middle" bgcolor="#EBE9ED">
                   <td colspan="2" nowrap><strong>Add Discount </strong></td>
                 </tr>
                 <tr align="left" valign="middle">
                   <td width="53" nowrap>Name:</td>
                   <td width="100"><input name="description" type="text" id="description" style="width: 100px;" value="Misc" size="10"></td>
                 </tr>
                 <tr align="left" valign="middle">
                   <td nowrap>Amount:</td>
                   <td width="100"><input name="amount" type="text" id="amount" style="width: 100px;" value="0.00" size="10"></td>
                 </tr>
                 <tr align="left" valign="middle">
                   <td nowrap><input type="hidden" name="id" value="<%= Request("id") %>" size="32"><input type="hidden" name="cid" value="<%= Request("cid") %>" size="32"></td>
                   <td>
                     <input name="submit" type="submit" value="Apply">
                   </td>
                 </tr>
               </table></form><br><form action="customers-ticket.asp" method="get">
                    <table width="175" border="0" align="center" cellpadding="5" cellspacing="0" style="border: 1px solid gray;">
                                <tr align="center" valign="middle" bgcolor="#EBE9ED">
                                  <td colspan="2" nowrap><strong>Set Shipping Amount </strong></td>
                                </tr>
                                <tr align="left" valign="middle">
                                  <td width="53" nowrap>Amount:</td>
                                  <td width="100"><input name="shipping" type="text" id="shipping" style="width: 100px;" size="10" value="<%= (shipping) %>"></td>
                                </tr>
                                <tr align="left" valign="middle">
                                  <td nowrap><input type="hidden" name="id" value="<%= Request("id") %>" size="32">
                                      <input type="hidden" name="cid" value="<%= Request("cid") %>" size="32"></td>
                                  <td>
                                    <input name="submit" type="submit" id="submit" value="Set">
                                  </td>
                                </tr>
                    </table>
                            </form>
<% 
end if
end if %>
<% if approved = 1 and isMemberOf("Administrators") then %><form action="customers-ticket.asp" method="get">
                  <table width="175" border="0" align="center" cellpadding="5" cellspacing="0" style="border: 1px solid gray;">
                    <tr align="center" valign="middle" bgcolor="#EBE9ED">
                      <td colspan="2" nowrap><strong>Approve Request</strong></td>
                    </tr>
                    <tr align="center" valign="middle">
                      <td colspan="2">Once approved, the request will be locked. If rejected, the request will be unlocked and can be resubmitted for approval. </td>
                      </tr>
                    <tr align="left" valign="middle">
                      <td width="50%" align="center" nowrap><input type="hidden" name="id" value="<%= Request("id") %>" size="32">
                          <input type="hidden" name="cid" value="<%= Request("cid") %>" size="32">                          <input name="submit" type="submit" id="submit23" value="Approve"></td>
                      <td width="50%" align="center" nowrap><input name="submit" type="submit" id="submit26" value="Reject"></td>
                    </tr>
                  </table>
                </form>
<% end if
if approved = 0 or (approved = 1 and not isMemberOf("Administrators")) or approved = 2 then
%>                <form action="customers-ticket.asp" method="get">
                  <table width="175" border="0" align="center" cellpadding="5" cellspacing="0" style="border: 1px solid gray;">
                    <tr align="center" valign="middle" bgcolor="#EBE9ED">
                      <td nowrap><strong>Submit for Approval </strong></td>
                    </tr>
<% if approved = 0 then %>
                    <tr align="center" valign="middle">
                      <td>Once submitted, the request will be locked until it has been processed by an administrator </td>
                    </tr>
                    <tr align="left" valign="middle">
                      <td align="center"><input type="hidden" name="id" value="<%= Request("id") %>" size="32">
                          <input type="hidden" name="cid" value="<%= Request("cid") %>" size="32">
                          <input name="submit" type="submit" id="submit25" value="Submit">
                      </td>
                    </tr>
<%
end if
if approved = 1 then
%>
                    <tr align="left" valign="middle">
                      <td align="center">This request is awaiting administrative review</td>
                    </tr>
<%
end if
if approved = 2 then
%>
                    <tr align="left" valign="middle">
                      <td align="center">This request has been approved</td>
                    </tr>
<% end if %>
                  </table>
                </form>
<% end if %></td>
         </tr>
       </table>
     <!-- InstanceEndEditable -->
     <p>&nbsp;</p><p style="border-top: 1px solid #CCCCCC; padding-top: 8px; font-size: 8pt; color: #AAAAAA;">Copyright &copy; 2003 Diversified Brokerage Atlanta, LLC. <br>
  All Rights Reserved. </p></td></tr>
</table></td>
    <td align="left" valign="top" background="../layout/i.gif" style="background-repeat: repeat-y;"><img name="d" src="../layout/d.gif" width="7" height="13" border="0" alt=""></td>
  </tr>
  <tr>
    <td align="right" valign="top">&nbsp;</td>
    <td height="60" align="center" valign="middle"><script src="/statsxp/track.asp?site=4&mode=1" language="javascript" type="text/javascript"></script></td>
    <td align="left" valign="top">&nbsp;</td>
  </tr>
</table><%
	on error resume next
	conn.close
	set conn = nothing
%></body>
<!-- InstanceEnd --></html>
<%
Recordset2.Close()
Set Recordset2 = Nothing
%>
<%
Recordset3.Close()
Set Recordset3 = Nothing
%>
<%
conn.close
set conn = nothing
%>
