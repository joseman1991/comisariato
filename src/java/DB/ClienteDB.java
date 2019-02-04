package DB;

import conexion.ConexionOracle;
import java.lang.reflect.InvocationTargetException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import oracle.jdbc.OracleTypes;

public class ClienteDB extends ConexionOracle<Clientes> {

    public ClienteDB() {
        super();
        tipo = Clientes.class;
        tabla = tipo.getSimpleName();
    }

    public void insertarCliente(Clientes cliente) throws SQLException {
        try {
            abrirConexion();
            campos = "nombres,apellidos,region,fecha_nacimiento,sexo,telefono,email,ciudad";
            procedimiento = conexion.prepareCall("{call dg_Oracle_Insertar_Cliente(?,?,?,?,?,?,?,?)}");
            llenaProdedure(cliente);
            procedimiento.executeUpdate();
            cerrarConexion();
        } catch (NoSuchMethodException | IllegalAccessException | IllegalArgumentException | InvocationTargetException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void obtenerLista(List<Clientes> lista) throws SQLException {
        campos = "idcliente,nombres,apellidos,region,fecha_nacimiento,sexo,telefono,email,ciudad";
        camposCondicion = "";
        condicion = "";
        super.obtenerLista(lista);
        cerrarConexion();
    }

    @Override
    public Clientes obtenerRegistro(Clientes dato) throws SQLException {
        campos = "idcliente,nombres,apellidos,region,sexo,telefono,email,ciudad";
        camposCondicion = "idcliente";
        condicion = "where idcliente=?";
        dato = super.obtenerRegistro(dato);
        cerrarConexion();
        return dato;
    }

    @Override
    public int actualizarRegistro(Clientes registro) throws SQLException {
        campos="email";
        camposCondicion = "idcliente";
        condicion = "where idcliente=?";
        int res=super.actualizarRegistro(registro); 
        cerrarConexion();
        return res;
    }
    
    
    
    
      public void obteLista(List<Auditoria> list) throws SQLException {
        abrirConexion();
        list.clear();
        procedimiento = conexion.prepareCall("{call ver_auditoria(?)}");       
        procedimiento.registerOutParameter(1, OracleTypes.CURSOR);
        procedimiento.executeUpdate();
        resultado = (ResultSet) procedimiento.getObject(1);
        while (resultado.next()) {
            Auditoria dg_consumo_art = new Auditoria();
            dg_consumo_art.setIdauditoria(resultado.getInt(1));
            dg_consumo_art.setCliente(resultado.getString(2));
            dg_consumo_art.setNombreusuario(resultado.getString(3));
            dg_consumo_art.setFecha(resultado.getString(4));
            dg_consumo_art.setHora(resultado.getString(5));
            dg_consumo_art.setEmail_antiguo(resultado.getString(6));
            dg_consumo_art.setEmail_nuevo(resultado.getString(7));
            list.add(dg_consumo_art);
        }
        cerrarConexion();
    }
    
    
    

}
