/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.bean.Usuario;
import model.dao.GenericDAO;

/**
 *
 * @author paulo
 */
public class CadastrarUsuarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doPost(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getParameter("senha").equals(request.getParameter("confirmar_senha"))) {
            Usuario user = new Usuario();
            GenericDAO<Usuario> dao = new GenericDAO<>();
            //data
            LocalDateTime agora = LocalDateTime.now();
            DateTimeFormatter formatterData = DateTimeFormatter.ofPattern("dd/MM/uuuu");
            String dataFormatada = formatterData.format(agora);

            user.setNome(request.getParameter("nome"));
            user.setEmail((request.getParameter("email")));
            user.setNome(request.getParameter("nome"));
            user.setSobrenome(request.getParameter("sobrenome"));
            user.setSenha(request.getParameter("senha"));
            user.setDataEntrada(dataFormatada);

            dao.saveOrUpdate(user);

//        request.getSession().setAttribute("usuario", pedagoga);
//        response.sendRedirect("../registros_pedagogicos/jsp/index.jsp");
            response.sendRedirect("../smart_script/index.jsp");

        } else {
            response.sendRedirect("../smart_script/cadastro.jsp?status=erro");
        }
    }
}
