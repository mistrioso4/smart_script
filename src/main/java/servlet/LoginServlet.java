package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.bean.Usuario;
import model.dao.GenericDAO;
import model.dao.UsuarioDAO;

/**
 *
 * @author eddunic
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().setAttribute("usuario", null);
        response.sendRedirect("/smart_script/index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        UsuarioDAO userDao = new UsuarioDAO();

        Long idUser = userDao.login(email, senha);

        Usuario user;

        if (idUser == null) {
            response.sendRedirect("/smart_script/index.jsp?status=erro");
        } else if (idUser == -1) {
            response.sendRedirect("/smart_script/index.jsp?status=erro");
        } else {
            try {
                GenericDAO<Usuario> userDao2 = new GenericDAO<>();
                user = userDao2.findById(Usuario.class, idUser);
                if (user != null) {
                    request.getSession().setAttribute("usuario", user);
                    response.sendRedirect("/smart_script/principal/index.jsp");
                } else {
                    response.sendRedirect("/smart_script/index.jsp?status=erro");
                }
            } catch (IOException e) {
                out.println("ERRO " + e.getMessage());
            }

        }
    }

}
