<nav class="navbar navbar-expand-lg navbar-light bg-system">  
    <a class="navbar-brand text-white" href="index.jsp">  
        <img src="../img/logo.png" width="37" height="37" >
        <b>Smart Script</b>
    </a>
    <a href="" class="navbar-toggler text-white border-white" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
        <i class="fa fa-bars fa-lg"></i>
    </a>
    <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
        <ul class="navbar-nav mr-auto">
        </ul>

        <a class="nav-link text-white" href="perfil.jsp"><i class="fas fa-user text-warning"></i> ${usuario.nome} ${usuario.sobrenome}</a>
        <a class="nav-link text-white" href="" data-toggle="modal" data-target="#sair"><i class="fas fa-1x fa-sign-out-alt text-warning"></i> Sair</a>
    </div>
</nav>

<div class="modal fade" id="sair" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="TituloModalCentralizado">Encerrar sessão</h5>
                <a href="" class="close text-white" data-dismiss="modal" aria-label="Cancelar">
                    <i class="fas fa-times-circle fa-lg"></i>
                </a> 
            </div>
            <div class="modal-body">
                    Confirmar saída?
            </div>
            <div class="modal-footer">
                <form action="/smart_script/LoginServlet" method="get">
                    <button type="submit" class="btn btn-outline-secondary">Sair</button>
                </form>
                <button type="button" class="btn bg-system text-white" data-dismiss="modal">Cancelar</button>
            </div>
        </div>
    </div>
</div>