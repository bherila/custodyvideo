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
' *** Insert Record: set variables

If (CStr(Request("MM_insert")) = "form1") Then

  MM_editConnection = MM_MySQL_STRING
  MM_editTable = "cv_db"
  MM_editRedirectUrl = "customers.asp"
  MM_fieldsStr  = "agency|value|chief|value|street_address|value|mailing_address|value|city|value|state|value|zip|value|phone|value|fax|value|primary_contact|value|primary_contact_phone|value|primary_contact_email|value|secondary_contact|value|secondary_contact_phone|value|secondary_contact_email|value|fleet_manager|value|fm_email|value|fm_phone|value|purchasing_agent|value|pa_email|value|pa_phone|value|initial_contact|value|select|value|video_retention_period|value|current_video_format|value|current_storage_format|value|recommended_storage_solution|value|demo_performed|value|proposal_submitted|value|proposal_submission_date|value|proposal_amount|value|on_location_visit|value|expected_purchase_date|value|funding_source|value|leasing_option|value|current_video_system|value|memo|value|interest_mobilevideo|value|interest_onbodydvr|value|interest_evidencebank|value|interest_callbox|value|interest_other|value|agent|value"
  MM_columnsStr = "agency|',none,''|chief|',none,''|street_address|',none,''|mailing_address|',none,''|city|',none,''|state|',none,''|zip|',none,''|phone|',none,''|fax|',none,''|primary_contact|',none,''|primary_contact_phone|',none,''|primary_contact_email|',none,''|secondary_contact|',none,''|secondary_contact_phone|',none,''|secondary_contact_email|',none,''|fleet_manager|',none,''|fleet_manager_email|',none,''|fleet_manager_phone|',none,''|purchasing_agent|',none,''|purchasing_agent_email|',none,''|purchasing_agent_phone|',none,''|initial_contact|',none,NULL|initial_contact_type|',none,''|video_retention_period|none,none,NULL|current_video_format|',none,''|current_storage_format|',none,''|recommended_storage_solution|',none,''|demo_performed|none,1,0|proposal_submitted|none,1,0|proposal_submission_date|',none,NULL|proposal_amount|none,none,NULL|on_location_visit|none,1,0|expected_purchase_date|',none,NULL|funding_source|',none,''|leasing_option|',none,''|current_video_system|',none,''|memo|',none,''|interest_mobilevideo|none,1,0|interest_onbodydvr|none,1,0|interest_evidencebank|none,1,0|interest_callbox|none,1,0|interest_other|',none,''|agent|none,none,NULL"

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
' *** Insert Record: construct a sql insert statement and execute it

Dim MM_tableValues
Dim MM_dbValues

If (CStr(Request("MM_insert")) <> "") Then

  ' create the sql insert statement
  MM_tableValues = ""
  MM_dbValues = ""
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
      MM_tableValues = MM_tableValues & ","
      MM_dbValues = MM_dbValues & ","
    End If
    MM_tableValues = MM_tableValues & MM_columns(MM_i)
    MM_dbValues = MM_dbValues & MM_formVal
  Next
  MM_editQuery = "insert into " & MM_editTable & " (" & MM_tableValues & ") values (" & MM_dbValues & ")"

  If (Not MM_abortEdit) Then
    ' execute the insert
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
.style1 {color: #999999}
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
     <h1><a href="customers.asp">Customer Management</a> &raquo; New Customer</h1>
     <p><em><strong>Careful!</strong></em> - Before adding a new customer, please <a href="check.asp" target="_blank">click here to check</a> if they have already been contacted by a Custody Video representative. </p>
     <form method="POST" action="<%=MM_editAction%>" name="form1">
       <table width="100%" border="0" cellpadding="5" cellspacing="0">
         <tr valign="baseline" bgcolor="#B1C3D9">
           <td colspan="2" align="left" nowrap><strong>General Information </strong></td>
           </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Agency Name:</td>
           <td height="32">
             <input name="agency" type="text" value="" size="32" maxlength="50">
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Primary Contact Name/Rank:</td>
           <td height="32">
             <input name="chief" type="text" value="" size="32" maxlength="50">
           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Street Address:</td>
           <td height="32">
             <input type="text" name="street_address" value="" size="32">
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Mailing Address:</td>
           <td height="32">
             <input type="text" name="mailing_address" value="" size="32">
           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>City:</td>
           <td height="32">
             <input name="city" type="text" value="" size="32" maxlength="50">
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>State:</td>
           <td height="32">
             <input name="state" type="text" value="" size="5" maxlength="2">
           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Zip:</td>
           <td height="32">
             <input name="zip" type="text" value="" size="32" maxlength="10">
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Phone:</td>
           <td height="32">
             <input name="phone" type="text" value="" size="32" maxlength="10">
           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Fax:</td>
           <td height="32">
             <input name="fax" type="text" value="" size="32" maxlength="10">
           </td>
         </tr>
         <tr align="left" valign="baseline" bgcolor="#B1C3D9">
           <td colspan="2" nowrap><strong>Primary Contact Information </strong></td>
           </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Primary Contact:</td>
           <td height="32">
             <input name="primary_contact" type="text" value="" size="32" maxlength="50">
           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Primary Contact Phone:</td>
           <td height="32">
             <input name="primary_contact_phone" type="text" value="" size="32" maxlength="10">
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Primary Contact E-Mail: </td>
           <td height="32"><input name="primary_contact_email" type="text" id="primary_contact_email" value="" size="32" maxlength="50"></td>
         </tr>
         <tr valign="baseline" bgcolor="#CCCCCC">
           <td colspan="2" align="left" nowrap bgcolor="#B1C3D9"><strong>Secondary Contact Information </strong></td>
           </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Secondary Contact:</td>
           <td height="32">
             <input name="secondary_contact" type="text" value="" size="32" maxlength="50">
           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Secondary Contact Phone:</td>
           <td height="32">
             <input name="secondary_contact_phone" type="text" value="" size="32" maxlength="10">
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Secondary Contact E-Mail: </td>
           <td height="32"><input name="secondary_contact_email" type="text" id="secondary_contact_email" value="" size="32" maxlength="50"></td>
         </tr>
         <tr align="left" valign="baseline" bgcolor="#B1C3D9">
           <td colspan="2" nowrap><strong>Fleet Manager Information</strong></td>
           </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Fleet Manager Name:</td>
           <td height="32">
             <input name="fleet_manager" type="text" value="" size="32" maxlength="50">
           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Fleet Manager Email:</td>
           <td height="32">
             <input name="fm_email" type="text" id="fm_email" value="" size="32" maxlength="50">
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Fleet Manager Phone:</td>
           <td height="32">
             <input name="fm_phone" type="text" id="fm_phone" value="" size="32" maxlength="10">
           </td>
         </tr>
         <tr align="left" valign="baseline" bgcolor="#B1C3D9">
           <td colspan="2" nowrap><strong>Purchasing Agent Information </strong></td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Purchasing Agent Name:</td>
           <td height="32">
             <input type="text" name="purchasing_agent" value="" size="32">
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Purchasing Agent Email:</td>
           <td height="32"><input name="pa_email" type="text" id="pa_email" value="" size="32" maxlength="50"></td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Purchasing Agent Phone:</td>
           <td height="32"><input name="pa_phone" type="text" id="pa_phone" value="" size="32" maxlength="10"></td>
         </tr>
         <tr align="left" valign="baseline" bgcolor="#B1C3D9">
           <td colspan="2" nowrap><strong>Additional Information </strong></td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Date of Initial Contact:</td>
           <td height="32">
             <input type="text" name="initial_contact" value="" size="32">
             YY-MM-DD <span class="style1">(04-10-31 = October 31, 2004) </span>           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Initial Contact Type:</td>
           <td height="32"><select name="select">
             <option value="Not Selected" selected>Not Selected</option>
             <option value="Trade Show">Trade Show</option>
             <option value="Magazine Lead">Magazine Lead</option>
             <option value="Phone Referral">Phone Referral</option>
             <option value="Cold Call">Cold Call</option>
             <option value="Other">Other</option>
           </select>
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Video Retention Period:</td>
           <td height="32">
             <input name="video_retention_period" type="text" value="-1" size="10" maxlength="5"> 
             days (enter <strong>-1</strong> for infinite)
           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Current Video Format:</td>
           <td height="32">
             <select name="current_video_format">
               <option value="NA" selected>Not Selected</option>
               <option value="VHS" >VHS</option>
               <option value="Hi-8" >Hi-8</option>
               <option value="DVD" >DVD</option>
               <option value="HD" >Hard Drive</option>
               <option value="Other" >Other</option>
                    </select>
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Current Storage Format:</td>
           <td height="32">
             <input type="text" name="current_storage_format" value="" size="32">
           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Recommended Storage Solution:</td>
           <td height="32">
             <input type="text" name="recommended_storage_solution" value="" size="32">
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Demo Performed?</td>
           <td height="32">
             <input type="checkbox" name="demo_performed" value=1 >
           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Proposal Submitted?</td>
           <td height="32">
             <input type="checkbox" name="proposal_submitted" value=1 >
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Proposal Submission Date:</td>
           <td height="32">
             <input type="text" name="proposal_submission_date" value="" size="32">
             YY-MM-DD <span class="style1">(04-10-31 = October 31, 2004) </span>           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Proposal Amount:</td>
           <td height="32">
             $
             <input type="text" name="proposal_amount" value="" size="32"> 
             No commas or $ signs or other characters</td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>On-Location Visit?</td>
           <td height="32">
             <input type="checkbox" name="on_location_visit" value=1 >
           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Expected purchase date:</td>
           <td height="32">
             <input type="text" name="expected_purchase_date" value="" size="32">
             YY-MM-DD <span class="style1">(04-10-31 = October 31, 2004) </span>           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap bgcolor="#EBE9ED">Funding Source:</td>
           <td height="32">
             <input type="text" name="funding_source" value="" size="32">
           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Leasing Option:</td>
           <td height="32">
             <input type="text" name="leasing_option" value="" size="32">
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>Current Video System:</td>
           <td height="32"><select name="current_video_system" id="current_video_system">
             <option value="NA" selected>Not Selected</option>
             <option value="Kustom">Kustom</option>
             <option value="Decatur">Decatur</option>
             <option value="Coban">Coban</option>
             <option value="Motorola">Motorola</option>
             <option value="IPT">IPT</option>
             <option value="Cruisecam">Cruisecam</option>
             <option value="Stalker">Stalker</option>
             <option value="Alphacam">Alphacam</option>
             <option value="Eagle Eye">Eagle Eye</option>
             <option value="MPH">MPH</option>
             <option value="Panasonic">Panasonic</option>
             <option value="ICOP">ICOP</option>
             <option value="Other">Other</option>
           </select>
           </td>
         </tr>
         <tr valign="middle">
           <td height="32" align="right" nowrap>Memo:</td>
           <td height="32"><textarea name="memo" cols="65" rows="5" wrap="VIRTUAL" id="memo" style="font-family: Arial; font-size: 10pt; width: 400px;"></textarea></td>
         </tr>
         <tr valign="baseline" bgcolor="#B1C3D9">
           <td colspan="2" align="left" nowrap><strong>Client Interests </strong></td>
           </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Mobile Video:</td>
           <td height="32">
             <input type="checkbox" name="interest_mobilevideo" value=1 >
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>On-Body DVR:</td>
           <td height="32">
             <input type="checkbox" name="interest_onbodydvr" value=1 >
           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Evidence Bank:</td>
           <td height="32">
             <input type="checkbox" name="interest_evidencebank" value=1 >
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>CallBox/Call Monitoring:</td>
           <td height="32">
             <input type="checkbox" name="interest_callbox" value=1 >
           </td>
         </tr>
         <tr valign="middle">
           <td width="225" height="32" align="right" nowrap>Other:</td>
           <td height="32">
             <input type="text" name="interest_other" value="" size="32">
           </td>
         </tr>
         <tr valign="middle" bgcolor="#EBE9ED">
           <td width="225" height="32" align="right" nowrap>&nbsp;</td>
           <td height="32">
             <input type="submit" value="Insert record">
           </td>
         </tr>
       </table>
       <input type="hidden" name="agent" value="<%= Session("MM_UserID") %>" size="32">
       <input type="hidden" name="MM_insert" value="form1">
     </form>
     <p>&nbsp;</p>
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
if not (isMemberOf("administrators") or isMemberOf("Reps") or isMemberOf("Dealers")) then response.Redirect("../login-done.asp")
%>