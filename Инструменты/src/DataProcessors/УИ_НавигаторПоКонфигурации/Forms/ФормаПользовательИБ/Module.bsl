
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	УстановитьПривилегированныйРежим(истина);
	
	Если Параметры.Свойство("РежимРаботы") Тогда
		_РежимРаботы = Параметры.РежимРаботы;
	КонецЕсли;
	
	Если _РежимРаботы = 0 Тогда
		Идентификатор = Параметры.ИдентификаторПользователяИБ;
		ИдентификаторПользователяИБ = новый УникальныйИдентификатор(Параметры.ИдентификаторПользователяИБ);
		
		Попытка
			ПользовательИБ = ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(ИдентификаторПользователяИБ);
			Если ПользовательИБ = Неопределено Тогда
				Отказ = истина;
			КонецЕсли;
		Исключение
			Отказ = истина;
		КонецПопытки;
		
	ИначеЕсли _РежимРаботы = 1 Тогда
		ПользовательИБ = ПользователиИнформационнойБазы.СоздатьПользователя();
		Элементы.ИзменитьПароль.Доступность = ложь;
		Заголовок = "Создание";
		
	ИначеЕсли _РежимРаботы = 2 Тогда
		Идентификатор = Параметры.ИдентификаторПользователяИБ;
		ИдентификаторПользователяИБ = новый УникальныйИдентификатор(Параметры.ИдентификаторПользователяИБ);
		
		Попытка
			ПользовательИБ = ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(ИдентификаторПользователяИБ);
			Если ПользовательИБ = Неопределено Тогда
				Отказ = истина;
			КонецЕсли;
		Исключение
			Отказ = истина;
		КонецПопытки;
		
		Элементы.ИзменитьПароль.Доступность = ложь;
		Заголовок = "Создание";
	Иначе
		Отказ = истина;
	КонецЕсли;
	
	Если не Отказ Тогда
		ЗаполнитьЗначенияСвойств(ЭтаФорма, ПользовательИБ,,"Пароль");
		
		Струк = вЗначениеСвойств(ПользовательИБ, "ЗащитаОтОпасныхДействий");
		Если Струк.ЗащитаОтОпасныхДействий <> Неопределено  Тогда
			ЗащитаОтОпасныхДействий = ПользовательИБ.ЗащитаОтОпасныхДействий.ПредупреждатьОбОпасныхДействиях;
		Иначе
			ЗащитаОтОпасныхДействий = ложь;
			Элементы.ЗащитаОтОпасныхДействий.ТолькоПросмотр = истина;
		КонецЕсли;
		
		Если ПользовательИБ.ПарольУстановлен Тогда
			Пароль = "12345";
			ПодтверждениеПароля = "54321";
		КонецЕсли;
		
		Для каждого Элем из Метаданные.Роли Цикл
			НС = РолиПользователя.Добавить();
			НС.Имя = Элем.Имя;
			НС.Представление = Элем.Представление();
			Если ПользовательИБ.Роли.Содержит(Элем) Тогда
				НС.Пометка = истина;
				НС.Присвоена = истина;
				Если _РежимРаботы = 2 Тогда
					НС.Присвоена = ложь;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
		
		РолиПользователя.Сортировать("Имя");
		
	КонецЕсли;
КонецПроцедуры

&НаСервереБезКонтекста
Функция вЗначениеСвойств(Знач Объект, ПереченьСвойств)
	Струк = новый Структура(ПереченьСвойств);
	ЗаполнитьЗначенияСвойств(Струк, Объект);
	
	Возврат Струк;
КонецФункции

&НаСервере
Процедура ЗаписатьОбъектНаСервере()
	Если _РежимРаботы = 0 Тогда
		ПользовательИБ = ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(ИдентификаторПользователяИБ);
	Иначе
		ПользовательИБ = ПользователиИнформационнойБазы.СоздатьПользователя();
		ПользовательИБ.Пароль = Пароль;
	КонецЕсли;
	
	Если не Элементы.ЗащитаОтОпасныхДействий.ТолькоПросмотр Тогда
		ЗаполнитьЗначенияСвойств(ПользовательИБ, ЭтаФорма,, "Пароль, ЗащитаОтОпасныхДействий");
		ПользовательИБ.ЗащитаОтОпасныхДействий.ПредупреждатьОбОпасныхДействиях = ЗащитаОтОпасныхДействий;
	Иначе
		ЗаполнитьЗначенияСвойств(ПользовательИБ, ЭтаФорма,, "Пароль");
	КонецЕсли;
	
	Для каждого Стр из РолиПользователя.НайтиСтроки(новый Структура("Пометка, Присвоена", истина, ложь)) Цикл
		ПользовательИБ.Роли.Добавить(Метаданные.Роли[Стр.Имя]);
	КонецЦикла;
	
	Для каждого Стр из РолиПользователя.НайтиСтроки(новый Структура("Пометка, Присвоена", ложь, истина)) Цикл
		ПользовательИБ.Роли.Удалить(Метаданные.Роли[Стр.Имя]);
	КонецЦикла;
	
	ПользовательИБ.Записать();
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьОбъект(Команда)
	Если _РежимРаботы <> 0 Тогда
		Если Пароль <> ПодтверждениеПароля Тогда
			ПоказатьПредупреждение(, "Пароль не совпадает с Подтверждением пароля!", 10);
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	Попытка
		ЗаписатьОбъектНаСервере();
		Закрыть();
	Исключение
		Сообщить(ОписаниеОшибки());
	КонецПопытки;
КонецПроцедуры

&НаСервере
Процедура ИзменитьПарольНаСервере()
	ПользовательИБ = ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(ИдентификаторПользователяИБ);
	ПользовательИБ.Пароль = Пароль;
	ПользовательИБ.Записать();
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьПароль(Команда)
	Если Пароль <> ПодтверждениеПароля Тогда
		ПоказатьПредупреждение(, "Пароль не совпадает с Подтверждением пароля!", 10);
		Возврат;
	КонецЕсли;
	
	ИзменитьПарольНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура _ПоказатьТолькоДоступные(Команда)
	ЭФ = Элементы.РолиПользователя_ПоказатьТолькоДоступные;
	ЭФ.Пометка = не Эф.Пометка;
	
	Если ЭФ.Пометка Тогда
		Элементы.РолиПользователя.ОтборСтрок = новый ФиксированнаяСтруктура(новый Структура("Пометка", истина));
	Иначе
		Элементы.РолиПользователя.ОтборСтрок = Неопределено;
	КонецЕсли;
КонецПроцедуры
