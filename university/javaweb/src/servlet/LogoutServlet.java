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
 * Servlet implementation class LogoutServlet
 */
/**
 * @author preetham
 *
 */
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogoutServlet() {
        super();
        System.out.println("Logout servlet constructor called");
    }

    /**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		System.out.println("LogoutServlet \"Init\" method called");
	}

	/**
	 * @see Servlet#destroy()
	 */
	public void destroy() {
		System.out.println("LogoutServlet \"Destroy\" method called");
	}


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("LogoutServlet doGet called");
		HttpSession session = request.getSession(false);
		PrintWriter out = response.getWriter();
		out.write("<html><body><h4>Check console to understand the flow</h4></body></html>");
		if(session!=null)
		{
			//invalidates the session
			session.invalidate();
			System.out.println("Session is invalidated/logged out");
			out.write("<html><body><h1>Session is invalidated/logged out</h1></body></html>");
			
			
		}
		else{
			out.write("<html><body><h1>Session not present</h1></body></html>");
		}
		out.write("<html><body></body></html>");
	}


}
