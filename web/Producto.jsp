<%--
    Document   : Producto
    Created on : 18/04/2016, 11:17:31 PM
    Author     : root
--%>
<%@page 
        import  = "com.par.paronline.modelo.Producto"
        import = "com.par.paronline.utils.Conexion"
        import = "com.par.paronline.modelo.ListaProductos"
        import = "java.util.ArrayList"
        import = "java.sql.SQLException" 
        import = "java.io.PrintWriter"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%!//esta funcion obtiene todos las categorias y las almacena en un arraylist de String
    public ArrayList<String> getCategorias() throws SQLException, ClassNotFoundException{
        ArrayList<String> categorias = new ArrayList<String>();
        Conexion.consultar("select descripcion from Categoria");
        while(Conexion.getResult().next()) categorias.add(Conexion.getResult().getString("descripcion"));
        return categorias;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Paronline</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/login.css" charset="utf-8">
    </head>
    <body>
        <header>
          <div class="">
            <nav>
              <ul>
                <li> <form action="Usuario" method="get"><input type="submit" value="Usuario"/></form> </li>
                <li> <form action="Producto" method="get"><input type="submit" value="Producto"/></form> </li>
                <li> <a href="Carrito.jsp"> Carrito</a> </li>
              </ul>
            </nav>
          </div>
        </header>
        <section>
            <form action="Producto" method="get">
                <select name="categoria">
                    <option value="all">Todas</option>
                    <%//cargamos las categorias obtenidas de la funcion en un select, exite un valor por default
                        ArrayList<String> categorias = getCategorias();
                        for(int i = 0 ; i < categorias.size() ; i ++){%> 
                            <option value="<%=categorias.get(i)%>"> 
                            <%=categorias.get(i)%> </option> <%}
                    %>
                </select>
                <input type="text" name="descripcion" placeholder="Escriba una descripcion del producto"/>
                <input type="submit" value="Buscar"/>
            </form>
            <%
                        ListaProductos productos = (ListaProductos)session.getAttribute("lista_productos");
                        ListaProductos carrito = (ListaProductos) session.getAttribute("carrito");
                        for(int i = 0 ; i < productos.size() ; i ++){
                            if(!carrito.existeProducto(productos.get(i))){%>
                            <form action="Carrito" method="get">
                                <div>
                                    <input type="text" name="descripcion" value="<%=productos.get(i).getDescripcion()%>" readonly="yes">
                                    <input type="submit" name="agregar-sacar" value="Agregar">
                                </div>
                            </form>
                            <%}
                            else{%>
                            <form action="ServletPop" method="get">
                                <div>
                                    <input type="text" name="descripcion" value="<%=productos.get(i).getDescripcion()%>" readonly="yes">
                                    <input type="submit" name="agregar-sacar" value="Sacar">
                                </div>
                            </form>
                          <%}
                        }
                    %>
        </section>
    </body>
</html>
