<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
	<title>Deal or No Deal</title>
	<link rel="stylesheet" type="text/css" href="dealOrNoDeal.css" />
	<script language="javascript" type="text/javascript" src="javascript.js"></script>
</head>

<%@ page import="gameManager.Player" %>
<%@ page errorPage="errors.jsp" %>
<%@ page isThreadSafe="false" %>  

<body onload="backButton()">
	
	<jsp:useBean id="player" class="gameManager.Player" scope="session" />
	
	<div class="bodyDiv">
	<h1>Deal or No Deal</h1>
		<form name="dealNoDeal" method="post" action="Game.jsp">
			<input name="selectedCase" id="selectedCase" type="hidden" value="" />
			<input type="hidden" id="refreshed" value="no" />
			
			<%
				String selectedCase = request.getParameter("selectedCase"); //Get selected case
				
				if(selectedCase != null) // Open case if user has selected case
				{
					int s = Integer.parseInt(selectedCase);
					player.openCase(s);
				}
				if(player.isEndRound()) // If end of round redirect to EndRound.jsp
				{
					response.sendRedirect("EndRound.jsp");
					return;	
				}	
			%>
			<p>
				Remaining Cases: <jsp:getProperty property="remainingCasesCount" name="player"/>
			</p>
			<table class="cases">
				<tr>
				<%
					for(int i = 0; i <= 11; i++)
					{
						if(i == 6)
							%></tr><tr>
						<td>
							<% 
							if(!player.isOpened(i)) 
							{ %>
								<div class="tdHyperlink">
									<a href="javascript: submit('<%=(i)%>')"><%=(i + 1)%></a>
								</div>
							<%
							}
							else 
							{
								 %>
									<div class="tdCaseOpened">
										<%= "$" + player.getCase(i) %>
									</div>
								<%	
							}
							%>							
						</td>
						<%							
					}
						%>
					</tr>
			</table>
		</form>
	</div>	
</body>
</html>