// 문제 객체(생성자 함수)
function Question(text, choice, answer) {
   this.text = text; // 질문 텍스트
   this.choice = choice; // 선택할 답들(배열)
   this.answer = answer; // 정답 정보
}

// 퀴즈 정보!!!
function Quiz(questions) {
   this.score = 0; // 점수
   this.questions = questions; // 문제
   this.questionIndex = 0; // 문제 번호
}

// 정답을 체크해주는 메소드
Quiz.prototype.correctAnswer = function(answer) {
   return answer == this.questions[this.questionIndex].answer;
}

var questions = [
   new Question('캡스톤 7조가 아닌사람은?', ['신동훈', '박다현', '정현운', '류민주'], '정현운'),
   new Question('7조의 캡스톤이름은 아닌것은?', ['Qna', 'AnQ', 'QnQ', 'OnO'], 'QnQ'),
   new Question('재현이가 좋아하는 게임이 아닌것은?', ['배틀그라운드', '바람의나라', 'LOL', '오버워치'], '오버워치'),
   new Question('CSS 속성 중 글자의 굵기를 변경하는 속성은?', ['font-size', 'font-style', 'font-weight', 'font-variant'], 'font-weight')
];

// 퀴즈 객체 생성
var quiz = new Quiz(questions);

// 문제 출력 함수
function updateQuiz() {
   var question = document.getElementById('question');
   var idx = quiz.questionIndex + 1;
   var choice = document.querySelectorAll('.btn');

   // 문제 출력
   question.innerHTML = '문제' + idx + ') ' + quiz.questions[quiz.questionIndex].text;

   // 선택 출력
   for (var i = 0; i < 4; i++) {
      choice[i].innerHTML = quiz.questions[quiz.questionIndex].choice[i];
   }

   progress();
}

function progress() {
   var progress = document.getElementById('progress');
   progress.innerHTML = '문제 ' + (quiz.questionIndex + 1) + '/ ' + quiz.questions.length;
}

var btn = document.querySelectorAll('.btn');

// 입력 및 정답 확인 함수
function checkAnswer(i) {
   btn[i].addEventListener('click', function() {
      var answer = btn[i].innerText;

      if (quiz.correctAnswer(answer)) {
         alert('정답!');
         quiz.score++;
      } else {
         alert('오답!');
      }

      if (quiz.questionIndex < quiz.questions.length - 1) {
         quiz.questionIndex++;
         updateQuiz();
      } else {
         result();
      }
   });
}

function result() {
   var quizDiv = document.getElementById('quiz');
   var per = parseInt((quiz.score * 100) / quiz.questions.length);
   var txt = '<h1>결과</h1>' + '<h2 id="score">당신의 점수: ' + quiz.score + '/' + quiz.questions.length + '<br><br>' + per + '점' + '</h2>';

   quizDiv.innerHTML = txt;

   // 점수별 결과 텍스트
   if (per < 60) {
      txt += '<h2>더 분발하세요</h2>';
      quizDiv.innerHTML = txt;
   } else if (per >= 60 && per < 80) {
      txt += '<h2>무난한 점수네요</h2>'
      quizDiv.innerHTML = txt;
   } else if (per >= 80) {
      txt += '<h2>훌륭합니다</h2>'
      quizDiv.innerHTML = txt;
   }
}

for (var i = 0; i < btn.length; i++) {
   checkAnswer(i);
}

updateQuiz();