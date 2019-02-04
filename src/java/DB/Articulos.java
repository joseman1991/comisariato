package DB;

import java.io.Serializable;

public class Articulos implements Serializable {

    private int idarticulos;
    private int idcategoria;
    private String descripcion;
    private float precioUnidad;
    private int existencias;
    private String estado;
    private String categoria ;

    public int getIdarticulos() {
        return idarticulos;
    }

    public void setIdarticulos(int idarticulos) {
        this.idarticulos = idarticulos;
    }

    public int getIdcategoria() {
        return idcategoria;
    }

    public void setIdcategoria(int idcategoria) {
        this.idcategoria = idcategoria;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public float getPrecioUnidad() {
        return precioUnidad;
    }

    public void setPrecioUnidad(float precioUnidad) {
        this.precioUnidad = precioUnidad;
    }

    public int getExistencias() {
        return existencias;
    }

    public void setExistencias(int existencias) {
        this.existencias = existencias;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }
    
    
    
    

}
