import 'package:flutter/material.dart';
import '../items/question.dart';
import '../items/quiz.dart';
import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/connect_wrong_overlay.dar.dart';
import './score_page.dart';

// // Choice_page den sonra gelecek olan Quiz sayfamızdır. Burada 10 tane soru gelecek.

class QuizPage3 extends StatefulWidget{



@override
  State createState() => new QuizPageState3();
}

class QuizPageState3 extends State<QuizPage3>{

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Dünyanın en genç Grammy ödülü kazanan şarkıcısı Taylo Swifttir", true),    // Questipon dart'dan gelen class ile sorularımızı burada oluşturuyoruz.
    new Question("Marvel filmlerinden Black panterin 2. Si çıkmıştır", false),
    new Question("Denzel Washinton Oscar ödülü kazanmıştır", true),
    new Question("Semih Kaplanoğlu Cannes Film Festivalinde ödül alan yönetmenlerimizden biridir", false),
    new Question("Hasılat rekoru kıran animasyon film Frozen(Karlar Ülkesi) dir", true),
    new Question("2013 yılında Yabancı dilde en iyi film Oscar ödülünü kazanan film La grande bellezza’dır", true),
    new Question("Dağ başını duman almış şarkısının bestecisi Felix Korbig’dir", true),
    new Question("2003 yılında Eurovision yarışmasında birinci olan sanatçımız Emre Aydındır", false),
    new Question("Bethowen Klasikl Batı müziğinin bestecisidir.", true),
    new Question("Çalgı eşliksiz Korolara Akapella adı verilir", true),


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