﻿
&НаКлиенте
Процедура ЗапуститьИгру(Команда)
	//Предупреждение("Превет!Все работает!");
	//ЗапуститьПриложение(Объект.СтрокаЗапуска);
	Если Прав(Объект.СтрокаЗапуска, 3) = "exe" Тогда
		ЗапуститьПриложение(Объект.СтрокаЗапуска);
	ИначеЕсли Прав(Объект.СтрокаЗапуска, 3) = "epf" Тогда	
		ОбработкаВПамяти="";
		ПоместитьФайл(ОбработкаВПамяти, Объект.СтрокаЗапуска, , Ложь);  
		ИмяОбработки = ПодключитьВнешнююОбработку(ОбработкаВПамяти);
		ОткрытьФорму("ВнешняяОбработка." + ИмяОбработки + ".Форма");
	КонецЕсли;
КонецПроцедуры
функция ПодключитьВнешнююОбработку(ОбработкаВПамяти)
	Возврат ВнешниеОбработки.Подключить(ОбработкаВПамяти);
КонецФункции

&НаКлиенте
Процедура СтрокаЗапускаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	Проводник=новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
		Если Проводник.Выбрать() Тогда 
			Объект.СтрокаЗапуска = Проводник.ПолноеИмяФайла;
		КонецЕсли;
КонецПроцедуры
