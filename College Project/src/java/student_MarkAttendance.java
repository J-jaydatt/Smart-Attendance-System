import db.database_Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.io.InputStream;
import java.sql.SQLException;


@WebServlet("/markAttendance")
@MultipartConfig(maxFileSize = 1600000) 
public class student_MarkAttendance extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        int id=Integer.parseInt(request.getParameter("stuID"));
        Connection connection = null;

      try {
            connection = database_Connection.getConnection();

             String query = "update student set requested=1 where sId=? ";
            
             PreparedStatement stmt = connection.prepareStatement(query);
             stmt.setInt(1, id);
             
              int row = stmt.executeUpdate();
              
                  if (row>0) 
                  {
                       response.sendRedirect("student_Index.jsp");
                  }
                  else
                  {
                       response.sendRedirect("student_Index.jsp");
                  }
               
            
       } 
      catch (IOException | SQLException e) 
       {
           System.out.print("<h1>"+e+"</h1>");
        } 
      
        
    }
}
