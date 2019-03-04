<?xml version="1.0" encoding="UTF-8" ?>
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
	function allowDrop(ev) {
		ev.preventDefault();
	}

	function drag(ev) {
		ev.dataTransfer.setData("text", ev.target.id);
	}

	function drop(ev) {
		ev.preventDefault();
		var data = ev.dataTransfer.getData("text");
		ev.target.appendChild(document.getElementById(data));
	}
</script>


</head>
<body>
	<div id="content">

		<div
			id="gz"
			class="questionclass">
			<p id="supergeil"></p>
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

	<!-- Translate New -->
	<div
		class="questionclass"
		id="question6"
		data-type="tl"
		style="">
		<div class="header">
			<p class="question">Übersetzungsfrage</p>
		</div>
		<div
			id="antworten"
			class="draganddrop">
			<p
				id="question6_answer0"
				class="drag"
				draggable="true"
				ondragstart="drag(event)">Test1</p>
			<p
				id="question6_answer1"
				class="drag"
				draggable="true"
				ondragstart="drag(event)">Test2</p>
			<p
				id="question6_answer2"
				class="drag"
				draggable="true"
				ondragstart="drag(event)">Test3</p>
		</div>
		<div
			id="boxen"
			class="draganddrop">
			<table id="question6_table">
				<tr>
					<th>Deutsch</th>
					<th>Englisch</th>
				</tr>
				<tr>
					<td>Wort1</td>
					<td><div
							id="question6_box0"
							class="dropTable"
							ondrop="drop(event)"
							ondragover="allowDrop(event)"></div></td>
				</tr>
				<tr>
					<td>Wort2</td>
					<td><div
							id="question6_box1"
							class="dropTable"
							ondrop="drop(event)"
							ondragover="allowDrop(event)"></div></td>
				</tr>
				<tr>
					<td>Wort3</td>
					<td><div
							id="question6_box2"
							class="dropTable"
							ondrop="drop(event)"
							ondragover="allowDrop(event)"></div></td>
				</tr>
			</table>
		</div>
	</div>


</body>
</html>