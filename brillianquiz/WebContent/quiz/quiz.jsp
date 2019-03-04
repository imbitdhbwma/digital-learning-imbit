<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="de">
<head>
<link
	rel="shortcut icon"
	href="../img/favicon.ico"
	type="image/x-icon">
<meta charset="UTF-8">
<title>Quiz</title>
<link
	rel="stylesheet"
	type="text/css"
	href="dev_files/main.css" />

<link
	rel="stylesheet"
	type="text/css"
	href="dev_files/Quiz_checkbox.css" />
<link
	rel="stylesheet"
	type="text/css"
	href="dev_files/Quiz_Drag.css" />
<link
	rel="stylesheet"
	type="text/css"
	href="dev_files/Quiz_Radiobutton.css" />
<link
	rel="stylesheet"
	type="text/css"
	href="dev_files/Quiz_Text.css" />
<link
	rel="stylesheet"
	type="text/css"
	href="dev_files/Quiz_Table.css" />
<link
	rel="stylesheet"
	type="text/css"
	href="dev_files/Quiz_Order.css" />

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	type="text/javascript"
	src="dev_files/helper.js"></script>
<link
	rel="stylesheet"
	type="text/css"
    href="../css/fonts.css" />
</head>

<body>
	<div>
		<div class="title" id="title">
			<h1></h1>
		</div>

		<div>
			<ol id="questionList">	
			</ol>
		</div>
		
		<button id="submit" class="button">Zur Auswertung
		</button>

		<div class="title">
				<p id="result"> </p>
		</div>
		
		<div>
			<p id="resultText"> </p>
	</div>
	</div>


	<div id="tl">
		<img
			id="tentakel_l"
			src="../img/tentakel_ltr.png">
	</div>
	<div id="tr">
		<img
			id="tentakel_r"
			src="../img/tentakel_rtl.png">
    </div>
	
	<script>
			
		//get Parameter aus der URL, um entsprechendes Fach aus dem Json zufiltern 
		function getParameter(key) {
				var query = window.location.search.substring(1); 
				var pairs = query.split('&');
		
				for (var i = 0; i < pairs.length; i++) {
				var pair = pairs[i].split('=');
				if(pair[0] == key) {
						if(pair[1].length > 0)
					return pair[1];
				}  
				}
		
				return undefined;  
		};
		
		var key = 'subject';
		var value = getParameter(key);
		
		//if (value) alert(value);//Für Testzwecke
	
		$(function() {
			var array = [];
			anzahlFragen = 0;
			maxScore = 0;
			score = 0;
	
			//json Datei laden
			$.getJSON("dev_files/convertcsv.json", function(data) {
					//Schleife iteriert durch das Array
					$.each(data, function(i, f) {
						var subject = f.subject;
						var questionType= f.questionType;
						var question= f.question;
						var answers = f.answers;
						var correct = f.correct;
						var title = f.title;

						
						// console.log(answers); Test ob Variable ausgelesen wird

						
	
						// Anzeige der Fragen sortiert nach questionType
						if(subject===value) {
							//Erzeugt Überschrift
							document.getElementById('title').innerHTML = "Quiz "+ value;

							switch (questionType){
								case "MC": 
								$(document).ready(function() {
									createMC(
										question,
										answers,
										correct
									);
								});
								break;
	
								case "SC": 
								$(document).ready(function() {
									createSC(
										question,
										answers,
										correct
									);
								});
								break;
	
								case "DD": 
								$(document).ready(function() {
									createDD(
										question,
										answers,
										title,
										correct
									);
								});
								break;
								
								case "TL": 
								$(document).ready(function() {
									createTL(
										question,
										answers,
										title,
										correct
									);
								});
								break;
	
								case "TQ": 
								$(document).ready(function() {
									createTQ(
										question,
										answers,
										title,
										correct
									);
								});
								break;
	
								case "OD": 
								$(document).ready(function() {
									createOD(
										question,
										answers,
										correct
									);
								});
								break;
							}	

							anzahlFragen++;
							console.log(anzahlFragen);
							var maxScore = anzahlFragen;
						}
					});
					//Variable anzahlFragen verfügbar console.log(anzahlFragen);
					document.getElementById("submit").addEventListener('click', evaluate);
						//console.log("Clicked!");
				});
			});
		</script>


    

</body>

</html>

