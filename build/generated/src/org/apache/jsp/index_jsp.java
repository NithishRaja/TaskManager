package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <link rel=\"stylesheet\" \n");
      out.write("              href=\"./static/css/bootstrap.css\"/>\n");
      out.write("        <title>Login</title>\n");
      out.write("    </head>\n");
      out.write("    ");

        int flag=1;
        if(request.getParameter("submit")!=null){
            System.out.println(request.getParameter("email"));
        }else{
            flag=0;
        }
    
      out.write("\n");
      out.write("    <body class=\"container\">\n");
      out.write("        <section>\n");
      out.write("            <form method=\"POST\" action=\"index.jsp\">\n");
      out.write("                <div class=\"form-group row\">\n");
      out.write("                    <label for=\"email\" class=\"col-form-label\">Email: </label>\n");
      out.write("                    <div class=\"col-md-10\">\n");
      out.write("                        <input type=\"email\" class=\"form-control\" id=\"email\" name=\"email\" placeholder=\"enter email here\" />    \n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"form-group row\">\n");
      out.write("                    <label for=\"password\" class=\"col-form-label\">Password: </label>\n");
      out.write("                    <div class=\"col-md-10\">\n");
      out.write("                        <input type=\"password\" class=\"form-control\" id=\"password\" name=\"password\" placeholder=\"enter password here\"/>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                <input type=\"submit\" name=\"submit\" class=\"btn btn-primary\" value=\"Login\"/>\n");
      out.write("            </form>\n");
      out.write("            ");

                if(flag==0){
            
      out.write("\n");
      out.write("            <div class=\"alert alert-warning\" role=\"alert\">iyviviui</div>    \n");
      out.write("            ");

                }
            
      out.write("\n");
      out.write("        </section>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
