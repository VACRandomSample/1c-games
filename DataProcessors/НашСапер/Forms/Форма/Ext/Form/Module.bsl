﻿
&НаКлиенте
Процедура НоваяИгра(Команда)
	Предупреждение("Новая игра работает");
КонецПроцедуры

&НаКлиенте
Процедура НачатьИгру(Команда)
//	Предупреждение("Новая игра работает");
	Подготовка_Поля();
КонецПроцедуры 

Процедура Подготовка_Поля()
	Элементы.Настройки.Видимость = Ложь;  
	
	Для x = 1 По ШиринаИгрПоля Цикл
		Группа = ЭтаФорма.Элементы.Добавить("Ряд" + x, Тип("ГруппаФормы"), Элементы.ИгровоеПоле);
		Группа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
		Группа.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
		Группа.ОтображатьЗаголовок = Ложь;
		Группа.Отображение = ОтображениеОбычнойГруппы.Нет;
		Для y = 1 По ВысотаИгрПоля Цикл
			НоваяКнопка = ЭтаФорма.Элементы.Добавить("кн_" + y + "_" + x, Тип("ДекорацияФормы"), Группа);
			НоваяКнопка.Вид = ВидДекорацииФормы.Картинка;
			НоваяКнопка.Рамка = Новый
			Рамка(ТипРамкиЭлементаУправления.Выпуклая, 3);
			НоваяКнопка.Гиперссылка = Истина;
			НоваяКнопка.УстановитьДействие("Нажатие", "КнопкаНажатие");
			НоваяКнопка.Высота = 1;
			НоваяКнопка.Ширина = 2;
			НоваяКнопка.КонтекстноеМеню.Видимость = Истина;
		КомандаНеЗнаю = ЭтаФорма.Элементы.Добавить("кн_" + y +"_" + x + "КонтекстноеМенюНеЗнаю", Тип("КнопкаФормы"), НоваяКнопка.КонтекстноеМеню);
		КомандаНеЗнаю.ИмяКоманды = "НеЗнаю";
		КомандаНеЗнаю.Картинка = БиблиотекаКартинок.Справка;     
		
		КомандаМина = ЭтаФорма.Элементы.Добавить("кн_" + y + "_" + x + "КонтекстноеМенюМина", Тип("КнопкаФормы"), НоваяКнопка.КонтекстноеМеню);
		КомандаМина.ИмяКоманды = "ЭтоМина";
		КомандаМина.Картинка = БиблиотекаКартинок.ВидРасчета;
		
		ПараметрыПоля = ПараметрыПолей.Добавить();
		ПараметрыПоля.ИмяПоля = "кн_" + y + "_" + x;
		ПараметрыПоля.Ряд = y;
		ПараметрыПоля.Колонка = x;
		ПараметрыПоля.Мина = 0;
		
		КонецЦикла;
	
	КонецЦикла;
	
	гсч = Новый ГенераторСлучайныхЧисел();

	Для Сч = 1 По КоличествоМин Цикл
		МинаПоставлена = Ложь;
		Пока Не МинаПоставлена Цикл
			КудаПоставитьМину = гсч.СлучайноеЧисло(0, ПараметрыПолей.Количество() - 1);
			Строка = ПараметрыПолей[КудаПоставитьМину];
			Если Строка.Мина = 1 Тогда
				Продолжить;
			КонецЕсли;
			Строка.Мина = 1;

			Элементы[Строка.ИмяПоля].Заголовок = "Х";

			МинаПоставлена = Истина;
		КонецЦикла;
	КонецЦикла;
	Для x=1 По ШиринаИгрПоля Цикл
		Для y=1 По ВысотаИгрПоля Цикл
			ИмяТекущегоЭлемента = "кн_" + y + "_" + x;

			Если Элементы[ИмяТекущегоЭлемента].Заголовок = "Х" Тогда
				Продолжить;
			КонецЕсли;
			МинРядом = 0;

			//1) для верхней левой клетки
			ИмяЭлемента = "кн_" + (y-1) + "_" + (x-1);
			Если (y - 1 > 0 и x - 1 > 0) и Элементы[ИмяЭлемента].Заголовок = "Х" Тогда
				МинРядом = МинРядом + 1;
			КонецЕсли;

			//2) для верхней клетки
			ИмяЭлемента = "кн_" + (y-1) + "_" + (x);
			Если (y - 1 > 0) и Элементы[ИмяЭлемента].Заголовок = "Х" Тогда
				МинРядом = МинРядом + 1;
			КонецЕсли;

			//3) для правой верхней клетки
			ИмяЭлемента = "кн_" + (y-1) + "_" + (x+1);
			Если (y - 1 > 0 и x + 1 <= ШиринаИгрПоля) и Элементы[ИмяЭлемента].Заголовок = "Х" Тогда
				МинРядом = МинРядом + 1;
			КонецЕсли;

			//4) для левой клетки:
			ИмяЭлемента="кн_"+(y)+"_"+(x-1);
			Если (x-1>0) и Элементы[ИмяЭлемента].Заголовок="X" Тогда
				МинРядом=МинРядом+1;
			КонецЕсли;

			//5) для правой клетки:
			ИмяЭлемента="кн_"+(y)+"_"+(x+1);
			Если (x+1<=ШиринаИгрПоля) и Элементы[ИмяЭлемента].Заголовок="X" Тогда
				МинРядом=МинРядом+1;
			КонецЕсли;

			//6) для левой нижней клетки:
			ИмяЭлемента="кн_"+(y+1)+"_"+(x-1);
			Если (y+1<ВысотаИгрПоля и x-1>0) и Элементы[ИмяЭлемента].Заголовок="X" Тогда
				МинРядом=МинРядом+1;
			КонецЕсли;

			//7) Для нижней клетки:
			ИмяЭлемента="кн_"+(y+1)+"_"+(x);
			Если (y+1<=ВысотаИгрПоля) и Элементы[ИмяЭлемента].Заголовок="X" Тогда
				МинРядом=МинРядом+1;
			КонецЕсли;

			//8) для нижней правой клетки:
			ИмяЭлемента="кн_"+(y+1)+"_"+(x+1);
			Если (y+1<=ВысотаИгрПоля и x+1<=ШиринаИгрПоля) и Элементы[ИмяЭлемента].Заголовок="X" Тогда
				МинРядом=МинРядом+1;
			КонецЕсли;

			//записываем кол-во мин в соседних клетках
			Если МинРядом > 0 Тогда
				Элементы[ИмяТекущегоЭлемента].Заголовок = МинРядом;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ТипПоляПриИзменении(Элемент)
	Изменение_ПараметровПоля();
КонецПроцедуры 

Процедура Изменение_ПараметровПоля()
	Если ТипПоля="Новичок" Тогда
		ШиринаИгрПоля = 9;
		ВысотаИгрПоля = 9;
		КоличествоМин = 10;
		Элементы.ПараметрыПоля.Видимость = Ложь;
	ИначеЕсли ТипПоля = "Любитель" Тогда
		ШиринаИгрПоля = 15;
		ВысотаИгрПоля = 15;
		КоличествоМин = 25;
		Элементы.ПараметрыПоля.Видимость = Ложь;
	ИначеЕсли ТипПоля = "Профи!" Тогда
		ШиринаИгрПоля = 20;
		ВысотаИгрПоля = 20;
		КоличествоМин = 35;
		Элементы.ПараметрыПоля.Видимость = Ложь;
	ИначеЕсли ТипПоля = "Особые" Тогда
		ШиринаИгрПоля = 0;
		ВысотаИгрПоля = 0;
		КоличествоМин = 0;
		Элементы.ПараметрыПоля.Видимость = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура КнопкаНажатие(Элемент)
	Элемент.Рамка = Новый Рамка(ТипРамкиЭлементаУправления.Одинарная, 1);
	Элемент.Картинка = БиблиотекаКартинок.Удалить;
	Если Элемент.Заголовок = "Х" Тогда
		Элемент.Картинка = БиблиотекаКартинок.Удалить;
		Предупреждение("Вы проиграли");
	Иначе
		Элемент.Картинка = новый картинка;
		Элемент.ТекстНевыбраннойКартинки = Элемент.Заголовок;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
		Элементы.ПараметрыПоля.Видимость = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура НеЗнаю(Команда)
	ТекущийЭлемент.Картинка = БиблиотекаКартинок.Справка;
КонецПроцедуры

&НаКлиенте
Процедура ЭтоМина(Команда)
	ТекущийЭлемент.Картинка = БиблиотекаКартинок.ВидРасчета;
КонецПроцедуры
