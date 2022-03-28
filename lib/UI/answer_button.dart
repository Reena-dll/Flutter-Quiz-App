import 'package:flutter/material.dart';
class AnswerButton extends StatelessWidget {

  final bool answer;  // Soruların True veya False değerlerini tutan bool değişkeni.
  final VoidCallback _onTap;

  AnswerButton(this.answer, this._onTap);

  @override

  Widget build(BuildContext context){
    return new Expanded(
      child:new Material(
        color: answer == true ? Colors.greenAccent : Colors.redAccent, // Eğer answer(bool değişkeni) değeri true ise yeşil arka plan renk, False ise kırmızı arka plan renk.
        child: new InkWell( // InkWell ve onTap kullanmamızın sebebi hem button olarak kullanılması hem de dalgalanma vermesi için kullandık.
          onTap: ()=> _onTap(),// InkWell ve onTap kullanmamızın sebebi hem button olarak kullanılması hem de dalgalanma vermesi için kullandık.
          child: new Center(
            child: new Container( // Hizalama işlemini yaptıktan sonra bir container açtık.
              decoration: new BoxDecoration(  // Açtığımız bu containerın dekarasyon işlemlerini buradan yaptık.
                  border: new Border.all(color: Colors.white, width: 5.0)  // Container'ımızın çevresine beyaz, genişiği 5 büyükliğinde bir katman attık. Böylelikle daha hoş göründü.
              ),
              padding: new EdgeInsets.all(20.0), // Burada yaptığımız ayar ise True veya False yazacak yerden çevreçeenin ne kadar uzak olacağı ile ilgili.
              child: new Text(answer == true ? "Doğru" : "Yanlış",  // Bu kısımda ise quiz_page sayfasına yolladığımız metod ile orada parantez içinde hangisi seçilecek ise ona göre rol oynayacak.
                style: new TextStyle(color: Colors.white, fontSize: 40.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic), // Burada ise çerçevesini hazırladığımız container alanına gelecek True veya False yazısının boyutu kalınlığı gibi özellikleri belirlendi.
              ),
            ),
          ),
        ),
      ),
    );
  }
}

