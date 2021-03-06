/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.bean.Publicacao;
import model.bean.Usuario;
import model.dao.GenericDAO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import util.Editavel;

/**
 *
 * @author paulo
 */
public class EditarPerfilServlet extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        Editavel editavel = new Editavel();
        String nome = null;
        String sobrenome = null;
        String aniversario = null;
        String endereco = null;
        String biografia = null;
        String nome_arquivo = null;
        String value = null;

        //Read archive
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);

        File uploadedFile = null;
        File imagem = null;

        if (isMultipart) {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);

            try {
                List items = upload.parseRequest(request);
                Iterator iterator = items.iterator();
                while (iterator.hasNext()) {
                    FileItem item = (FileItem) iterator.next();
                    if (!item.isFormField() && !item.getName().equals("null") && item.getName() != null && !item.getName().equals("")) {
                        String fileName = item.getName();
                        nome_arquivo = fileName;
                        File path = new File(editavel.getDiretorio());
                        if (!path.exists()) {
                            boolean status = path.mkdirs();
                        }
                        String name = item.getFieldName();
                        if (name.equals("imagem")) {
                            imagem = new File(path + "/" + fileName);
                            System.out.println(imagem.getAbsolutePath());
                            item.write(imagem);
                        } else {
                            uploadedFile = new File(path + "/" + fileName);
                            System.out.println(uploadedFile.getAbsolutePath());
                            item.write(uploadedFile);
                        }
                    } else {
                        String name = item.getFieldName();
                        value = item.getString();
                        if (name.equals("nome")) {
                            nome = value;
                        }

                        if (name.equals("sobrenome")) {
                            sobrenome = value;
                        }

                        if (name.equals("aniversario")) {
                            aniversario = value;
                        }

                        if (name.equals("endereco")) {
                            endereco = value;
                        }
                        if (name.equals("bio")) {
                            biografia = value;
                        }
                        // **************************************************
                        // Process your name and value pairs here! *****
                        // **************************************************
                        System.out.println("Found field " + name + " and value " + value);
                    }
                }
            } catch (FileUploadException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        //publicacao
        GenericDAO<Usuario> gu = new GenericDAO<>();
        Usuario userLogado = (Usuario) request.getSession().getAttribute("usuario");

        userLogado.setNome(nome);
        userLogado.setSobrenome(sobrenome);
        userLogado.setBio(biografia);
        userLogado.setDataAniversario(aniversario);
        userLogado.setEndereco(endereco);
        
        if (nome_arquivo != null) {
            System.out.println("entrouuuu");
            userLogado.setDiretorioFoto(nome_arquivo);
        }else{
            userLogado.setDiretorioFoto(userLogado.getDiretorioFoto());
        }

        gu.saveOrUpdate(userLogado);
        //imagem
        if (nome_arquivo != null) {
            byte[] fileContent = FileUtils.readFileToByteArray(new File(imagem.getAbsolutePath()));
            String encodedString = Base64.getEncoder().encodeToString(fileContent);

            String ext[] = imagem.getAbsolutePath().split("\\.");
            int i = ext.length;
            String extensao = null;
            if (i > 1) {
                extensao = ext[i - 1];
            }

            String img = "data:image/" + extensao + ";base64," + encodedString;

            System.out.println(img);
        }

        response.sendRedirect("../smart_script/principal/perfil.jsp?status=alterado");
    }

}
