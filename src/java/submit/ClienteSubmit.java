package submit;

import DB.Auditoria;
import DB.ClienteDB;
import DB.Clientes;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClienteSubmit extends ActionSupport implements ModelDriven<Clientes> {

    private Clientes cliente;
    private final List<Clientes> listaClientes;
    private final List<Auditoria> listaAuditoria;
    private final ClienteDB cdb;

    private String mensaje;
    private String style;
    private String status;

    public ClienteSubmit() {
        cliente = new Clientes();
        listaClientes = new ArrayList<>();
        listaAuditoria = new ArrayList<>();
        cdb = new ClienteDB();
    }

    @Override
    public String execute() throws Exception {
        try {
            cdb.obtenerLista(listaClientes);
            cdb.obteLista(listaAuditoria);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            cdb.cerrarConexion();
        }
        return SUCCESS;
    }

    public String insertar() {
        try {
            cdb.insertarCliente(cliente);
            mensaje = "Cliente insertado";
            style = "alert-success";
            status = "Correcto";
            cdb.obtenerLista(listaClientes);
        } catch (SQLException e) {
            style = "alert-danger";
            status = "Error";
            mensaje = e.getMessage();
            System.out.println(e.getMessage());
        } finally {
            cdb.cerrarConexion();
        }
        return SUCCESS;
    }

    public String actualizar() {
        try {
            cdb.actualizarRegistro(cliente);
            mensaje = "Cliente Actualizado";
            style = "alert-success";
            status = "Correcto";
            cdb.obtenerLista(listaClientes);
            cdb.obteLista(listaAuditoria);
            cliente.setIdcliente(0);
        } catch (SQLException e) {
            style = "alert-danger";
            status = "Error";
            mensaje = e.getMessage();
            System.out.println(e.getMessage());
        } finally {
            cdb.cerrarConexion();
        }
        return SUCCESS;
    }

    public String obtenerCliente() {
        try {
            cliente = cdb.obtenerRegistro(cliente);
            cdb.obtenerLista(listaClientes);
            cdb.obteLista(listaAuditoria);
            System.out.println(listaClientes.size());
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            cdb.cerrarConexion();
        }
        return SUCCESS;
    }

    @Override
    public Clientes getModel() {
        return cliente;
    }

    public Clientes getCliente() {
        return cliente;
    }

    public void setCliente(Clientes cliente) {
        this.cliente = cliente;
    }

    public List<Clientes> getListaClientes() {
        return listaClientes;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<Auditoria> getListaAuditoria() {
        return listaAuditoria;
    }

}
