import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class QuestionText extends StatefulWidget{

  final String _question;  // Soruları takip edebilmek adına string değişkene soruları aktardık.
  final int _quesitonNumber; // Aynı şekilde soruların sırasını da bir değişkende tutuyoruz.

  QuestionText(this._question,this._quesitonNumber);

  @override

  State createState()=> QuestionTextState();

}

class QuestionTextState extends State<QuestionText> with SingleTickerProviderStateMixin{ // SingleTickerProviderStateMixin bu kodu animasyonu gerçekleştirebilmek için Class'ın başında tanımladık.

  Animation<double> _fontSizeAnimation;
  AnimationController _fontSizeAnimationController; // Bu 2 satırda ise Animasyon ayarlarını yapacağımızdan dolayı değişkenlerimizi isimlendirdik.

@override

void initState(){  // Değişen bir birim olacağından dolayı initState'in altında Sorular ekrana gelirken ki animasyon ayarı kod bloğunu yazacağız.
  super.initState();
  _fontSizeAnimationController = new AnimationController(duration: new Duration(milliseconds: 500), vsync: this); // Animasyonun kaç saniye boyunca devam edeceğini Controllerimizden tanımladık.
  _fontSizeAnimation = new CurvedAnimation(parent: _fontSizeAnimationController, curve: Curves.bounceIn); // Animasyonumuza daha öncesinde hazırladığımız controllerı işleyip animasyon şeklini belirledik.
  _fontSizeAnimation.addListener(()=> this.setState(() {})); // SetState içerisinde ki değişikliği listeliyoruz.
  _fontSizeAnimationController.forward();
}

@override
void didUpdateWidget(QuestionText oldWidget){  // Bu kısmı, Uygulamayı açtıktan sonra hata aldığımız için yaptık. Uygulama 2. soruya geçtiğinde animasyonu çalışmayınca, her soruda bir reset atıyoruz.
  super.didUpdateWidget(oldWidget);
  if(oldWidget._question != widget._question)
    _fontSizeAnimationController.reset();
  _fontSizeAnimationController.forward();
}

@override
void dispose(){
  _fontSizeAnimationController.dispose();
  super.dispose();
}


  Widget build(BuildContext context) {
 return  new Material(
    color: Colors.white,  // Barın renk ayarı
    child: new Padding(   // Padding özelliği ile Doğru ve Yanlış butonların arasında simetrik bir bar oluşturduk.
      padding: new EdgeInsets.symmetric(vertical: 20.0), // Soruların geldiği beyaz barın simetrik boyutu.
      child: new Center(  // Yazıyı ortaladık.
        child: new Text(widget._question,//Kaçıncı ve hangi soru olacağını class'a extends vererek quiz_page tarafında parantez içine girecek metodu belirledik.
          style: new TextStyle(fontSize: _fontSizeAnimation.value*20), //  Örneğin, Soru ve kaçıncı soru olduğu. Ardından da bu text'imizin büyüklüğünü Animasyonumuza göre ayarladık.
        ),
      ),
    ),
  );
  }
}