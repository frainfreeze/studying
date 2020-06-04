package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.Servlet;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class SessionServlet
 */
/**
 * @author preetham
 *
 */
public class TestSessionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TestSessionServlet() {
        super();
        System.out.println("TestSessionServlet constructor called");
    }

    /**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		System.out.println("TestSessionServlet \"Init\" method called");
	}

	/**
	 * @see Servlet#destroy()
	 */
	public void destroy() {
		System.out.println("TestSessionServlet \"Destroy\" method called");
	}


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("TestSessionServlet doGet method called");
		//Get the exisiting session, if session doesn't exist it will return null
		HttpSession session = request.getSession(false);
		PrintWriter out = response.getWriter();
		if(session!=null)
		{
			//get the attributes from session
			String uname=(String) session.getAttribute("uname");
			String emailId=(String) session.getAttribute("emailId");
			System.out.println("Username and email id is retrived from the session");
			out.write("<html><body><h1>Username in session is "+uname +" and email id is "+ emailId +"</h1></body></html>");
			
		}
		else{
			//session not present(session=null)
			out.write("<html><body><h1>Session not present</h1></body></html>");
		}
		out.write("<html><body></body></html>");
	}

}
