<%@LANGUAGE="VBSCRIPT"%><!--#include file="../Connections/MySQL.asp" -->
<%

on error resume next 

page = 1
page = ccur(Request("page"))
if page < 1 then page = 1

set conn = server.CreateObject("adodb.connection")
conn.open(MM_MySQL_STRING)

lastID = -1
lastName = ""
function getAgent(id)
	if lastID <> id then
		set urs = conn.execute("select lastname from cv_users where id = " & id & " limit 1")
		lastID = id
		lastName = urs(0)
		urs.close
		set urs = nothing
	end if
	getAgent = lastName
end function

%>
<%
Randomize

Dim rsCustomers
Dim rsCustomers_numRows

Set rsCustomers = Server.CreateObject("ADODB.Recordset")
rsCustomers.ActiveConnection = MM_MySQL_STRING
f = " where agent = '" & Replace(Session("MM_UserID"), "'", "''") & "'"
if inStr(lcase(Session("MM_Groups")), "administrator") then
	if len(Request("agg")) > 0 then
		f = " where agent = '" & Replace(Request("agg"), "'", "''") & "'"
	else
		f = ""
	end if
end if

rsCustomers.Source = "SELECT id, agent, agency,  initial_contact, demo_performed, proposal_submitted, on_location_visit, interest_mobilevideo, interest_onbodydvr, interest_evidencebank, interest_callbox, interest_other  from cv_db " & f & " ORDER BY agent asc, id asc limit " & (ccur(page) * 50)

set conn = server.CreateObject("adodb.connection")
conn.open(MM_MySQL_STRING)
set rs = conn.execute("select count(*) from cv_db " & f)
total = rs(0)
rs.close

max = page * 50
if max > total then max = total

rsCustomers.CursorType = 0
rsCustomers.CursorLocation = 2
rsCustomers.LockType = 1
rsCustomers.Open()

rsCustomers_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 100000000000
Repeat1__index = 0
rsCustomers_numRows = rsCustomers_numRows + Repeat1__numRows
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
<style type="text/css">
<!--
.style1 {font-size: 7pt}
.btm {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #A7A6AA;
}
.style4 {font-size: 7pt; font-weight: bold; }
.style5 {color: #666666}
-->
</style>
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
     <h1>Customer Management </h1>
     <p><a href="customers-new.asp">New Customer</a> | <a href="customers-export.asp?rnd=<%= Rnd %>">Export to CSV</a></p>
	 <% if inStr(lcase(Session("MM_Groups")), "administrator") then %>
     <form method="post" action="customers.asp">
	 Show only this user: 
	   <select name="agg">
	   <option value="">(ALL)</option>
	   	<%
		set rs = conn.execute("select distinct agent from cv_db")
		while not rs.eof
			Response.Write("<option value=""" & rs(0) & """>" & getAgent(rs(0)) & "</option>" & vbNewLine)
			rs.movenext
		wend
		rs.close
		%>
	   </select>
	   <input type="submit" value="Submit">
	 </form>
	 <% end if %>
     <table width="100%"  border="0" cellpadding="10" cellspacing="0" bgcolor="#FFFFCC" style="border: 1px solid Gray;">
       <tr>
         <td width="100" align="left" valign="middle">
           <% if page > 1 then %>
           <a href="?page=<%= page - 1 %>">&laquo; Back</a>
           <% else %><span class="style5">
           &laquo; Back</span>
           <% end if %>         </td>
         <td align="center" valign="middle">Showing Records <%= FormatNumber((cint(page) - 1) * 50 + 1, 0) %> to <%= FormatNumber(max, 0) %> of <%= FormatNumber(total, 0) %></td>
         <td width="100" align="right" valign="middle">
           <% if cdbl(page) < cdbl(total) / 50 then 
		   p = true
		   %>
           <a href="?page=<%= page + 1 %>">Next &raquo;</a>
           <% else
		   p = false
		   %><span class="style5">
           Next &raquo;</span>
           <% end if %>         </td>
       </tr>
     </table><br>
     <table width="100%" border="0" cellpadding="5" cellspacing="0" style="border: 1px solid gray;">
       <tr align="center" valign="middle">
         <td width="40" rowspan="2" align="right" bgcolor="#D8D3DC" class="btm">id</td>
         <td rowspan="2" align="left" bgcolor="#EBE9ED" class="btm">agent</td>
         <td rowspan="2" align="left" bgcolor="#EBE9ED" class="btm">agency</td>
         <td colspan="3" bgcolor="#D8D3DC"><span class="style4">Stages</span></td>
         <td colspan="5" bgcolor="#EBE9ED"><span class="style4">Interests</span></td>
         </tr>
       <tr>
         <td width="40" align="center" valign="middle" bgcolor="#D8D3DC" class="btm"><span class="style1">Demo</span></td>
         <td width="40" align="center" valign="middle" bgcolor="#D8D3DC" class="btm"><span class="style1">Proposal</span></td>
         <td width="40" align="center" valign="middle" bgcolor="#D8D3DC" class="btm"><span class="style1">Onsite<br>
           Visit</span></td>
         <td width="40" align="center" valign="middle" bgcolor="#EBE9ED" class="btm"><span class="style1">Mobile<br>
           Video</span></td>
         <td width="40" align="center" valign="middle" bgcolor="#EBE9ED" class="btm"><span class="style1">DVR</span></td>
         <td width="40" align="center" valign="middle" bgcolor="#EBE9ED" class="btm"><span class="style1">Evdnc<br>
           Bank</span></td>
         <td width="40" align="center" valign="middle" bgcolor="#EBE9ED" class="btm"><span class="style1">Callbox</span></td>
         <td width="40" align="center" valign="middle" bgcolor="#EBE9ED" class="btm"><span class="style1">Other</span></td>
       </tr>
	   <% cbgcolor = "#FFFFCC" 
	   p = 0 %>
       <% While ((Repeat1__numRows <> 0) AND (NOT rsCustomers.EOF)) %>
	   <%
	   
	   p = p + 1
	   if p > ((page - 1) * 50) then
	   
	   cID = rsCustomers.Fields.Item("agent").Value
	   if lastID <> cID then
	   		if cbgcolor = "#FFFFFF" then
				cbgcolor = "#FFFFCC"
			else
				cbgcolor = "#FFFFFF"
			end if
			%>
			<tr align="center" valign="middle" bgcolor="#CFDDFE">
              <td rowspan="2" align="right" bgcolor="#DEE8FE" class="btm">id</td>
              <td rowspan="2" align="left" class="btm">agent</td>
              <td rowspan="2" align="left" bgcolor="#DEE8FE" class="btm">agency</td>
              <td colspan="3"><span class="style4">Stages</span></td>
              <td colspan="5"><span class="style4">Interests</span></td>
			  </tr>
			<tr>
              <td align="center" valign="middle" bgcolor="#EBE9ED" class="btm"><span class="style1">Demo</span></td>
              <td align="center" valign="middle" bgcolor="#EBE9ED" class="btm"><span class="style1">Proposal</span></td>
              <td align="center" valign="middle" bgcolor="#EBE9ED" class="btm"><span class="style1">Onsite<br>
    Visit</span></td>
              <td align="center" valign="middle" class="btm"><span class="style1">Mobile<br>
    Video</span></td>
              <td align="center" valign="middle" class="btm"><span class="style1">DVR</span></td>
              <td align="center" valign="middle" class="btm"><span class="style1">Evdnc<br>
    Bank</span></td>
              <td align="center" valign="middle" class="btm"><span class="style1">Callbox</span></td>
              <td align="center" valign="middle" class="btm"><span class="style1">Other</span></td>
			  </tr>
			<tr bgcolor="#CFDDFE">
			  <td colspan="2" style="border-bottom: 1px solid gray;">User: <%= GetAgent(cid) %></td>
			  <td colspan="9" align="right" style="border-bottom: 1px solid gray;"><%
			  
			  on error resume next
			  set rs = conn.execute("select count(proposal_amount), avg(proposal_amount), sum(proposal_amount) from cv_db where agent = " & cID)
			  
			  %><%= FormatNumber(rs(0), 0) %> <strong>Sales</strong> :: <strong>Average</strong> <%= FormatCurrency(rs(1), 2) %> :: <strong>Total</strong> <%= FormatCurrency(rs(2), 2) %> <%
			  
			  rs.close 
			  set rs = nothing
			  on error goto 0
			  
			  %></td>
			  </tr>
			<%
	   end if
	   
	   
	   %>
       <tr align="left" valign="middle">
         <td width="40" align="right" bgcolor="<%= cbgcolor %>" class="btm"><%=(rsCustomers.Fields.Item("id").Value)%></td>
         <td bgcolor="#EBE9ED" class="btm"><%=GetAgent(rsCustomers.Fields.Item("agent").Value)%></td>
         <td bgcolor="<%= cbgcolor %>" class="btm"><a href="customers-edit.asp?id=<%=(rsCustomers.Fields.Item("id").Value)%>"><%=(rsCustomers.Fields.Item("agency").Value)%></a></td>
         <td width="40" align="center" valign="middle" bgcolor="#EBE9ED" class="btm"><% if ccur(rsCustomers.Fields.Item("demo_performed").Value) = 1 then %><img src="check.gif" width="16" height="16"><% end if %>&nbsp;</td>
         <td width="40" align="center" valign="middle" bgcolor="#EBE9ED" class="btm"><% if ccur(rsCustomers.Fields.Item("proposal_submitted").Value) = 1 then %><img src="check.gif" width="16" height="16"><% end if %>&nbsp;</td>
         <td width="40" align="center" valign="middle" bgcolor="#EBE9ED" class="btm"><% if ccur(rsCustomers.Fields.Item("on_location_visit").Value) = 1 then %><img src="check.gif" width="16" height="16"><% end if %>&nbsp;</td>
         <td width="40" align="center" valign="middle" bgcolor="<%= cbgcolor %>" class="btm"><% if ccur(rsCustomers.Fields.Item("interest_mobilevideo").Value) = 1 then %><img src="check.gif" width="16" height="16"><% end if %>&nbsp;</td>
         <td width="40" align="center" valign="middle" bgcolor="<%= cbgcolor %>" class="btm"><% if ccur(rsCustomers.Fields.Item("interest_onbodydvr").Value) = 1 then %><img src="check.gif" width="16" height="16"><% end if %>&nbsp;</td>
         <td width="40" align="center" valign="middle" bgcolor="<%= cbgcolor %>" class="btm"><% if ccur(rsCustomers.Fields.Item("interest_evidencebank").Value) = 1 then %><img src="check.gif" width="16" height="16"><% end if %>&nbsp;</td>
         <td width="40" align="center" valign="middle" bgcolor="<%= cbgcolor %>" class="btm"><% if ccur(rsCustomers.Fields.Item("interest_callbox").Value) = 1 then %><img src="check.gif" width="16" height="16"><% end if %>&nbsp;</td>
         <td width="40" align="center" valign="middle" bgcolor="<%= cbgcolor %>" class="btm"><% if len(rsCustomers.Fields.Item("interest_other").Value) > 0 then %><img src="check.gif" width="16" height="16"><% end if %>&nbsp;</td>
       </tr>
       <% 
	   end if
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  rsCustomers.MoveNext()
Wend
%>
     </table>
     <br>
     <table width="100%"  border="0" cellpadding="10" cellspacing="0" bgcolor="#FFFFCC" style="border: 1px solid Gray;">
       <tr>
         <td width="100" align="left" valign="middle">
           <% if page > 1 then %>
           <a href="?page=<%= page - 1 %>">&laquo; Back</a>
           <% else %>
           <span class="style5"> &laquo; Back</span>
           <% end if %>
         </td>
         <td align="center" valign="middle">Showing Records <%= FormatNumber((page - 1) * 50 + 1, 0) %> to <%= FormatNumber(max, 0) %> of <%= FormatNumber(total, 0) %></td>
         <td width="100" align="right" valign="middle">
           <% if p then %>
           <a href="?page=<%= page + 1 %>">Next &raquo;</a>
           <% else %>
           <span class="style5"> Next &raquo;</span>
           <% end if %>
         </td>
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
rsCustomers.Close()
Set rsCustomers = Nothing
%>
<%
if not (isMemberOf("administrators") or isMemberOf("Reps") or isMemberOf("Dealers")) then response.Redirect("../login-done.asp")
%>
<%

conn.close
set conn = nothing

%>