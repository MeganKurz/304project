<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Kyla Reid and Megan Kurz Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection

// Write query to retrieve all order headers

// For each order in the ResultSet

	// Print out the order header information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>
<%@ page import="java.sql.*" %> 
<% Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
Connection con = null; 
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;"; 
String uid = "kreid";
String pw = "39265137"; 
try { 
	con = DriverManager.getConnection(url, uid, pw); 
String SQL = "select orderId, c.customerId, cname, totalAmount from Orders o, Customer c where o.customerId=c.customerId";
PreparedStatement pstmt = con.prepareStatement(SQL); 
ResultSet rst = pstmt.executeQuery();
out.println("<table><tr><td>Order Id</td><td>Customer Id</td><td>Customer Name</td><td>Total Amount</td></tr>");
String oid = null;
while (rst.next()) { 
	oid=rst.getString(1);
	out.println("<tr><td>"+rst.getString(1)+"</td><td>"+rst.getString(2)+"</td><td>"+rst.getString(3)+"</td><td>"+rst.getString(4)+"</td></tr>"); 
out.println("<tr align='right'><td colspan='4'><table><tr><td>Product Id</td><td>Quantity</td><td>Price</td></tr>");
String SQL2 = "select productId, quantity, price from OrderedProduct where orderId=?";
PreparedStatement pstmt2 = con.prepareStatement(SQL2); 
pstmt2.setString(1, oid);
ResultSet rst2 = pstmt2.executeQuery();
while(rst2.next()){
	out.println("<tr><td>"+rst2.getString(1)+"</td><td>"+rst2.getString(2)+"</td><td>"+rst2.getString(3)+"</td></tr>");
}out.println("</table></td></tr>");
}out.println("</table>");
}
catch (SQLException ex) { out.println(ex); } 
finally { 
	if (con != null) 
		try { con.close(); } 
	catch (SQLException ex) { System.err.println("SQLException: " + ex); } } %> 

</body>
</html>

