import 'quiz_page1.dart';
import 'quiz_page2.dart';
import 'quiz_page3.dart';
import 'quiz_page4.dart';
import 'quiz_page5.dart';
import 'quiz_page6.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// Burası bizim seçim sayfamız. Kullanıcı hangi alanı seçiyorsa o alanla alakalı soru quiz sayfasına yönlendirilecek.


class ChoicePage extends StatefulWidget {

  @override
  State createState()=> ChoicePageState();

  }

class ChoicePageState extends State<ChoicePage> with SingleTickerProviderStateMixin { // Animasyon kullanabilmemiz için oluşturulan sınıf
  @override

  Animation<double> _imageSizeAnimation;   // ANimasyon Değişkeni
  AnimationController _imageSizeAnimationController;  // Animasyon değişkeni

  @override

  void initState(){  // Değişen bir birim olacağından dolayı initState'in altında Sorular ekrana gelirken ki animasyon ayarı kod bloğunu yazacağız.
    super.initState();
    _imageSizeAnimationController = new AnimationController(duration: new Duration(seconds: 1), vsync: this); // Animasyonun kaç saniye boyunca devam edeceğini Controllerimizden tanımladık.
    _imageSizeAnimation = new CurvedAnimation(parent: _imageSizeAnimationController, curve: Curves.bounceIn); // Animasyonumuza daha öncesinde hazırladığımız controllerı işleyip animasyon şeklini belirledik.
    _imageSizeAnimation.addListener(()=> this.setState(() {})); // SetState içerisinde ki değişikliği listeliyoruz.
    _imageSizeAnimationController.forward();
  }


  @override
  void dispose(){
    _imageSizeAnimationController.dispose(); // Burada hazırladığımız controllerin düzenlemesini yaptık.
    super.dispose();

  }



  Expanded controller(int imageNumber, String textString, Color colorText){
    // Burada bir class kullandık ve aşağıda 10 defa yazmak yerine burada 1 defa yazdık ve belirli değişkenlere göre alt kısımda değerler verdik.

   return   Expanded(
      child: FlatButton( // Buton görevi gören içerisinde text ve image bulunan ve basıldığında bir sayfaya yönlendiren flatbutton.
        onPressed: () {    //Basıldığında neler olacağını belirliyoruz.
          setState(() {  //
            if(imageNumber==1)
            {Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) =>  QuizPage1()));}
            else if(imageNumber==2)
            {Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) =>  QuizPage2()));}
            else if(imageNumber==3)
            {Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) =>  QuizPage3()));}
            // Bu kod bloğunda ise, kullanıcım hangi image'i seçerse yani hangi alanı seçerse ona göre QuizPage sayfasına yönlendiriliyor. Her quizpage sayfası image'e göre ayarlanmıştır.
            else if(imageNumber==4)
            {Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) =>  QuizPage4()));}
            else if(imageNumber==5)
            {Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) =>  QuizPage5()));}
            else if(imageNumber==6)
            {Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) =>  QuizPage6()));}

          });
        },
        child: Column(// ÖNEMLİ //
          // Burada kolon kullanmamın sebebi şudur. Flatbutton bize bir child veriyor ve image mi atacağım yoksa Text mi atacağım derdine düştüm.
          // Sonrasında ise colon açarak childrenden yararlandım ve zaten image ve text alt alta gelmesi gerekiyordu. Hem image yükledim hem text attım.
          children: <Widget>[
            new Transform.rotate( // Her hangi bir öğeyi çevirmekte kullanılır.
                angle: _imageSizeAnimation.value*6.27, // 6,27 vermemizin sebebi transform yaptığımız resim tam düz gelsin diye ince ayar yapıldı.
                child: Image.asset('images/$imageNumber.png',width: _imageSizeAnimation.value*200, height: _imageSizeAnimation.value*200,),  // imagesnumber değişkenini kullanıyoruz.
              // İmage'mizi animasyonlayan kod satırı budur. Yukarıda 6,27 yazmamın sebebi ise şudur. Fotoğraf tam dikey konumda kalmasından dolayı tam ayar yapılmıştır.
            ),
            Text(textString,style: TextStyle( // textString değişkenini kullanıyoruz.
              fontSize: _imageSizeAnimation.value*25,  // Burada ise image'mizin altında bulunan yazı ve animasyon ayarı bulunmaktadır.
              fontWeight: FontWeight.bold,
              color: colorText,         // Text'in ayarları... // Burada colorText değişkenini kullanıyoruz.
              fontStyle: FontStyle.italic
            ),
            )
          ],
        ),
      ),
    );

  }




  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Debug etiketi gizleme kodu.
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,  // Arka plan rengi.
        body: Column(  // Burada kolon kullanmamın sebebi ise, fotoğraflar ve en alttaki yazı alt alta geleceğinden dolayı. İmage'ler row ile yazılıp sayfa kolon ile hazırlandı.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                controller(1, 'Bilim', Colors.green,),
                controller(2, 'Coğrafya', Colors.blueAccent,),   // Bu kod bloğunda 3 tane image var ve bu imageler yukarıda yönlendirmesi yapılan imageler. Yukarıdan çekilen bilgilere göre Row'da 3 image oluşturulmuş ve her birisine tıklandığında farklı yerlere yönlendiriliyor.
                controller(3, 'Eğlence', Colors.purple),
              ],
            ),
            new Padding(
              padding: new EdgeInsets.all(20.0),  // İmage'ler arasına boşluk atmak için padding kodunu kullandık. Üst 3 lü resimden 3 altta ki resim arasına boşluk attık.
            ),
            Row(
              children: <Widget>[
                controller(4, 'Sanat', Colors.redAccent),
                controller(5, 'Spor', Colors.deepOrangeAccent),    // Bu kod bloğunda 3 tane image var ve bu imageler yukarıda yönlendirmesi yapılan imageler. Yukarıdan çekilen bilgilere göre Row'da 3 image oluşturulmuş ve her birisine tıklandığında farklı yerlere yönlendiriliyor.
                controller(6, 'Tarih', Colors.yellowAccent),
              ],
            ),
            new Padding(
              padding: new EdgeInsets.all(20.0),  // Yukarıda fotoğraflar arasına attığımız boşluğu şimdide 'Alanlardan Birisini Seçiniz' yazısı için yaptık
            ),
            Text('Alanlardan Birisini Seçiniz', style: TextStyle(  // Text'imizin renk boyut style ayarları.
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: FontStyle.italic
            ),)
          ],
        ),
      ),
    );
  }
}

