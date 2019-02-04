package DB;

import conexion.ConexionOracle;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import oracle.jdbc.OracleTypes;

public class ArticulosDB extends ConexionOracle<Articulos> {

    public ArticulosDB() {
        tipo = Articulos.class;
        tabla = tipo.getSimpleName();
    }

    public void obtenerListaC(List<Categorias> list) throws SQLException {
        list.clear();
        abrirConexion();
        sentencia = conexion.prepareStatement("select * from categorias");
        resultado = sentencia.executeQuery();
        while (resultado.next()) {
            Categorias c = new Categorias();
            c.setIdcategoria(resultado.getInt(1));
            c.setNombre(resultado.getString(2));
            list.add(c);
        }
        cerrarConexion();
    }

    public void obteLista(List<Articulos> list, Articulos id) throws SQLException {
        abrirConexion();
        list.clear();
        procedimiento = conexion.prepareCall("{call dg_Oracle_detalle_categoria(?,?)}");
        procedimiento.setInt(1, id.getIdcategoria());
        procedimiento.registerOutParameter(2, OracleTypes.CURSOR);
        procedimiento.executeUpdate();
        resultado = (ResultSet) procedimiento.getObject(2);
        while (resultado.next()) {
            Articulos dg_consumo_art = new Articulos();
            dg_consumo_art.setIdarticulos(resultado.getInt(1));
            dg_consumo_art.setDescripcion(resultado.getString(2));
            dg_consumo_art.setCategoria(resultado.getString(3));
            list.add(dg_consumo_art);
        }
        cerrarConexion();
    }

}
