import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/Logout")
public class Logout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            session.invalidate();
        }

        String redirectURL = "YouAreLogOut.jsp";

        if (request.getParameter("stuLogin") != null) {
            redirectURL += "?logoutId=student";
        } else if (request.getParameter("Log") != null) {
            redirectURL += "?logoutId=hod";
        } else if (request.getParameter("Tea") != null) {
            redirectURL += "?logoutId=teacher";
        } else {
            System.out.println("No ID Found");
            return; // Stop execution if no valid parameter is found
        }

        response.sendRedirect(redirectURL);
    }
}
