#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ОбновитьСписокЗадачНаСервере();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура СписокЗадачВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;

	ДанныеСтроки = СписокЗадач.НайтиПоИдентификатору(ВыбраннаяСтрока);

	НачатьЗапускПриложения(УИ_ОбщегоНазначенияКлиент.ПустоеОписаниеОповещенияДляЗапускаПриложения(), ДанныеСтроки.URL);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОбновитьСписокЗадач(Команда)
	ОбновитьСписокЗадачНаСервере();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьСписокЗадачНаСервере()
	СписокЗадач.Очистить();

	БазовыйАдрес = "https://api.github.com/repos/cpr1c/tools_ui_1c/issues";

	СписокЗадачРепозитория = УИ_КоннекторHTTP.GetJson(БазовыйАдрес);

	Для Каждого ЗадачаРепозитория Из СписокЗадачРепозитория Цикл
		НоваяЗадача = СписокЗадач.Добавить();
		НоваяЗадача.Номер = ЗадачаРепозитория["number"];
		НоваяЗадача.URL = ЗадачаРепозитория["html_url"];
		НоваяЗадача.Тема = ЗадачаРепозитория["title"];
		НоваяЗадача.Статус = ЗадачаРепозитория["state"];
		ОтветственныйЗадача = ЗадачаРепозитория["assignee"];
		Если ТипЗнч(ОтветственныйЗадача) = Тип("Соответствие") Тогда
			НоваяЗадача.Ответственный = ОтветственныйЗадача["login"];
		КонецЕсли;

		ТегиЗадачи = ЗадачаРепозитория["labels"];
		Если ТипЗнч(ТегиЗадачи) = Тип("Массив") Тогда
			Для Каждого ТекущийТег Из ТегиЗадачи Цикл
				НоваяЗадача.Теги.Добавить(ТекущийТег["name"]);
			КонецЦикла;
		КонецЕсли;

	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура СоздатьНовуюЗадачу(Команда)
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;

	ТокенАвторизации = "d1af40528d2ceec322be578bc935a1b46b9af8cc";

	Заголовки = Новый Соответствие;
	Заголовки.Вставить("Authorization", "token " + ТокенАвторизации);

	СтруктураТела = Новый Структура;
	СтруктураТела.Вставить("title", НоваяЗадачаТема);
	СтруктураТела.Вставить("body", НоваяЗадачаОписание);

	БазовыйАдрес = "https://api.github.com/repos/cpr1c/tools_ui_1c/issues";

	Аутентификация = Новый Структура("Пользователь, Пароль", "tools-ui", ТокенАвторизации);

	Ответ = УИ_КоннекторHTTP.PostJson(БазовыйАдрес, СтруктураТела, Новый Структура("Заголовки, Аутентификация",
		Заголовки, Аутентификация));

	АдресЗадачи = Ответ["html_url"];
	Если АдресЗадачи <> Неопределено Тогда
		УИ_ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Задача успешно создана");
		НачатьЗапускПриложения(УИ_ОбщегоНазначенияКлиент.ПустоеОписаниеОповещенияДляЗапускаПриложения(), АдресЗадачи);
	Иначе
		УИ_ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Создание задачи не удалось");
	КонецЕсли;

	ОбновитьСписокЗадачНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура СоздатьНовуюЗадачуНаГитхабе(Команда)
	НачатьЗапускПриложения(УИ_ОбщегоНазначенияКлиент.ПустоеОписаниеОповещенияДляЗапускаПриложения(),
		"https://github.com/cpr1c/tools_ui_1c/issues/new");
КонецПроцедуры

#КонецОбласти