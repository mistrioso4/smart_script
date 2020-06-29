<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="model.bean.Publicacao"%>
<%@page import="model.dao.PublicacaoDAO"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <!-- Required meta tags -->
        <title>Smart Script</title>
        <meta charset="utf-8"> 
        <link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="sortcut icon" href="img/logo.png" type="image/x-icon" />
        <script src="js/jquery-3.4.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/fontawesome.js"></script>
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
                <div class="col-lg-6">
                    <div class="mx-auto bg-white  px-3 py-3 rounded shadow border mb-3">
                        <h4 class="mb-3">Pesquisar roteiros</h4>
                        <form action="busca.jsp" method="post">
                            <div class="form-row">
                                <div class="form-group col-md-3">
                                    <label for="endereco">Estado</label>
                                    <!-- Estado -->
                                    <select id="estados" name="estados" class="form-control">
                                        <option value=""></option>
                                    </select>
                                </div>
                                <div class="form-group col-md-3" >
                                    <label for="endereco">Cidade</label>
                                    <select id="cidades" name="cidades" class="form-control">
                                        <option value=""></option>
                                    </select>
                                </div>
                                <div class="col-md-3 form-group">
                                    <label for="anopublicado">Ano publicado</label>
                                    <input type="text" class="form-control" id="data" name="data" placeholder="Ano publicado">
                                </div>
                                <div class="col-md-3 form-group">
                                    <label for="anopublicado">Pesquisar</label>
                                    <button onclick="fun()" type="submit" class="btn bg-system text-white btn-block">Buscar </button>
                                </div>
                            </div>
                            <div class="text-center">
                                <img src="img/figuras_fundo.png" style="width: 26rem">  
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-6 ">
                    <div class="bg-white px-3 py-3 rounded shadow border">
                        <form action="/smart_script/LoginServlet" method="post">
                            <h4 class="mb-2">Acessar conta</h4>
                            <div class="form-group">
                                <label for="exampleInputEmail1">Email</label>
                                <input type="email" required="" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Email">
                                <small id="emailHelp" class="form-text text-muted">Nunca compartilharemos seu email com ningém.</small>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Senha</label>
                                <input type="password" required="" class="form-control" id="senha" name="senha" placeholder="Senha">
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">Sempre conectado</label>
                            </div>
                            <button onclick="fun()" type="submit"  class="btn bg-system text-white btn-block mt-3">Entrar <i class="fas fa-angle-double-right"></i></button>
                            <div class="text-center mt-2">
                                <a href="">Esqueci minha senha</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="carregando" data-backdrop="static">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body text-center">
                        <img src="img/loading.gif" style="width: 12rem" />
                        <h4>Carregando...</h4>
                    </div>
                </div>
            </div>
        </div>
        <script src="js/carregando.js"></script>  
        <script>
            $(document).ready(function () {
                $.getJSON('js/estados_cidades.json', function (data) {
                    var items = [];
                    var options = '<option value="">Escolha um estado</option>';
                    $.each(data, function (key, val) {
                        options += '<option value="' + val.nome + '">' + val.nome + '</option>';
                    });
                    $("#estados").html(options);
                    $("#estados").change(function () {
                        var options_cidades = '';
                        var str = "";
                        $("#estados option:selected").each(function () {
                            str += $(this).text();
                        });
                        $.each(data, function (key, val) {
                            if (val.nome == str) {
                                $.each(val.cidades, function (key_city, val_city) {
                                    options_cidades += '<option value="' + val_city + '">' + val_city + '</option>';
                                });
                            }
                        });
                        $("#cidades").html(options_cidades);
                    }).change();
                });
            });
        </script>
        <jsp:include page="footer.jsp"/>
    </body>
</html>  