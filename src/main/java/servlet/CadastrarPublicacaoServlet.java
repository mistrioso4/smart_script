/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
public class CadastrarPublicacaoServlet extends HttpServlet {

    private String entradaFormat;
    private String saidaFormat;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Editavel editavel = new Editavel();
        String categoria = null;
        String preco = null;
        String comentario = null;
        String value = null;
        String nome_arquivo = null;
        String endereco = null;
        String cidade = null;
        String estado = null;

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

                    if (!item.isFormField()) {
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
                        if (name.equals("categoria")) {
                            categoria = value;
                        }

                        if (name.equals("preco")) {
                            preco = value;
                        }

                        if (name.equals("estados")) {
                            estado = value;
                        }
                        
                        if (name.equals("cidades")) {
                            cidade = value;
                        }
                        
                        if (name.equals("endereco")) {
                            endereco = value;
                        }

                        if (name.equals("comentario")) {
                            comentario = value;
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

        //data
        LocalDateTime agora = LocalDateTime.now();
        DateTimeFormatter formatterData = DateTimeFormatter.ofPattern("dd/MM/uuuu");
        String dataFormatada = formatterData.format(agora);

        //publicacao
        Publicacao p = new Publicacao();
        Usuario userLogado = (Usuario) request.getSession().getAttribute("usuario");

        p.setCategoria(categoria);
        p.setComentario(comentario.getBytes());
        p.setPreco(Float.parseFloat(preco));
        p.setIdUsuario("" + userLogado.getId());
        p.setEndereco(endereco);
        p.setCidade(cidade);
        p.setEstado(estado);
        p.setData(dataFormatada);
        p.setNomeArquivo(nome_arquivo);

        GenericDAO<Publicacao> gp = new GenericDAO<>();
        gp.saveOrUpdate(p);
        //imagem
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

        response.sendRedirect("../smart_script/principal/perfil.jsp?status=salvo");
    }
}
