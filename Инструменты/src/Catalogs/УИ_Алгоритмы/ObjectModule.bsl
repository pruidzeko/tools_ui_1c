#Область СлужебныйПрограммныйИнтерфейс

Функция ПолучитьПараметры() Экспорт
//	Параметры = Хранилище.Получить();
//	Если Параметры = Неопределено ИЛИ ТипЗнч(Параметры) <> Тип("Структура")Тогда 
//		Параметры =  Новый Структура;
//	КонецЕсли;
//	Возврат Параметры;
КонецФункции

Функция ПолучитьПараметр(НаименованиеПараметра) Экспорт
//	Параметры = Хранилище.Получить();
//	Если Параметры <> Неопределено И Параметры.Свойство(НаименованиеПараметра) Тогда
//		Возврат Параметры[НаименованиеПараметра];
//	Иначе 
//		Возврат Неопределено;
//	КонецЕсли;
КонецФункции

Функция УдалитьПараметр(Ключ) Экспорт
//	Попытка
//		Параметры = ПолучитьПараметры();
//		Параметры.Удалить(Ключ);
//		Хранилище = Новый ХранилищеЗначения(Параметры);
//		Записать();
//		Возврат Истина;	
//	Исключение
//		ЗаписатьВЖурналРегистрации("Удаление параметра",ОписаниеОшибки());
//		Возврат Ложь;
//	КонецПопытки;
КонецФункции

Функция ПереименоватьПараметр(Ключ, НовИмя) Экспорт
//	Попытка
//		Параметры = ПолучитьПараметры();
//		Значение = Параметры[Ключ];
//		Параметры.Удалить(Ключ);
//		Параметры.Вставить(НовИмя,Значение);
//		Хранилище = Новый ХранилищеЗначения(Параметры);
//		Записать();
//		Возврат Истина;
//	Исключение
//		ЗаписатьВЖурналРегистрации("Переименовать параметр",ОписаниеОшибки());
//		Возврат Ложь;
//	КонецПопытки;
КонецФункции

#КонецОбласти