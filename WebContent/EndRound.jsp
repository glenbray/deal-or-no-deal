<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
		<title>End of Round</title>
		<link rel="stylesheet" type="text/css" href="dealOrNoDeal.css" />
		<script language="javascript" type="text/javascript" src="javascript.js"></script>
	</head>
	<jsp:useBean id="player" class="gameManager.Player" scope="session" />
	<%@ page isThreadSafe="false" %>  
	<body>
		<div class="bodyDiv">
			<%
				String deal = request.getParameter("deal"); //Check if deal or no deal was clicked

				if(deal == null && !player.isEndRound()) //If player attempts to access this page when not in the correct round redirect back to game.jsp
				{			
					response.sendRedirect("Game.jsp");
					return;					
				}				
				
				if(deal != null && deal.equals("noDeal")) //If no deal was clicked continue on to the next round
				{
					player.setEndRound(false);
					response.sendRedirect("Game.jsp");
					return;		
				}
			%>
		
			<form name="endRound" method="post" action="EndRound.jsp">
				<input type="hidden" id="deal" name="deal" value="" />
				
				<% if(player.getCurrentRound() != 6 && deal == null) {%>
				
				<h1><%= "Round: " + (player.getCurrentRound() - 1) %></h1>
				
				<table class="endRound">
					<tr>
						<td colspan="2">
							<p>
								Largest amount remaining: <jsp:getProperty property="largestAmount" name="player"/>								
							</p>
						</td>
					</tr>
				<tr>
					<td colspan="2"><p><%="Bank Offer: $" + player.bankOffer()%></p></td>
				</tr>
				<tr>
						<td>
							<div class="tdDeal">
								<a href="javascript: deal(true)">Deal</a>
							</div>
						</td>
						<td>
							<div class="tdNoDeal">
								<a href="javascript: deal(false)">No Deal</a>
							</div>
						</td>
					</tr>
				</table>						
				<%}
				  else {				  
				  %>
				  <div class="win">
					  <p>
						  Congratulations you have won: $<jsp:getProperty property="win" name="player"/>
					  </p>
					  <% session.invalidate(); %>
					  <a href="Game.jsp">New Game</a>
				  </div>
				<%} %>
			</form>
		</div>
	</body>
</html>