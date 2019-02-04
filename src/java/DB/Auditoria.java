
package DB;

import java.io.Serializable;


public class Auditoria implements Serializable {

    private int idauditoria;
    private String nombreusuario;
    private int idcliente;
    private String fecha_hora;
    private String fecha;
    private String cliente;
    private String hora;
    private String email_nuevo;
    private String email_antiguo;

    public int getIdauditoria() {
        return idauditoria;
    }

    public void setIdauditoria(int idauditoria) {
        this.idauditoria = idauditoria;
    }

    public String getNombreusuario() {
        return nombreusuario;
    }

    public void setNombreusuario(String nombreusuario) {
        this.nombreusuario = nombreusuario;
    }

    public int getIdcliente() {
        return idcliente;
    }

    public void setIdcliente(int idcliente) {
        this.idcliente = idcliente;
    }

    public String getFecha_hora() {
        return fecha_hora;
    }

    public void setFecha_hora(String fecha_hora) {
        this.fecha_hora = fecha_hora;
    }

    public String getEmail_nuevo() {
        return email_nuevo;
    }

    public void setEmail_nuevo(String email_nuevo) {
        this.email_nuevo = email_nuevo;
    }

    public String getEmail_antiguo() {
        return email_antiguo;
    }

    public void setEmail_antiguo(String email_antiguo) {
        this.email_antiguo = email_antiguo;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }    

    public String getCliente() {
        return cliente;
    }

    public void setCliente(String cliente) {
        this.cliente = cliente;
    }
    
    
    
    

}
