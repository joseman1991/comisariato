/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function () {

    var boton = $("#boton");
    var email = $("#email");
    var correo = $("#correo");
    var formulario = $("#formulario");
    var userError = $("#userError");

    var isSUbmit = true;

    jQuery(formulario).validate(
            {
                
            }

    );


    boton.click(function () {
        if (isSUbmit) {
            formulario.submit();
        }
    });

    email.keyup(function () {
        var user = email.val();
        var usuario = {
            'usuario': {
                email: user
            }
        };
        $.ajax({
            url: "obtenerUser",
            data: JSON.stringify(usuario),
            dataType: 'json',
            contentType: 'application/json',
            type: 'POST',
            async: true,
            success: function (res) {
                if (res.usuario === null) {
                    isSUbmit = true;
                    userError.css("display", "none");
                } else {
                    isSUbmit = false;
                    userError.css("display", "block");
                }
            }
        });
    });

    correo.keyup(function () {
        var user = $("#idusuario").val();
        var corr = correo.val();

        var usuario = {
            'usuario': {
                idusuario: user
            }
        };

        $.ajax({
            url: "actualiz",
            data: JSON.stringify(usuario),
            dataType: 'json',
            contentType: 'application/json',
            type: 'POST',
            async: true,
            success: function (res) {
                if (corr === res.usuario.email) {
                    userError.css("display", "none");
                } else {
                    userError.css("display", "none");
                    var user = correo.val();
                    var usuario = {
                        'usuario': {
                            email: user
                        }
                    };
                    $.ajax({
                        url: "obtenerUser",
                        data: JSON.stringify(usuario),
                        dataType: 'json',
                        contentType: 'application/json',
                        type: 'POST',
                        async: true,
                        success: function (res) {
                            if (res.usuario === null) {
                                isSUbmit = true;
                                userError.css("display", "none");
                            } else {
                                isSUbmit = false;
                                userError.css("display", "block");
                            }
                        }
                    });
                }
            }
        });
    });



});