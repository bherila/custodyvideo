<% on error resume next %>
             <style type="text/css">
<!--
.clsCursor {  cursor: hand}
-->
             </style>
             <textarea name="EditorValue" style="display: none;"><%= EditorValue %></textarea>
<% on error goto 0 %>
             <script language="JavaScript">

  var errorString = "Sorry but this web page needs\nWindows95 and Internet Explorer 5 or above to view."
  var Ok = "false";
  var name =  navigator.appName;
  var version =  parseFloat(navigator.appVersion);
  var platform = navigator.platform;

	if (platform == "Win32" && name == "Microsoft Internet Explorer" && version >= 4){
		Ok = "true";
	} else {
		Ok= "false";
	}

	if (Ok == "false") {
		alert(errorString);
	}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

function ColorPalette_OnClick(colorString){
	
	cpick.bgColor=colorString;
	document.all.colourp.value=colorString;
	doFormat('ForeColor',colorString);
}

function initToolBar(ed) {
    
	var eb = document.all.editbar;
	if (ed!=null) {
		eb._editor = window.frames['myEditor'];
	}
}

function doFormat(what) {

	var eb = document.all.editbar;
		
	if(what == "FontName"){
		if(arguments[1] != 1){
			eb._editor.execCommand(what, arguments[1]);
			document.all.font.selectedIndex = 0;
		} 
	} else if(what == "FontSize"){
    if(arguments[1] != 1){
      eb._editor.execCommand(what, arguments[1]);
      document.all.size.selectedIndex = 0;
    } 
	} else {
	   eb._editor.execCommand(what, arguments[1]);
	}
}

function swapMode() {

	var eb = document.all.editbar._editor;
  eb.swapModes();
}

function create() {

    var eb = document.all.editbar;
    eb._editor.newDocument();
}

function newFile(){

	create();
}

function makeUrl(){

	sUrl = document.all.what.value + document.all.url.value;
	doFormat('CreateLink',sUrl);
}

function copyValue() {

	var theHtml = "" + document.frames("myEditor").document.frames("textEdit").document.body.innerHTML + "";
	document.all.EditorValue.value = theHtml;
}

function insertImage(img, align) {
	var theHtml = "" + document.frames("myEditor").document.frames("textEdit").document.body.innerHTML + "<img border=\"0\" src=\"/images/" + img + "\" align=\"" + align + "\">";
	document.frames("myEditor").document.frames("textEdit").document.body.innerHTML = theHtml;
}

function SwapView_OnClick(){

  if(document.all.btnSwapView.value == "View Html"){
		var sMes = "View Wysiwyg";
    var sStatusBarMes = "Current View Html";
	} else {
		var sMes = "View Html"
    var sStatusBarMes = "Current View Wysiwyg";
  }
	
	document.all.btnSwapView.value = sMes;
  window.status  = sStatusBarMes;
	swapMode();
}

function Help_OnClick(){
  window.open("editor_images/help_document.htm","wHelp", "toolbar=0, scrollbars=yes, width=640, height=480");
}

function OnFormSubmit(){

  if(confirm("This Document is about to be submitted\nAre you sure you have finished editing?")){
    copyValue();
    document.fHtmlEditor.submit();
  }
}
             </script>
             <table border="1" cellspacing="0" cellpadding="0" bgcolor="#CCCCCC" width="100%" height="100%" bordercolor="#CCCCCC">
               <tr valign="top">
                 <td>
                   <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                     <tr valign="top">
                       <td valign="top">
                         <div id=editbar >
                           <table width="100%" border="0" cellpadding="0" cellspacing="0" align="left">
                             <tr>
                               <td>
                                 <table border="0" cellpadding="0" cellspacing="0">
                                   <tr>
                                     <td>
                                       <table border="0">
                                         <tr valign="baseline">
                                           <td nowrap>  <img class='clsCursor' src="editor_images/Copy.gif" width="16" height="16" border="0" alt="Copy" onClick="doFormat('Copy')">&nbsp; <img class='clsCursor' src="editor_images/Paste.gif" border="0" alt="Paste" onClick="doFormat('Paste')" width="16" height="16">&nbsp; </td>
                                         </tr>
                                     </table></td>
                                     <td>
                                       <table border="0">
                                         <tr valign="baseline">
                                           <td nowrap> <img src="editor_images/para_bul.gif" alt="Bullet List" width="16" height="16" border="0" align="absmiddle" class='clsCursor' onClick="doFormat('InsertUnorderedList');" >&nbsp; <img src="editor_images/para_num.gif" alt="Numbered List" width="16" height="16" border="0" align="absmiddle" class='clsCursor' onClick="doFormat('InsertOrderedList');" >&nbsp; <img src="editor_images/indent.gif" alt="Indent" width="20" height="16" align="absmiddle" class='clsCursor' onClick="doFormat('Indent')">&nbsp; <img src="editor_images/outdent.gif" alt="Outdent" width="20" height="16" align="absmiddle" class='clsCursor' onClick="doFormat('Outdent')">&nbsp; <img src="editor_images/hr.gif" alt="HR" width="16" height="18" align="absmiddle" class='clsCursor' onClick="doFormat('InsertHorizontalRule')">&nbsp;&nbsp;&nbsp;[<a href="javascript:void(0);" onClick="MM_openBrWindow('../images/images.aspx','frmImages','status=yes,scrollbars=yes,resizable=yes,width=640,height=480')">IMG</a>]&nbsp; </td>
                                         </tr>
                                     </table></td>
                                     <td>
                                       <table border="0">
                                         <tr valign="baseline">
                                           <td nowrap><img src="editor_images/link.gif" border="0" alt="Link to external site"></td>
                                           <td nowrap>
                                             <select name="what" style="font: 8pt verdana;">
                                               <option value="http://" selected>http://</option>
                                               <option value="mailto:">mailto:</option>
                                               <option value="ftp://">ftp://</option>
                                               <option value="https://">https://</option>
                                             </select>
                                           </td>
                                           <td>
                                             <input type="text" name="url" size="35" style="font: 8pt verdana;">
                                           </td>
                                           <td>
                                             <input type="button" name="button2" value="Add" onClick="makeUrl();" style="font: 8pt verdana;">
                                           </td>
                                         </tr>
                                     </table></td>
                                     <td><img class='clsCursor' src="editor_images/help.gif" width="20" height="20" align="middle" alt="Help" onClick="Help_OnClick();"> </td>
                                   </tr>
                               </table></td>
                             </tr>
                             <tr>
                               <td height="41">
                                 <table border="0">
                                   <tr>
                                     <td nowrap valign="baseline">
                                       <div align="left">
                                         <select name="font" onChange=" doFormat('FontName',document.all.font.value);" style="font: 8pt verdana;">
                                           <option value="1" selected >Select Font...</option>
                                           <option value="arial">Arial, Helvetica, sans-serif</option>
                                           <option value="times" >Times New Roman, Times, serif</option>
                                           <option value="courier">Courier New, Courier, mono</option>
                                           <option value="georgia">Georgia, Times New Roman</option>
                                           <option value="verdana">Verdana, Arial, Helvetica</option>
                                         </select>
                                         <select name="size" onChange="doFormat('FontSize',document.all.size.value);" style="font: 8pt verdana;">
                                           <option value="None" selected>Size</option>
                                           <option value="1">1</option>
                                           <option value="2">2</option>
                                           <option value="3">3</option>
                                           <option value="4">4</option>
                                           <option value="5">5</option>
                                           <option value="6">6</option>
                                           <option value="7">7</option>
                                           <option value="+1">+1</option>
                                           <option value="+2">+2</option>
                                           <option value="+3">+3</option>
                                           <option value="+4">+4</option>
                                           <option value="+5">+5</option>
                                           <option value="+6">+6</option>
                                           <option value="+7">+7</option>
                                         </select>
                                         <img class='clsCursor' src="editor_images/Bold.gif" width="16" height="16" border="0" align="absmiddle" alt="Bold text" onClick="doFormat('Bold')">&nbsp; <img class='clsCursor' src="editor_images/Italics.gif" width="16" height="16" border="0" align="absmiddle" alt="Italic text" onClick="doFormat('Italic')">&nbsp; <img class='clsCursor' src="editor_images/underline.gif" width="16" height="16" border="0" align="absmiddle" alt="Underline text" onClick="doFormat('Underline')" >&nbsp; <img class='clsCursor' src="editor_images/left.gif" width="16" height="16" border="0" alt="Align Left" align="absmiddle"  onClick="doFormat('JustifyLeft')"> <img class='clsCursor' src="editor_images/centre.gif" width="16" height="16" border="0" alt="Align Center" align="absmiddle" onClick="doFormat('JustifyCenter')">&nbsp; <img class='clsCursor' src="editor_images/right.gif" width="16" height="16" border="0" alt="Align Right" align="absmiddle"  onClick="doFormat('JustifyRight')">&nbsp; </div></td>
                                     <td align="left" nowrap valign="baseline">
                                       <input type="button" name="btnSwapView" value="View Html" onClick="SwapView_OnClick();" style="width:100px; font: 8pt verdana;">
                                     </td>
                                   </tr>
                               </table></td>
                             </tr>
                           </table>
                       </div></td>
                     </tr>
                     <tr valign="top" align="left">
                       <td valign="top">
                         <table width="100%" border="0" height="100%">
                           <tr valign="top">
                             <td width="100%" height="100%">
                               <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
                                 <tr valign="top">
                                   <td bgcolor="#FFFFFF"><iframe id=myEditor src="pd_edit.htm" onfocus="initToolBar(this)" width=100% height=100%></iframe></td>
                                 </tr>
                             </table></td>
                             <td width="9%" align="center">
                               <table  bgcolor="#000000" width="74" id="cpick" border="1" cellspacing="0" cellpadding="0" align="center">
                                 <tr>
                                   <td>&nbsp;</td>
                                 </tr>
                               </table>
                               <input type="text" name="colourp" size="8" value="#000000" style="width:74px; font: 8pt verdana" readonly>
                               <table border=1 bgcolor="#CCCCCC" cellpadding="0" cellspacing="0" width="74">
                                 <tr>
                                   <td bgcolor="#ffffff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ffffff')"></td>
                                   <td bgcolor="#ffffcc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ffffcc')"></td>
                                   <td bgcolor="#ffff99" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ffff99')"></td>
                                   <td bgcolor="#ffff66" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ffff66')"></td>
                                   <td bgcolor="#ffff33" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ffff33')"></td>
                                   <td bgcolor="#ffff00" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ffff00')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#ccffff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ccffff')"></td>
                                   <td bgcolor="#ccffcc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ccffcc')"></td>
                                   <td bgcolor="#ccff99" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ccff99')"></td>
                                   <td bgcolor="#ccff66" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ccff66')"></td>
                                   <td bgcolor="#ccff33" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ccff33')"></td>
                                   <td bgcolor="#ccff00" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ccff00')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#99ffff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#99ffff')"></td>
                                   <td bgcolor="#99ffcc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#99ffcc')"></td>
                                   <td bgcolor="#99ff99" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#99ff99')"></td>
                                   <td bgcolor="#99ff66" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#99ff66')"></td>
                                   <td bgcolor="#99ff33" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#99ff33')"></td>
                                   <td bgcolor="#99ff00" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#99ff00')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#00ffff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#00ffff')"></td>
                                   <td bgcolor="#00ffcc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#00ffcc')"></td>
                                   <td bgcolor="#00ff99" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#00ff99')"></td>
                                   <td bgcolor="#00ff66" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#00ff66')"></td>
                                   <td bgcolor="#00ff33" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#00ff33')"></td>
                                   <td bgcolor="#00ff00" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#00ff00')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#ffccff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ffccff')"></td>
                                   <td bgcolor="#ffcccc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ffcccc')"></td>
                                   <td bgcolor="#ffcc99" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ffcc99')"></td>
                                   <td bgcolor="#ffcc66" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ffcc66')"></td>
                                   <td bgcolor="#ffcc33" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ffcc33')"></td>
                                   <td bgcolor="#ffcc00" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ffcc00')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#ccccff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ccccff')"></td>
                                   <td bgcolor="#cccccc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cccccc')"></td>
                                   <td bgcolor="#cccc99" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cccc99')"></td>
                                   <td bgcolor="#cccc66" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cccc66')"></td>
                                   <td bgcolor="#cccc33" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cccc33')"></td>
                                   <td bgcolor="#cccc00" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cccc00')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#00ccff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#00ccff')"></td>
                                   <td bgcolor="#00cccc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#00cccc')"></td>
                                   <td bgcolor="#00cc99" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#00cc99')"></td>
                                   <td bgcolor="#00cc66" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#00cc66')"></td>
                                   <td bgcolor="#00cc33" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#00cc33')"></td>
                                   <td bgcolor="#00cc00" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#00cc00')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#ff99ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff99ff')"></td>
                                   <td bgcolor="#ff99cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff99cc')"></td>
                                   <td bgcolor="#ff9999" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff9999')"></td>
                                   <td bgcolor="#ff9966" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff9966')"></td>
                                   <td bgcolor="#ff9933" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff9933')"></td>
                                   <td bgcolor="#ff9900" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff9900')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#cc99ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc99ff')"></td>
                                   <td bgcolor="#cc99cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc99cc')"></td>
                                   <td bgcolor="#cc9999" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc9999')"></td>
                                   <td bgcolor="#cc9966" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc9966')"></td>
                                   <td bgcolor="#cc9933" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc9933')"></td>
                                   <td bgcolor="#cc9900" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc9900')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#9999ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#9999ff')"></td>
                                   <td bgcolor="#9999cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#9999cc')"></td>
                                   <td bgcolor="#999999" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#999999')"></td>
                                   <td bgcolor="#999966" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#999966')"></td>
                                   <td bgcolor="#999933" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#999933')"></td>
                                   <td bgcolor="#999900" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#999900')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#6699ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#6699ff')"></td>
                                   <td bgcolor="#6699cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#6699cc')"></td>
                                   <td bgcolor="#669999" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#669999')"></td>
                                   <td bgcolor="#669966" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#669966')"></td>
                                   <td bgcolor="#669933" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#669933')"></td>
                                   <td bgcolor="#669900" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#669900')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#3399ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#3399ff')"></td>
                                   <td bgcolor="#3399cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#3399cc')"></td>
                                   <td bgcolor="#339999" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#339999')"></td>
                                   <td bgcolor="#339966" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#339966')"></td>
                                   <td bgcolor="#339933" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#339933')"></td>
                                   <td bgcolor="#339900" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#339900')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#0099ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#0099ff')"></td>
                                   <td bgcolor="#0099cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#0099cc')"></td>
                                   <td bgcolor="#009999" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#009999')"></td>
                                   <td bgcolor="#009966" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#009966')"></td>
                                   <td bgcolor="#009933" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#009933')"></td>
                                   <td bgcolor="#009900" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#009900')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#ff66ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff66ff')"></td>
                                   <td bgcolor="#ff66cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff66cc')"></td>
                                   <td bgcolor="#ff6699" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff6699')"></td>
                                   <td bgcolor="#ff6666" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff6666')"></td>
                                   <td bgcolor="#ff6633" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff6633')"></td>
                                   <td bgcolor="#ff6600" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff6600')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#cc66ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc66ff')"></td>
                                   <td bgcolor="#cc66cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc66cc')"></td>
                                   <td bgcolor="#cc6699" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc6699')"></td>
                                   <td bgcolor="#cc6666" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc6666')"></td>
                                   <td bgcolor="#cc6633" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc6633')"></td>
                                   <td bgcolor="#cc6600" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc6600')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#9966ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#9966ff')"></td>
                                   <td bgcolor="#9966cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#9966cc')"></td>
                                   <td bgcolor="#996699" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#996699')"></td>
                                   <td bgcolor="#996666" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#996666')"></td>
                                   <td bgcolor="#996633" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#996633')"></td>
                                   <td bgcolor="#996600" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#996600')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#6666ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#6666ff')"></td>
                                   <td bgcolor="#6666cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#6666cc')"></td>
                                   <td bgcolor="#666699" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#666699')"></td>
                                   <td bgcolor="#666666" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#666666')"></td>
                                   <td bgcolor="#666633" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#666633')"></td>
                                   <td bgcolor="#666600" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#666600')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#3366ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#3366ff')"></td>
                                   <td bgcolor="#3366cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#3366cc')"></td>
                                   <td bgcolor="#336699" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#336699')"></td>
                                   <td bgcolor="#336666" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#336666')"></td>
                                   <td bgcolor="#336633" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#336633')"></td>
                                   <td bgcolor="#336600" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#336600')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#0066ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#0066ff')"></td>
                                   <td bgcolor="#0066cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#0066cc')"></td>
                                   <td bgcolor="#006699" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#006699')"></td>
                                   <td bgcolor="#006666" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#006666')"></td>
                                   <td bgcolor="#006633" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#006633')"></td>
                                   <td bgcolor="#006600" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#006600')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#ff33ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff33ff')"></td>
                                   <td bgcolor="#ff33cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff33cc')"></td>
                                   <td bgcolor="#ff3399" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff3399')"></td>
                                   <td bgcolor="#ff3366" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff3366')"></td>
                                   <td bgcolor="#ff3333" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff3333')"></td>
                                   <td bgcolor="#ff3300" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff3300')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#cc33ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc33ff')"></td>
                                   <td bgcolor="#cc33cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc33cc')"></td>
                                   <td bgcolor="#cc3399" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc3399')"></td>
                                   <td bgcolor="#cc3366" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc3366')"></td>
                                   <td bgcolor="#cc3333" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc3333')"></td>
                                   <td bgcolor="#cc3300" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc3300')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#9933ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#9933ff')"></td>
                                   <td bgcolor="#9933cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#9933cc')"></td>
                                   <td bgcolor="#993399" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#993399')"></td>
                                   <td bgcolor="#993366" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#993366')"></td>
                                   <td bgcolor="#993333" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#993333')"></td>
                                   <td bgcolor="#993300" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#993300')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#6633ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#6633ff')"></td>
                                   <td bgcolor="#6633cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#6633cc')"></td>
                                   <td bgcolor="#663399" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#663399')"></td>
                                   <td bgcolor="#663366" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#663366')"></td>
                                   <td bgcolor="#663333" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#663333')"></td>
                                   <td bgcolor="#663300" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#663300')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#3333ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#3333ff')"></td>
                                   <td bgcolor="#3333cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#3333cc')"></td>
                                   <td bgcolor="#333399" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#333399')"></td>
                                   <td bgcolor="#333366" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#333366')"></td>
                                   <td bgcolor="#333333" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#333333')"></td>
                                   <td bgcolor="#333300" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#333300')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#0033ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#0033ff')"></td>
                                   <td bgcolor="#0033cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#0033cc')"></td>
                                   <td bgcolor="#003399" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#003399')"></td>
                                   <td bgcolor="#003366" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#003366')"></td>
                                   <td bgcolor="#003333" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#003333')"></td>
                                   <td bgcolor="#003300" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#003300')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#ff00ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff00ff')"></td>
                                   <td bgcolor="#ff00cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff00cc')"></td>
                                   <td bgcolor="#ff0099" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff0099')"></td>
                                   <td bgcolor="#ff0066" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff0066')"></td>
                                   <td bgcolor="#ff0033" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff0033')"></td>
                                   <td bgcolor="#ff0000" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#ff0000')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#cc00ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc00ff')"></td>
                                   <td bgcolor="#cc00cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc00cc')"></td>
                                   <td bgcolor="#cc0099" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc0099')"></td>
                                   <td bgcolor="#cc0066" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc0066')"></td>
                                   <td bgcolor="#cc0033" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc0033')"></td>
                                   <td bgcolor="#cc0000" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#cc0000')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#9900ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#9900ff')"></td>
                                   <td bgcolor="#9900cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#9900cc')"></td>
                                   <td bgcolor="#990099" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#990099')"></td>
                                   <td bgcolor="#990066" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#990066')"></td>
                                   <td bgcolor="#990033" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#990033')"></td>
                                   <td bgcolor="#990000" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#990000')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#6600ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#6600ff')"></td>
                                   <td bgcolor="#6600cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#6600cc')"></td>
                                   <td bgcolor="#660099" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#660099')"></td>
                                   <td bgcolor="#660066" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#660066')"></td>
                                   <td bgcolor="#660033" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#660033')"></td>
                                   <td bgcolor="#660000" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#660000')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#3300ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#3300ff')"></td>
                                   <td bgcolor="#3300cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#3300cc')"></td>
                                   <td bgcolor="#330099" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#330099')"></td>
                                   <td bgcolor="#330066" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#330066')"></td>
                                   <td bgcolor="#330033" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#330033')"></td>
                                   <td bgcolor="#330000" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#330000')"></td>
                                 </tr>
                                 <tr>
                                   <td bgcolor="#0000ff" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#0000ff')"></td>
                                   <td bgcolor="#0000cc" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#0000cc')"></td>
                                   <td bgcolor="#000099" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#000099')"></td>
                                   <td bgcolor="#000066" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#000066')"></td>
                                   <td bgcolor="#000033" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#000033')"></td>
                                   <td bgcolor="#000000" width="12"><img class="clsCursor" src="blank.gif" height=8 width=10 border=0 onClick="ColorPalette_OnClick('#000000')"></td>
                                 </tr>
                             </table></td>
                           </tr>
                       </table></td>
                     </tr>
                 </table></td>
               </tr>
             </table>
             <script>
  initToolBar("foo");
  window.status  = "Current View: Wysiwyg";
             </script>