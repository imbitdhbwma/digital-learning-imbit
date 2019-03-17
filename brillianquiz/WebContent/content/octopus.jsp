<%@ page import="org.dhbw.imbit11.ApplicationConstants"%>
<%@ page language="java" contentType="text.jsp; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE.jsp>
.jsp>
	<head>
		<meta charset="UTF-8">
		<title>brillianIDEAS</title>
		<link rel="shortcut icon" href="../img/favicon.ico" type="image/x-icon">
		<link rel="icon" href="../img/favicon.ico" type="image/x-icon">
		<link rel="stylesheet" href="../css/core-a.css">
		<link rel="stylesheet" href="../css/color-a.css">
		<link rel="stylesheet" href="../css/octopus.css">
		<link rel="stylesheet" href="../css/dots.css" />
		<link rel="stylesheet" href="../css/curriculum.css"> 
		<link rel="stylesheet" href="../css/ipad.css" />
		<link rel="stylesheet" href="../css/fonts.css" />
		<link rel="stylesheet" type="text/css" href="../css/digitallearning.css">
		<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
		<script src="../js/jquery/jquery-3.3.1.min.js"></script>
		<link rel="stylesheet" type="text/css" href="../css/QuizOverview.css">

		<!-- Old jQuery for jQuery Mobile Support -->
		<!-- <script src="../js/jquery.min.js"></script> --> <!-- Dieses script löst den doppelten Hintergrund aus. Ist aber auch für Mobile Safari notwendig. -->
		<script src="../js/velocity.min.js"></script>
		<!-- Custom jQuery Mobile - Touch Only -->
		<script src="../js/jquery.mobile.custom.min.js"></script>
		<script src="../js/jquery.waitforimages.js"></script>
		<script src="../js/navigation.js"></script>
		<script type="text/javascript" src="../js/einstellung.js"></script>
	</head>

	<body style="position: fixed;">

		<!-- Bubbles, bubbles everywhere! ~RAHS -->
		<video
			id="video_background"
			preload="auto"
			autoplay="true"
			loop="loop"
			muted="muted"
			volume="0">
			<source
				src="../img/Background.mp4"
				type="video/mp4">
		</video>
	
		<div
			id="container"
			style="display: block">
				<img
					class="background_image"
					id="octo_kopf"
					src="../img/Tintenfisch_Kopf_HOME_gedreht_ex.png"
					alt="" />
				<div id="Titeltext">
					Hallo, ich bin <a href="https://www.duden.de/rechtschreibung/Krake">der/die</a>
					IMBIT-Krake! Hilfst du mir mein IT-Unternehmen aufzubauen?
				</div>

				<div class="tooltip">
					<a href="QuizzesIT.jsp"> <img
						class="octo_arm_links"
						src="../img/tentakel_ltr.png"
						alt="" /> <span class="tooltiptext_l">Hilf die IT
							aufzubauen!</span>
					</a>
				</div>

				<div class="tooltip">
					<a href="QuizzesBWL.jsp"> 
							<img class="octo_arm_rechts_unten"  src="../img/tentakel_rtl.png" alt=""/> 
						</a>
						<span class="tooltiptext">Hilf das Unternehmen
							zu führen!</span>
					
				</div>

				<div class="tooltip">
					<a href="QuizzesWI.jsp"> <img
						class="background_image"
						id="octo_arm_rechts_oben"
						src="../img/tentakelarm_u11.png"
						alt="" /> <span class="tooltiptext_ro">Hilf BWL und IT zu
							vereinen!</span>
					</a>
				</div>
		</div>
		
		<footer></footer>
		<script>
			document.onload = $("footer").load("rocketbar.html");
		</script>
	</body>
<.jsp>