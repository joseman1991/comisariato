package submit;

import DB.Articulos;
import DB.ArticulosDB;
import DB.Categorias;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ArticulosSubmit extends ActionSupport implements ModelDriven<Articulos> {

    private Articulos articulos;
    private final List<Articulos> listaArticulos;
    private final List<Categorias> listaCategoria;
    private final ArticulosDB adb;

    private String mensaje;
    private String style;
    private String status;

    public ArticulosSubmit() {
        articulos = new Articulos();
        listaArticulos = new ArrayList<>();
        listaCategoria = new ArrayList<>();
        adb = new ArticulosDB();
    }

    @Override
    public String execute() throws Exception {
        try {
            adb.obtenerListaC(listaCategoria);
            if (listaCategoria.size() > 0) {
                articulos.setIdcategoria(listaCategoria.get(0).getIdcategoria());
                adb.obteLista(listaArticulos, articulos);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            adb.cerrarConexion();
        }
        return SUCCESS;
    }

    public String consultar() {
        try {
            adb.obtenerListaC(listaCategoria);
            adb.obteLista(listaArticulos, articulos);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }finally{
            adb.cerrarConexion();
        }
        return SUCCESS;
    }

    @Override
    public Articulos getModel() {
        return articulos;
    }

    public List<Articulos> getListaArticulos() {
        return listaArticulos;
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

    public Articulos getArticulos() {
        return articulos;
    }

    public void setArticulos(Articulos articulos) {
        this.articulos = articulos;
    }

    public List<Categorias> getListaCategoria() {
        return listaCategoria;
    }

}
