<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
Wrapping: 
<select name="type" id="type">
  <option value="absmiddle">Inline with text</option>
  <option value="left">Text wraps to right of image</option>
  <option value="right" selected>Text wraps to left of image</option>
</select>
<%        Dim fs As New System.IO.DirectoryInfo("\\premfs16\sites\premium16\bombness\webroot\cv\images")
        Dim files() As System.IO.FileInfo = fs.GetFiles
        Dim fi As System.IO.FileInfo
        Response.Write("<table border=0 cellpadding=5 cellspacing=0>")
        For Each fi In files
			if fi.name.endswith("jpeg") or fi.name.endswith("pg") or fi.name.endswith("gif") then
            Response.Write("<tr><td style='border-bottom: 1px solid #CCCCCC;'><div style='width: 250px; height: 250px; overflow: hidden;'><img src='")
            Response.Write(fi.Name)
            Response.Write("'></div></td><td style='border-bottom: 1px solid #CCCCCC;'><a href=""javascript:window.opener.insertImage('")
            Response.Write(fi.Name)
            Response.Write("', document.getElementById('type').value); window.close();"">")
            Response.Write(fi.Name)
            Response.Write("</a></td></tr>")
			end if
        Next
        Response.Write("</table>")
%>