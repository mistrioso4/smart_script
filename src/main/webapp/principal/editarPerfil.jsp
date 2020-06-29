<%-- 
    Document   : perfil
    Created on : 22/06/2020, 18:51:34
    Author     : paulo
--%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <style>
            .img-perfil{
                background-color: #ddd;
                border-radius: 100%;
                height: 150px;
                object-fit: cover;
                width: 150px;  
            }
        </style>
    </head>
    <body class="body-background-2">
        <jsp:include page="header.jsp"/>  
        <div class="container">
            <div class="col-lg-8 mx-auto  bg-white px-3 py-3 rounded mt-4 shadow border">
                <h4>Editar Perfil</h4>
                <form action="/smart_script/EditarPerfilServlet" enctype="multipart/form-data" method="POST">
                    <div class="form-group">
                        <div class="form-panel">
                            <div class="form-group last">
                                <div class="fileupload fileupload-new" data-provides="fileupload">
                                    <div class="fileupload-new thumbnail w-100 text-center" >
                                        <img class="img-perfil" src="../upload/${usuario.diretorioFoto}" alt="" />
                                    </div>
                                    <div class="col-md-12 text-center">
                                        <div class="fileupload-preview fileupload-exists thumbnail img-perfil" ></div>
                                    </div>
                                    <div class="text-center">
                                        <span class="btn btn-theme02  btn-sm btn-file">
                                            <span class="fileupload-new"><i class="fa fa-paperclip"></i> Selecionar</span>
                                            <span class="fileupload-exists"><i class="fa fa-undo"></i> Escolher outra</span>
                                            <input type="file" id="imagem" class="default" name="imagem" onchange="previewImage(this, 'modalPreviewImg');" accept="image/png, image/jpg"  multiple/>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="exampleInputEmail1">Nome</label>
                            <input type="text" required="true" class="form-control" id="nome" name="nome" value="${usuario.nome}" aria-describedby="emailHelp" placeholder="Nome">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="exampleInputEmail1">Sobrenome</label>
                            <input type="text" required="true" class="form-control" id="sobrenome" name="sobrenome" value="${usuario.sobrenome}" aria-describedby="emailHelp" placeholder="Sobrenome">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEmail1">Email</label>
                        <input type="email" required="true" disabled="" class="form-control" id="email" name="email" value="${usuario.email}" aria-describedby="emailHelp" placeholder="Email">
                        <small id="emailHelp" class="form-text text-muted">Nunca compartilharemos seu email com ningém.</small>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="data"> Data de aniversário</label>
                            <input type="date" required="" class="form-control" id="aniversario" value="${usuario.dataAniversario}" name="aniversario"  placeholder="Data de aniversário">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="endereco"> Endereço</label>
                            <input type="text" required="" class="form-control" id="endereco" name="endereco" value="${usuario.endereco}" placeholder="Endereço">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="bio">Biográfia</label>
                        <textarea class="form-control" placeholder="Biográfia" required id="bio" name="bio" rows="3">${usuario.bio}</textarea>
                    </div>
                    <div class="col-md-12 text-center">
                        <button  onclick="fun()" type="submit" class="btn btn-outline-secondary mr-1 mb-1 mt-1 ">Confirmar alteração <i class="fa fa-check"></i></button>
                    </div>
                </form>
            </div>
        </div>

        <!--Modal carregando-->
        <div class="modal fade shadow" id="carregando" data-backdrop="static">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body text-center">
                        <img src="../img/loading.gif" style="width: 12rem" />
                        <h4>Carregando...</h4>
                    </div>
                </div>
            </div>
        </div>
        <script src="../js/carregando.js"></script>
        <jsp:include page="../footer.jsp"/>  
    </body>
</html>