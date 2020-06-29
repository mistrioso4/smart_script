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
<html lang="pt-br">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            .btn-foto {
                position:absolute;
                left:80%;
                margin-left: -60px;
                bottom: 16%;
            }
        </style>
    </head>
    <body class="body-background-2">
        <jsp:include page="header.jsp"/>  
        <div class="profile-block ">
            <div class="bg-system">
                <%
                    Usuario userLogado = (Usuario) request.getSession().getAttribute("usuario");
                    if (userLogado.getDiretorioWallpaper() != null) {%>
                <img src="../upload/<%=userLogado.getDiretorioWallpaper()%>" class="profile-block-thumb w-100">
                <% } else {%>
                <img src="../img/fundo.jpg" class="profile-block-thumb w-100">
                <% } %>  
            </div>
            <div class="profile-img">
                <a href="#">
                    <%
                        if (userLogado.getDiretorioFoto() != null) {%>
                    <img src="../upload/<%= userLogado.getDiretorioFoto()%>" width="162" height="162" class="img-perfil border" title=""> 
                    <% } else {%>
                    <img src="../img/perfil.webp" width="162" height="162" class="bg-white rounded-circle border  shadow" alt="" title="">  
                    <% } %>  
                </a>
                <button class="btn btn-outline-light btn-foto" data-toggle="modal" data-target="#foto"><i class="fa fa-images"></i> Alterar fundo</button>
            </div>
        </div>
        <div class="mt-5 text-center">
            <a>
                <h2>${usuario.nome} ${usuario.sobrenome}</h2>
                <h6>${usuario.bio}</h6>
            </a>  
        </div>
        <div class="container">
            <div class="form-row mt-3 ">
                <div class="col-lg-3 mx-auto mr-2 mb-3">
                    <div class="bg-white px-3 py-3 rounded shadow border">
                        <h4>Dados pessoais</h4>
                        <div class="px-2">
                            <h6><i class="fa fa-calendar"></i> Entrou em ${usuario.dataEntrada}</h6>
                            <h6><i class="fa fa-map-marker-alt"></i> ${usuario.endereco}</h6>
                            <h6><i class="fa fa-birthday-cake"></i> ${usuario.dataAniversario}</h6>
                        </div>
                        <a href="editarPerfil.jsp" class="btn bg-system btn-block text-white mt-3">Editar perfil</a>
                    </div>
                </div>
                <div class="col-lg-8 mx-auto  bg-white px-3 py-3 rounded shadow border">
                    <div class="form-row mb-3   ">
                        <div class="col-md-4">
                            <h4>Minhas publicações</h4>
                        </div>
                        <div class="col-md-8">
                            <a class="btn btn-outline-secondary float-right" data-toggle="modal" data-target="#exampleModalCenter">
                                <i class="fa fa-share-alt"></i> Compartilhar aventura   
                            </a>
                        </div>
                    </div>

                    <%
                        PublicacaoDAO pDAO = new PublicacaoDAO();
                        List<Publicacao> lista = pDAO.getMinhasPublicacoes("" + userLogado.getId());
                        Collections.reverse(lista);
                        for (Publicacao p : lista) {
                    %>
                    <div class="card mx-auto mb-4">
                        <div class="card-header">
                            <div class="row">
                                <div class="col-md-9">
                                    <a>
                                        <img src="../upload/${usuario.diretorioFoto}" class="img-perfil-mini border" alt="" title="">
                                        <b>${usuario.nome}</b>  
                                    </a>
                                </div>
                                <div class="col-md-3 py-1">
                                    <a class="text-dark mr-2" href="" data-toggle="modal" data-target="#modal<%= p.getId()%>"><i class="fa fa-pen"></i> Editar</a>
                                    <a class="text-dark" href="" data-toggle="modal" data-target="#excluir<%= p.getId()%>"><i class="fa fa-trash"></i> Excluir</a>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <p class="card-text text-justify"> <%=IOUtils.toString(p.getComentario())%></p>
                            <div class="form-row">
                                <div class="col-md-3">
                                    <a><i class="fa fa-calendar"></i> <%= p.getData()%></a>
                                </div>
                                <div class="col-md-6 text-center">
                                    <a class="d-inline-block text-truncate w-100"><i class="fa fa-map-marker-alt"></i> <%= p.getEstado()%>, <%= p.getCidade()%>, <%= p.getEndereco()%></a>
                                </div>
                                <div class="col-md-3">
                                    <a class="float-right"><b>R$</b> <%= p.getPreco()%></a>
                                </div>
                            </div>
                            <div class="text-center">
                                <img  style="width: 100%; max-height: 400px; object-fit: cover; object-position: top;" src="../upload/<%= p.getNomeArquivo()%>" alt="Não foi possível carregar a imagem, atualize a página e tente novamente.">
                            </div>
                        </div>
                    </div>
                    <!--Modal editar-->
                    <div class="modal fade" id="modal<%= p.getId()%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLongTitle">Editar Publicação</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <form action="/smart_script/PublicacaoServlet" enctype="multipart/form-data" method="POST">
                                    <div class="modal-body">
                                        <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <label for="categoria"><i class="fa fa-check-double"></i> Categoria</label>
                                                <input type="text" required="" class="form-control" id="categoria" name="categoria" value="<%= p.getCategoria()%>"  placeholder="Categoria">
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label for="exampleFormControlSelect1"><i class="fa fa-dollar-sign"></i> Faixa de preço</label>
                                                <div class="input-group">
                                                    <input type="number" required id="preco" value="<%= p.getPreco()%>" name="preco" class="form-control" aria-label="Amount (to the nearest dollar)">
                                                    <div class="input-group-append">
                                                        <span class="input-group-text">R$</span>
                                                        <span class="input-group-text">0.00</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <label for="endereco"><i class="fa fa-flag"></i> Estado</label>
                                                <!-- Estado -->
                                                <select id="estados2" name="estados" class="form-control" required="">
                                                    <option value=""></option>
                                                </select>
                                            </div>
                                            <div class="form-group col-md-4" >
                                                <label for="endereco"><i class="fa fa-city"></i> Cidade</label>
                                                <select id="cidades2" name="cidades" class="form-control" required="">
                                                    <option value=""></option>
                                                </select>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="endereco"><i class="fa fa-map-marker-alt"></i> Endereço</label>
                                                <input type="text" required="" class="form-control" id="endereco" name="endereco" value="<%= p.getEndereco()%>"  placeholder="Endereço">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleFormControlTextarea1"><i class="fa fa-comment-alt"></i> Comentário</label>
                                            <textarea class="form-control" required id="comentario" name="comentario" rows="3"><%=IOUtils.toString(p.getComentario())%></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label for="imagem"><i class="fa fa-image"></i> Foto</label>
                                            <div class="form-panel">
                                                <div class="form-group last">
                                                    <div class="fileupload fileupload-new" data-provides="fileupload">
                                                        <div class="fileupload-new thumbnail" style="width: 100%">
                                                            <div class="col-md-12 text-center">
                                                                <img  style="width: 100%; max-height: 400px; object-fit: cover; object-position: top;" src="../upload/<%= p.getNomeArquivo()%>" alt="Card image cap">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-12 text-center">
                                                            <div class="fileupload-preview fileupload-exists thumbnail" style="width: 100%; max-height: 400px; object-fit: cover; object-position: top;" ></div>
                                                        </div>
                                                        <div class="text-center">
                                                            <span class="btn btn-theme02  btn-sm btn-file">
                                                                <span class="fileupload-new"><i class="fa fa-undo"></i> Escolher outra</span>
                                                                <span class="fileupload-exists"><i class="fa fa-undo"></i> Escolher outra</span>
                                                                <input type="file"  id="imagem"  value="../upload/<%= p.getNomeArquivo()%>" class="default" name="imagem" onchange="previewImage(this, 'modalPreviewImg');" accept="image/png, image/jpg"  multiple/>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <input type="text" value="<%= p.getId()%>" name="idP" id="idP" hidden="">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button  onclick="fun()" type="submit" class="btn btn-outline-secondary mr-1 mb-1 mt-1 float-right">Confirmar alteração <i class="fa fa-check"></i></button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!--Modal Excluir-->
                    <div class="modal fade" id="excluir<%= p.getId()%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-md" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLongTitle">Excluir Publicação</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <form action="/smart_script/ExcluirPublicacaoServlet"  method="POST">
                                    <div class="modal-body">
                                        Confirmar exclusão desta publicação?
                                        <input type="text" name="idEx" id="idEx" hidden  value="<%= p.getId()%>">
                                    </div>
                                    <div class="modal-footer">
                                        <button  onclick="fun()" type="submit" class="btn btn-outline-danger mr-1 mb-1 mt-1 float-right">Sim, confirmo exclusão <i class="fa fa-check"></i></button>
                                    </div>
                                </form>
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
        <!--Modal cadastro-->
        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Qual foi a aventura dessa vez, ${usuario.nome}?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="/smart_script/CadastrarPublicacaoServlet"  enctype="multipart/form-data" method="POST">
                        <div class="modal-body">
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="categoria"><i class="fa fa-check-double"></i> Categoria</label>
                                    <input type="text" required="" class="form-control" id="categoria" name="categoria"  placeholder="Categoria">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="exampleFormControlSelect1"><i class="fa fa-dollar-sign"></i> Faixa de preço</label>
                                    <div class="input-group">
                                        <input type="number" id="preco" required name="preco" class="form-control" placeholder="Faixa de preço" aria-label="Amount (to the nearest dollar)">
                                        <div class="input-group-append">
                                            <span class="input-group-text">R$</span>
                                            <span class="input-group-text">0.00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <label for="endereco"><i class="fa fa-flag"></i> Estado</label>
                                    <!-- Estado -->
                                    <select id="estados" name="estados" class="form-control" required="">
                                        <option value=""></option>
                                    </select>
                                </div>
                                <div class="form-group col-md-4" >
                                    <label for="endereco"><i class="fa fa-city"></i> Cidade</label>
                                    <select id="cidades" name="cidades" class="form-control" required="">
                                        <option value=""></option>
                                    </select>
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="endereco"><i class="fa fa-map-marker-alt"></i> Endereço</label>
                                    <input type="text" required="" class="form-control" id="endereco" name="endereco"  placeholder="Endereço">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="exampleFormControlTextarea1"><i class="fa fa-comment-alt"></i> Comentário</label>
                                <textarea class="form-control" placeholder="Comentário" required id="comentario" name="comentario" rows="3"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="imagem"><i class="fa fa-image"></i> Foto</label>
                                <div class="form-panel">
                                    <div class="form-group last">
                                        <div class="fileupload fileupload-new" data-provides="fileupload">
                                            <div class="fileupload-new thumbnail" style="border: 2px dotted #999; background-color: #ebebeb; width: 100%; height: 59px">

                                                <div class="col-md-12  mt-1 text-center" >
                                                    <i class="fa fa-upload"></i> Selecione uma imagem  
                                                    <small class="form-text text-muted">Envie apenas arquivo do tipo <b>JPG</b> ou <b>PNG</b>.</small>
                                                </div>
                                            </div>
                                            <div class="col-md-12 text-center">
                                                <div class="fileupload-preview fileupload-exists thumbnail" style="width: 100%; max-height: 400px; object-fit: cover; object-position: top;" ></div>
                                            </div>
                                            <div class="text-center">
                                                <span class="btn btn-theme02  btn-sm btn-file">
                                                    <span class="fileupload-new"><i class="fa fa-paperclip"></i> Selecionar</span>
                                                    <span class="fileupload-exists"><i class="fa fa-undo"></i> Escolher outra</span>
                                                    <input type="file" id="imagem" required class="default" name="imagem" onchange="previewImage(this, 'modalPreviewImg');" accept="image/png, image/jpg"  multiple/>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button  onclick="fun()" type="submit" class="btn btn-outline-secondary mr-1 mb-1 mt-1 float-right">Enviar <i class="fa fa-paper-plane"></i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!--Modal alterar fundo-->
        <div class="modal fade" id="foto" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Alterar fundo</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="/smart_script/AlterarFundoServlet" enctype="multipart/form-data" method="POST">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="imagem"><i class="fa fa-images"></i> Escolha uma imagem</label>
                                <div class="form-panel">
                                    <div class="form-group last">
                                        <div class="fileupload fileupload-new" data-provides="fileupload">
                                            <div class="fileupload-new thumbnail" style="border: 2px dotted #999; background-color: #ebebeb; width: 100%; height: 200px">

                                                <div class="col-md-12  mt-5 text-center" >
                                                    <br>
                                                    <i class="fa fa-upload"></i> Selecione uma imagem  
                                                    <small class="form-text text-muted">Envie apenas arquivo do tipo <b>JPG</b> ou <b>PNG</b>.</small>
                                                </div>
                                            </div>
                                            <div class="col-md-12 text-center">
                                                <div class="fileupload-preview fileupload-exists thumbnail" style="width: 100%; max-height: 400px; object-fit: cover; object-position: top;" ></div>
                                            </div>
                                            <div class="text-center">
                                                <span class="btn btn-theme02  btn-sm btn-file">
                                                    <span class="fileupload-new"><i class="fa fa-paperclip"></i> Selecionar</span>
                                                    <span class="fileupload-exists"><i class="fa fa-undo"></i> Escolher outra</span>
                                                    <input type="file" id="imagem" required class="default" name="imagem" onchange="previewImage(this, 'modalPreviewImg');" accept="image/png, image/jpg"  multiple/>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button  onclick="fun()" type="submit" class="btn btn-outline-secondary mr-1 mb-1 mt-1 float-right">Confirmar alteração <i class="fa fa-check"></i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!--modal primeira vez-->
        <div class="modal fade" id="ModalPrimeiraVez" data-backdrop="static" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Finalização do cadastro</h5>
                        <button type="button" class="close" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="/smart_script/FinalizarCadastroServlet"  enctype="multipart/form-data" method="POST">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="imagem"><i class="fa fa-image"></i> Foto de perfil</label>
                                <div class="form-panel">
                                    <div class="form-group last">
                                        <div class="fileupload fileupload-new" data-provides="fileupload">
                                            <div class="fileupload-new thumbnail w-100 text-center" >
                                                <img class="img-perfil border" src="https://png.pngtree.com/png-vector/20190704/ourlarge/pngtree-businessman-user-avatar-free-vector-png-image_1538405.jpg" alt="" />
                                            </div>
                                            <div class="col-md-12 text-center">
                                                <div class="fileupload-preview fileupload-exists thumbnail img-perfil" ></div>
                                            </div>
                                            <div class="text-center">
                                                <span class="btn btn-theme02  btn-sm btn-file">
                                                    <span class="fileupload-new"><i class="fa fa-paperclip"></i> Selecionar</span>
                                                    <span class="fileupload-exists"><i class="fa fa-undo"></i> Escolher outra</span>
                                                    <input type="file" id="imagem" required class="default" name="imagem" onchange="previewImage(this, 'modalPreviewImg');" accept="image/png, image/jpg"  multiple/>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="data"><i class="fa fa-birthday-cake"></i> Data de aniversário</label>
                                    <input type="date" required="" class="form-control" id="aniversario" name="aniversario"  placeholder="Data de aniversário">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="endereco"><i class="fa fa-map-marker-alt"></i> Endereço</label>
                                    <input type="text" required="" class="form-control" id="endereco" name="endereco"  placeholder="Endereço">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="bio"><i class="fa fa-address-card"></i> Biográfia</label>
                                <textarea class="form-control" placeholder="Biográfia" required id="bio" name="bio" rows="3"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button  type="submit" class="btn btn-outline-secondary mr-1 mb-1 mt-1 float-right">Finalizar cadastro <i class="fa fa-angle-double-right"></i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!--feedback-->

        <%
            if (request.getQueryString() != null) {

        %>
        <script>
            $(document).ready(function () {
                $('#salvo').modal('show');
            })
        </script>

        <div class="modal fade" data-backdrop="static" id="salvo" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <button type="button" class="close float-lg-right">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <div class="text-center mt-3">
                            <% if (request.getParameter("status").equals("salvo")) { %>
                            <i class="fa fa-trophy fa-4x"></i> <br>
                            <h5 class="mt-1">Os dados foram salvos com sucesso!</h5>
                            <% } %>
                            <% if (request.getParameter("status").equals("alterado")) { %>
                            <i class="fa fa-smile-wink fa-4x"></i> <br>
                            <h5 class="mt-1">Os dados foram altualizados com sucesso!</h5>
                            <% } %>
                            <% if (request.getParameter("status").equals("apagado")) { %>
                            <i class="fa fa-trash fa-4x"></i> <br>
                            <h5 class="mt-1">Os dados foram apagados com sucesso!</h5>
                            <% }%>
                            <a href="perfil.jsp" class="btn btn-outline-secondary"><i class="fa fa-check"></i> Fechar</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%            }
        %>

        <!--Modal carregando-->
        <div class="modal fade shadow" data-backdrop="static" id="carregando">
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
    <script>
            $(document).ready(function () {
                $.getJSON('../js/estados_cidades.json', function (data) {
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

            $(document).ready(function () {
                $.getJSON('../js/estados_cidades.json', function (data) {
                    var items = [];
                    var options = '<option value="">Escolha um estado</option>';
                    $.each(data, function (key, val) {
                        options += '<option value="' + val.nome + '">' + val.nome + '</option>';
                    });
                    $("#estados2").html(options);
                    $("#estados2").change(function () {
                        var options_cidades = '';
                        var str = "";
                        $("#estados2 option:selected").each(function () {
                            str += $(this).text();
                        });
                        $.each(data, function (key, val) {
                            if (val.nome == str) {
                                $.each(val.cidades, function (key_city, val_city) {
                                    options_cidades += '<option value="' + val_city + '">' + val_city + '</option>';
                                });
                            }
                        });
                        $("#cidades2").html(options_cidades);
                    }).change();
                });
            });
    </script>  
</html>