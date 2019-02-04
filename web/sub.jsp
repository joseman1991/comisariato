

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Comisariato</title>
        <link href="Librerias/css/bootstrap.min.css" rel="stylesheet">
        <script type="text/javascript" src="Librerias/js/jquery-3.3.1.min.js" ></script>
        <script type="text/javascript" src="Librerias/js/bootstrap.min.js" ></script> 
        <script type="text/javascript" src="Librerias/js/gijgo.min.js"></script>
        <link href="Librerias/css/gijgo.min.css" rel="stylesheet" type="text/css" />
        <style>
            label.error { float: none; color: red; padding-left: .5em; vertical-align: middle; font-size: 12px; }

        </style>
    </head>
    <body>
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>                        
                    </button>
                    <a class="navbar-brand" href="#">Comisariato</a>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">
                        <s:url action="index" var="index"/>
                        <s:url action="sub" var="sub"/>
                        <s:url action="audi" var="audi"/>
                        <li class=""><s:a href="%{index}">Insertar Cliente</s:a></li>
                        <li class="active"><s:a href="%{sub}">Sub Consulta</s:a></li>
                        <li><s:a href="%{audi}">Auditoría</s:a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="row">
                <div class="col-md-1">

                </div>
                <div class="col-md-5">
                <s:if test="mensaje!=null">
                    <div class="alert <s:property value="style"/> alert-dismissible">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <strong>¡<s:property value="status"/>!</strong> <s:property value="mensaje"/>.
                    </div>
                </s:if>   
                <h2>Registrar nuevo cliente</h2>
                <form action="consultar" method="post" id="formulario">
                    <div class="form-group">
                        <label for="idcategoria">Categorias</label>
                        <select class="form-control" name="idcategoria">
                            <s:iterator value="listaCategoria">
                                <s:if test="idcategoria==articulos.idcategoria">
                                    <option value="<s:property value="idcategoria"/>" selected><s:property value="nombre"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="idcategoria"/>"><s:property value="nombre"/></option>
                                </s:else>
                            </s:iterator>
                        </select>
                    </div> 
                    <button type="submit" class="btn btn-primary">Consultar productos</button>
                </form>
            </div>
            <div class="col-md-6">
                <h2>Lista de Articulos</h2> 
                <s:if test="listaArticulos.size()>0">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Descripcion</th>
                                    <th>Categoria</th>                                    
                                </tr>
                            </thead>
                            <tbody>
                                <s:iterator value="listaArticulos">
                                    <tr>
                                        <td><s:property value="idarticulos"/> </td>
                                        <td><s:property value="descripcion"/> </td>
                                        <td><s:property value="categoria"/> </td>                                                                          
                                    </tr>
                                </s:iterator>


                            </tbody>
                        </table>
                    </div> 
                </s:if>
                <s:else>
                    <h3>No hay resultados</h3>
                </s:else>


            </div>
        </div>
        <script type="text/javascript" src="Librerias/js/jquery.validate.min.js" ></script>    
        <script type="text/javascript" src="Librerias/js/messages_es.js" ></script>   
        <script type="text/javascript" src="Librerias/js/script.js" ></script>   
        <script type="text/javascript">
            $('#datepicker').datepicker({
                uiLibrary: 'bootstrap',
                format: 'dd/mm/yyyy'
            });
        </script>
    </body>
</html>
