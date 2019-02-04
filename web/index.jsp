

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
                        <li class="active"><s:a href="%{index}">Insertar Cliente</s:a></li>
                        <li><s:a href="%{sub}">Sub Consulta</s:a></li>
                        <li><s:a href="%{audi}">Auditor�a</s:a></li>


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
                        <strong>�<s:property value="status"/>!</strong> <s:property value="mensaje"/>.
                    </div>
                </s:if>   
                <h2>Registrar nuevo cliente</h2>
                <form action="insertar" method="post" id="formulario">
                    <div class="form-group">
                        <label for="nombres">Nombres</label>
                        <input type="text" class="form-control"  required placeholder="Nombres" name="nombres">
                    </div>
                    <div class="form-group">
                        <label for="apellidos">Apellidos</label>
                        <input type="text" class="form-control" required  placeholder="Apellidos" name="apellidos">
                    </div>                    
                    <div class="form-group">
                        <label for="region">Regi�n</label>
                        <select class="form-control" name="region">
                            <option value="Costa">Costa</option>
                            <option value="Sierra">Sierra</option>
                            <option value="Oriente">Oriente</option>
                            <option value="Galapagos">Galapagos</option>
                        </select>
                    </div>                    
                    <div class="form-group">
                        <label for="fecha_nacimiento">Fecha de Nacimiento</label>
                        <input type="text" class="form-control" required=""   placeholder="Fecha Nacimiento" name="fecha_nacimiento" readonly="" id="datepicker">
                    </div>                    
                    <div class="form-group">
                        <label for="sexo">Sexo</label>
                        <select class="form-control" name="sexo">
                            <option value="F">Femenino</option>
                            <option value="M">Masculino</option>
                        </select>
                    </div>                    
                    <div class="form-group">
                        <label for="telefono">Telefono</label>
                        <input type="text" class="form-control requerid"   placeholder="Telefono" name="telefono">
                    </div>                    
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" class="form-control"  required="" placeholder="Email" name="email">
                    </div>                    
                    <div class="form-group">
                        <label for="ciudad">Ciudad</label>
                        <select class="form-control" name="ciudad">
                            <option value="Babahoyo">Babahoyo</option>
                            <option value="Guayaquil">Guayaquil</option>
                            <option value="Quito">Quito</option>
                            <option value="Cuenca">Cuenca</option>
                            <option value="Cuenca">Ambato</option>
                        </select>
                    </div>                    
                    <button type="submit" class="btn btn-primary">Registrar</button>
                </form>
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
                                    <th>Regi�n</th>
                                    <th>Fecha de Nacimiento</th>
                                    <th>Sexo</th>
                                    <th>Tel�fono</th>
                                    <th>Email</th>
                                    <th>Ciudad</th>
                                </tr>
                            </thead>
                            <tbody>
                                <s:iterator value="listaClientes">
                                    <tr>
                                        <td><s:property value="idcliente"/> </td>
                                        <td><s:property value="nombres"/> </td>
                                        <td><s:property value="apellidos"/> </td>
                                        <td><s:property value="region"/> </td>
                                        <td><s:property value="fecha_nacimiento"/> </td>
                                        <td><s:property value="sexo"/> </td>
                                        <td><s:property value="telefono"/> </td>
                                        <td><s:property value="email"/> </td>
                                        <td><s:property value="ciudad"/> </td>
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
