import 'package:flutter/material.dart';
import '../items/question.dart';
import '../items/quiz.dart';
import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/connect_wrong_overlay.dar.dart';
import 'score_page.dart';

// Choice_page den sonra gelecek olan Quiz sayfamızdır. Burada 10 tane soru gelecek.

class QuizPage1 extends StatefulWidget{



@override
  State createState() => new QuizPageState1();

}

class QuizPageState1 extends State<QuizPage1>{


  Question currentQuestion;

  Quiz quiz = new Quiz([
    new Question("Gırtlağın ön ve alt blümünde bulunan iç salgı bezine Hipofiz adı verilir", false),    // Questipon dart'dan gelen class ile sorularımızı burada oluşturuyoruz.
    new Question("Metro benzin ile çalışan bir ulaşım aracıdır", false),
    new Question("Maddenin PH’ı ise  7.1 asittir", true),
    new Question("İnsanın nefesi -90 derecede donar", true),
    new Question("Bir insanın kaşını kaldırabilmesi için 30 kası oynar", true),
    new Question("Kangurular bir sıçrayışta 2 metreye kadar çıkarlar", false),
    new Question("Pi sayısının 1 milyarıncı sayısı 9 dur", true),
    new Question("İnsanlar bir yıl içinde en az 1460 rüya görür", true),
    new Question("Bir rüzgar türbini yaklaşık 100 evin bir senelik elektrik ihtiyacını karşılamaktadır", true),
    new Question("Bir insanın kaşını kaldırabilmesi için 30 kası oynar", true),
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
                   Navigator.of(context).pushAndRemoveUntil
                     (new MaterialPageRoute(builder: (BuildContext context)=> new ScorPage(quiz.score, quiz.lenght)), (Route route)=>route==null);
                   // Burada yaptığımız işlem ise eğer Quiz boyunca soruların sorusunun uzunluğu şu anda çözülen soruya eşit ise ScorPage sayfasına geç.
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