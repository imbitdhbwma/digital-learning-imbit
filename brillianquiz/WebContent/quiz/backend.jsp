<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  
<script>
    async function loadJSON(callback) {   
        var xobj = await new XMLHttpRequest();
            xobj.overrideMimeType("application/json");
            xobj.open('GET', 'data.json', true);
            xobj.onreadystatechange = function () {
              if (xobj.readyState == 4 && xobj.status == "200") {
                callback(xobj.responseText);
              }
        };
        xobj.send(null);  
     }
    console.log(getLocalProgress());
    
    if(getLocalProgress() === null){
      loadJSON(function(response) {
        // Parse JSON string into object
        var questions = JSON.parse(response);
        // Create userProgress Array containing all questions with necessary fields
        userProgress = []
        // console.log(questions);    
        questions.forEach(question => {
          userProgress.push({
            id: question.id,
            completed: question.completed,
            subject: question.subject
          })
        });
        // Group userProgress by subject
        userProgress = userProgress.reduce(function (arr, question) {       
          arr[question.subject] = arr[question.subject] || [];
          arr[question.subject].push(question);
          return arr;
        }, Object.create(null));
        setLocalProgress(userProgress)
        // console.log(userProgress);
      });
    }
    
    function displayUserProgress(){    
      document.getElementById('content').innerHTML = JSON.stringify(getLocalProgress())
    }


    //write progess to local stoage
    function setLocalProgress(userProgress){
      localStorage.setItem('userProgress', JSON.stringify(userProgress))
    }
  
    //load progress from local Storage
    function getLocalProgress(){
      return JSON.parse(localStorage.getItem('userProgress'))
    }

    //delete local progress
    function dropLocalProgess(){
      localStorage.removeItem('userProgress')
    }

</script>

<a onclick="displayUserProgress()">load</a><a onclick="dropLocalProgess()">Remove</a>
<div id="content"></div>