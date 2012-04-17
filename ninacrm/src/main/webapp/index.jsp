<html>
<%@ page import="java.util.*, java.net.*" %>
<head>
	<title>Incident #676</title>
	<link rel="stylesheet" type="text/css" href="oslc-tools.css" />

    <!-- ======================================================================
	Dojo framework includes and requires
	-->
	<link rel="stylesheet" type="text/css" href="dojo.css">
	<link rel="stylesheet" type="text/css" href="dijit/themes/tundra/tundra.css">
	<script type="text/javascript" src="dojo/dojo.js" djConfig="parseOnLoad:true"></script>
	<script type="text/javascript">
		dojo.require("dojo.parser");
	    dojo.require("dijit.Dialog");	
	    dojo.require("dijit.Tooltip");	
	    dojo.require("dijit.form.Button");	
	    dojo.require("dijit.form.Form");	
	    dojo.require("dijit.form.TextBox");	
		dojo.require("dojo.NodeList-manipulate");
	</script>
	
</head>
<body class="tundra">
<div id="wrapper">


<!-- ==========================================================================
HTML display of incident
-->

<h2>Incident #676</h2>

<p style="width:100%; border: 1px solid grey"><span id="status">Status</span></p>

<table border="0" width="40%">
<tr>
	<td><b>Customer</b></td>
	<td>Totally Fictional Corporation, Inc.</td>
</tr>
<tr>
	<td><b>Created</b></td>
	<td>Feb. 15, 2011</td>
</tr>
<tr>
	<td><b>Updated</b></td>
	<td>Feb 21, 2011</td>
</tr>
<tr>
	<td><b>Status</b></td>
	<td>OPEN</td>
</tr>
</table>

<p><b>Description</b>: Lorem ipsum et cum fabulas indoctum consequuntur, te 
eum habeo eleifend. Usu cetero scribentur no, ius ad nominati accusamus 
accommodare. Dolorem appellantur te mel, nihil latine expetendis usu at,
mel ei prima graeco. Harum scribentur est in. Mel cu natum interesset, suas
 menandri salutatus at est, debet ignota qui an. Epicurei scribentur ei pri. 
 Cu utroque vituperata cum, agam invidunt ei nec, eum eu sonet  possit.</p>
 

<!-- ==========================================================================
Add link by entering URL and name
-->

<button id="addLinkButton" type="button" 
	dojoType="dijit.form.Button" onclick="showAddLinkDialog()">
    Add Link...
</button>

<div dojoType="dijit.Dialog" id="addLinkDialog" title="Add Link">
	<form id="newLinkForm" dojoTyp="dijit.form.Form">
		<table>
			<tr>
				<td>Name:</td>
				<td><input name="linkname" id="linkname" type="text" value="Bug 1"
					dojoType="dijit.form.TextBox" /></td>
			</tr>
			<tr>
				<td>URL:</td>
				<td><input name="linkurl" id="linkurl" type="text" name="linkurl" value="http://oslc/bugzilla/show_bug.cgi?id=1"
					dojoType="dijit.form.TextBox" /></td>
			</tr>
		</table>
		<button id="addLinkButton" type="button" 
			onclick="saveNewLink()">Add</button>
		<button id="cancelLinkButton" type="button" 
			onclick="cancelAddLinkDialog()">Cancel</button>
	</form>
</div>

<script language="JavaScript">

function showAddLinkDialog(url,width,height) {
	dijit.byId("addLinkDialog").show();
}

function cancelAddLinkDialog() {
	dijit.byId("addLinkDialog").hide();
}

function saveNewLink() {
	dijit.byId("addLinkDialog").hide();
	var link = dojo.formToObject("newLinkForm");
	if (link.linkname.length > 0 && link.linkurl.match("http")) {
		addLink(link.linkname, link.linkurl);
	} else {
		alert("Invalid link, not added");
	}
}
</script> 


<!-- ==========================================================================
Add link via OSLC Delegated Picker
-->

<button id="selectDefectButton" type="button" 
	dojoType="dijit.form.Button" onclick="selectDefect()">  
    Select Defect to Link to...
</button>
 
<button id="createDefectButton" type="button" 
	dojoType="dijit.form.Button" onclick="createDefect()">
    Create Defect to Link to...
</button>


<!-- ==========================================================================
List of defects, each with OSLC UI Preview 
-->

<h3>Related Defects</h3> 
<ul id="linkList">
<%
Map<URL, String> data = (Map<URL, String>)request.getAttribute("data");
for (URL url : data.keySet()) { %>
    <li><a href="<%= url.toString() %>"><%= (String)data.get(url) %></a></li>
<% } %>
</ul>

</div> <!--  end wrapper -->


<!-- ==========================================================================
Code for OSLC UI Preview 
-->

<script language="JavaScript">

dojo.addOnLoad(addPreviewMouseOverHandlers);	

function addPreviewMouseOverHandlers() {
   dojo.query("a").forEach(function(elem) {
      elem.onmouseover = function() { showPreview(elem); };
    });
}

/* show UI Preview for specified link element */
function showPreview(elem) { // (1) 
   var previewURI = elem.getAttribute("href"); // (2) 
   if (!previewURI) return;
   dojo.xhrGet({  // (3) 
      url: "http://oslc:8181/ninacrm/proxy?uri=" + previewURI,
      handleAs:"xml",
      headers: {
         "Accept": "application/x-oslc-compact+xml" // (4) 
      },
      load: function(data) {
         try {
            var previewData = parsePreview(data); // (5) 
            var html = "<iframe src='" + previewData.uri + "' "; // (6) 
            var w = previewData.width ? previewData.width : "30em";
            var h = previewData.height ? previewData.height : "10em";
            html += " style='border:0px; height:" + h + "; width:" + w + "'";
            html += "></iframe>";
            var tip = new dijit.Tooltip({label: html, connectId: elem}); // (7) 
            tip.open(elem);
         } catch (e) { // (8) 
	        var tip = new dijit.Tooltip({label: "Error parsing", connectId: elem});
	        tip.open(elem);
         }
      },
      error: function (error) {
         var tip = new dijit.Tooltip({label: "Preview not found", connectId: elem});
         tip.open(elem); // (10) 
      }
   });
}

/* parse OSLC UI Preview XML into JSON structure with uri, h and w */
function parsePreview(xml) { // (1)  
   var ret = {};
   var compact = firstChild(firstChild(xml));
   var preview = firstChild(
      firstChildNamed(compact,'oslc:smallPreview')); // (2) 
   if (preview) {
      var document = firstChildNamed(preview, 'oslc:document');
      if (document) ret.uri = document.getAttribute('rdf:resource');
      ret.height = firstChildNamed(preview, 'oslc:hintHeight').nodeValue;
      ret.width = firstChildNamed(preview, 'oslc:hintWidth').nodeValue;
   }
   return ret;
}

function firstChild(e) { // (3) 
   for (i=0; i<e.childNodes.length; i++) {
      if (e.childNodes[i].nodeType == Node.ELEMENT_NODE) {
	   return e.childNodes[i];
      }
   }
}

function firstChildNamed(e, nodeName) { // (4) 
   for (i=0; i<e.childNodes.length; i++) {
      if (e.childNodes[i].nodeType == Node.ELEMENT_NODE 
         && e.childNodes[i].nodeName == nodeName) {
	   return e.childNodes[i];
      }
   }
}

/* ========================================================================== 
Code for OSLC Delegated UI 
*/

var createDialogURL = "http://oslc:8282/bugz/creator?productId=1";
var selectDialogURL = "http://oslc:8282/bugz/selector?productId=1";
var returnURL       = "http://oslc:8181/ninacrm/blank.html";

function selectDefect() {
	windowNameProtocol(selectDialogURL);
}

function createDefect() {
	windowNameProtocol(createDialogURL);
}

var frame;
function windowNameProtocol(dialogURL) {	
	// Step #1: create iframe with fragment to indicate protocol 
	// Step #2: set the iframe's window.name to indicate the Return URL 
	var ie = window.navigator.userAgent.indexOf("MSIE");
	if (ie > 0) {
		frame = document.createElement('<iframe name=\'' + returnURL + '\'>');
	} else {
		frame = document.createElement('iframe');
		frame.name = returnURL;
	}
	frame.src = dialogURL + '#oslc-core-windowName-1.0';
	frame.width = 450;
	frame.height = 300;

	displayFrame(frame);

	// Step #3: listen for onload events on the iframe
	if (ie > 0) {
		status("Add onload handler using attachEvent for IE");
		frame.attachEvent("onload", onFrameLoaded);
	} else {
		status("Add onload handler the normal way");
		frame.onload = onFrameLoaded;
	}
}

function onFrameLoaded() {
	try { // May throw an exception if the frame's location is still a different origin 
		// Step #4: when frame's location is equal to the Return URL 
		// then read response and return.
		//alert(frame.contentWindow.location);
		if (frame.contentWindow.location.toString() == returnURL) {
			status("User made selection");
			var message = frame.contentWindow.name;
			destroyFrame(frame);
			handleMessage(message);
		} 	     
	} catch (e) { 
		// ignore: access exception when trying to access window name 
	}
}

var dialog;
function displayFrame(frame) {
	if (!dialog) dialog = new dijit.Dialog();
	dialog.setContent(frame);
	dialog.show();
}

function destroyFrame(frame) {
	dialog.hide();
}

function handleMessage(message) {
	var json = message.substring(message.indexOf("{"), message.length);
	var results = eval("(" + json + ")");
	var linkname = results["oslc:results"][0]["oslc:label"];
	var linkurl = results["oslc:results"][0]["rdf:resource"];
    addLink(linkname, linkurl);
}
	
function addLink(linkname, linkurl) {
    dojo.xhrPost( {  
        url: "http://oslc:8181/ninacrm/data",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        postData: "linkname=" + linkname + "&linkurl=" + linkurl,
        load: function(data) {
            status("Added link!");
            var li = document.createElement("li");
            li.innerHTML = "<a href='" + linkurl + "' onclick='showPreview()'>" + linkname + "</a>";
            var ul = dojo.byId("linkList").appendChild(li);
            addPreviewMouseOverHandlers();
        },
        error: function (error) {
            status("Error adding link!");
        }
    });
}
	


function status(msg) {
	document.getElementById("status").innerHTML = msg;
}
</script>

</html>
