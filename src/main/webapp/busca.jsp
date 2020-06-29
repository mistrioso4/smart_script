<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="model.bean.Usuario"%>
<%@page import="model.dao.GenericDAO"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="model.bean.Publicacao"%>
<%@page import="model.dao.PublicacaoDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Smart Script</title>
        <meta charset="utf-8"> 
        <link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="sortcut icon" href="img/logo.png" type="image/x-icon" />
        <script src="js/jquery-3.4.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/fontawesome.js"></script>
        <script>
            $(document).ready(function () {
                $("#myInput").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $("#myTable tr").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
            });
        </script>
    </head>
    <body class="body-background">
        <nav class="navbar navbar-expand-lg navbar-light bg-system mb-5">  
            <a class="navbar-brand text-white" href="index.jsp">  
                <img src="img/logo.png" width="37" height="37">
                <b>Smart Script</b>
            </a>

            <a href="" class="navbar-toggler text-white border-white" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
                <i class="fa fa-bars fa-lg"></i>
            </a>
            <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
                <ul class="navbar-nav mr-auto">
                </ul>
                <a class="nav-link text-white" href="cadastro.jsp"><i class="fas fa-user-plus"></i> Cadastrar-se</a>
            </div>
        </nav>
        <div class="container">
            <div class="row">
                <div class="col-lg-11 mx-auto  bg-white px-3 py-3 rounded  shadow border">
                    <h4 class="mb-3">Resultado:</h4>
                    <div class="px-4 py-3">
                        <div class="form-row">
                            <%
                                PublicacaoDAO pDAO1 = new PublicacaoDAO();
                                List<Publicacao> lista1 = pDAO1.buscar(request.getParameter("estados"), request.getParameter("cidades"), request.getParameter("data"));
                                Collections.reverse(lista1);
                                for (Publicacao p : lista1) {
                                    GenericDAO dDono = new GenericDAO();
                                    Usuario dono = (Usuario) dDono.findById(Usuario.class, Long.parseLong(p.getIdUsuario()));
                            %>
                            <div class="col-auto mx-auto mb-3">
                                <div class="card shadow mx-auto mb-2 card-width">
                                    <div class="text-center">
                                        <img src="upload/<%= p.getNomeArquivo()%>" class="card-img" alt="..." style="width: 100%; max-height: 195px; object-fit: cover; object-position: top;">
                                    </div>
                                    <div class="card-body">
                                        <div class="text-center">
                                            <a>
                                                <img src="upload/<%= dono.getDiretorioFoto()%>" class="img-perfil-mini border" alt="" title=""><br>
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
                                                <a class="text-dark">
                                                    <img src="upload/<%= dono.getDiretorioFoto()%>" class="img-perfil-mini border" alt="" title="">
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
                                if (lista1.size() == 0) {
                            %>
                            <div class="col-md-12 text-center mt-3">
                                <i class="fa fa-ban fa-4x"></i> <br>
                                <h4>Nenhum roteiro foi encontrado</h4>
                            </div>
                            <% }%>
                        </div>
                    </div>
                    <h4 class="mb-3">Pesquisar por outros roteiros</h4>
                    <input class="form-control" id="myInput" type="text" placeholder="Pesquisar..">
                    <table class="table table-bordered mt-3">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Local</th>
                                <th scope="col">Categoria</th>
                                <th scope="col">Data</th>
                                <th scope="col">Opções</th>
                            </tr>
                        </thead>
                        <tbody id="myTable">
                            <%
                                int i = 0;
                                PublicacaoDAO pDAO = new PublicacaoDAO();
                                List<Publicacao> lista = pDAO.getTodasPublicacoes("-1");
                                Collections.reverse(lista);
                                for (Publicacao p : lista) {
                                    GenericDAO dDono = new GenericDAO();
                                    Usuario dono = (Usuario) dDono.findById(Usuario.class, Long.parseLong(p.getIdUsuario()));
                                    i++;
                            %>
                            <tr>
                                <th scope="row"><%= i%></th>
                                <td><%= p.getEstado() %>, <%= p.getCidade()%>, <%= p.getEndereco()%></td>
                                <td><%= p.getCategoria()%></td>
                                <td><%= p.getData()%></td>
                                <td><a href="" data-toggle="modal" data-target="#modal<%= p.getId()%>">Ver tudo</a></td>
                            </tr>
                            <!--modal ver publicacao-->
                        <div class="modal fade" id="modal<%= p.getId()%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLongTitle">
                                            <a class="text-dark">
                                                <img src="upload/<%= dono.getDiretorioFoto()%>" class="img-perfil-mini border" alt="" title="">
                                                <b><%= dono.getNome()%> <%= dono.getSobrenome()%></b>  
                                            </a>
                                        </h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <p class="text-justify"> <%=IOUtils.toString(p.getComentario(), "ISO-8859-1")%></p>
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
                                    <div class="modal-footer">
                                        <a class="btn btn-outline-secondary" class="close" data-dismiss="modal" aria-label="Close" >Fechar</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>