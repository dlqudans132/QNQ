// Setup your quiz text and questions here

// NOTE: pay attention to commas, IE struggles with those bad boys

var quizJSON = {
    "info": {
        "name":    "수업시간 도중 돌발 퀴즈",
        "main":    "<p>돌발퀴즈 입니다.</p>",
    },
    "questions": [
        { // Question 1
            "q": "캡스톤 7조 멤버가 아닌사람은?",
            "a": [
                {"option": "박다현",     "correct": false},
                {"option": "정현운",     "correct": true},
                {"option": "류민주",     "correct": false},
                {"option": "이재현",     "correct": false} 
            ],
            "correct": "<p><span>정답입니다!</span> 캡스톤 7조에는 신동훈,이재현,류민주,이병문,박다현,한상민이 있습니다. </p>",
            "incorrect": "<p><span>이걸틀려?</span> 캡스톤 7조에는 현운이가 없습니다!! </p>" 
       }
     ]
};