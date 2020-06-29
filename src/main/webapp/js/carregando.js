/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function fun() {
    $(document).ready(function () {
        $("#carregando").modal("show");
    });
    time()
}

function time() {
    var i = setInterval(function () {
        clearInterval(i);
        // O código desejado é apenas isto:
        $('#carregando').modal('hide');
    }, 9000);
}


$('form').submit(function (e) {
    var form = this;
    e.preventDefault();
    setTimeout(function () {
        form.submit();
    }, 1000); // in milliseconds

    $("<p>Delay...</p>").appendTo("body");
});


