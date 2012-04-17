package ninacrm;

import java.io.IOException;
import java.net.URL;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Accepts post of link data in URL encoded form
 */
@SuppressWarnings("serial")
public class DataServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		
		String linkurl = request.getParameter("linkurl");
		String linkname = request.getParameter("linkname");
        if (linkurl == null || linkname == null) {
        	response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        	return;
        }
        
		@SuppressWarnings("unchecked")
		Map<URL, String> data = (Map<URL, String>)request.getAttribute("data");
		data.put(new URL(linkurl), linkname); 
	}
}
