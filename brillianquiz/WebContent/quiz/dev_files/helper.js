// hier werden alle Lösungen gespeichert. Der x-te Eintrag ist immer ein Array der Lösungen der x-ten Frage
var richtigArray = [];
/**
 * eine Multiple Choice Frage anlegen
 * 
 * @param frage
 *            Frage als String
 * @param antworten
 *            Antworten als Array aus Strings
 * @param richtig
 *            Lösung als Array aus Strings. Für jede Antwortmöglichkeit ein Eintrag 0 oder 1 wobei 1 für richtig und 0 für falsch steht
 * @returns ein <div> tag mit der Frage
 */
function createMC(frage, antworten, richtig) {

	richtigArray.push(richtig);

	var n = findQuestionNumber();

	var questiondiv = createHeader(frage, n);

	questiondiv.setAttribute("data-type", "mc");

	// erstelle alle Antwortmöglichkeiten jeweils mit Checkbox und hänge sie direkt in den div der Frage
	var i;
	for (i = 0; i < antworten.length; i++) {
		var questionlabel = document.createElement("label");
		questionlabel.className = "container_check";
		var questionlabeltext = document.createTextNode(antworten[i]);
		questionlabel.appendChild(questionlabeltext);
		var questionlabelinput = document.createElement("input");
		questionlabelinput.type = "checkbox";
		questionlabelinput.id = "question" + n + "_answer" + i;
		questionlabel.appendChild(questionlabelinput);
		var questionlabelspan = document.createElement("span");
		questionlabelspan.className = "checkmark_check";
		questionlabel.appendChild(questionlabelspan);
		questiondiv.appendChild(questionlabel);
		var list = document.createElement("li");
		list.appendChild(questiondiv);
		var list = document.createElement("li");
		list.appendChild(questiondiv);
	}

	var contentdiv = document.getElementById("questionList");
	contentdiv.append(list);
}
/**
 * eine Single Choice Frage anglegen
 * 
 * @param frage
 *            Frage als String
 * @param antworten
 *            Antworten als Array aus Strings
 * @param richtig
 *            Lösung als Array aus Strings. Für jede Antwortmöglichkeit ein Eintrag 0 oder 1 wobei 1 für richtig und 0 für falsch steht
 * @returns ein <div> tag mit der Frage
 */
function createSC(frage, antworten, richtig) {

	richtigArray.push(richtig);

	var n = findQuestionNumber();

	var questiondiv = createHeader(frage, n);
	questiondiv.setAttribute("data-type", "sc");

	// erstelle alle Antwortmöglichkeiten jeweils mit Radiobutton und hänge sie direkt in den div der Frage
	var i;
	for (i = 0; i < antworten.length; i++) {
		var questionlabel = document.createElement("label");
		questionlabel.className = "container";
		var questionlabeltext = document.createTextNode(antworten[i]);
		questionlabel.appendChild(questionlabeltext);
		var questionlabelinput = document.createElement("input");
		questionlabelinput.type = "radio";
		questionlabelinput.name = "question_" + n + "radio";
		questionlabelinput.id = "question" + n + "_answer" + i;
		questionlabel.appendChild(questionlabelinput);
		var questionlabelspan = document.createElement("span");
		questionlabelspan.className = "checkmark";
		questionlabel.appendChild(questionlabelspan);
		questiondiv.appendChild(questionlabel);
		var list = document.createElement("li");
		list.appendChild(questiondiv);
		var list = document.createElement("li");
		list.appendChild(questiondiv);
	}

	var contentdiv = document.getElementById("questionList");
	contentdiv.append(list);

}
/**
 * Eine Drag&Drop Frage anlegen
 * 
 * @param frage
 *            Frage als String
 * @param antworten
 *            Antwortmöglichkeiten als Array aus Strings
 * @param container
 *            Container in die gedropt werden soll als Array aus Strings
 * @param richtig
 *            Lösung als Array. Der Arrayindex entspricht der Antwortnummer und der eingetragene Wert dem erwarteten Feld
 * @returns ein <div> tag mit der Frage
 */
function createDD(frage, antworten, container, richtig) {

	richtigArray.push(richtig);

	var n = findQuestionNumber();

	var questiondiv = createHeader(frage, n);
	questiondiv.setAttribute("data-type", "dd");

	var answersDiv = document.createElement("div");
	answersDiv.className = "antworten";
	questiondiv.appendChild(answersDiv);

	// Erstelle alle Antworten als draggable <p> und hänge sie jeweils in den Antworten div
	var i;
	for (i = 0; i < antworten.length; i++) {
		var p = document.createElement("p");
		p.id = "question" + n + "_answer" + i;
		p.className = "drag";
		p.draggable = "true";
		p.setAttribute("ondragstart", "drag(event)");
		var pText = document.createTextNode("> " + antworten[i]);
		p.appendChild(pText);

		answersDiv.appendChild(p);
	}

	var boxenDiv = document.createElement("div");
	boxenDiv.id = "boxen";
	answersDiv.insertAdjacentElement('beforeend',boxenDiv);

	// Erstelle die Boxen jeweils mit Überschrift und hänge sie in den boxen div
	for (i = 0; i < container.length; i++) {
		var box = document.createElement("div");
		box.id = "question" + n + "_Box" + i;
		box.className = "dropbox";
		box.addEventListener('drop', function() {
			dropDD(event, this)
		});
		box.addEventListener('dragover', function() {
			allowDrop(event)
		});

		var boxTitel = document.createElement("p");
		boxTitel.className = "titel";
		var titelText = document.createTextNode(container[i]);
		boxTitel.appendChild(titelText);

		box.appendChild(boxTitel);

		boxenDiv.appendChild(box);
		var list = document.createElement("li");
		list.appendChild(questiondiv);
	}

	var contentdiv = document.getElementById("questionList");
	contentdiv.append(list);

}

/**
 * Eine Lückentext Frage anlegen
 * 
 * @param frage
 *            Frage als String
 * @param text
 *            Text mit Lücken als Array aus Strings wobei ein leerer String "" eine Lücke darstellt
 * @param antworten
 *            Antwortmöglichkeiten als Array aus Strings
 * @param richtig
 *            Lösung als Array. Der Arrayindex entspricht der Antwortnummer und der eingetragene Wert dem erwarteten Feld
 * @returns ein <div> tag mit der Frage
 */
function createTQ(frage, text, antworten, richtig) {

	richtigArray.push(richtig);

	var n = findQuestionNumber();

	var questiondiv = createHeader(frage, n);
	questiondiv.setAttribute("data-type", "tq");

	var TextP = document.createElement("p");
	TextP.id = "question" + n + "text";

	// Erstelle den Lückentext, indem jeder leere String durch ein Eingabefeld ersetzt wird.
	var i;
	var j = 0;
	for (i = 0; i < text.length; i++) {
		if (text[i] !== "") {
			var TQText = document.createTextNode(" " + text[i] + " ");
			TextP.appendChild(TQText);
			TextP.className = "text";
		} else {
			var TQinput = document.createElement("input");
			TQinput.className = "text_input";
			TQinput.type = "text";
			TQinput.name = "question" + n + "_blanc" + j;
			TQinput.id = "question" + n + "_blanc" + j;
			j++;
			TextP.appendChild(TQinput)
		}
	}
	questiondiv.appendChild(TextP);

	var answersdiv = document.createElement("div");

	// Erstelle alle Antwortmöglichkeiten
	for (i = 0; i < antworten.length; i++) {

		var answerP = document.createElement("p");
		answerP.className = "text_to_input";
		answerP.id = "question" + n + "_answer" + i;
		var answerText = document.createTextNode(antworten[i]);
		answerP.appendChild(answerText);

		answersdiv.appendChild(answerP);
	}
	questiondiv.appendChild(answersdiv);
	var list = document.createElement("li");
		list.appendChild(questiondiv);
	

	var contentdiv = document.getElementById("questionList");
	contentdiv.append(list);
}

/**
 * Eine Übersetzungsfrage anlegen
 * 
 * @param frage
 *            Frage als String
 * @param antworten
 *            Antwortmöglichkeiten als Array aus Strings
 * @param container
 *            Container in die gedropt werden soll als Array aus Strings
 * @param richtig
 *            Lösung als Array. Der Arrayindex entspricht der Antwortnummer und der eingetragene Wert dem erwarteten Feld
 * @returns ein <div> tag mit der Frage
 */
function createTL(frage, antworten, container, richtig) {

	richtigArray.push(richtig);

	var n = findQuestionNumber();

	var questiondiv = createHeader(frage, n);
	questiondiv.setAttribute("data-type", "tl");

	var answersDiv = document.createElement("div");
	answersDiv.className = "antworten";
	questiondiv.appendChild(answersDiv);

	// Erstelle alle Antwortmöglichkeiten als draggable <p>
	var i;
	for (i = 0; i < antworten.length; i++) {
		var p = document.createElement("p");
		p.id = "question" + n + "_answer" + i;
		p.className = "drag";
		p.draggable = "true";
		p.setAttribute("ondragstart", "drag(event)");
		var pText = document.createTextNode(antworten[i]);
		p.appendChild(pText);

		answersDiv.appendChild(p);
	}

	var boxenDiv = document.createElement("div");
	boxenDiv.id = "boxen";
	answersDiv.insertAdjacentElement('beforeend',boxenDiv);

	// Erstelle die Tabelle mit Überschriften
	var table = document.createElement("table");
	table.id = "question" + n + "_table";
	boxenDiv.appendChild(table);
	var tr1 = document.createElement("tr");
	table.appendChild(tr1);
	var th1 = document.createElement("th");
	tr1.appendChild(th1);
	var th1label = document.createTextNode("Deutsch");
	th1.appendChild(th1label);
	var th2 = document.createElement("th");
	tr1.appendChild(th2);
	var th2label = document.createTextNode("Englisch");
	th2.appendChild(th2label);

	// Ergänze die Tabelle um jeweils eine Zeile mit dem deutschen Wort und einem Feld in welches gedropt werden kann.
	for (i = 0; i < container.length; i++) {
		var zeile = document.createElement("tr");
		table.appendChild(zeile);
		var td1 = document.createElement("td");
		zeile.appendChild(td1);
		var tdtext = document.createTextNode(container[i]);
		td1.appendChild(tdtext);
		var td2 = document.createElement("td");
		zeile.appendChild(td2);
		var td2div = document.createElement("div");
		td2div.id = "question" + n + "_box" + i;
		td2div.className = "dropTable";
		td2div.addEventListener('drop', function() {
			dropTL(event, this)
		});
		td2div.addEventListener('dragover', function() {
			allowDrop(event)
		});
		td2.appendChild(td2div);
		table.appendChild(zeile);
		var list = document.createElement("li");
		list.appendChild(questiondiv);
	}

	var contentdiv = document.getElementById("questionList");
	contentdiv.append(list);
}

/**
 * Eine Reihenfolgenfrage anlegen
 * 
 * @param frage
 *            Frage als String
 * @param antworten
 *            Antwortmöglichkeiten als Array aus Strings
 * 
 * @param richtig
 *            Lösung als Array angeben Inhalt des Arrays ist die Angabe der Positionen jeder einzelnen Antwort als Integer
 * @returns ein <div> tag mit der Frage
 */
function createOD(frage, antworten, richtig) {

	richtigArray.push(richtig);

	var n = findQuestionNumber();

	var questiondiv = createHeader(frage, n);
	questiondiv.setAttribute("data-type", "od");

	var answersDiv = document.createElement("div");
	answersDiv.id = "antwortenOD";
	var answersDiv2 = document.createElement("div");
	answersDiv2.id = "antwortenOD2";
	answersDiv.appendChild(answersDiv2);
	questiondiv.appendChild(answersDiv);

	// Erstelle alle Antworten als draggable <p>
	var i;
	for (i = 0; i < antworten.length; i++) {
		var p = document.createElement("p");
		p.id = "question" + n + "_answer" + i;
		p.className = "dragOD";
		p.draggable = "true";
		p.setAttribute("ondragstart", "drag(event)");
		var pText = document.createTextNode(antworten[i]);
		p.appendChild(pText);

		answersDiv2.appendChild(p);
	}

	var boxenDiv = document.createElement("div");
	boxenDiv.id = "boxenOD";
	answersDiv.insertAdjacentElement('beforeend',boxenDiv);

	// Erstelle eine reihe leerer boxen und nummeriere sie.
	for (i = 0; i < antworten.length; i++) {
		var box = document.createElement("div");
		box.id = "question" + n + "_Box" + i;

		var boxTitel = document.createElement("p");
		boxTitel.className = "box_textOrder";
		boxTitel.addEventListener('drop', function() {
			dropOD(event, this)
		});
		boxTitel.addEventListener('dragover', function() {
			allowDrop(event)
		});
		var titelText = document.createTextNode(i + 1);
		boxTitel.appendChild(titelText);

		box.appendChild(boxTitel);

		boxenDiv.appendChild(box);
		var list = document.createElement("li");
		list.appendChild(questiondiv);
	}

	var contentdiv = document.getElementById("questionList");
	contentdiv.append(list);
}
/**
 * Erstellt den div der Frage und fügt den Header mit dem Fragentext ein.
 * 
 * @param frage
 *            Text der Frage als String
 * @param n
 *            Nummer der zu erstellenden Frage
 * @returns div der Frage
 */
function createHeader(frage, n) {

	var questiondiv1 = document.createElement("div");
	questiondiv1.className = "questionclass";
	questiondiv1.id = "question" + n;

	var headerdiv1 = document.createElement("div");
	headerdiv1.className = "header";
	questiondiv1.appendChild(headerdiv1);

	var headerP1 = document.createElement("p");
	headerdiv1.appendChild(headerP1);
	var headerP1text = document.createTextNode(frage);
	headerP1.appendChild(headerP1text);
	headerP1.className = "question";

	questiondiv1.appendChild(headerdiv1);

	return questiondiv1;
}

/**
 * 
 * @returns niedrigste, noch nicht vergebene Fragennummer
 */
function findQuestionNumber() {
	var weiter = true;
	var n = 1;

	

	while (weiter) {
		if (document.getElementById("question" + n + "_answer1") !== null) {
			n++;
		} else {
			weiter = false;
		}
	}
	return n;
	
}

/**
 * Wertet die gegebenen Antworten aus und setzt score auf den entsprechenden Wert.
 * 
 */
function evaluate() {
	
	// läuft durch alle Fragen
	for (var i = 1; i <= anzahlFragen; i++) {
		var question = document.getElementById("question" + i);

		// Falls die Frage eine Einfach- oder Mehrfachauswahl ist wird dieser Teil durchlaufen.
		if (question.getAttribute("data-type").localeCompare("mc") === 0
				|| question.getAttribute("data-type").localeCompare("sc") === 0) {
			var childrenInput = $("#question" + i).find("input").toArray();
			var richtig = richtigArray.shift();
			console.log(richtig);

			var gibMirPunkte = true;
			// Durchläuft alle Kinder (=Antwortmöglichkeiten), prüft ob sie geklickt wurden und vergleicht dies mit dem erwarteten Ergebnis aus der Lösung
			if (childrenInput !== null) {
				for (var j = 0; j < childrenInput.length; j++) {
					var child = childrenInput[j];
					if (!(child.checked && (richtig[j] === 1) || !child.checked
							&& (richtig[j] === 0))) {
						gibMirPunkte = false;
					}
				}
				if (gibMirPunkte) {
					score++;
					console.log("Score: " + score);
				}
			}
		}

		// Falls die Frage eine Drag&Drop Aufgabe ist wird dieser Teil durchlaufen.
		else if (question.getAttribute("data-type").localeCompare("dd") === 0) {
			var draggables = $("#question" + i).find(".drag").toArray();
			var gibMirPunkte = true;
			var anzahlAntworten = draggables.length;
			var richtig = richtigArray.shift();
			var question = $('#question' + i);
			var boxes = $("#question" + i).find(".dropbox").toArray();
			//console.log(boxes);

			// Durchläuft alle Antworten, prüft in welcher Box sie hängen und vergleicht dies mit dem erwarteten Ergebnis aus der Lösung
			for (var k = 0; k < draggables.length; k++) {
				var father = document.getElementById("question" + i + "_answer"
						+ k).parentNode;
				if (!father.isSameNode(boxes[(richtig[k] - 1)])) {
					gibMirPunkte = false;
				}

			}

			if (gibMirPunkte) {
				score++;
				console.log("Score: " + score); 
			}

			// set the variable question to be the DOM representation of the element again (instead of jQuery)
			var question = document.getElementById("question" + i);
		}

		// Falls die Frage eine Reihenfolgen-Aufgabe ist wird dieser Teil durchlaufen.
		else if (question.getAttribute("data-type").localeCompare("od") === 0) {
			var draggables = $("#question" + i).find(".dragOD").toArray();
			var gibMirPunkte = true;
			var anzahlAntworten = draggables.length;
			var richtig = richtigArray.shift();
			var question = $('#question' + i);
			var boxes = $("#question" + i).find(".box_textOrder").toArray();
			//console.log("anzahl der boxen: " + boxes.length);

			// Durchläuft alle Antworten, prüft in welcher Box sie hängen und vergleicht dies mit dem erwarteten Ergebnis aus der Lösung
			for (var k = 0; k < draggables.length; k++) {
				var father = document.getElementById("question" + i + "_answer"
						+ k).parentNode;
				if (!father.isSameNode(boxes[(richtig[k] - 1)])) {
					gibMirPunkte = false;
				}

			}

			if (gibMirPunkte) {
				score++;
			}

			// set the variable question to be the DOM representation of the element again (instead of jQuery)
			var question = document.getElementById("question" + i);
		}
		// Falls die Frage eine Vokabel Aufgabe ist wird dieser Teil durchlaufen.
		else if (question.getAttribute("data-type").localeCompare("tl") === 0) {
			var draggables = $("#question" + i).find(".drag").toArray();
			var gibMirPunkte = true;
			var anzahlAntworten = draggables.length;
			var richtig = richtigArray.shift();
			var question = $('#question' + i);
			var boxes = $("#question" + i).find(".dropTable").toArray();

			// Durchläuft alle Antworten, prüft in welcher Box sie hängen und vergleicht dies mit dem erwarteten Ergebnis aus der Lösung
			for (var k = 0; k < draggables.length; k++) {
				var father = document.getElementById("question" + i + "_answer"
						+ k).parentNode;
				if (!father.isSameNode(boxes[(richtig[k] - 1)])) {
					gibMirPunkte = false;
				}

			}

			if (gibMirPunkte) {
				score++;
			}

			// set the variable question to be the DOM representation of the element again (instead of jQuery)
			var question = document.getElementById("question" + i);
		}

		// Falls die Frage ein Lückentext ist wird dieser Teil durchlaufen.
		else if (question.getAttribute("data-type").localeCompare("tq") === 0) {

			var question = document.getElementById("question" + i);

			// lade die Lösungen zu dieser Frage in richtig
			var richtig = richtigArray.shift();

			// finde alle <p> Kinder der Frage
			var antworten = $("#question" + i).find("p").toArray();

			var gibMirPunkte = true;
			// durchlaufe alle Antworten. Die ersten beiden Einträge werden übersprungen, da sie keine Antworten sind.
			for (var j = 2; j < antworten.length; j++) {
				var antworttext = antworten[j].textContent;
				// finde das Feld in dem die Antwort stehen sollte
				var Feldnummer = richtig[j - 2];
				var feld = document.getElementById("question" + i + "_blanc"
						+ (Feldnummer - 1));
				var feldtext = feld.value;
				// vergleiche ob der Feldtext mit dem Antworttext übereinstimmt
				if (antworttext !== feldtext) {
					gibMirPunkte = false;
				}

			}
			if (gibMirPunkte) {
				score++;
			}

		}

	} createScoreText();
}

// Genereate text after evaluating depending on the score
function createScoreText (){
	document.getElementById('result').innerHTML = "Du hast " + score +" von "+ anzahlFragen + " Punkten erreicht";
	var wellDone = anzahlFragen * 0.7;
	console.log(wellDone);
	if(score>wellDone){
		document.getElementById('resultText').innerHTML = "Das ist echt klasse. Du hast den Stoff aus " + value +" verstanden. Weiter so!";
	} else {
		document.getElementById('resultText').innerHTML = "Scheint als ob du mit dem Stoff nicht vertraut bist. Vertiefe dein Wissen indem du dich weiter mit dem IMBIT-Curriculum beschäftigst";
	}
}

//Change color of numering depending on input

function changeColor (){
	var element = document.getElementById("title");
	element.classList.toggle("correct");
}

// When clicking the "next"-button, the "question number" is counted upwards.
// All the questions are hidden except the next question
function nextButtonClick() {
	count++;
	showTheQuestion(count);
}

// When clicking the "back"-button, the question number is counted downwards.
// All the questions are hidden except the previous question
function backButtonClick() {
	count--;
	showTheQuestion(count);
}

// This function shows the question on the screen that the user has to answer next
function showTheQuestion(count) {

	// Hides all the questions. The show() function of the questions has to be called again to make them visible
	$(".questionclass").hide();

	$('#question' + count).show();

	if (count === 1) {
		$('#back_button_div').hide();
	} else if (count <= anzahlFragen) {
		$('#back_button_div').show();
		$('#next_button_div').show();
	} else {
		evaluate();
		$('#next_button_div').hide();
		$('#back_button_div').hide();
		$('#gz').show();

		$('#supergeil').html(
				"Gratuliere! Du hast " + score + " von " + maxScore
						+ " Punkten!");
	}
}

function allowDrop(ev) {
	ev.preventDefault();
}

function drag(ev) {
	ev.dataTransfer.setData("text", ev.target.id);
}

// Dropmethode für Übersetzungsfragen, lässt genau eine Antwort pro Feld zu.
function dropTL(ev, el) {
	ev.preventDefault();

	if (el.childNodes.length === 0) {
		// data ist die ID des Elements, das verschoben wird
		var data = ev.dataTransfer.getData("text");

		el.appendChild(document.getElementById(data));
	}
}

// Dropmethode für Reihenfolgen, lässt genau eine Antwort pro Feld zu, berücksichtigt dabei dass immer bereits ein Text (die Zahl) im Feld vorhanden ist
function dropOD(ev, el) {
	ev.preventDefault();

	if (el.childNodes.length === 1) {
		// data ist die ID des Elements, das verschoben wird
		var data = ev.dataTransfer.getData("text");

		el.appendChild(document.getElementById(data));
	}
}

// Dropmethode für Drag&Drop, lässt beliebig viele Antworten pro Feld zu.
function dropDD(ev, el) {
	ev.preventDefault();

	// data ist die ID des Elements, das verschoben wird
	var data = ev.dataTransfer.getData("text");

	el.appendChild(document.getElementById(data));
}
