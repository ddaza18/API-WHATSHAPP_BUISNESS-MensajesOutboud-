<%-- 
    Document   : index
    Created on : 21/02/2023, 10:13:00 p. m.
    Author     : Daniel Daza
--%>

<%@page import="java.util.Scanner"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.OutputStreamWriter"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>API WP</title>
    </head>
    <body>
        <%
            //TOKEN DESDE FACEBOOK
            String token = "EAAKQmfoJVTQBAAmYxOskIGINkdYeY2SKGZBWNDZAtVWKiAWNv8mZAZAJIzLkktZC9MfNusp5Ej3XNcgHPKWXHpaTcsjx2i5e2f5rc5Jk8FI9cENNxOVhFuUGUmoe1hXLvkPvGM4ksbPehm9PCWkgOl5qzb9gvJkEvc6OW46C9LwThRdu3x0SgUR2ZCTe1yZChZCVBT3oZCxsKVgZDZD";
            //TELEFONO
            String telefono = "573138730570";
            //IDENTIFICADOR DEL NUMERO DE TELEFONO
            String id_telefono = "110284955326163";
            //URL PARA ENVIAR EL MENSAJE
            URL url = new URL("https://graph.facebook.com/v15.0/"+id_telefono+"/messages");
            //CONTENEDOR DEL ENVIO
            HttpURLConnection httpcon = (HttpURLConnection) url.openConnection();
            //TIPO DE ENVIO POST
            httpcon.setRequestMethod("POST");
            //AUTORIZACION JAVA
            httpcon.addRequestProperty("Authorization", "Bearer "+token);
            //DEFINIMOS QUR SE TRATE COMO JSON
            httpcon.addRequestProperty("Content-Type", "application/json; application/x-www-form-urlencoded; charset=UFT-8");
            //PREPARA Y ENVIA EL JSON
            httpcon.setDoOutput(true);
            OutputStreamWriter writer = new OutputStreamWriter(httpcon.getOutputStream());
            writer.write("{ "
                    + "\"messaging_product\": \"whatsapp\", "
                    + "\"to\": \"" + telefono + "\", "
                    + "\"type\": \"template\", "
                    + "\"template\": "
                    + "  { \"name\": \"hello_world\", "
                    + "    \"language\": { \"code\": \"en_US\" } "
                    + "  } "
                    + "}");
            //LIMPIAMOS
            writer.flush();
            //CERRAMOS (DATOS)
            writer.close();
            //CERRAMOS LA CONEXION
            httpcon.getOutputStream().close();
            //RESULTADO DEL ENVIO
            InputStream res = httpcon.getResponseCode() / 100 == 2
                ? httpcon.getInputStream()
                    : httpcon.getErrorStream();
            Scanner scanner = new Scanner(res).useDelimiter("\\A");
            //OBTENEMOS LOS RESULTADOS
            String resp = scanner.hasNext() ? scanner.next() : "";
            System.out.println(res);
            %>
    </body>
</html>
