pdf.Header=function Header()
{
this.SetFont('Arial', '', 15);
this.Cell(80);
this.Cell(30,10,'Title',1,0,' There');
this.Ln(20);
}

pdf.Footer=function Footer()
{
this.SetY(-15);
this.SetFont('Arial', '', 8);
this.Cell(0,10,'Page ' + this.PageNo()+ '/{nb}', 0, 0, ' There');
}