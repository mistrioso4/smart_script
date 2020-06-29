<%-- 
    Document   : index
    Created on : 22/06/2020, 17:15:22
    Author     : paulo
--%>

<%@page import="model.dao.GenericDAO"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="java.util.Collections"%>
<%@page import="model.bean.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="model.bean.Publicacao"%>
<%@page import="model.dao.PublicacaoDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Smart Script</title>
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="../css/style.css">
        <link rel="sortcut icon" href="../img/logo.png" type="image/x-icon" />
        <script src="../js/jquery-3.4.1.min.js"></script>
        <script src="../js/popper.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/fontawesome.js"></script> 
    </head>
    <body class="body-background-2">
        <div id="loading" style="display: block">
            <div  class="loader"></div>
        </div>
        <div id="conteudo" style="display: none">
            <jsp:include page="header.jsp"/>  
            <div class="block">
                <img src="../img/principal.png" class="fundo-principal w-100">
                <div class="search text-white">
                    <h3><b>O que você está procurando?</b></h3>
                    <a href="busca.jsp" class="stretched-link" style="text-decoration: none">
                        <div class="input-group shadow">
                            <input type="text" class="form-control" placeholder="Digite aqui para pesquisar" aria-label="Recipient's username" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button class="btn btn-light border-dark border-right-0 border-top-0 border-bottom-0" type="button"><i class="fa fa-search"></i> Pesquisar</button>
                            </div>
                        </div> 
                    </a>
                </div>
            </div>

            <div class="container">
                <div class="px-4 py-3">
                    <div class="form-row">
                        <%
                            Usuario userLogado = (Usuario) request.getSession().getAttribute("usuario");
                            PublicacaoDAO pDAO = new PublicacaoDAO();
                            List<Publicacao> lista = pDAO.getTodasPublicacoes("" + userLogado.getId());
                            Collections.reverse(lista);
                            for (Publicacao p : lista) {
                                GenericDAO dDono = new GenericDAO();
                                Usuario dono = (Usuario) dDono.findById(Usuario.class, Long.parseLong(p.getIdUsuario()));
                        %>
                        <div class="col-auto mx-auto mb-3">
                            <div class="card shadow mx-auto mb-2 card-width">
                                <div class="text-center">
                                    <img src="../upload/<%= p.getNomeArquivo()%>" class="card-img" alt="..." style="width: 100%; max-height: 195px; object-fit: cover; object-position: top;">
                                </div>
                                <div class="card-body">
                                    <div class="text-center">
                                        <a class="text-dark" href="verPerfil.jsp?id=<%= p.getIdUsuario()%>">
                                            <img src="../upload/<%= dono.getDiretorioFoto()%>" class="img-perfil-mini border" alt="" title=""><br>
                                            <b><%= dono.getNome()%> <%= dono.getSobrenome()%></b>  
                                        </a>
                                    </div>
                                    <p class="card-text text-justify comentario"><i class="fa fa-comment-alt text-system"></i> <%=IOUtils.toString(p.getComentario())%></p>
                                </div>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item border-top"><i class="fa fa-flag text-system"></i> <%= p.getEstado()%></li>
                                    <li class="list-group-item"><i class="fa fa-city text-system"></i> <%= p.getCidade()%></li>
                                    <li class="list-group-item"><i class="fa fa-map-marker-alt text-system"></i> <%= p.getEndereco()%></li>
                                </ul>
                                <div class="card-body text-center">
                                    <a href="#" class="btn  text-white bg-system" data-toggle="modal" data-target="#modal<%= p.getId()%>">Ver roteiro <i class="fas fa-angle-double-right"></i></a>
                                </div>
                            </div>
                        </div>

                        <!--Modal ver publicacao-->
                        <div class="modal fade" id="modal<%= p.getId()%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLongTitle">
                                            <a class="text-dark" href="verPerfil.jsp?id=<%= p.getIdUsuario()%>">
                                                <img src="../upload/<%= dono.getDiretorioFoto()%>" class="img-perfil-mini border" alt="" title="">
                                                <b><%= dono.getNome()%> <%= dono.getSobrenome()%></b>  
                                            </a>
                                        </h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <p class="text-justify"> <%=IOUtils.toString(p.getComentario())%></p>
                                        <div class="form-row">
                                            <div class="col-md-4">
                                                <a><i class="fa fa-calendar"></i> <%= p.getData()%></a>
                                            </div>
                                            <div class="col-md-4 text-center">
                                                <a class="d-inline-block text-truncate w-100"><i class="fa fa-map-marker-alt"></i> <%= p.getEstado()%>, <%= p.getCidade()%>, <%= p.getEndereco()%></a>
                                            </div>
                                            <div class="col-md-4">
                                                <a class="float-right"><b>R$</b> <%= p.getPreco()%></a>
                                            </div>
                                        </div>
                                        <div class="text-center">
                                            <img  style="width: 100%; max-height: 400px; object-fit: cover; object-position: top;" src="../upload/<%= p.getNomeArquivo()%>" alt="Não foi possível carregar a imagem, atualize a página e tente novamente.">
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <a class="btn btn-outline-secondary" class="close" data-dismiss="modal" aria-label="Close" >Fechar</a>
                                    </div>
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
                    </div>
                </div>
            </div>
            <jsp:include page="../footer.jsp"/>  
        </div>
        <script>
            var i = setInterval(function () {

                clearInterval(i);

                // O código desejado é apenas isto:
                document.getElementById("loading").style.display = "none";
                document.getElementById("conteudo").style.display = "inline";

            }, 1800);
        </script>
    </body>
</html>
