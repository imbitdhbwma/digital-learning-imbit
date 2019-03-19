<%@ page import="org.dhbw.imbit11.ApplicationConstants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<!-- <html xmlns="http://www.w3.org/1999/xhtml"  style="width:100%; margin:0; padding:0 ">-->
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width = device-width, initial-scale = 1">
<title><%=ApplicationConstants.PAGETITLE_LOGIN%></title>
<link rel="stylesheet" href="style.css">
<script src="js/jquery/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="js/fancybox/dist/jquery.fancybox.min.css" />
<script src="js/fancybox/dist/jquery.fancybox.min.js"></script>
<script>
$(document).ready(function(){
	DivObject = function() {
		var imgs = ['img/QuizMeerestiere/bwl/bwl-01.png', 'img/QuizMeerestiere/wi/wi-01.png', 'img/QuizMeerestiere/it/it-01.png'];
		<!--var zrandom = Math.floor((Math.random() * -100) - 10);-->
		this.div = document.createElement("div");
		document.body.appendChild(this.div);
		this.div.className = "fish";
		this.div.style.top = parseInt( 100 * Math.random() ) + "%" ;
	    this.div.style.left = parseInt( 100 * Math.random() ) + "%" ;
		this.div.style.backgroundImage = 'url(' + imgs[Math.floor(Math.random() * imgs.length)] + ')';
		<!--this.div.style.zIndex = zrandom;-->
	}
})
</script>
</head>

<body>

<div class="container">
<p style="color: red; text-align: left;">${error}</p>
</div>

<a href="#" onclick="new DivObject()">Fish</a>

<!-- <h1>h1</h1> Inhalt 
<div class="outer">
<div class="inner" align="center">-->
<figure>
	<a href="/brillianQUIZ/content/QuizzesWI.jsp" style="text-decoration:none;">
	<img class="animated" src="img/animated/wi.gif" alt="WI">
	<figcaption>WI</figcaption>
	<!-- <p class="title"> Wirtschaftsinformatik </p> -->
	</a>
</figure>

<figure>
	<a href="/brillianQUIZ/content/QuizzesBWL.jsp" style="text-decoration:none;">
	<img class="animated" src="img/animated/bwl.gif" alt="BWL">
	<!-- <p class="title"> BWL </p> -->
	<figcaption>BWL</figcaption>
	</a>
</figure>

<figure>
	<a href="/brillianQUIZ/content/QuizzesIT.jsp" style="text-decoration:none;">
	<img class="animated" src="img/animated/it.gif" alt="IT">
	<!-- <p class="title"> IT </p> -->
	<figcaption>IT</figcaption>
	</a>
</figure>

<!--</div>
</div>-->

<div class="loginkopf">
<a data-fancybox="login" data-src="#login" href="javascript:;"><img src="img/background/kopf01.png" alt="Login"> </a>
</div>
         

    <form id="login" action="LoginUser" method="post" style="display: none;width:100%;max-width:400px;">
        <h2 class="mb-3">
            Hallo!
        </h2>
        <p>
           Willst du deinen Fortschritt speichern?
        </p>
        <p>
            <input type="text" value="" name="username" class="form-control" placeholder="Email" />
        </p>
        <p>
            <input type="password" value="" name="password" class="form-control" placeholder="Paswort" />
        </p>
        <p class="mb-0 text-right">
            <input type="submit" class="btn btn-primary" value="Anmelden" />
        </p>
		<a href='resetpw.jsp'>Passwort vergessen?</a>
		<a href="Registration?g=000">Konto erstellen</a>
    </form>



</body>

</html>