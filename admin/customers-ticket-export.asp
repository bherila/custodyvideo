<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%><%

    strBody = _
      "<html xmlns:o='urn:schemas-microsoft-com:office:office' " & _
      "xmlns:w='urn:schemas-microsoft-com:office:word'" & _
      "xmlns='http://www.w3.org/TR/REC-html40'" & _
      "><head><title>Time</title>"

    strBody = strBody + _
        "<!--[if gte mso 9]><xml>" & _
        "<w:WordDocument>  <w:View>" & _
        "Print</w:View> <BR>" & _
        "<w:Zoom>90</w:Zoom>  " & _
        "<w:DoNotOptimizeForBrowser/>" & _
        "</w:WordDocument></xml><![endif]-->"
          
    strBody = strBody + _
              "<style><!-- /* Style Definitions" & _
              " */@page Section1{size:8.5in 11.0in;" & _
              "margin:1.0in 1.25in 1.0in " & _
              "1.25in;mso-header-margin:.5in; " & _
              "mso-footer-margin:.5in;    mso-paper-source:0;}"

    strBody = strBody + _
      "div.Section1{page:Section1;}--></style></head>"

    strBody = strBody + _
      "@page Section1{size:8.5in 11.0in;    " & _
      "margin:1.0in 1.0in 45.0pt 1.0in;" & _
      "mso-header-margin:.5in;    " & _ 
      "mso-footer-margin:.5in; mso-paper-source:0;}"

    strBody = strBody + "div.Section1 {page:Section1;}--></style>"
          
    strBody = strBody + _
      "<body lang=EN-US style='tab-interval:.5in'><div " & _
      "class=Section1><h1>Time and tide wait for none</h1>" & _
      "<p style='color:red'><I>" & Now & _
      "</I></p></div></body></html>"

    'Force this content to be downloaded 
    'as a Word document with the name of your choice
    Response.AddHeader "Content-Type","application/msword"
    Response.AddHeader "Content-disposition", "attachment; filename=myword.doc"
    Response.Charset="" 
    Response.Write(strBody)

%>