<%@page import="java.util.Map"%>
<!DOCTYPE html>

<%@page import="com.proj.tdi_projeto_jstl.*"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.AbstractMap"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="method" value="${pageContext.request.getParameter('_method')}"></c:set>
<c:set var="id" value="${pageContext.request.getParameter('id')}"></c:set>
<c:set var="doenca" value="${pageContext.request.getParameter('doenca')}"></c:set>

TODO ADD DRIVER AND CONNECTION

	<html>
		<head>
			<title>Start Page</title>
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
				</font>
				
			<jsp:useBean id="hue" class="java.util.LinkedHashMap"/>

			<c:choose>

				<c:when test = "${method eq 'PUT'}">
					${hue.put("nome", doenca)}
					${DAO.Inserir(db, "Doenca", hue)}
				</c:when>

				<c:when test = "${method eq 'GET'}">
					<c:set var="doenca" value="${DAO.Pesquisa(db, 'Doenca', 'id', id).next()}"></c:set>
					<c:out value="${id}"></c:out>
					<c:out value="${doenca}"></c:out>
					<c:out value="${method}"></c:out>
					<c:choose>
						<c:when test = "${doenca ne null}">
							<form>
								<fieldset>
									<input type="text" value="${doenca.getString('id')}">
								</fieldset>
								<fieldset>
									<input type="text" value="${doenca.getString('nome')}">
								</fieldset>
							</form>
						</c:when>
					</c:choose>
				</c:when>

				<c:when test = "${method eq 'POST'}">
					${DAO.Atualizar(db, "Doenca", hue)}
				</c:when>

				<c:when test = "${method eq 'DELETE'}">
					${hue.put("id", doenca)}
					${DAO.Inserir(db, "Doenca", hue)}
				</c:when>
			</c:choose>
		</div>
</html>