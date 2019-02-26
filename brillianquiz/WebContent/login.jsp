<?xml version="1.0" encoding="UTF-8" ?>
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
</head>

<body>

<div class="container">
</div>

<a href="#" onclick="new DivObject()">Fish</a>

<!-- <h1>h1</h1> Inhalt -->
<div class="outer">
<div class="inner" align="center">
<a href="../../../brillianideas/brillianIDEAS/content/QuizzesWI.html" style="text-decoration:none;">
<img class="animated" src="img/animated/wi.gif" alt="WI">
<!-- <p class="title"> Wirtschaftsinformatik </p> -->
</a>
<a href="../../../brillianideas/brillianIDEAS/content/QuizzesBWL.html" style="text-decoration:none;">
<img class="animated" src="img/animated/bwl.gif" alt="BWL">
<!-- <p class="title"> BWL </p> -->
</a>
<a href="../../../brillianideas/brillianIDEAS/content/QuizzesIT.html" style="text-decoration:none;">
<img class="animated" src="img/animated/it.gif" alt="IT">
<!-- <p class="title"> IT </p> -->
</a>
</div>
</div>

<div class="loginkopf">
<a data-fancybox="login" data-src="#login" href="javascript:;"><img src="img/background/kopf01.png" alt="Login"> </a>
</div>
         

    <form id="login" action="LoginUser" method="post" style="display: none;width:100%;max-width:660px;">
        <h2 class="mb-3">
            Hallo!
        </h2>
        <p>
            Melde dich an, um deinen Fortschritt zu speichern.
        </p>
        <p>
            <input type="text" value="" name="name" class="form-control" placeholder="Email" />
        </p>
        <p>
            <input type="password" value="" name="password" class="form-control" placeholder="Paswort" />
        </p>
        <p class="mb-0 text-right">
            <input data-fancybox-close type="button" class="btn btn-primary" value="Anmelden" />
        </p>
		<a href='resetpw.jsp'>Passwort vergessen?</a>
		<a href="Registration?g=000">Konto erstellen</a>
    </form>

</body>
<script>
	DivObject = function() {
		this.div = document.createElement("div");
		document.body.appendChild(this.div);
		this.div.className = "fish";
	}
</script>
</html>