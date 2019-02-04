

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
                        <li><s:a href="%{sub}">Sub Consulta</s:a></li>
                        <li class="active"><s:a href="%{audi}">Auditoría</s:a></li>
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
                <s:if test="cliente.idcliente>0">
                    <h2>Actualizar cliente <s:property value="nombres"/> <s:property value="apellidos"/></h2>
                    <form action="actualizado" method="post" id="formulario">                                      
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" value="<s:property value="email" />" class="form-control"  required="" placeholder="Email" name="email">
                        </div>     
                        <input type="hidden" value="<s:property value="cliente.idcliente"/>" name="idcliente"/>
                        <button type="submit" class="btn btn-primary">Actualizar Email</button>
                    </form>
                </s:if><s:else>
                    <h2>Selecciona un cliente de la lista</h2>
                </s:else>

            </div>
            <div class="col-md-6">
                <h2>Lista de Clientes</h2> 
                <s:if test="listaClientes.size()>0">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Nombres</th>
                                    <th>Apellidos</th>
                                    <th>Región</th>
                                    <th>Sexo</th>
                                    <th>Teléfono</th>
                                    <th>Email</th>
                                    <th>Ciudad</th>
                                    <th>Actualizar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <s:iterator value="listaClientes">
                                    <tr>
                                        <td><s:property value="idcliente"/> </td>
                                        <td><s:property value="nombres"/> </td>
                                        <td><s:property value="apellidos"/> </td>
                                        <td><s:property value="region"/> </td>
                                        <td><s:property value="sexo"/> </td>
                                        <td><s:property value="telefono"/> </td>
                                        <td><s:property value="email"/> </td>
                                        <td><s:property value="ciudad"/> </td>
                                        <td> 
                                            <s:url action="editar" var="actualizar">
                                                <s:param name="idcliente">
                                                    <s:property value="idcliente"/>                                                                    
                                                </s:param>
                                            </s:url>
                                            <s:a href="%{actualizar}" cssClass="btn btn-info" data-toggle="tooltip" title="Editar costo"> 
                                                <span class="glyphicon glyphicon-edit"></span>
                                            </s:a>
                                        </td>   
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
        <div class="row">
            <div class="col-md-2">

            </div>
            <div class="col-md-8">
                <h3 class="text-center">Lista de Cambios de correo en auditoría</h3>
                <s:if test="listaAuditoria.size()>0">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Cliente</th>
                                    <th>Usuario DB</th>
                                    <th>Fecha</th>
                                    <th>Hora</th>
                                    <th>Email Antiguo</th>
                                    <th>Email Nuevo</th>                                                                
                                </tr>
                            </thead>
                            <tbody>
                                <s:iterator value="listaAuditoria">
                                    <tr>
                                        <td><s:property value="idauditoria"/> </td>
                                        <td><s:property value="cliente"/> </td>
                                        <td><s:property value="nombreusuario"/> </td>
                                        <td><s:property value="fecha"/> </td>
                                        <td><s:property value="hora"/> </td>
                                        <td><s:property value="email_antiguo"/> </td>
                                        <td><s:property value="email_nuevo"/> </td>
                                    </tr>

                                </s:iterator>


                            </tbody>
                        </table>
                    </div> 
                </s:if>
                <s:else>
                    <h4>No hay cambios de email de los clientes en la tabla auditoría</h4>
                </s:else>
            </div>
            <div class="col-md-2">

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
