package conexion;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

public class ConexionOracle<T extends Object> implements ModelDAO<T> {

    protected Class tipo;
    protected Connection conexion;
    protected PreparedStatement sentencia;
    protected ResultSet resultado;
    protected CallableStatement procedimiento;
    protected String sqlScript;
    private String valores;
    protected String condicion;

    protected String tabla;

    private String columnas[];
    private String columnasCondcion[];
    private String temp[];
    protected String campos;
    protected String camposCondicion;

    public ConexionOracle() {
        sqlScript = "";
        valores = "";
        conexion = null;
        condicion = "";
        camposCondicion = "";
    }

    protected void abrirConexion() throws SQLException {
        String url;
        String usuario = "damian";
        String clave = "123456";
        String BaseDeDatos = "XE";
        String puerto = "1521";
        String servidor = "localhost";
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            url = "jdbc:oracle:thin:@" + servidor + ":" + puerto + ":" + BaseDeDatos;
            conexion = DriverManager.getConnection(url, usuario, clave);
        } catch (ClassNotFoundException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public void cerrarConexion() {
        try {
            if (conexion != null) {
                conexion.close();
                conexion = null;
            }
            if (sentencia != null) {
                sentencia.close();
                sentencia = null;
            }
            if (resultado != null) {
                resultado.close();
                resultado = null;
            }
            sqlScript = "";
            valores = "";
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

    }

    @Override
    public int insertarRegistro(T registro) throws SQLException {
        abrirConexion();
        construirSentenciaInsert();
        sentencia = conexion.prepareStatement(sqlScript);
        try {
            llenarSentencia(registro);
        } catch (IllegalAccessException | IllegalArgumentException | NoSuchMethodException | InvocationTargetException | SQLException e) {
            System.out.println(e.getMessage());
        }
        return sentencia.executeUpdate();
    }

    @Override
    public int actualizarRegistro(T registro) throws SQLException {
        abrirConexion();
        construirSentenciaUpdate();
        sentencia = conexion.prepareStatement(sqlScript);

        try {
            llenarSentencia(registro);
        } catch (IllegalAccessException | IllegalArgumentException | NoSuchMethodException | InvocationTargetException | SQLException e) {
            System.out.println(e.getMessage());
        }
        return sentencia.executeUpdate();
    }

    @Override
    public int eliminarRegistro(T registro) throws SQLException {
        abrirConexion();
        sentencia = conexion.prepareStatement(sqlScript);
        return 0;
    }

    @Override
    public T obtenerRegistro(T dato) throws SQLException {
        abrirConexion();
        construirSentenciaSelect();
        sentencia = conexion.prepareStatement(sqlScript);
        try {
            llenarSentencia(dato);
            columnas = temp;
            resultado = sentencia.executeQuery();
            if (resultado.next()) {
                dato = obtenerResultado(dato);
            }
        } catch (IllegalAccessException | IllegalArgumentException | NoSuchMethodException | InvocationTargetException | SQLException e) {
            System.out.println(e.getMessage());
        }
        return dato;
    }

    @Override
    public void obtenerLista(List<T> lista) throws SQLException {
        abrirConexion();
        construirSentenciaSelect();
        sentencia = conexion.prepareStatement(sqlScript);
        columnas = temp;
        try {
            resultado = sentencia.executeQuery();
            while (resultado.next()) {
                T dato = (T) tipo.newInstance();
                dato = obtenerResultado(dato);
                lista.add(dato);
            }
        } catch (IllegalAccessException | IllegalArgumentException | NoSuchMethodException | InvocationTargetException | SQLException | InstantiationException e) {
            System.out.println(e.getMessage());
        }
    }

    private void construirSentenciaSelect() {
        campos = campos.replaceAll("\\s", "");
        this.columnas = campos.split(",");
        sqlScript = "select " + campos + " from " + tabla + " ";
        sqlScript += condicion;
        camposCondicion = camposCondicion.replaceAll("\\s", "");
        this.columnasCondcion = camposCondicion.split(",");
        temp = columnas;
        columnas = columnasCondcion;
    }

    private void construirSentenciaInsert() {
        campos = campos.replaceAll("\\s", "");
        this.columnas = campos.split(",");
        sqlScript = "insert into " + tabla + "(" + campos;
        for (int i = 0; i < this.columnas.length; i++) {
            if (i < this.columnas.length - 1) {
                valores += "?,";
            } else {
                sqlScript += ")";
                valores += "?)";
            }
        }
        sqlScript += " values(" + valores;
    }

    private T obtenerResultado(T dato) throws NoSuchMethodException, IllegalAccessException, IllegalArgumentException, InvocationTargetException, SQLException {
        letraMayuscula();
        Class clase = dato.getClass();
        for (int i = 0; i < columnas.length; i++) {
            String columna = columnas[i];
            Method method = clase.getMethod("get" + columna);
            Method method2;
            if (method.getReturnType() == java.sql.Date.class) {
                method2 = clase.getMethod("set" + columna, String.class);
            } else {
                method2 = clase.getMethod("set" + columna, method.getReturnType());
            }
            if (method.invoke(dato) instanceof Integer) {
                method2.invoke(dato, resultado.getInt(i + 1));
            }
            if (method.getReturnType() == String.class) {
                method2.invoke(dato, resultado.getString(i + 1));
            }
            if (method.invoke(dato) instanceof Double) {
                method2.invoke(dato, resultado.getDouble(i + 1));
            }
            if (method.invoke(dato) instanceof Float) {
                method2.invoke(dato, resultado.getFloat(i + 1));
            }
            if (method.getReturnType() == Date.class) {
                method2.invoke(dato, resultado.getString(i + 1));
            }

        }

        return dato;
    }

    private void construirCondicion() {
        camposCondicion = camposCondicion.replaceAll("\\s", "").toLowerCase();
        this.columnasCondcion = camposCondicion.split(",");
        temp = columnas;
        columnas = new String[temp.length + columnasCondcion.length];
        System.arraycopy(temp, 0, columnas, 0, temp.length);
        System.arraycopy(columnasCondcion, 0, columnas, temp.length, columnasCondcion.length);
    }

    private void construirSentenciaUpdate() {
        campos = campos.replaceAll("\\s", "");
        this.columnas = campos.split(",");
        sqlScript = "update " + tabla + " set ";
        System.out.println("col " + Arrays.toString(columnas) + columnas.length);
        for (int i = 0; i < this.columnas.length; i++) {
            String campo = this.columnas[i];
            if (i < this.columnas.length - 1) {
                valores = "?,";
            } else {
                valores = "? ";
            }
            sqlScript += campo + "=" + valores;
        }
        sqlScript += condicion;
        construirCondicion();
    }

    private void llenarSentencia(T registro) throws NoSuchMethodException, IllegalAccessException, IllegalArgumentException, InvocationTargetException, SQLException {
        letraMayuscula();
        Class clase = registro.getClass();
        for (int i = 0; i < columnas.length; i++) {
            String campo = columnas[i];
            Method method = clase.getMethod("get" + campo);
            Object dato = method.invoke(registro);
            sentencia.setObject(i + 1, dato);
        }
    }

    public void llenaProdedure(T registro) throws NoSuchMethodException, IllegalAccessException, IllegalArgumentException, InvocationTargetException, SQLException {
        campos = campos.replaceAll("\\s", "");
        this.columnas = campos.split(",");
        letraMayuscula();
        Class clase = registro.getClass();
        for (int i = 0; i < columnas.length; i++) {
            String campo = columnas[i];
            Method method = clase.getMethod("get" + campo);
            Object dato = method.invoke(registro);
            procedimiento.setObject(i + 1, dato);
        }
    }

    private void letraMayuscula() {
        System.out.println("Numero de columnas "+columnas.length);
        for (int i = 0; i < columnas.length; i++) {
            String string = columnas[i];            
            columnas[i] = Character.toUpperCase(string.charAt(0)) + string.substring(1).toLowerCase();
        }
    }

    @Override
    public void obtenerLista(List<T> lista, T dato) throws SQLException {
        abrirConexion();
        construirSentenciaSelect();
        sentencia = conexion.prepareStatement(sqlScript);
        try {
            llenarSentencia(dato);
            System.out.println(sentencia);
            columnas = temp;
            resultado = sentencia.executeQuery();
            while (resultado.next()) {
                T dato2 = (T) tipo.newInstance();
                dato2 = obtenerResultado(dato2);
                lista.add(dato2);
            }
        } catch (IllegalAccessException | IllegalArgumentException | NoSuchMethodException | InvocationTargetException | SQLException | InstantiationException e) {
            System.out.println(e.getMessage());
        }
    }

}
