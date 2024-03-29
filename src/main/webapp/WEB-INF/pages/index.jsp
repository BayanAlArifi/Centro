<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.centro.util.PlaceType" %>
<%@ page import="com.centro.util.TransportationMode" %>
<%  pageContext.setAttribute("placeTypes", PlaceType.values()); %>
<%  pageContext.setAttribute("transportationModes", TransportationMode.values()); %>
<html>
<head>
	<meta charset="utf-8">
	<title>Centro</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- Fav Icon -->
	<link rel="shortcut icon" href="<c:url value='/img/favicon.ico'/>" type="image/x-icon">
	<link rel="icon" href="<c:url value='/img/favicon.ico'/>" type="image/x-icon">

	<link rel="stylesheet" href="<c:url value='/resources/bootstrap/css/bootstrap.min.css'/>">
	<link href='https://fonts.googleapis.com/css?family=Fira+Sans' rel='stylesheet' type='text/css'>
	
	<!-- Centro theme -->
	<link rel="stylesheet" href="<c:url value='/resources/centro.css'/>">
        <script src="<c:url value='/resources/analytics/ga.js'/>"></script>
</head>
<body>
	<!-- Map Container -->
	<div id="map"></div>
	
	<div class="grey-bkg">
		<div class="logo-container">
			<img src="<c:url value='/img/logo.png'/>" />
			<p id="first-desc">
				Centro helps you to find the middle point between different locations. 
				It's easy, start by typing your address.
			</p>
			<p id="snd-desc">
				Now add the remaining addresses, when you're done click "Go". <br />
			</p>
		</div>
		
		<div style="padding: 0px 25px;">
			<form id="address-form">
				<div class="form-group">
					<div id="home-addon"><span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span></div>
					<input type="text" class="form-control" placeholder="Type your address.." id="address-input"><!--
				 --><button class="btn btn-success" type="submit" id="add-button"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
				 </div>
			</form>
			
			<div id="address-container"></div>
			<button class="btn btn-default submit">Go!</button>
		</div>
	</div>
	
	<div id="hamb-hidder" style="display:none;">
		<div id="hamburger">
			_<br />
			_<br />
			_<br />
		</div>
	</div>

	<div id="res-panel">
		<img src="<c:url value='/img/logo.png'/>" class="logo" />
		<h1>Middle point:</h1>
		<div class="res-detail">
		</div>
		
		<!--h1>Filters</h1-->
		<ul class="nav nav-tabs nav-justified filter-pills" role="tablist">
		    <li role="presentation" class="active"><a href="#dest-pane" aria-controls="dest-pane" role="tab" data-toggle="tab">Destination</a></li>
		    <li role="presentation"><a href="#start-pane" aria-controls="start-pane" role="tab" data-toggle="tab" id="start-pane-tab">Starting Points</a></li>
		</ul>

	  	<div class="tab-content filter-content">
		    <div role="tabpanel" class="tab-pane fade in active" id="dest-pane">
		    	<h2>Destination category</h2>
				<div class="form-group">
		            <select class="form-control" id="ResPlaceType">
		            	<option value="">Nothing specific</option>
		            	<option value="any" selected="selected">Any point of interest</option>
		                <c:forEach var="placeType" items="${placeTypes}">
		                    <option value="<c:out value="${placeType.getGoogleApiName()}"/>"><c:out value="${placeType.getFrontEndName()}"/></option>
		                </c:forEach>
		            </select>
				</div>
				<!-- h2>Meeting time</h2>
				<select class="form-control" id="hour">
					<option value="">--</option>
					<option value="0">0</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
					<option value="19">19</option>
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
				</select>
				:
				<select class="form-control" id="min">
					<option value="">--</option>
					<option value="0">0</option>
					<option value="5">5</option>
					<option value="10">10</option>
					<option value="15">15</option>
					<option value="20">20</option>
					<option value="25">25</option>
					<option value="30">30</option>
					<option value="35">35</option>
					<option value="40">40</option>
					<option value="45">45</option>
					<option value="50">50</option>
					<option value="55">55</option>
				</select><br /><br /-->
                <button class="btn btn-default" id="transportation"> Transportation Mode </button>
            </div>
                    
            <div role="tabpanel" class="tab-pane fade" id="start-pane">
	          <h2>Addresses</h2>
	          <form id="res-address-form">
				<div class="form-group">
				   <div id="res-home-addon"><span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span></div>
				   <input type="text" class="form-control" placeholder="Add more address.." id="res-address-input"><!--
				--><button class="btn btn-success" type="submit" id="res-add-button"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
				</div>
			 </form>
	         <div id="res-address-container"> </div>
	         </div>
		</div>
		<div id="save-button-container">
			<button class="btn btn-default submit btn-lg">Recalculate</button><br /><br />
			<button class="btn btn-default btn-success" id="save-button">Save/Share my search!</button>
		</div>
	</div>
	
	<div id="overlay" style="display:none;"></div>
	<div id="load-phrase" style="display:none;"></div>
	<div id="loader" style="display:none;">
		<img src="<c:url value='/img/loader.gif'/>" alt="loading" />
	</div>
	
	
	<!--  Util for cpy paste later on -->
	<div style="display:none;" id="mean-select">
		<select class="form-control mode">
            <c:forEach var="transportationMode" items="${transportationModes}">
                <option value="<c:out value="${transportationMode.getMapsFormat()}"/>"><c:out value="${transportationMode.getFrontEndName()}"/></option>
            </c:forEach>
        </select>
	</div>
	
	<div class="modal fade" id="directionModal" tabindex="-1" role="dialog" aria-labelledby="directionModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-body" id="direction-detail">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div class="modal fade" id="saveModal" tabindex="-1" role="dialog" aria-labelledby="saveModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	      	<h3>Save and share your search!</h3>
	      </div>
	      <div class="modal-body">
	      	You want to save that search and come back to it later? Don't worry, we have your back! Here, take this link on your journey:<br />
      		<div class="well">
	      		<a id="save-link"></a>
	      	</div>
	      	<a href="" id="fb-share" target="_blank">Share on Facebook</a> - <a href="" id="tw-share" target="_blank">Share on Twitter</a>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-body" style="text-align:center;">
			<img src="<c:url value='/img/503.jpg'/>" alt="503 - service unavailable	"/>
	        <span data-dismiss="modal" style="float:right;font-size:2em;cursor:pointer;"><span aria-hidden="true">&times;</span></span>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div class="modal fade" id="noplacesModal" tabindex="-1" role="dialog" aria-labelledby="noplacesModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-body" style="text-align:center;">
			<img src="<c:url value='/img/noplaces.jpg'/>" alt="No places available"/>
	        <span data-dismiss="modal" style="float:right;font-size:2em;cursor:pointer;"><span aria-hidden="true">&times;</span></span>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script src="<c:url value='/resources/jquery/jquery.min.js'/>"></script>
	<script src="<c:url value='/resources/bootstrap/js/bootstrap.min.js'/>"></script>
	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>
	<script src="<c:url value='/resources/centro.js'/>"></script>
	<script>
		var startMarkerIcon = "<c:url value='/img/small_pin.png'/>";
		var resMarkerIcon = "<c:url value='/img/marker.png'/>";
		var placeMarkerIcon = "<c:url value='/img/placeMarker.png'/>";
		var starsImg = "<c:url value='/img/stars.png'/>";
	</script>
</body>
</html>