<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>TEEEEEEEEEEEEEEST</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>

<script>


    function createMC(frage, antworten, richtig){

        var weiter = true;
        var n=1;
        console.log(document.getElementById("multipleChoice"+n+"_answer1"));
        while(weiter){
            console.log(document.getElementById("multipleChoice"+n+"_answer1"));
            if(document.getElementById("multipleChoice"+n+"_answer1") !== null){
                n++;
            }else{
                weiter=false;
            }
        }

        //Erste Frage
        var questiondiv1 = document.createElement("div");

        //Erster Header
        var headerdiv1 = document.createElement("div");
        headerdiv1.className = "header";
        questiondiv1.appendChild(headerdiv1);

        var headerP1 = document.createElement("p");
        headerdiv1.appendChild(headerP1);
        var headerP1text = document.createTextNode(frage);
        headerP1.appendChild(headerP1text);
        headerP1.className = "question";

        questiondiv1.appendChild(headerdiv1);

        //Erste Antwort

        var i;
        for(i=0;i<antworten.length;i++){
            var questionlabel = document.createElement("label");
            questionlabel.className = "container_check";
            var questionlabeltext = document.createTextNode(antworten[i]);
            questionlabel.appendChild(questionlabeltext);
            var questionlabelinput = document.createElement("input");
            questionlabelinput.type = "checkbox";
            questionlabelinput.id = "multipleChoice"+n+"_answer"+(i+1)+"";
            questionlabel.appendChild(questionlabelinput);
            questiondiv1.appendChild(questionlabel);
        }



        var contentdiv = document.getElementById("content");
        contentdiv.append(questiondiv1);


    }


    $(document).ready(function(){
        createMC("Wie viele...",["Antwort1","Antwort2"],1);
        createMC("Welche...",["Dings","Bums"],2);
    })

</script>

<body>

<div id="content">


</div>


</body>
</html>