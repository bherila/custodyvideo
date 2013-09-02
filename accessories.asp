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
     <h1>Accessories</h1>
     <table width="100%"  border="0" cellspacing="10" cellpadding="0">
       <tr align="center" valign="middle">
         <td width="50%" style="border: 1px solid #CCCCCC; background-color: #EEEEEE; padding: 10px;"><table width="100%"  border="0" cellspacing="0" cellpadding="10">
           <tr>
             <td><img src="images/hd.jpg" width="69" height="100"></td>
             <td><table cellspacing="0" cellpadding="0">
               <tr>
                 <td><p><strong>Secure Mobile Hardrives <br>
&nbsp;</strong></p></td>
               </tr>
               <tr>
                 <td><p>Our patent pending Secure Hard Drives insure that the chain of custody is maintained. </p></td>
               </tr>
             </table></td>
           </tr>
         </table>           </td><td width="50%" style="border: 1px solid #CCCCCC; background-color: #EEEEEE; padding: 10px;"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
               <tr>
                 <td><img src="images/cd.jpg" width="100" height="100"></td>
                 <td><table cellspacing="0" cellpadding="0">
                   <tr>
                     <td><p><strong>Serialized DVD Media <br>
&nbsp;                     </strong></p></td>
                   </tr>
                   <tr>
                     <td><p>Bar coded, serialized and imprinted with your agency's name and logo to control the flow of evidence within your agency. </p></td>
                   </tr>
                 </table></td>
               </tr>
             </table></td></tr>
       <tr align="center">
         <td height="100" colspan="2"><p><strong>Agencies should be able to upgrade their recorders as they grow. </strong></p>
           <p>Custody provides agencies the ability to upgrade their recorders with new software features, expanded camera coverage and additional microphones. Here is a partial accessory list; </p></td>
         </tr>
       <tr valign="top">
         <td width="50%" style="border: 1px solid #CCCCCC; background-color: #EEEEEE; padding: 10px;"><p align="center"><strong>GPS Module</strong></p>
           <p align="justify"> Highest quality GPS chip set available. Not all GPS systems are equal. CUSTODY uses the oldest, most reliable and exacting GPS technology available. Integration and operation with other chipsets and reliability is a customers first concern. Our supplier is the most established name in GPS technology. It is also one of the most costly. </p>
           <hr width="90%" size="1" noshade>           <p align="center"><strong>CV-GPS-ANT 1</strong></p>
           <p>GPS Hard Mount Antenna - 26dB with TNC connector (<em><strong>O</strong></em><strong><em>ptional</em></strong>)</p>
           <hr width="90%" size="1" noshade>           <p align="center"><strong><a href="prod/cv-titan-2000.asp">CV-TITAN 2000</a></strong></p>
           <p align="center"><a href="prod/cv-titan-2000.asp"><img src="images/accessories_clip_image002_0000.jpg" width="84" height="119" border="0"></a></p>           
           <p>40 Channel, Frequency Hopping, 2 way Wireless Microphone / Transceiver.</p>
           <hr width="90%" size="1" noshade>           <p align="center"><strong>CV-TITAN-2MIC </strong></p>
           <p align="center"><img width="143" height="107" src="images/accessories_clip_image004.jpg"></p>
           <p><strong>Microphone / Headset </strong> for achieving 2 way communications between the vehicle and the officer wearing the transceiver . </p>
           <p><strong>CV-MIC-Case for Titan 2000 Microphone </strong></p></td>
         <td width="50%" style="border: 1px solid #CCCCCC; background-color: #EEEEEE; padding: 10px;"><p align="center"><strong>Extended Term Service Contracts </strong></p>             
           <p align="center">A total of 5 years, with 24 hour advance replacement policy.</p>
           <hr width="90%" size="1" noshade>           <p align="center"><img width="88" height="37" src="images/accessories_clip_image002.jpg"></p>
           <p align="center"><strong>Micro USB Transport Drives</strong></p>
           <ul>
             <li><strong>CV-IStick-512- </strong>Stores 30 Minutes of video evidence. </li>
             <li><strong>CV-Istick-1G </strong>Stores 30 Minutes of video evidence </li>
           </ul>           
           <hr width="90%" size="1" noshade>           <p align="center"><img width="119" height="65" src="images/accessories_clip_image004.gif"></p>
           <p align="center"><strong>CV-CSS-1 </strong></p>           
           <p align="center"><strong>Collision Shock Sensor </strong> - Measures and records vehicle impact, force, direction</p>           </td>
       </tr>
       <tr align="center" valign="middle">
         <td width="50%" style="border: 1px solid #CCCCCC; background-color: #EEEEEE; padding: 10px;"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
           <tr>
             <td align="center" valign="top"><img src="images/duty%20recorder%20-20gb-stand.gif" width="100" height="87"></td>
             <td align="left"><p align="left"><strong>Radar Interface Module</strong></p>
               <p align="justify"> Our Radar Interface Module seamlessly integrates with major radar system manufacturers.</p>
               <p>( <strong><em>Optional </em></strong>) </p>
               <p><strong>CV-KUS-RI - </strong>Kustom CV<br>
                 <strong>CV-MPH- RI - </strong>MPH<strong><br>
                 CV-LT-RI </strong>- Laser Tech <strong><br>
                 CV-DEC-RI </strong> - Decatur</p>               
               </td>
           </tr>
         </table>           </td>
         <td width="50%" style="border: 1px solid #CCCCCC; background-color: #EEEEEE; padding: 10px;"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
           <tr>
             <td><img src="images/docking%20station.gif" width="151" height="124"></td>
             <td><p align="left"><strong>MDVR </strong><strong></strong><strong>Agency </strong><strong></strong><strong>Docking </strong><strong></strong><strong>Bay </strong><strong></strong></p>
               <p align="left"><strong> </strong>Holds&nbsp; 1 to 4 MDVR units </p></td>
           </tr>
         </table>           </td>
       </tr>
       <tr align="center" valign="middle">
         <td style="border: 1px solid #CCCCCC; background-color: #EEEEEE; padding: 10px;">  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
           <tr>
             <td> <img width="94" height="99" src="images/accessories_clip_image002_0001.jpg"> </td>
             <td><p align="left"><strong>Body Wearable, Remote Cameras <br>
( <strong><em>Optional </em></strong>)             </strong></p>
                 </td>
           </tr>
         </table></td>
         <td style="border: 1px solid #CCCCCC; background-color: #EEEEEE; padding: 10px;">           <table width="100%"  border="0" cellspacing="0" cellpadding="0">
           <tr>
             <td align="center" valign="top"><img src="images/duty%20recorder%20-20gb-stand.gif" width="100" height="87"></td>
             <td align="left"><p align="left"><strong>Pre-Event / Post Event Recording Module - </strong>User defined time for pre &amp; post event recording - Up to 8 minutes! </p>
                 </td>
           </tr>
         </table>           </td>
       </tr>
       <tr align="center" valign="middle">
         <td style="border: 1px solid #CCCCCC; background-color: #EEEEEE; padding: 10px;"> <table width="100%"  border="0" cellspacing="0" cellpadding="0">
           <tr>
             <td align="center" valign="top"><img src="images/duty%20recorder%20-20gb-stand.gif" width="100" height="87"></td>
             <td><p align="left"><strong>Evidence Bank Server System - </strong> We customize the right system based upon the size and needs of each age <br>
( <strong><em>Optional </em></strong>)             </p></td>
           </tr>
         </table>           </td>
         <td style="border: 1px solid #CCCCCC; background-color: #EEEEEE; padding: 10px;"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
           <tr>
             <td align="center" valign="top"> <img width="95" height="79" src="images/accessories_clip_image002_0002.jpg"> </td>
             <td align="left"><p align="left">CV-IDLINK-1&nbsp; <strong>ID Link&reg; - </strong></p>                 <p align="left">MDT based program linking incident or arrest number directly to MDVR 


 (<strong><em>Optional</em></strong>) </p></td>
           </tr>
         </table>           </td>
       </tr>
       <tr align="center" valign="middle">
         <td style="border: 1px solid #CCCCCC; background-color: #EEEEEE; padding: 10px;"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
           <tr>
             <td align="center" valign="top"><img width="95" height="79" src="images/accessories_clip_image002_0002.jpg"></td>
             <td align="left"><p align="left">CV-IDLINK-2 </p>
               <p align="left"><strong>ID LinkPlus&reg; - </strong>MDT based program linking incident or arrest number, crime classification codes directly to MDVR after event activation and before &nbsp;post event closing 


 ( <strong><em>Optional </em></strong>) </p>               </td>
           </tr>
         </table>           </td>
         <td style="border: 1px solid #CCCCCC; background-color: #EEEEEE; padding: 10px;"><table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
           <tr>
             <td align="center" valign="top"><img src="images/duty%20recorder%20-20gb-stand.gif" width="100" height="87"></td>
             <td align="left"><p align="left">CV-Soft-1 </p>
               <p align="left">LTP <strong>Software Upgrade Plan - </strong> Receive MDVR Custody Software updates for life of the DVR 


 ( <strong><em>Optional </em></strong>) </p>               </td>
           </tr>
         </table>           </td>
       </tr>
       <tr valign="top">
         <td colspan="2" style="border: 1px solid #CCCCCC; background-color: #EEEEEE; padding: 10px;"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td width="125" align="center" valign="middle"><img src="images/pts.gif" height="72" width="100"></td>
               <td><p align="center"><em>Portable - Transportable - Secure </em></p>
                 <p align="center"><strong>Maintain the chain from vehicle to courtroom. Give every officer their own CUSTODY BioDNA Transport Drive. </strong></p>
                 <p align="justify">CUSTODY&reg; ensures that the "chain of CUSTODY" is never broken by offering you a more secure means to transporting your digital video evidence to and from the court room. Our Bio Metric Flash Drives limited the release and playing of your video evidence to the officer it was signed out to. We can even issue an expiration time or date to ensure that the files cannot be played after the court date. </p>
                 <p align="justify">If the CUSTODY&reg; Bio Metric Evidence Drive is lost, no problem. Without the officer's fingerprint to authorize the mounting of the folder, this drive is rendered useless. Drives can be formatted and use over again, thus eliminating the need for media cost such as VHS tapes or DVD's. </p></td>
             </tr>
           </table>           </td>
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