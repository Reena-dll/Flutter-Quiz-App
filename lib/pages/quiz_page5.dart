import 'package:flutter/material.dart';
import '../items/question.dart';
import '../items/quiz.dart';
import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/connect_wrong_overlay.dar.dart';
import './score_page.dart';

// Burası bizim anasayfamıza yönlendireceğimiz, Landingpage den sonra gelecek olan Quiz sayfamızdır.

class QuizPage5 extends StatefulWidget{



@override
  State createState() => new QuizPageState5();
}

class QuizPageState5 extends State<QuizPage5>{

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("2010-2011 Türkiye Süper Lig Şampiyonu Fenerbahçe’dir", true),    // Questipon dart'dan gelen class ile sorularımızı burada oluşturuyoruz.
    new Question("2000 yılında UEFA Şampiyonu olan takımımız Beşiktaş’tır", false),
    new Question("Alex De Souza Türkiye Ligine Gelmiş En iyi oyuncudur", true),
    new Question("Galatasaray Fenerbahçe’yi Deplasmanda 21 sene yenememiştir", true),
    new Question("Fenerbahçe Galatasaray’ı 2002 senesinde 6-0 yenmiştir", true),
    new Question("Galatasaray’ın UEFA kupası yoktur", false),
    new Question("Türkiye’nin en iyi takımı Fenerbahçe’dir.", true),
    new Question("Beşiktaş’ın iki yıldızı vardır", false),
    new Question("Fenerbahçe Galatasaray’ı 2002 senesinde 6-0 yenmiştir", true),
    new Question("Trabzonspor’un maskotu hamsidir", false),

  ]);




  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;
  
  @override
  void initState(){
    super.initState();
    currentQuestion = quiz.nextQuestion;      // Burada, Quiz dart dosyasında tuttuğumuz verileri değişkenlere aktarıyoruz.
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;

  }

  void handleAnswer (bool answer){
    isCorrect = (currentQuestion.answer == answer);   // Bu kısımda ise butonlara tıklandığında sonucun doğru olup olmadığını kontrol ediyoruz.
    quiz.answer(isCorrect);
    this.setState((){
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context){
    return new Stack( // Stack kullanmamızın sebebi birden fazla child'i üst üste bindirmeyi sağlıyor. Animasyon kullandığımızdan dolayı burada Stack kullanıyoruz.
      fit: StackFit.expand,
      children: <Widget>[
        new Column( // Kolon olmasının sebebi yukarıdan aşağıya doğru True, Soru ve False barlarının bulunması.
          children: <Widget>[
          new AnswerButton(true, () => handleAnswer(true) ), // Doğru Butonu. AnswerButton class'ını çağırıyoruz ve yukarıda oluşturduğumuz handleAnswer metodunu çağırıyoruz
          new QuestionText(questionText,questionNumber), // QuestionText class'ını çağırıyoruz ve gerekli değerleri giriyoruz.
          new AnswerButton(false, () => handleAnswer(false)),// Yanlış Butonuz. AnswerButton class'ını çağırıyoruz ve gerekli değerleri giriyoruz.
          ],
        ),
        overlayShouldBeVisible == true ? new CorrectWrongOverlay(
          isCorrect,
            (){
                 if(quiz.lenght == questionNumber){
                   Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context)=> new ScorPage(quiz.score, quiz.lenght)), (Route route)=>route==null); // Burada yaptığımız işlem ise eğer Quiz boyunca soruların sorusunun uzunluğu şu anda çözülen soruya eşit ise ScorPage sayfasına geç.
                   return;
                 }
               currentQuestion = quiz.nextQuestion;  // Burada yağtığımız işlem ise her verilen cevaptan sonra, soruyu bir sonraki soruya geçirmeye yarayan fonksiyon. QuestionNumber'ı bir arttırarak bu işlemi gerçekleştiriyoruz.
               this.setState((){
                 overlayShouldBeVisible = false ;     // Quiz.dart dan çektiğimiz verilere göre burada nextQuestion işlemini gerçekleştirerek sorularımız her yanıtını bulduktan sonra bir sonraki soruya geçiyor.
                 questionText = currentQuestion.question;
                 questionNumber = quiz.questionNumber;
               });
            }
        ) : new Container() //
      ],
    );
  }
}