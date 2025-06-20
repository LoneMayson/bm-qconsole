﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	МассивПользователей = ПользователиИнформационнойБазы.ПолучитьПользователей();
	Для Каждого ПользовательИБ Из МассивПользователей Цикл
		ЭтотОбъект.СписокПользователей.Добавить(ПользовательИБ.Имя);
	КонецЦикла;
	
	МассивИменХранилищ = Новый Массив();
	МассивИменХранилищ.Добавить("ХранилищеОбщихНастроек");
	МассивИменХранилищ.Добавить("ХранилищеСистемныхНастроек");
	МассивИменХранилищ.Добавить("ХранилищеНастроекДанныхФорм");
	МассивИменХранилищ.Добавить("ХранилищеВариантовОтчетов");
	МассивИменХранилищ.Добавить("ХранилищеПользовательскихНастроекОтчетов");
	МассивИменХранилищ.Добавить("ХранилищеПользовательскихНастроекДинамическихСписков");
	
	Попытка
		Хранилище = Вычислить("ХранилищеВнешнихДанныхНавигационныхСсылок");
		МассивИменХранилищ.Добавить("ХранилищеВнешнихДанныхНавигационныхСсылок");
	Исключение
	КонецПопытки;
			
	Для Каждого ИмяХранилища Из МассивИменХранилищ Цикл                
		Если ТипЗнч(ВыбранноеХранилище(ИмяХранилища)) = Тип("СтандартноеХранилищеНастроекМенеджер") Тогда
			Элементы.РеквизитХранилище.СписокВыбора.Добавить(ИмяХранилища);
		КонецЕсли;
	КонецЦикла;
	
	Элементы.РеквизитХранилище.РежимВыбораИзСписка = Истина;
	
	Элементы.РеквизитПользователь.КнопкаВыбора = Истина;
	Элементы.РеквизитПользователь.КнопкаОчистки = Истина;
	
	Элементы.ДеревоНастроек.ИзменятьСоставСтрок = Ложь;
	Элементы.ДеревоНастроек.ИзменятьПорядокСтрок = Ложь;
	Элементы.ДеревоНастроек.ТолькоПросмотр = Истина;
	
	ЭлементУО = УсловноеОформление.Элементы.Добавить();	
	ПолеЭлемента = ЭлементУО.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоНастроек.Имя);	
	ОтборЭлемента = ЭлементУО.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоНастроек.Удалено");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;
	ЭлементУО.Оформление.УстановитьЗначениеПараметра("ЦветТекста", Новый Цвет(153, 153, 153));
		
КонецПроцедуры

&НаКлиенте
Процедура РеквизитХранилищеПриИзменении(Элемент)
	
	ЭтотОбъект.ТаблицаНастроек.Очистить();
	ЭтотОбъект.ДеревоНастроек.ПолучитьЭлементы().Очистить();
	
КонецПроцедуры

&НаКлиенте
Процедура РеквизитПользовательНачалоВыбора(Элемент, ДанныеВыбора, ВыборДобавлением, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения("РеквизитПользовательВыборЗавершение", ЭтотОбъект, Новый Структура());
	ЭтотОбъект.СписокПользователей.ПоказатьВыборЭлемента(Оповещение,, ЭтотОбъект.СписокПользователей.НайтиПоЗначению(ЭтотОбъект.РеквизитПользователь));
	
КонецПроцедуры

&НаКлиенте
Процедура РеквизитПользовательВыборЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЭтотОбъект.РеквизитПользователь = Результат.Значение;
	
	ЭтотОбъект.ТаблицаНастроек.Очистить();
	ЭтотОбъект.ДеревоНастроек.ПолучитьЭлементы().Очистить();
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаПрочитатьНастройки(Команда)
	
	ПрочитатьНастройки();
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаУдалитьНастройки(Команда)
	
	ОткрытьФормуРедактированияНастроек("Удалить");
		
КонецПроцедуры

&НаКлиенте
Процедура КомандаСкопироватьНастройки(Команда)
	
	ОткрытьФормуРедактированияНастроек("Скопировать");
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуРедактированияНастроек(Команда)
	
	ТекДанные = Элементы.ДеревоНастроек.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	МассивНастроек = Новый Массив();
	Для Каждого Идентификатор Из Элементы.ДеревоНастроек.ВыделенныеСтроки Цикл
		ЗаполнитьВыбранныеНастройки(ЭтотОбъект.ДеревоНастроек.НайтиПоИдентификатору(Идентификатор), МассивНастроек); 
	КонецЦикла;
	
	ПараметрыОткрытия = Новый Структура("Команда,МассивНастроек", Команда, МассивНастроек);
	Если Команда = "Скопировать" Тогда
		ПараметрыОткрытия.Вставить("СписокПользователей", ЭтотОбъект.СписокПользователей.ВыгрузитьЗначения());
	КонецЕсли;
	Оповещение = Новый ОписаниеОповещения("РедактированиеНастройкиЗавершение", ЭтотОбъект, Новый Структура("Команда,МассивНастроек", Команда, МассивНастроек));
	ОткрытьФорму(ИмяФормыОбработки("РедактированиеНастройки"), ПараметрыОткрытия, ЭтотОбъект, УникальныйИдентификатор,,, Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура РедактированиеНастройкиЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Результат.Команда = "Удалить" Тогда
		УдалитьНастройки(Результат, ДополнительныеПараметры);
	ИначеЕсли Результат.Команда = "Скопировать" Тогда
		СкопироватьНастройки(Результат, ДополнительныеПараметры);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьВыбранныеНастройки(Узел, МассивНастроек)
	
	Если Узел.ПолучитьЭлементы().Количество() = 0 И Не Узел.Удалено Тогда
		МассивНастроек.Добавить(Новый Структура("КлючОбъекта,КлючНастроек,Идентификатор", Узел.КлючОбъекта, Узел.КлючНастроек, Узел.ПолучитьИдентификатор()));
	Иначе
		Для Каждого Строка Из Узел.ПолучитьЭлементы() Цикл
			ЗаполнитьВыбранныеНастройки(Строка, МассивНастроек);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьНастройки()
	
	Отбор = Новый Структура("Пользователь", ЭтотОбъект.РеквизитПользователь);
	
	ЭтотОбъект.ТаблицаНастроек.Очистить();
	ТЗНастроек = РеквизитФормыВЗначение("ТаблицаНастроек");
	
	ВыбранноеХранилище = ВыбранноеХранилище(ЭтотОбъект.РеквизитХранилище);
	
	Выборка = ВыбранноеХранилище.Выбрать(Отбор);
	ИдентификаторСтроки = 0;
	Пока Выборка.Следующий() Цикл	
		НовСтр = ТЗНастроек.Добавить();
		ЗаполнитьЗначенияСвойств(НовСтр, Выборка);
		НовСтр.ИдентификаторСтроки = ИдентификаторСтроки;
		ИдентификаторСтроки = ИдентификаторСтроки + 1;
	КонецЦикла;
	
	ЭтотОбъект.ДеревоНастроек.ПолучитьЭлементы().Очистить();
	ДЗНастроек = РеквизитФормыВЗначение("ДеревоНастроек");
	
	Для Каждого СтрокаТЗ Из ТЗНастроек Цикл
		МассивСтрок = СтрРазделить(СтрокаТЗ.КлючОбъекта, "/");
		Текст = МассивСтрок[0];
		МассивСтрок = СтрРазделить(Текст, ".");
		СтрокаДЗ = НайтиСоздатьВеткуРекурсивно(ДЗНастроек, МассивСтрок);
		НовСтр = СтрокаДЗ.Строки.Добавить();
		ЗаполнитьЗначенияСвойств(НовСтр, СтрокаТЗ);		
	КонецЦикла;
	
	ДЗНастроек.Строки.Сортировать("КлючУзла");
	
	ЗначениеВРеквизитФормы(ДЗНастроек, "ДеревоНастроек");
	ЗначениеВРеквизитФормы(ТЗНастроек, "ТаблицаНастроек");
	
КонецПроцедуры

&НаСервере
Процедура УдалитьНастройки(Результат, ДополнительныеПараметры)
	
	Пользователь = ?(Результат.ПрименитьКоВсемПользователям = Ложь, ЭтотОбъект.РеквизитПользователь, Неопределено);
	ВыбранноеХранилище = ВыбранноеХранилище(ЭтотОбъект.РеквизитХранилище);
	
	Для Каждого СтрокаНастроек Из ДополнительныеПараметры.МассивНастроек Цикл
		ВыбранноеХранилище.Удалить(СтрокаНастроек.КлючОбъекта, СтрокаНастроек.КлючНастроек, Пользователь);
		ТекДанные = ЭтотОбъект.ДеревоНастроек.НайтиПоИдентификатору(СтрокаНастроек.Идентификатор);
		ТекДанные.Удалено = Истина;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура СкопироватьНастройки(Результат, ДополнительныеПараметры)
	
	ВыбранноеХранилище = ВыбранноеХранилище(ЭтотОбъект.РеквизитХранилище);
	
	Для Каждого СтрокаНастроек Из ДополнительныеПараметры.МассивНастроек Цикл
		ОписаниеНастроек = Новый ОписаниеНастроек();
		ЗначениеНастройки = ВыбранноеХранилище.Загрузить(СтрокаНастроек.КлючОбъекта, СтрокаНастроек.КлючНастроек, ОписаниеНастроек, ЭтотОбъект.РеквизитПользователь);
		Для Каждого ИмяПользователя Из Результат.ВыбранныеПользователи Цикл
			ВыбранноеХранилище.Сохранить(СтрокаНастроек.КлючОбъекта, СтрокаНастроек.КлючНастроек, ЗначениеНастройки,, ИмяПользователя);
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция НайтиСоздатьВеткуРекурсивно(ДЗНастроек, МассивСтрок)
	
	Если МассивСтрок.Количество() > 1 Тогда
		МассивПоиска = Новый Массив();
		Для Итер = 0 По МассивСтрок.Количество() - 2 Цикл
			МассивПоиска.Добавить(МассивСтрок[Итер]);
		КонецЦикла;
		Значение = СтрСоединить(МассивПоиска, ".");
		Приемник = НайтиСоздатьВеткуРекурсивно(ДЗНастроек, МассивПоиска);
		Возврат НайтиСоздатьВеткуКоллекции(Приемник, МассивСтрок[МассивСтрок.Количество() - 1]);
	Иначе
		Возврат НайтиСоздатьВеткуКоллекции(ДЗНастроек, МассивСтрок[0]); 
	КонецЕсли;
	
КонецФункции

&НаСервере
Функция НайтиСоздатьВеткуКоллекции(Коллекция, Значение)
	
	Резт = Неопределено;
	
	Для Каждого Строка Из Коллекция.Строки Цикл
		Если Строка.КлючУзла = Значение Тогда
			Резт = Строка;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Если Резт = Неопределено Тогда
		Резт = Коллекция.Строки.Добавить();
		Резт.КлючУзла = Значение;
	КонецЕсли;
	
	Возврат Резт;
	
КонецФункции

&НаСервере
Функция ВыбранноеХранилище(ИмяХранилища)
	
	Резт = Неопределено;
	Если ИмяХранилища = "ХранилищеОбщихНастроек" Тогда
		Резт = ХранилищеОбщихНастроек;
	ИначеЕсли ИмяХранилища = "ХранилищеСистемныхНастроек" Тогда
		Резт = ХранилищеСистемныхНастроек;
	ИначеЕсли ИмяХранилища = "ХранилищеНастроекДанныхФорм" Тогда
		Резт = ХранилищеНастроекДанныхФорм;
	ИначеЕсли ИмяХранилища = "ХранилищеВариантовОтчетов" Тогда
		Резт = ХранилищеВариантовОтчетов;
	ИначеЕсли ИмяХранилища = "ХранилищеПользовательскихНастроекОтчетов" Тогда
		Резт = ХранилищеПользовательскихНастроекОтчетов;
	ИначеЕсли ИмяХранилища = "ХранилищеПользовательскихНастроекДинамическихСписков" Тогда
		Резт = ХранилищеПользовательскихНастроекДинамическихСписков;
	ИначеЕсли ИмяХранилища = "ХранилищеВнешнихДанныхНавигационныхСсылок" Тогда
		Резт = Вычислить("ХранилищеВнешнихДанныхНавигационныхСсылок");
	КонецЕсли;
	
	Возврат Резт;
	
КонецФункции

&НаКлиенте
Функция ИмяФормыОбработки(Имя)
	
	ТипМетаданных = ?(СтрНачинаетсяС(ЭтотОбъект.ИмяФормы, "ВнешняяОбработка"), "ВнешняяОбработка", "Обработка");
	Возврат ТипМетаданных + ".bm_ХранилищеНастроек.Форма." + Имя;
	
КонецФункции







