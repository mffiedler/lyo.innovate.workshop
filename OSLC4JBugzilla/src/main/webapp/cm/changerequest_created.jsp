<!DOCTYPE html>
<html>
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
    Michael Fiedler  - adapter for OSLC4J
--%>
<%@ page contentType="text/html" language="java" pageEncoding="UTF-8" %> 
<%@ page import="org.eclipse.lyo.oslc4j.bugzilla.resources.BugzillaChangeRequest" %>
<% 
BugzillaChangeRequest   changeRequest     = (BugzillaChangeRequest)request.getAttribute("changeRequest");
String changeRequestUri  = (String)request.getAttribute("changeRequestUri");
String title   = changeRequest.getTitle();
%>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<script type="text/javascript"> 
   var response = "oslc-response:{\"oslc:results\" \: [{ \"oslc:label\" : \"<%= title %>\", \"rdf:resource\" : \"<%=changeRequestUri %>\"}]}";
   window.postMessage(response, "*");
</script>
</head>
<body>
</body>
</html>
