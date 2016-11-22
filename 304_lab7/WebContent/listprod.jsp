<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Kyla Reid and Megan Kurz Grocery</title>
</head>
<body>

	<h1>Search for the products you want to buy:</h1>

	<form method="get" action="listprod.jsp">
		<input type="text" name="productName" size="50"> <input
			type="submit" value="Submit"><input type="reset"
			value="Reset"> (Leave blank for all products)
	</form>

	<%@ page import="java.sql.*"%>
	<%
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection con = null;
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
		String uid = "kreid";
		String pw = "39265137";
		String name = request.getParameter("productName");

		try {
			con = DriverManager.getConnection(url, uid, pw);
			boolean hasName = (name != null && !name.equals(""));
			if (hasName) {
				out.println("<h2>Products containing '" + name + "'</h2>");
				out.println("<table> <tr><td></td><td><h3>Product Name</h3></td><td><h3>Price</h3></td></tr>");
				String SQL = "select productName, price, productId from Product where productName like ? Order by productName";
				PreparedStatement pstmt = con.prepareStatement(SQL);
				pstmt.setString(1, "%" + name + "%");
				ResultSet rst = pstmt.executeQuery();
				while (rst.next()) {
					out.println("<tr><td><a href=\"addcart.jsp?id=" + rst.getString(3) + "&name=" + rst.getString(1)
							+ "&price=" + rst.getString(2) + "\">Add to cart</a>" + "</td><td>" + rst.getString(1)
							+ "</td><td>" + rst.getString(2) + "</td></tr>");
				}
				out.println("</table>");
			} else {
				out.println("<h2>All Products</h2>");
				out.println("<table> <tr><td></td><td><h3>Product Name</h3></td><td><h3>Price</h3></td></tr>");
				String SQL = "select productName, price, productId from Product Order by productName";
				PreparedStatement pstmt = con.prepareStatement(SQL);
				ResultSet rst = pstmt.executeQuery();
				while (rst.next()) {
					out.println("<tr><td><a href=\"addcart.jsp?id=" + rst.getInt(3) + "&name=" + rst.getString(1)
							+ "&price=" + rst.getString(2) + " \">Add to cart</a>" + "</td><td>" + rst.getString(1)
							+ "</td><td>" + rst.getString(2) + "</td></tr>");
				}
				out.println("</table>");
			}
		} catch (SQLException ex) {
			out.println(ex);
		} finally {
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
					System.err.println("SQLException: " + ex);
				}
		}
	%>
</body>
</html>