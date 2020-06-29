/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.bean.Publicacao;
import model.dao.GenericDAO;

/**
 *
 * @author paulo
 */
public class ExcluirPublicacaoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Publicacao p = new Publicacao();
        GenericDAO<Publicacao> gp = new GenericDAO<>();
        System.out.println("iddddd" + request.getParameter("idEx"));
        p = gp.findById2(Publicacao.class, Long.parseLong(request.getParameter("idEx")));
        gp.remove(p);
        response.sendRedirect("../smart_script/principal/perfil.jsp?status=apagado");
    }
}
