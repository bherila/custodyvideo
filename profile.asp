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
  mm_menu_1028200032_0.addMenuItem("About&nbsp;Us","location='/about.asp'");
  mm_menu_1028200032_0.addMenuItem("Company&nbsp;Profile","location='/profile.asp'");
  mm_menu_1028200032_0.addMenuItem("Careers","location='/careers.asp'");
  mm_menu_1028200032_0.addMenuItem("News","location='/news.asp'");
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
conn.open("Driver={MySQL ODBC 3.51 Driver};Server=localhost;uid=custody;pwd=bigfoot;database=custody;")
set rs = conn.execute("select name, id from cv_categories where parent = 0 order by name asc")
while not rs.eof 
%>
    mm_menu_1028200418_1_1.addMenuItem("<%= Replace(rs("name"), """", "'") %>","location='/catalog.asp?id=<%= rs("id") %>'");
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
  mm_menu_1028200418_1.addMenuItem(mm_menu_1028200418_1_1,"location='/products.asp'");
  mm_menu_1028200418_1.addMenuItem("Specifications","location='/specifications.asp'");
  mm_menu_1028200418_1.addMenuItem("Features","location='/features.asp'");
  mm_menu_1028200418_1.addMenuItem("Pricing","location='/pricing.asp'");
  mm_menu_1028200418_1.addMenuItem("Warranties","location='/warranty.asp'");
  mm_menu_1028200418_1.addMenuItem("Leasing","location='/leasing.asp'");
   mm_menu_1028200418_1.hideOnMouseOut=true;
   mm_menu_1028200418_1.childMenuIcon="/images/arrows.gif";
   mm_menu_1028200418_1.menuBorder=1;
   mm_menu_1028200418_1.menuLiteBgColor='#ffffff';
   mm_menu_1028200418_1.menuBorderBgColor='#555555';
   mm_menu_1028200418_1.bgColor='#555555';
  window.mm_menu_1028200427_2 = new Menu("root",140,20,"Arial, Times New Roman, Times, serif",14,"#000000","#ffffff","#d4d0c8","#000084","left","middle",3,0,1000,-5,7,true,true,true,0,false,true);
  mm_menu_1028200427_2.addMenuItem("One-Day&nbsp;Service","location='/service.asp'");
  mm_menu_1028200427_2.addMenuItem("Warranties","location='/warranty.asp'");
  mm_menu_1028200427_2.addMenuItem("Leasing","location='/leasing.asp'");
   mm_menu_1028200427_2.hideOnMouseOut=true;
   mm_menu_1028200427_2.menuBorder=1;
   mm_menu_1028200427_2.menuLiteBgColor='#ffffff';
   mm_menu_1028200427_2.menuBorderBgColor='#555555';
   mm_menu_1028200427_2.bgColor='#555555';
  window.mm_menu_1028200430_3 = new Menu("root",140,20,"Arial, Times New Roman, Times, serif",14,"#000000","#ffffff","#d4d0c8","#000084","left","middle",3,0,1000,-5,7,true,true,true,0,false,true);
  mm_menu_1028200430_3.addMenuItem("Downloads","location='/downloads.asp'");
  mm_menu_1028200430_3.addMenuItem("Contact&nbsp;Us","location='/contact.asp'");
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
   <td width="664" height="95" colspan="6" background="layout/h.jpg"><!--#include virtual="/include.asp"--></td>
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
     <h1>Company Profile</h1>
     <table width="100%"  border="0" cellspacing="0" cellpadding="0">
       <tr>
         <td width="250" align="center" valign="top"><p>&nbsp;</p>
           <p><img src="images/david_goliath_victory_lg_nwm_14028.jpg" width="200" height="200"></p>           </td>
         <td><p><em>CUSTODY &reg; Law Enforcement Video&nbsp; is a wholly owned division of Diversified Brokerage Atlanta, LLC. </em><br>
               <br>
               <strong> History: </strong><br>
 CUSTODY was founded in 2001 by Ray Edwards, a 14 year veteran in the law enforcement video marketplace. Ray begin his career as the National Strategic Marketing Manager of Law Enforcement Video for Panasonic Broadcast and Television Systems Company. This gave him a unique opportunity and position to sell to and examine the various suppliers of in car video systems. His observations prompted him form a company dedicated to developing cutting edge digital audio and video technologies for the law enforcement and public safety markets. Most importantly, develop products that are dependable and affordable.<br>
  <br>
  <strong>Technology:</strong></p>
           <p> CUSTODY &reg; is the leading provider of&nbsp; affordable video and rich media communication and content management&nbsp; hardware and software solutions.. We developed our own mobile digital video recording platform designed is insure the digital chain of custody in evidence gathering. At the heart of the newly integrated platform&nbsp; is the ability to process text, voice, and video and identify and rank the evidence <br>
               <strong><br>
  Benefits: </strong></p>
           <p>CUSTODY &reg; law enforcement grade recording platforms&nbsp; and storage solutions help agencies communicate, share, manage, archive, and distribute video and rich media. Removing the need for costly and time-consuming manual processes, CUSTODY&nbsp; increases the productivity of agency high-volume workflows through automation and advanced technologies. An additional benefit is the abilityto work within any existing IT infrastructure, by overlaying existing architectures and enhancing current production tools, enabling staff to become more productive within a familiar environment. </p>
           <p><strong> Solutions </strong></p>
           <ul>
             <li> <em>CUSTODY&reg; Cosmos Series</em> - a family&nbsp; of mobile digital video recording platforms developed to meet all of <br>
&nbsp; the needs of law enforcement video / audio recording. <br>
&nbsp; </li>
             <li> <em>Evidence Bank</em> - a content management solution to efficiently store, categorize, manage, retrieve and distribute <br>
&nbsp; video, audio and other rich media content.<br>
&nbsp; </li>
             <li> <em>Evidence Vault</em> - gives companies a combined solution for planning and producing interactive, live webcasts <br>
    as well as on-demand searchable events </li>
           </ul>
           <p><strong>Core Products &amp; Technology </strong></p>
           <ul>
             <li>Custody&reg; Cosmos Series - MDVR 2000, MDVR 2050, MDVR 3000, OnBodyDVR.<br>
&nbsp; </li>
             <li> CustodyEncodeSecure - VHS to Digital Encoding Platforms for secure media conversions.<br>
&nbsp; </li>
             <li>Evidence Bank / Vault&nbsp; -&nbsp; Storage software / hardware solutions for small, medium and large public safety organizations. <br>
&nbsp; </li>
             <li>CUSTODY Secure Server - Hard drive based video on demand technologies <br>
             </li>
           </ul></td>
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