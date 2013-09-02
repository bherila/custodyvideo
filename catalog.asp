<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="Connections/MySQL.asp" -->
<%
Dim rsProducts__MMColParam
rsProducts__MMColParam = "0"
If (Request.QueryString("id") <> "") Then 
  rsProducts__MMColParam = Request.QueryString("id")
End If
%>
<%
Dim rsProducts
Dim rsProducts_numRows

Set rsProducts = Server.CreateObject("ADODB.Recordset")
rsProducts.ActiveConnection = MM_MySQL_STRING
rsProducts.Source = "SELECT *  FROM cv_products  WHERE cat = " + Replace(rsProducts__MMColParam, "'", "''") + ""
rsProducts.CursorType = 0
rsProducts.CursorLocation = 2
rsProducts.LockType = 1
rsProducts.Open()

rsProducts_numRows = 0
%>
<%
Dim rsCategories__xxx
rsCategories__xxx = "0"
If (Request("id") <> "") Then 
  rsCategories__xxx = Request("id")
End If
%>
<%
Dim rsCategories
Dim rsCategories_numRows

Set rsCategories = Server.CreateObject("ADODB.Recordset")
rsCategories.ActiveConnection = MM_MySQL_STRING
rsCategories.Source = "SELECT *  FROM cv_categories  WHERE parent = " + Replace(rsCategories__xxx, "'", "''") + ""
rsCategories.CursorType = 0
rsCategories.CursorLocation = 2
rsCategories.LockType = 1
rsCategories.Open()

rsCategories_numRows = 0
%>
<%
Dim rsCurrentCategory__xxxx
rsCurrentCategory__xxxx = "0"
If (Request("id") <> "") Then 
  rsCurrentCategory__xxxx = Request("id")
End If
%>
<%
Dim rsCurrentCategory
Dim rsCurrentCategory_numRows

Set rsCurrentCategory = Server.CreateObject("ADODB.Recordset")
rsCurrentCategory.ActiveConnection = MM_MySQL_STRING
rsCurrentCategory.Source = "SELECT *  FROM cv_categories  WHERE id = " + Replace(rsCurrentCategory__xxxx, "'", "''") + ""
rsCurrentCategory.CursorType = 0
rsCurrentCategory.CursorLocation = 2
rsCurrentCategory.LockType = 1
rsCurrentCategory.Open()

rsCurrentCategory_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 15
Repeat1__index = 0
rsProducts_numRows = rsProducts_numRows + Repeat1__numRows
%>
<%
Dim Repeat2__numRows
Dim Repeat2__index

Repeat2__numRows = -1
Repeat2__index = 0
rsCategories_numRows = rsCategories_numRows + Repeat2__numRows
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
</script><script language="JavaScript1.2" src="layout/mm_menu.js"></script>
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
<!-- InstanceBeginEditable name="head" --><!-- InstanceEndEditable -->
</head>
<body onLoad="MM_preloadImages('layout/mf2.gif','layout/nf2.gif','layout/of2.gif','layout/pf2.gif','layout/qf2.gif')">
<script language="JavaScript1.2">mmLoadMenus();</script>

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="right" valign="top" background="layout/f.gif" style="background-repeat: repeat-y; background-position:right;"><img name="b" src="layout/b.gif" width="7" height="13" border="0" alt=""></td>
    <td width="800"><table width="800" height="300" border="0" cellpadding="0" cellspacing="0" bgcolor="#4a0000">
<!-- fwtable fwsrc="layout-source.png" fwbase="layout.gif" fwstyle="Dreamweaver" fwdocid = "2085802691" fwnested="0" -->

  <tr>
   <td height="13" colspan="8"><img name="c" src="layout/c.gif" width="800" height="13" border="0" alt=""></td>
   </tr>
  <tr>
   <td width="139" height="95"><a href="default.asp"><img name="g" src="layout/g.jpg" width="139" height="95" border="0" alt=""></a></td>
   <td width="664" height="95" colspan="6" background="layout/h.jpg"><!--#include virtual="/cv/include.asp"--></td>
   </tr>
  <tr>
   <td height="49" colspan="8"><table width="800"  border="0" cellpadding="0" cellspacing="0" background="layout/s.gif">
       <tr valign="top">
         <td><img name="l" src="layout/l.gif" width="22" height="49" border="0" alt=""><a href="default.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('m','','layout/mf2.gif',1)"><img name="m" src="layout/m.gif" width="96" height="49" border="0" alt="Home"></a><a href="#" onMouseOut="MM_swapImgRestore();MM_startTimeout()" onMouseOver="MM_showMenu(window.mm_menu_1028200032_0,6,32,null,'n');MM_swapImage('n','','layout/nf2.gif',1)"><img name="n" src="layout/n.gif" width="100" height="49" border="0" alt="Company"></a><a href="#" onMouseOut="MM_swapImgRestore();MM_startTimeout()" onMouseOver="MM_showMenu(window.mm_menu_1028200418_1,6,32,null,'o');MM_swapImage('o','','layout/of2.gif',1)"><img name="o" src="layout/o.gif" width="100" height="49" border="0" alt="Products"></a><a href="#" onMouseOut="MM_swapImgRestore();MM_startTimeout()" onMouseOver="MM_showMenu(window.mm_menu_1028200427_2,6,32,null,'p');MM_swapImage('p','','layout/pf2.gif',1)"><img name="p" src="layout/p.gif" width="100" height="49" border="0" alt="Services"></a><a href="#" onMouseOut="MM_swapImgRestore();MM_startTimeout()" onMouseOver="MM_showMenu(window.mm_menu_1028200430_3,6,32,null,'q');MM_swapImage('q','','layout/qf2.gif',1)"><img name="q" src="layout/q.gif" width="100" height="49" border="0" alt="Support"></a><img src="layout/spacer.gif" width="1" height="49" border="0" alt=""></td>
         <td align="right"><a href="contact_.asp"><img name="t" src="layout/t.gif" width="116" height="49" border="0" alt="Contact"></a></td>
       </tr>
     </table></td>
   </tr>
  <tr>
   <td height="14" colspan="8"><img name="u" src="layout/u.gif" width="800" height="14" border="0" alt=""></td>
   </tr>
  <tr>
   <td background="layout/v.gif" height="100%" colspan="8" style="padding-left: 20px; padding-right: 20px; padding-bottom: 30px; padding-top: 0px; background-repeat: repeat-y;">
     <!-- InstanceBeginEditable name="Content" -->
     <h1><% If Not rsCurrentCategory.EOF Or Not rsCurrentCategory.BOF Then %>
     <%=(rsCurrentCategory.Fields.Item("name").Value)%>
	 <% else %>
	 Product Catalog
     <% End If ' end Not rsCurrentCategory.EOF Or NOT rsCurrentCategory.BOF %></h1>

     <table width="100%"  border="0" cellspacing="0" cellpadding="0">
       <tr>
         <td style="padding-bottom: 20px; padding-top: 20px;">
           <% If Not rsCurrentCategory.EOF Or Not rsCurrentCategory.BOF Then %>
           <%=(rsCurrentCategory.Fields.Item("header").Value)%>
		   <%
		   p = (rsCurrentCategory.Fields.Item("header").Value)
		   if instr(p, "X-GOTO:") then
			s = split(p, ":")
			rsProducts.Close()
			Set rsProducts = Nothing
			rsCategories.Close()
			Set rsCategories = Nothing
			rsCurrentCategory.Close()
			Set rsCurrentCategory = Nothing
			l = s(1)
			erase s
			response.Redirect(l)
			response.End()
		   end if
		   %>
		   <% else %>
		   <img src="catalog-welcome-a.jpg" width="419" height="300"><img src="catalog-welcome-a.gif" width="341" height="300">		   <% End If ' end Not rsCurrentCategory.EOF Or NOT rsCurrentCategory.BOF %></td></tr>
       <tr>
         <td style="border-top: 1px solid #CCCCCC; border-bottom: 1px solid #CCCCCC;">
           <table border="0" cellpadding="5" cellspacing="0">
             <tr>
               <td><% If Not rsCurrentCategory.EOF Or Not rsCurrentCategory.BOF Then %><img src="images/arrowup.gif" width="20" height="20" hspace="10" border="0" align="absmiddle"><a href="catalog.asp?id=<%=(rsCurrentCategory.Fields.Item("parent").Value)%>">Parent Category</a><br>
                 <% End If ' end Not rsCurrentCategory.EOF Or NOT rsCurrentCategory.BOF %>
                 <% i = 1 %>
             <% While ((Repeat2__numRows <> 0) AND (NOT rsCategories.EOF)) %>
<img src="images/arrowbullet.gif" width="20" height="20" hspace="10" border="0" align="absmiddle"><a href="catalog.asp?id=<%=(rsCategories.Fields.Item("id").Value)%>"><%=(rsCategories.Fields.Item("name").Value)%></a><br>
             <% 
  Repeat2__index=Repeat2__index+1
  Repeat2__numRows=Repeat2__numRows-1
  rsCategories.MoveNext()
  if i = 8 then
  	i = 0
	response.Write("</td><td>")
  end if
Wend
%></td>
               </tr>
           </table></td></tr>
       <tr>
         <td>&nbsp;
           <table width="100%" border="0" cellpadding="5" cellspacing="0">
             <% While ((Repeat1__numRows <> 0) AND (NOT rsProducts.EOF)) %>
			 <% if isMemberOf(rsProducts.Fields.Item("perm").Value) then %>
             <tr>
               <td nowrap><img src="images/circlebullet.gif" width="20" height="20" hspace="10" border="0" align="absmiddle"><a href="product.asp?id=<%=(rsProducts.Fields.Item("id").Value)%>"><%=(rsProducts.Fields.Item("name").Value)%></a></td>
             </tr>
			 <% end if %>
             <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  rsProducts.MoveNext()
Wend
%>
           </table></td>
       </tr>
     </table>
     <p>&nbsp;</p>
     <!-- InstanceEndEditable -->
     <p>&nbsp;</p><p style="border-top: 1px solid #CCCCCC; padding-top: 8px; font-size: 8pt; color: #AAAAAA;">Copyright &copy; 2003 Diversified Brokerage Atlanta, LLC. <br>
  All Rights Reserved. </p></td></tr>
</table></td>
    <td align="left" valign="top" background="layout/i.gif" style="background-repeat: repeat-y;"><img name="d" src="layout/d.gif" width="7" height="13" border="0" alt=""></td>
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
rsProducts.Close()
Set rsProducts = Nothing
%>
<%
rsCategories.Close()
Set rsCategories = Nothing
%>
<%
rsCurrentCategory.Close()
Set rsCurrentCategory = Nothing
%>
