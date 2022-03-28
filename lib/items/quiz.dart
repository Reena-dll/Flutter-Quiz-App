import 'dart:ui';
import 'package:quiz/items/question.dart';
import 'package:flutter/src/widgets/framework.dart';

// Bu dart dosyamızda soru skorlarını, Soru numaralarını, şu an ki soru, kaç tane soru olduğu gibi bazı durumları değişkenlerimiz de tuttuk.

class Quiz{
  List <Question> _question;
  int _currentQuestionIndex=-1;  // -1 den başlamasının sebebi soruların tamamını ekranda göstermesi için.
  int _score = 0;   // Başlangıç score değerimiz 0

  Quiz(this._question){
    _question.shuffle();   // Soruları karışık bir şekilde vermesi için bu metodu kullandık.
  }

  List<Question> get questions => _question;
  int get lenght => _question.length;
  int get questionNumber =>_currentQuestionIndex+1;   // Burada ise sonra ki soruya geçme işlememizi gerçekleştiriyoruz.
  int get score => _score;

  Question get nextQuestion{
    _currentQuestionIndex++;

    if(_currentQuestionIndex>=lenght) return null;
    return _question[_currentQuestionIndex];
  }

  void answer(bool isCorrect){   // Burada ise score 1 arttırılarak en son ki sayfada kullanılır.
    if(isCorrect)
      _score++;
  }

}

