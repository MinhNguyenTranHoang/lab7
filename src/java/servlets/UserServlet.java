package servlets;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Role;
import models.User;
import services.RoleService;
import services.UserService;

/**
 *
 * @author MINH
 */
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        UserService us = new UserService();
        RoleService rs = new RoleService();
        
        try {
            String action = request.getParameter("action");
            
            if (action != null && action.equals("delete")) {
                String email = request.getParameter("email");
                us.delete(email);
            } 
            
            else if (action != null && action.equals("edit")) {
                String email = request.getParameter("email");
                User user = us.get(email);
                request.setAttribute("edit_email", user.getEmail());
                request.setAttribute("edit_active", user.getActive());
                request.setAttribute("edit_first_name", user.getFirst_name());
                request.setAttribute("edit_last_name", user.getLast_name());
                request.setAttribute("edit_password", user.getPassword());
                request.setAttribute("edit_roles", user.getRole());
            }
            
            List<User> users = us.getAll();
            request.setAttribute("userList", users);
            
            List<Role> roles = rs.getAll();
            request.setAttribute("roleList", roles);
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        getServletContext().getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        UserService us = new UserService();
        RoleService rs = new RoleService();

        try {
            String action = request.getParameter("action");
            
            if (request.getParameter("add_email") != null && !request.getParameter("add_email").equals("") && action.equals("add")) {
                String email = request.getParameter("add_email");
                boolean active = Boolean.parseBoolean(request.getParameter("add_active"));
                String firstName = request.getParameter("add_first_name");
                String lastName = request.getParameter("add_last_name");
                String password = request.getParameter("add_password");
                int roleId = Integer.parseInt(request.getParameter("add_roles"));

                us.insert(email, active, firstName, lastName, password, roleId);

            }
            
            else if (action.equals("edit")) {
                String email = request.getParameter("edit_email");
                boolean active = Boolean.parseBoolean(request.getParameter("edit_active"));
                String firstName = request.getParameter("edit_first_name");
                String lastName = request.getParameter("edit_last_name");
                String password = request.getParameter("edit_password");
                int roleId = Integer.parseInt(request.getParameter("edit_roles"));
                
                us.update(email, active, firstName, lastName, password, roleId);
               
            }
            
            List<User> users = us.getAll();
            request.setAttribute("userList", users);

            List<Role> roles = rs.getAll();
            request.setAttribute("roleList", roles);
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        getServletContext().getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
    }
}
