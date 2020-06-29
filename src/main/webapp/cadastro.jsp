<%-- 
    Document   : cadastro
    Created on : 22/06/2020, 12:55:30
    Author     : paulo
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Smart Script</title>
        <link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="sortcut icon" href="img/logo.png" type="image/x-icon" />
        <script src="js/jquery-3.4.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/fontawesome.js"></script> 
    </head>
    <body class="body-background">
        <nav class="navbar navbar-expand-lg navbar-light bg-system mb-4">  
            <a class="navbar-brand text-white" href="index.jsp  ">  
                <img src="img/logo.png" width="37" height="37">
                <b>Smart Script</b>
            </a>
            <a href="" class="navbar-toggler text-white border-white" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
                <i class="fa fa-bars fa-lg"></i>
            </a>
            <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
                <a class="nav-link text-white ml-auto" href="index.jsp"><i class="fas fa-angle-double-left"></i> Voltar</a>
            </div>
        </nav>
        <div class="container">
            <div class="row">
                <div class="col-md-6 mx-auto">
                    <div class=" bg-white px-3 py-3 rounded shadow border">
                        <form method="post" name="dados_cadastro" id="form" name="form" action="/smart_script/CadastrarUsuarioServlet">
                            <h4 class="mb-2">Novo cadastro</h4>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="exampleInputEmail1">Nome</label>
                                    <input type="text" required="true" class="form-control" id="nome" name="nome" aria-describedby="emailHelp" placeholder="Nome">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="exampleInputEmail1">Sobrenome</label>
                                    <input type="text" required="true" class="form-control" id="sobrenome" name="sobrenome" aria-describedby="emailHelp" placeholder="Sobrenome">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail1">Email</label>
                                <input type="email" required="true" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Email">
                                <small id="emailHelp" class="form-text text-muted">Nunca compartilharemos seu email com ningém.</small>
                            </div>
                            <div class="form-group">
                                <label>Senha</label>
                                <div class="input-group" id="show_hide_password">
                                    <input type="password" class="form-control" id="senha" name="senha" placeholder="Senha">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button" id="button-addon2"><i class="fa fa-eye-slash" aria-hidden="true"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Confirmar senha</label>
                                <div class="input-group" id="show_hide_password2">
                                    <input type="password" class="form-control" id="confirmar_senha" name="confirmar_senha" placeholder="Confirmar senha">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button" id="button-addon2"><i class="fa fa-eye-slash" aria-hidden="true"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">Concordo com os termos.</label>
                            </div>
                            <button onclick="fun()" type="submit" class="btn bg-system text-white btn-block mt-3">Confirmar <i class="fas fa-angle-double-right"></i></button>
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
        <!--feedback-->
        <%
            if (request.getQueryString() != null) {
                if (request.getParameter("status").equals("erro")) {
        %>
        <script>
            $(document).ready(function () {
                $('#salvo').modal('show');
            })
        </script>

        <div class="modal fade"  id="salvo" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <button type="button" class="close float-lg-right" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <div class="text-center mt-3">
                            <i class="fa fa-exclamation fa-3x"></i> <br>
                            <h5 class="mt-1">Senhas não coincidem</h5>
                            <a  data-dismiss="modal" aria-label="Close" class="btn btn-outline-secondary"><i class="fa fa-undo-alt"></i> Tentar novamente</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            }
        %>
        <script>
            $(document).ready(function () {
                $("#show_hide_password button").on('click', function (event) {
                    event.preventDefault();
                    if ($('#show_hide_password input').attr("type") == "text") {
                        $('#show_hide_password input').attr('type', 'password');
                        $('#show_hide_password i').addClass("fa-eye-slash");
                        $('#show_hide_password i').removeClass("fa-eye");
                    } else if ($('#show_hide_password input').attr("type") == "password") {
                        $('#show_hide_password input').attr('type', 'text');
                        $('#show_hide_password i').removeClass("fa-eye-slash");
                        $('#show_hide_password i').addClass("fa-eye");
                    }
                });
            });
            $(document).ready(function () {
                $("#show_hide_password2 button").on('click', function (event) {
                    event.preventDefault();
                    if ($('#show_hide_password2 input').attr("type") == "text") {
                        $('#show_hide_password2 input').attr('type', 'password');
                        $('#show_hide_password2 i').addClass("fa-eye-slash");
                        $('#show_hide_password2 i').removeClass("fa-eye");
                    } else if ($('#show_hide_password2 input').attr("type") == "password") {
                        $('#show_hide_password2 input').attr('type', 'text');
                        $('#show_hide_password2 i').removeClass("fa-eye-slash");
                        $('#show_hide_password2 i').addClass("fa-eye");
                    }
                });
            });
        </script>
        <script src="js/carregando.js"></script>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
