<!DOCTYPE html>
<%--
 Copyright (c) 2011, 2012 IBM Corporation.

 All rights reserved. This program and the accompanying materials
 are made available under the terms of the Eclipse Public License v1.0
 and Eclipse Distribution License v. 1.0 which accompanies this distribution.
 
 The Eclipse Public License is available at http://www.eclipse.org/legal/epl-v10.html
 and the Eclipse Distribution License is available at
 http://www.eclipse.org/org/documents/edl-v10.php.
 
 Contributors:
 
    Sam Padgett		 - initial API and implementation
    Michael Fiedler	 - adapted for OSLC4J
--%>
<%@ page contentType="text/html" language="java" pageEncoding="UTF-8" %>
<%@ page import="org.eclipse.lyo.oslc4j.core.model.Service" %>
<%@ page import="org.eclipse.lyo.oslc4j.core.model.ServiceProvider" %>

<%
String bugzillaUri = (String) request.getAttribute("bugzillaUri");
Service service = (Service)request.getAttribute("service");
ServiceProvider serviceProvider = (ServiceProvider)request.getAttribute("serviceProvider");
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
		<title>Bugzilla OSLC Adapter: Service Provider for <%= serviceProvider.getTitle() + "(" + serviceProvider.getIdentifier() + ")" %></title>
		<link href="<%= bugzillaUri %>/skins/standard/global.css" rel="stylesheet" type="text/css">
		<link href="<%= bugzillaUri %>/skins/standard/index.css" rel="stylesheet" type="text/css">
		<link href="<%= bugzillaUri %>/skins/standard/global.css" rel="alternate stylesheet" title="Classic" type="text/css">
		<link href="<%= bugzillaUri %>/skins/standard/index.css" rel="alternate stylesheet" title="Classic" type="text/css">
		<link href="<%= bugzillaUri %>/skins/contrib/Dusk/global.css" rel="stylesheet" title="Dusk" type="text/css">
		<link href="<%= bugzillaUri %>/skins/contrib/Dusk/index.css" rel="stylesheet" title="Dusk" type="text/css">
		<link href="<%= bugzillaUri %>/skins/custom/global.css" rel="stylesheet" type="text/css">
		<link href="<%= bugzillaUri %>/skins/custom/index.css" rel="stylesheet" type="text/css">
		<link rel="shortcut icon" href="<%= bugzillaUri %>/images/favicon.ico">
	</head>
	<body onload="">
	
		<div id="header">
			<div id="banner"></div>
			<table border="0" cellspacing="0" cellpadding="0" id="titles">
				<tr>
					<td id="title">
						<p>
							Bugzilla OSLC Adapter: Service Provider
						</p>
					</td>
					<td id="information">
						<p class="header_addl_info">
							version 0.1
						</p>
					</td>
				</tr>
			</table>
		</div>
		
		<div id="bugzilla-body">
			<div id="page-index">
			
				<img src="../../images/resources/bugzilla.gif" alt="icon" width="80" height="80" />
	
				<h1>Service Provider for <%= serviceProvider.getTitle() + "(" + serviceProvider.getIdentifier() + ")" %></h1>
				
				<p>Enables navigation to OSLC-CM Resource Creator and Selector Dialogs</p>

	            <table>
		            <tr>
			            <td><b>This document</b>:</td>
			            <td><a href="<%= serviceProvider.getAbout() %>">
			            <%= serviceProvider.getAbout() %></a></td>
		            </tr>
		            <tr>
			            <td><b>Bugzilla</b>:</td>
			            <td><a href="<%= bugzillaUri %>"><%= bugzillaUri %></a></td>
		            </tr>
		            <tr>
			            <td><b>Adapter Publisher</b>:</td>
			            <td>Eclipse Lyo</td>
		            </tr>
		            <tr>
			            <td><b>Adapter Identity</b>:</td>
			            <td>org.eclipse.lyo.oslc4j.bugzilla.test</td>
		            </tr>
	            </table>
            								
				<h2>OSLC-CM Resource Selector Dialog</h2>
				<p><a href="<%= service.getSelectionDialogs()[0].getDialog().toString() %>">
				            <%= service.getSelectionDialogs()[0].getDialog().toString() %></a></p>
				
				<h2>OSLC-CM Resource Creator Dialog</h2>
				<p><a href="<%= service.getCreationDialogs()[0].getDialog().toString() %>">
				            <%= service.getCreationDialogs()[0].getDialog().toString() %></a></p>
			
				<h2>OSLC-CM Resource Creation Factory and Resource Shape</h2>
				<p><a href="<%= service.getCreationFactories()[0].getCreation().toString() %>">
				<%= service.getCreationFactories()[0].getCreation().toString() %></a></p>
				<p><a href="<%= service.getCreationFactories()[0].getResourceShapes()[0].toString() %>">
				            <%= service.getCreationFactories()[0].getResourceShapes()[0].toString() %></a></p>
				
				<h2>OSLC-CM Resource Query Capability and Resource Shape</h2>
				<p><a href="<%= service.getQueryCapabilities()[0].getQueryBase().toString() %>">
				<%= service.getQueryCapabilities()[0].getQueryBase().toString() %></a></p>
				<p><a href="<%= service.getQueryCapabilities()[0].getResourceShape().toString() %>">
				            <%= service.getQueryCapabilities()[0].getResourceShape().toString() %></a></p>
			
			</div>
		</div>
		
		<div id="footer">
			<div class="intro"></div>
			<div class="outro">
				<div style="margin: 0 1em 1em 1em; line-height: 1.6em; text-align: left">
					<b>OSLC Tools Adapter Server 0.1</b> brought to you by <a href="http://eclipse.org/lyo">Eclipse Lyo</a><br>
				</div>
			</div>
		</div>
	</body>
</html>