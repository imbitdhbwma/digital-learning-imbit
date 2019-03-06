<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="de">
<head>
<link
	rel="shortcut icon"
	href="../../img/favicon.ico"
	type="image/x-icon">
<meta charset="UTF-8">
<title>Demo Quiz</title>
<link
	rel="stylesheet"
	type="text/css"
	href="../dev_files/main.css" />

<link
	rel="stylesheet"
	type="text/css"
	href="../dev_files/Quiz_checkbox.css" />
<link
	rel="stylesheet"
	type="text/css"
	href="../dev_files/Quiz_Drag.css" />
<link
	rel="stylesheet"
	type="text/css"
	href="../dev_files/Quiz_Radiobutton.css" />
<link
	rel="stylesheet"
	type="text/css"
	href="../dev_files/Quiz_Text.css" />
<link
	rel="stylesheet"
	type="text/css"
	href="../dev_files/Quiz_Table.css" />
<link
	rel="stylesheet"
	type="text/css"
	href="../dev_files/Quiz_Order.css" />

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	type="text/javascript"
	src="../dev_files/helper.js"></script>
<link
	rel="stylesheet"
	href="../../css/fonts.css" />

<script>
	//***********************
	//Diese Werte nicht verändern!
	var count = 1;
	var score = 0;
	//***********************
	//***********************
	//Hier bitte Werte eintragen!
	var anzahlFragen = 6;
	var maxScore = 6;
	//***********************
	$(document)
			.ready(
					function() {
						//Demo Multiple Choice Aufgabe mit drei Attributen: Frage als String, Antworten als Array und Lösungen als Array mit 1=richtig, 0=falsch
						createMC("TEST?", [ "A", "B", "C" ], [ 1, 1, 0 ]);
						//Demo Single Choice Aufgabe mit drei Attributen: Frage als String, Antworten als Array und Lösungen als Array mit 1=richtig, 0=falsch
						createSC("Meine SC Frage", [ "G", "H", "I" ],
								[ 0, 1, 0 ]);
						//Demo Drag&Drop Aufgabe mit 4 Attributen: Frage als String, Antworten als Array, Felder/Boxen als Array und Lösung als Array. Der Arrayindex entspricht der Antwortnummer und der eingetragene Wert dem erwarteten Feld
						createDD(
								"ABCDEF",
								[
										"Dies\u00ADist\u00ADein\u00ADlanges\u00ADWort\u00ADmit\u00ADeinigen\u00ADweichen\u00ADTrennzeichen",
										"Test2" ], [ "Box1", "Box2", "Box3" ],
								[ 3, 2 ]);
						//Demo Lückentext Aufgabe mit 4 Attributen: Frage als String, Lückentext als Array mit leerem String "" für jede Lücke, Antworten als Array und Lösung als Array. Der Arrayindex entspricht der Antwortnummer und der eingetragene Wert dem erwarteten Feld
						createTQ(
								"Meine TQ Frage",
								[
										"Lorem ipsum dolor sit amet",
										"",
										"consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita",
										"",
										"kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
										"",
										"ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore",
										"",
										"aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet." ],
								[ "Antwort1", "Antwort2", "Antwort3",
										"Antwort4" ], [ 4, 3, 2, 1 ]);
						//Demo Frage zur Reihenfolge mit 3 Attributen: Frage als STring, Antworten als Array und Lösungen als Array. Die Angegebene Zahl entspricht der Position des jeweiligen Elements. Der Arrayindex entspricht der Antwortnummer und der eingetragene Wert dem erwarteten Feld
						createOD("Frage zur Reihenfolge", [ "Test1", "Test2",
								"Test3" ], [ 1, 2, 3 ]);
						//Demo Übersetzungsfrage mit 4 Attributen: Frage als String, Antworten als Array, zu übersetzende Begriffe als Array und Lösung als Array.
						createTL("Übersetzungsfrage", [ "Test1", "Test2",
								"Test3" ], [ "Wort1", "Wort2", "Wort3" ], [ 3,
								2, 1 ]);
						showTheQuestion(count);
					});
</script>


</head>
<body>
	<!--in diesen div werden alle Fragen gehängt-->
	<div id="content">

		<div
			id="gz"
			class="questionclass">
			<p id="supergeil"></p>
			<p id="outro">Cleverer Outrotext darüber wie toll du das Quiz
				gemeistert hast.</p>
		</div>

	</div>
	<div id="next_button_div">
		<button
			style="vertical-align: middle"
			class="button"
			type="button">
			<a
				href="#"
				id="next_button"
				onclick="nextButtonClick()">Weiter</a>
		</button>
	</div>

	<div id="back_button_div">
		<button
			style="vertical-align: middle"
			class="button"
			type="button">
			<a
				href="#"
				id="back_button"
				onclick="backButtonClick()">Zurück</a>
		</button>
	</div>

	<div id="tl">
		<img
			id="tentakel_l"
			src="../../img/tentakel_ltr.png">
	</div>
	<div id="tr">
		<img
			id="tentakel_r"
			src="../../img/tentakel_rtl.png">
	</div>

</body>
</html>