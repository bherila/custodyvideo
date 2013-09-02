<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include virtual="/bombness/includes/fpdf.asp"-->
<!--#include file="../Connections/MySQL.asp" -->
<%
Response.AddHeader "Content-Disposition", "filename=export.pdf"
set Conn = Server.CreateObject("adodb.connection")
Conn.Open(MM_MySQL_STRING)
y = 0


Set Rs = Conn.Execute("select count(*) from cv_invoice_items where tid = '" & Replace(Request("id"), "'", "''") & "'")
s = rs(0)
dim products()
dim descriptions()
dim unitprices()
dim quantities()
dim discounts()
dim discount_amounts()
redim products(s)
redim descriptions(s)
redim unitprices(s)
redim quantities(s)
rs.close
Set Rs = Conn.Execute("select * from cv_invoice_items where tid = '" & Replace(Request("id"), "'", "''") & "'")
i = 0
While Not Rs.EOF
	set rs2 = Conn.Execute("select price, name, description from cv_invoice_products where id = " & rs("pid"))
		unitprices(i) = rs2(0)
		products(i) = rs2(1)
		descriptions(i) = rs2(2)
		rs2.close
	quantities(i) = rs("quantity")
	i = i + 1
	rs.MoveNext
Wend
rs.close
set rs = conn.execute("select count(*) from cv_invoice_discounts where tid = " & ccur(Request("id")))
dcount = ccur(rs(0))
redim discounts(dcount)
redim discount_amounts(dcount)
rs.close
set rs = conn.execute("select id, description, amount from cv_invoice_discounts where tid = " & ccur(Request("id")))
i = 0
while not rs.eof
	discounts(i) = rs("description")
	discount_amounts(i) = rs("amount")
	i = i + 1
	rs.movenext
wend
rs.close

set rs = conn.execute("select * from cv_invoices where id = " & ccur(Request("id")) & " limit 1")
rep = rs("rep")
cid = rs("cid")
shipping = rs("shipping")
rs.close
set rs = conn.execute("select agency, mailing_address, city, state, zip, phone, primary_contact from cv_db where id = " & cid & " limit 1")
agency = rs(0)
address = rs(1)
address2 = rs(2) & ", " & rs(3) & " " & rs(4)
phone = FormatPhoneNumber(rs(5))
pdate = Now
attention = rs(6)
rs.close

id = ccur(request("id"))

set rs = nothing
set rs2 = nothing
conn.close
set conn = nothing

subtotal = ccur(0.00)

function writeInfo()
	pdf.SetFont "Times", "B", 10
	pdf.Text  20, y +  0, "Agency:"
	pdf.Text  20, y +  4, "Address:"
	pdf.Text 100, y +  0, "Attention:"
	pdf.Text 100, y +  4, "Phone:"
	pdf.Text 100, y +  8, "Proposal #:"
	pdf.Text 100, y + 12, "Date:"
	pdf.Text 100, y + 16, "Prepared By:"
	pdf.SetFont "Times", "", 10
	pdf.text  50, y +  0, agency
	pdf.text  50, y +  4, address
	pdf.text  50, y +  8, address2
	pdf.text 130, y +  0, attention
	pdf.text 130, y +  4, phone
	pdf.text 130, y +  8, id
	pdf.text 130, y + 12, pdate
	pdf.text 130, y + 16, Session("MM_Name")
	y = y + 24
end function

function pageHeader(xxx)
	pdf.SetFont "Times", "", 16
	pdf.Image "/admin/logo.jpg", 18, 20, 30, 23, "JPEG"
	pdf.SetFont "Times","", 20
	pdf.Text 50, 29, xxx
	pdf.SetFont "Times","", 8
	pdf.Text 50, 36, "CUSTODY Law Enforcement Video 3350 Riverwood Parkway S.E. Suite 1900 Atlanta, Georgia 30039"
	pdf.Text 50, 41, "PHONE  866-277-5098        FAX 770-973-1666       WEB www.custodyvideo.com"
	pdf.Line 20, 45, 180, 45
	pdf.SetXY 20, 50
	y = 55
end function

Function FormatPhoneNumber(strNumber)
	Dim strInput       ' String to hold our entered number
	Dim strTemp        ' Temporary string to hold our working text
	Dim strCurrentChar ' Var for storing each character for eval.
	Dim I	           ' Looping var
	strInput = UCase(strNumber)
	For I = 1 To Len(strInput)
		strCurrentChar = Mid(strInput, I, 1)
		If Asc("0") <= Asc(strCurrentChar) And Asc(strCurrentChar) <= Asc("9") Then
			strTemp = strTemp & strCurrentChar
		End If 
		If Asc("A") <= Asc(strCurrentChar) And Asc(strCurrentChar) <= Asc("Z") Then
			strTemp = strTemp & strCurrentChar
		End If 
	Next 'I
	strInput = strTemp
	strTemp = ""
	If Len(strInput) = 11 And Left(strInput, 1) = "1" Then
		strInput = Right(strInput, 10)
	End If
	If Not Len(strInput) = 10 Then
		FormatPhoneNumber = strInput
		exit function
	End If
	strTemp = "("                             ' "("
	strTemp = strTemp & Left(strInput, 3)     ' Area code
	strTemp = strTemp & ") "                  ' ") "
	strTemp = strTemp & Mid(strInput, 4, 3)   ' Exchange
	strTemp = strTemp & "-"                   ' "-"
	strTemp = strTemp & Right(strInput, 4)    ' 4 digit part
	FormatPhoneNumber = strTemp
End Function

function writeRow(product, unit_price, qty, desc)
	pdf.SetFont "Times", "B", 10
	pdf.Text 20, y, product
	pdf.Text 100, y, FormatCurrency(unit_price, 2)
	pdf.Text 130, y, FormatNumber(qty, 0)
	pdf.Text 160, y, FormatCurrency(unit_price * qty, 2)
	subtotal = ccur(subtotal + ccur(unit_price * qty))
	pdf.SetXY 23, y + 3
	pdf.SetFont "Times", "I", 7
	pdf.MultiCell 72, 3, desc, 0, 0, "L", 0, ""
	y = y + 24
	if y > 275 then
		WriteFooters()
		pdf.AddPage
		PageHeader("Mobile Digital Video System Proposal")
		WriteHeaders()
	end if
end function

function writeHeaders()
	pdf.SetFont "Times", "B", 10
	pdf.Text 20, y, "Product"
	pdf.Text 100, y, "Unit Price"
	pdf.Text 130, y, "Qty"
	pdf.Text 160, y, "Extended"
	pdf.Line 20, y + 2, 180, y + 2
	y = y + 8
end function

function writeFooters()
	pdf.SetFont "Times", "", 10
	pdf.Text 20, 280, "Page " & (pdf.PageNo()) & " of {nb}"
	pdf.Line 20, 277, 180, 277
end function

Set pdf=CreateJsObject("FPDF")
pdf.CreatePDF()
pdf.Open()
pdf.AddPage()
PageHeader("Mobile Digital Video System Proposal")
WriteInfo
writeHeaders()
dim x
for x = 0 to (ccur(s) - 1)
	writeRow products(x), ccur(unitprices(x)), ccur(quantities(x)), descriptions(x)
next

if y > (275 - (70 + 4 * ubound(discounts))) then
	WriteFooters()
	pdf.AddPage
	PageHeader("Mobile Digital Video System Proposal Summary")
else
end if
y = y + 4

pdf.SetFont "Times", "B", 10
pdf.Text 20, y, "Discounts"
pdf.Line 20, y + 1, 180, y + 1
y = y + 6
pdf.SetFont "Times", "", 10
d = ccur(0)
for x = 0 to dcount - 1
	pdf.Text 20, y, discounts(x)
	pdf.Text 160, y, formatCurrency(discount_amounts(x), 2)
	d = d + ccur(discount_amounts(x))
	y = y + 4
next
y = y + 8

pdf.SetFont "Times", "B", 10
pdf.Text 20, y, "Additional Charges"
pdf.Line 20, y + 1, 180, y + 1
y = y + 6
pdf.SetFont "Times", "", 10
pdf.Text 130, y, "Shipping Charges:"
pdf.Text 160, y, formatCurrency(shipping, 2)


y = y + 8
pdf.SetFont "Times", "B", 10
pdf.Text 20, y, "Summary"
pdf.Line 20, y + 1, 180, y + 1
y = y + 6
pdf.SetFont "Times", "", 10
pdf.Text 130, y, "Merchandise Total:"
pdf.Text 160, y, formatCurrency(subtotal, 2)
y = y + 4
pdf.Text 130, y, "Discount Total:"
pdf.Text 160, y, formatCurrency(d, 2)
y = y + 4
pdf.Text 130, y, "Other Charges:"
pdf.Text 160, y, formatCurrency(shipping, 2)
y = y + 8
grand_total = subtotal + shipping - d
pdf.Text 130, y, "Grand Total:"
pdf.Text 160, y, formatCurrency(grand_total, 2)
pdf.SetXY 20, y + 8
pdf.MultiCell 162, 6, "All orders require a 33% deposit upon issuance of the purchase order. Balance is due upon reciept of order. Delivery will occur within 45 days after receipt of purchase order.", 0, "L", 0
writeFooters()



pdf.AddPage()
PageHeader("Mobile Digital Video System Estimate")
WriteInfo()
y = y - 3
pdf.SetFont "Times", "B", 10
pdf.Text 20, y, "Leasing Option - First Capital Equipment Leasing Corporation"
pdf.Line 20, y + 1, 180, y + 1
y = y + 6
pdf.SetFont "Times", "", 10
pdf.Text 130, y, "24 Months:"
pdf.Text 160, y, formatCurrency(grand_total * 0.045152, 2)
y = y + 4
pdf.Text 130, y, "36 Months:"
pdf.Text 160, y, formatCurrency(grand_total * 0.030866, 2)
y = y + 4
pdf.Text 130, y, "48 Months:"
pdf.Text 160, y, formatCurrency(grand_total * 0.023702, 2)
y = y + 8
pdf.SetFont "Times", "B", 10
pdf.Text 20, y, "Leasing Benefits"
pdf.Line 20, y + 1, 180, y + 1
y = y + 9
pdf.SetY(y)

dim hdr(11)
dim txt(11)
hdr(0) = "Pay as you go and multiply current appropriations by three, four, or five times!"
txt(0) = "Annual appropriations can be disbursed today, dollar-for-dollar, or can be ""leveraged"" by three, four, or five times when the same amount is allocated to lease payments. A $25,000 budget appropriation may provide enough ""buying power"" to place $100-125,000 of new equipment in service today."
hdr(1) = "Non-Appropriation Language? No Problem!"
txt(1) = "First Capital's municipal, state and federal leasing programs have non-appropriation language built in.  In the event funds are no longer available, the equipment is returned and the lease can be terminated."
hdr(2) = "Buy More, Even With a Reduced Budget!"
txt(2) = "Leasing significantly reduces the cash needed to acquire new equipment. Governments do not have to have the full purchase price in the current budget. Only the much smaller amount needs to be in the current budget, and anticipated to be available in subsequent budgets."
hdr(3) = "Overcome Capital Budget Freezes"
txt(3) = "Equipment acquired under Frist Capital's government leases is not generally classified as a capital acquisition. Lease payments do not have to come from the capital budget. Most often, lease payments are treated as operating expenses and are charged to operating accounts and budgets."
hdr(4) = "Leases Are Faster, Less Complicated and Much Less Expensive"
txt(4) = "First Capital only requires a one page application for up to $100,000. Lease documentation is straightforward with NO complicated public filings, NO legal fees, NO voter approval and NO referendums. No opinion of counsel letter is required under $100,000. Most leases are approved in one day and finalized in a few days. Compare this to the time and expense of a bond issue, other public debt or making a grant application."
hdr(5) = "100% Financing"
txt(5) = "Leases can include many related expenses like shipping, installation, maintenance and training costs. There are no down payments or deposits with First Capital's government leases."
hdr(6) = "Flexible Payment Terms"
txt(6) = "With our cash flow friendly terms, we can invoice on your terms, the way your finance department prefers to pay... monthly, quarterly, semi-annually or annually. We can bill in advance or in arrears. Payments can even be deferred to the beginning of the next applicable budget period."
hdr(7) = "Get Everything Up Front"
txt(7) = "By making monthly lease payments, you can get the entire solution you need to meet your needs right away rather than settling for a partial solution in hopes you'll be able to add to it next budget year."
hdr(8) = "Low Monthly Payments"
txt(8) = "A monthly lease payment will usually be lower than the payment from other methods of financing. You can afford more with leasing."
hdr(9) = "Virtually Nothing Down"
txt(9) = "Where other types of financing require a hefty down payment, leasing is 100% financing. Most lease agreements require an advance of only one or two months payment. Leasing puts your First Capital solution to work immediately, at a minimal up-front cost.  Start seeing immediate return on your solution investmenr without tying up your capital."
hdr(10) = "NOTES:"
txt(10) = "Lease rates and monthly payment prices quoted are for evaluation purposes only and are subject to change, depending on customer credit criteria and/or prevailing economic conditions. Final rate and payment schedule will be provided upon request."

for x = 0 to 10
	pdf.SetX(20)
	pdf.SetFont "Times", "B", 10
	pdf.MultiCell 180, 6, hdr(x), 0, "L", 0
	pdf.SetFont "Times", "", 10
	pdf.SetX(20)
	pdf.MultiCell 162, 6, txt(x), 0, "L", 0
	pdf.ln
	if pdf.GetY() > 260 then
		WriteFooters
		pdf.AddPage
		PageHeader("Mobile Digital Video System Leasing Options")
	end if
next
pdf.SetX(20)
pdf.MultiCell 162, 4, "This lease proposal replaces all previous lease proposals.", 0, "L", 0
WriteFooters

pdf.Close()
pdf.Output()
Set pdf = nothing
%>