<%@ page import="org.dhbw.imbit11.ApplicationConstants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">


		
	<!-- Autor: Alexander Hager WIMBIT 16B 2018-->


<head>
	<title>Quizübersicht IT</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" href="../css/QuizOverview.css">
    <link rel="stylesheet" href="../css/octopus.css">	
	<link rel="shortcut container" href="../img/favcontainer.ico" type="image/ico" />
	<link rel="stylesheet" type="text/css" href="../css/quiz.css" />
	<link rel="stylesheet" type="text/css" href="../css/fonts.css" />
	<script language="javascript" type="text/javascript" src="../js/quiz.js"></script>
	<script src="../js/jquery/jquery-3.3.1.min.js"></script>


	<style>
		html {
			 overflow-x: hidden;}
	</style>
	<div id="video_pattern"></div>
	
		
	
</head>


<body>
	<div></div>
	</div><img class="octo_kopf" src="../img/Tintenfisch_Kopf_HOME_gedreht_ex.png" alt=""/></div>
	<div class="Aufforderung">
		Hilf mir die IT aufzubauen!
	</div>
	
	<div class="containerFlex">

			<div class="container tooltiphover">  <!--workaround um Karkenkopf auszuweichen -->
				</div>


		<div class="container tooltiphover">
	
			<a href="../quiz/quiz.jsp?subject=verteilteSysteme" target="_blank">
			<span class="" ><img class="fisch" src="../img/QuizMeerestiere/it/it-01.png"></span>
			
			<p class="Untertitel">Verteilte&nbsp;Systeme</p>

			<p class="IntroText">Die IMBIT-Kra&shy;ke will fort&shy;ge&shy;schrit&shy;te&shy;ne Funk&shy;tio&shy;nen im Web ab&shy;bil&shy;den.<p>
			</a>
		</div>
	
		
		<div class="container tooltiphover">
			<a href="../quiz/quiz.jsp?subject=ITIntro" target="_blank">
			<span class="" ><img class="fisch" src="../img/QuizMeerestiere/it/it-02.png"></span>
			
			<p class="Untertitel">IT In&shy;tro</p>
			
			<p class="IntroText">Die IMBIT-&shy;Kra&shy;ke kann ge&shy;ra&shy;de so ih&shy;ren Com&shy;pu&shy;ter an&shy;schal&shy;ten. Sie muss wohl noch et&shy;was mehr ler&shy;nen!<p>
		
			</a>
		</div> 
		

	
		<div class="container tooltiphover">
	
			<a href="../quiz/quiz.jsp?subject=datenbanken" target="_blank">
			<span class="" ><img class="fisch" src="../img/QuizMeerestiere/it/it-03.png"></span>
			
			<p class="Untertitel">Da&shy;ten&shy;bank&shy;en</p>

			<p class="IntroText">Das Un&shy;ter&shy;neh&shy;men der IMBIT-&shy;Kra&shy;ke braucht auch eine Da&shy;ten&shy;bank. Weißt du ge&shy;nug, um Da&shy;ten&shy;bank&shy;spe&shy;zia&shy;list zu wer&shy;den?!?<p>
			</a>
		</div>
		
		
		
		<div class="container tooltiphover">
			<a href="../quiz/quiz.jsp?subject=webprogrammierung" target="_blank">
			<span class="" ><img class="fisch" src="../img/QuizMeerestiere/it/it-04.png"></span>
			
			<p class="Untertitel">Web&shy;pro&shy;gram&shy;mie&shy;rung</p>
			
			<p class="IntroText">Dem Un&shy;ter&shy;neh&shy;men der IMBIT-&shy;Kra&shy;ke fehlt noch ein In&shy;ter&shy;net&shy;auf&shy;tritt. Kannst du ihr hel&shy;fen?<p>
			</a>
		</div> 

		
		

	
	
		<div class="container tooltiphover">
			<a href="../quiz/quiz.jsp?subject=kommunikationssysteme" target="_blank">
			<span class="" ><img class="fisch" src="../img/QuizMeerestiere/it/it-05.png"></span>
			
			<p class="Untertitel">Kom&shy;mu&shy;ni&shy;ka&shy;tions&nbsp;sys&shy;teme</p>

			<p class="IntroText">Die IMBIT-&shy;Kra&shy;ke möchte he&shy;raus&shy;fin&shy;den, wie das In&shy;ter&shy;net funk&shy;ti&shy;o&shy;nie&shy;rt. Hilf ihr!<p>
			</a>
		</div> 
	
	
		
	
		<div class="container tooltiphover">
			<a href="../quiz/quiz.jsp?subject=betriebssysteme"target="_blank">
			<span class="" ><img class="fisch" src="../img/QuizMeerestiere/it/it-06.png"></span>
			
			<p class="Untertitel">Betriebssysteme</p>
			
			<p class="IntroText">Die IMBIT-&shy;Kra&shy;ke hat Sys&shy;tem 32 ge&shy;löscht! Hilf ihr he&shy;raus&shy;zu&shy;fin&shy;den wie ein Be&shy;triebs&shy;sys&shy;tem funk&shy;ti&shy;o&shy;niert um Win&shy;dows neu zu in&shy;stal&shy;lie&shy;ren.<p>
		 
			</a>
		</div> 
	
	</div>

	

	<!--Rocketbar + kleiner Krakenarm aus rocketbar.html geladen-->
	<footer></footer>
	<script>
		document.onload = $("footer").load("rocketbarQuiz.html");
	</script>
</body>
</html>