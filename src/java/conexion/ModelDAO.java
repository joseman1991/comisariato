/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conexion;

import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author 
 * @param <T>
 */
public interface ModelDAO<T extends Object> {   
    
    public int insertarRegistro(T registro)throws SQLException;

    public int actualizarRegistro(T registro) throws SQLException;

    public int eliminarRegistro(T registro)throws SQLException;

    public T obtenerRegistro(T dato)throws SQLException;

    public void obtenerLista(List<T> lista)throws SQLException;
    
    public void obtenerLista(List<T> lista,T dato)throws SQLException;
    
    
    
}
