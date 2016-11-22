/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.72
 * Generated at: 2016-11-22 01:28:12 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.ArrayList;
import java.text.NumberFormat;
import java.util.Map;

public final class showcart_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<title>Your Shopping Cart</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\t<script>\r\n");
      out.write("\t\tfunction update(newid, newqty) {\r\n");
      out.write("\t\t\twindow.location.href = \"showcart.jsp?update=\"+newid+\"&newqty=\"+newqty;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t</script>\r\n");
      out.write("\t<form name=\"listcart\"> \r\n");
      out.write("\t");

		// Get the current list of products
		@SuppressWarnings({"unchecked"})
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
		ArrayList<Object> product = new ArrayList<Object>();
		String del = request.getParameter("delete");
		String update = request.getParameter("update");
		String newqty = request.getParameter("newqty");
			if (productList == null){
		out.println("<H1>Your shopping cart is empty!</H1>");
		productList = new HashMap<String, ArrayList<Object>>();
		}
			else{
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			
			if(update != null && (!update.equals(""))) {
				if (productList.containsKey(update)) { 
				product = (ArrayList<Object>) productList.get(update);
				product.set(3, (new Integer(newqty))); 
				}else {
					productList.put(update,product); 
				}
			}
			if(del != null && (!del.equals(""))){
				if(productList.containsKey(del)){ 
				productList.remove(del); 
				}
			}
			
			out.println("<h1>Your Shopping Cart</h1>");
			out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
			out.println("<th>Price</th><th>Subtotal</th><td></td><td></td></tr>");

			double total =0;
			
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext()) {
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		product = (ArrayList<Object>) entry.getValue();
		String pid = (String)product.get(0);
		
		out.print("<tr><td>"+pid+"</td>");
		out.print("<td>"+product.get(1)+"</td>");
		out.print("<td><input type=\"text\" name=\"newqty"+pid+"\" size = \"3\" value = \""+product.get(3)+"\"></td>");
		double pr = Double.parseDouble( (String) product.get(2));
		int qty = ( (Integer)product.get(3)).intValue();

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td>");
		out.println("<td><a href=\"showcart.jsp?delete="+pid+"\">Remove from item cart</a>");
		out.println("<td><input type=BUTTON OnClick=\"update("+pid+", document.listcart.newqty"+pid+".value)\" value= \"Update Quantity\"></td>");
		out.println("</tr>");
		total = total +pr*qty;
			
		}
			out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
			out.println("</table>");

			out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
		}
	
      out.write("\r\n");
      out.write("\t<h2>\r\n");
      out.write("\t\t<a href=\"listprod.jsp\">Continue Shopping</a>\r\n");
      out.write("\t</h2>\r\n");
      out.write("\t</form>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
      out.write("\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
