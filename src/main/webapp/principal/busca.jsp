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
        <meta charset="utf-8">
        <title>Smart Script</title>
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="../css/style.css">
        <link rel="sortcut icon" href="../img/logo.png" type="image/x-icon" />
        <script src="../js/jquery-3.4.1.min.js"></script>
        <script src="../js/popper.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/fontawesome.js"></script> 
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
        <jsp:include page="header.jsp"/>
        <div class="container mt-5">
            <div class="row">
                <div class="col-lg-10 mx-auto  bg-white px-3 py-3 rounded  shadow border">
                    <h4 class="mb-3">Pesquisar roteiros</h4>
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
                                <td><%= p.getEndereco()%></td>
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
        <jsp:include page="../footer.jsp"/>
    </body>
</html>