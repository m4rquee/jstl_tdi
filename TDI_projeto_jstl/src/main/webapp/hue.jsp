<%@page import="java.util.Map"%>
<!DOCTYPE html>

<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.AbstractMap"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<c:set var="method" value="${pageContext.request.getParameter('_method')}"></c:set>
<c:set var="id" value="${pageContext.request.getParameter('id')}"></c:set>
<c:set var="nome" value="${pageContext.request.getParameter('doenca')}"></c:set>


<%-- <sql:setDataSource var  = "db" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                   url  = "jdbc:sqlserver://localhost:9432;databaseName=My"
                   user = "tiago" password = "T0pSecret"/>
--%>

<sql:setDataSource var  = "db" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                   url  = "jdbc:sqlserver://regulus:1433;databasename=BD15182"
                   user = "BD15182" password = "BD15182"/>

<html>
  <head>
    <title>Página de resposta</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <link rel="stylesheet" type="text/css" href="style.css">
  </head>
  <body>

    <div class="container">
      <br>
      <br>
      <br>
      <font size="10">
      <h1>DOENÇA</h1>
      <br>
      </font>

      <c:choose>

        <c:when test = "${method eq 'PUT'}">
          <sql:query dataSource = "${db}" var = "doenca">
            SELECT * FROM Doenca WHERE nome = ?
            <sql:param value = "${nome}" />
          </sql:query>

          <c:choose>
            <c:when test="${doenca.rowCount eq 0}">
              <sql:update dataSource = "${db}" var = "_">
            INSERT INTO Doenca VALUES (?)
            <sql:param value = "${nome}" />
          </sql:update>
          <sql:query dataSource = "${db}" var = "doenca">
            SELECT * FROM Doenca WHERE nome = ?
            <sql:param value = "${nome}" />
          </sql:query>

          <c:forEach var="row" items="${doenca.rows}">
            <form id="contact">
              <h3>Resultado</h3>
              <fieldset>
                <input type="text" readonly value="${row.id}">
              </fieldset>
              <fieldset>
                <input type="text" readonly value="${row.nome}">
              </fieldset>
            </form>
          </c:forEach>
            </c:when>
            <c:otherwise>
              <form id="contact">
                <h3>Sem resultados</h3>
              </form>
            </c:otherwise>
          </c:choose>
        </c:when>

        <c:when test = "${method eq 'GET'}">
          <sql:query dataSource = "${db}" var = "doenca">
            SELECT * FROM Doenca WHERE id = ?
            <sql:param value = "${id}" />
          </sql:query>
          <c:choose>
            <c:when test="${doenca.rowCount eq 0}">
              <form id="contact">
                <h3>Sem resultados</h3>
              </form>
            </c:when>
            <c:otherwise>
              <c:forEach var="row" items="${doenca.rows}">
                <form id="contact">
                  <h3>Resultado</h3>
                  <fieldset>
                    <input type="text" readonly value="${row.id}">
                  </fieldset>
                  <fieldset>
                    <input type="text" readonly value="${row.nome}">
                  </fieldset>
                </form>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </c:when>

        <c:when test = "${method eq 'POST'}">
          <sql:update dataSource = "${db}" var = "_">
            UPDATE Doenca SET nome = ? WHERE id = ?
            <sql:param value = "${nome}" />
            <sql:param value = "${id}" />
          </sql:update>
          <sql:query dataSource = "${db}" var = "doenca">
            SELECT * FROM Doenca WHERE id = ?
            <sql:param value = "${id}" />
          </sql:query>
          <c:choose>
            <c:when test="${doenca.rowCount eq 0}">
              <form id="contact">
                <h3>Não existe</h3>
              </form>
            </c:when>
            <c:otherwise>
              <c:forEach var="row" items="${doenca.rows}">
                <form id="contact">
                  <h3>Resultado</h3>
                  <fieldset>
                    <input type="text" readonly value="${row.id}">
                  </fieldset>
                  <fieldset>
                    <input type="text" readonly value="${row.nome}">
                  </fieldset>
                </form>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </c:when>

        <c:when test = "${method eq 'DELETE'}">
          <sql:query dataSource = "${db}" var = "doenca">
            SELECT * FROM Doenca WHERE id = ?
            <sql:param value = "${id}" />
          </sql:query>
          <c:choose>
            <c:when test="${doenca.rowCount eq 0}">
              <form id="contact">
                <h3>Não existe</h3>
              </form>
            </c:when>
            <c:otherwise>
              <c:forEach var="row" items="${doenca.rows}">
                <form id="contact">
                  <c:forEach var="row" items="${doenca.rows}">
                    <h1>${row.nome.toUpperCase()} EXTERMINADO </h1>
                  </c:forEach>
                </c:forEach>
              </c:otherwise>
            </c:choose>
            <sql:update dataSource = "${db}" var = "_">
              DELETE Doenca WHERE id = ?
              <sql:param value = "${id}" />
            </sql:update>
          </c:when>
        </c:choose>
    </div>
</html>