<%-- 
    Document   : perfil
    Created on : 22/06/2020, 18:51:34
    Author     : paulo
--%>

<%@page import="java.util.Collections"%>
<%@page import="model.dao.GenericDAO"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="model.bean.Usuario"%>
<%@page import="model.bean.Publicacao"%>
<%@page import="java.util.List"%>
<%@page import="model.dao.PublicacaoDAO"%>
<!DOCTYPE html>
<html>
    <head>

        <title>Perfil</title>
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/bootstrap/bootstrap-file-upload.css">
        <link rel="sortcut icon" href="../img/logo.png" type="image/x-icon" />
        <script src="../js/jquery-3.4.1.min.js"></script>
        <script src="../js/popper.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/fontawesome.js"></script>
        <script src="../js/bootstrap-file-upload.js"></script>
    </head>
    <body>
        <jsp:include page="header.jsp"/>  
        <%
            String id = (String) request.getParameter("id");
            GenericDAO dDono = new GenericDAO();
            Usuario user = (Usuario) dDono.findById(Usuario.class, Long.parseLong(id));
        %>
        <div class="profile-block">
            <div class="bg-system">
                <%
                    Usuario userLogado = (Usuario) request.getSession().getAttribute("usuario");
                    if (user.getDiretorioWallpaper() != null) {%>
                <img src="../upload/<%=user.getDiretorioWallpaper()%>" class="profile-block-thumb w-100">
                <% } else {%>
                <img src="../img/fundo.jpg" class="profile-block-thumb w-100">
                <% } %>  
            </div>
            <div class="profile-img">
                <a href="#">
                    <%
                        if (user.getDiretorioFoto() != null) { %>
                    <img src="../upload/<%=user.getDiretorioFoto() %>" width="162" height="162" class="img-perfil border" alt="" title=""> 
                    <% } else {%>
                    <img src="../img/perfil.webp" width="162" height="162" class="bg-white rounded-circle border  shadow" alt="" title="">  
                    <% }%>      
                </a>
            </div>
        </div>
        <div class="mt-5 text-center">
            <a>
                <h2><%=user.getNome()%> <%=user.getSobrenome()%></h2>
                <h6><%=user.getBio()%></h6>
            </a>  
        </div>
        <div class="container">
            <div class="form-row mt-3 ">
                <div class="col-lg-3 mx-auto mr-2 mb-3">
                    <div class="bg-white px-3 py-3 rounded shadow border">
                        <h4>Dados pessoais</h4>
                        <div class="px-2">
                            <h6><i class="fa fa-calendar"></i> Entrou em <%=user.getDataEntrada()%></h6>
                            <h6><i class="fa fa-map-marker-alt"></i> <%=user.getEndereco()%></h6>
                            <h6><i class="fa fa-birthday-cake"></i> <%=user.getDataAniversario()%></h6>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8 mx-auto  bg-white px-3 py-3 rounded shadow border">
                    <div class="form-row mb-3   ">
                        <div class="col-md-6">
                            <h4>Publicações</h4>
                        </div>
                    </div>

                    <%
                        PublicacaoDAO pDAO = new PublicacaoDAO();
                        List<Publicacao> lista = pDAO.getMinhasPublicacoes("" + user.getId());
                        Collections.reverse(lista);
                        for (Publicacao p : lista) {
                    %>
                    <div class="card mx-auto mb-4">
                        <div class="card-header">
                            <div class="row">
                                <div class="col-md-9">
                                    <a>
                                        <img src="../upload/<%= user.getDiretorioFoto() %>" class="img-perfil-mini border" alt="" title="">
                                        <b><%= user.getNome() %> <%= user.getSobrenome() %></b>  
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <p class="card-text text-justify"> <%=IOUtils.toString(p.getComentario())%></p>
                            <div class="form-row">
                                <div class="col-md-4">
                                    <a><i class="fa fa-calendar"></i> <%= p.getData()%></a>
                                </div>
                                <div class="col-md-4 text-center">
                                    <a class="d-inline-block text-truncate w-100"><i class="fa fa-map-marker-alt"></i> <%= p.getEndereco()%></a>
                                </div>
                                <div class="col-md-4">
                                    <a class="float-right"><b>R$</b> <%= p.getPreco()%></a>
                                </div>
                            </div>
                            <div class="text-center">
                                <img  style="width: 100%; max-height: 400px; object-fit: cover; object-position: top;" src="../upload/<%= p.getNomeArquivo()%>" alt="Não foi possível carregar a imagem, atualize a página e tente novamente.">
                            </div>
                        </div>
                    </div>
                    <% }
                        if (lista.size() == 0) {
                    %>
                    <div class="col-md-12 text-center mt-3">
                        <i class="fa fa-ban fa-4x"></i> <br>
                        <h4>Nenhuma publicação foi cadastrada</h4>
                    </div>
                    <% }%>

                    <!--primeira vez fazendo login-->
                    <% if (userLogado.getBio() == null) { %>
                    <script>
                        $(document).ready(function () {
                            $("#ModalPrimeiraVez").modal("show");
                        });
                    </script>
                    <%}%>
                </div>
            </div>
        </div>
        <jsp:include page="../footer.jsp"/>  
    </body>
</html>