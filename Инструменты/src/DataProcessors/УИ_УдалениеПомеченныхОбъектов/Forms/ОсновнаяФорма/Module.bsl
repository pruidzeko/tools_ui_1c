
////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ
&НаКлиенте
Процедура ПриОткрытии(Отказ)       
      
	НачатьПодключениеРасширенияРаботыСФайлами(Новый ОписаниеОповещения("ПриОткрытииЗавершение", ЭтаФорма));
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытииЗавершение(Подключено, ДополнительныеПараметры) Экспорт
	
	//Объект.Кодировка = "DOS";  
	//Объект.НачПериода = ТекущаяДата(); 
	//Объект.КонПериода = ТекущаяДата(); 
	//
	//@skip-warning
	ВозможностьВыбораФайлов = Подключено;
	//Если НЕ ВозможностьВыбораФайлов Тогда
	//	ОбщегоНазначенияКлиент.ПредложитьУстановкуРасширенияРаботыСФайлами();
	//	ВозможностьВыбораФайлов = ПодключитьРасширениеРаботыСФайлами();
	//КонецЕсли;

КонецПроцедуры  

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	РежимУдаления = "Полный";
	
//	УИ_РаботаСФормами.ФормаПриСозданииНаСервереСоздатьРеквизитыПараметровЗаписи(ЭтотОбъект, Элементы.ГруппаПараметрыЗаписи);
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура РежимУдаленияПриИзменении(Элемент)
	
	ОбновитьДоступностьКнопок();
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ СписокПомеченныхНаУдаление

&НаКлиенте
Процедура ПометкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.СписокПомеченныхНаУдаление.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьПометкуВСписке(ТекущиеДанные, ТекущиеДанные.Пометка, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПомеченныхНаУдалениеВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если Элемент.ТекущиеДанные <> Неопределено Тогда
		ОткрытьЗначениеПоТипу(Элемент.ТекущиеДанные.Значение);
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ ДеревоОставшихсяОбъектов

&НаКлиенте
Процедура ДеревоОставшихсяОбъектовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если Элемент.ТекущиеДанные <> Неопределено Тогда 
		ОткрытьЗначениеПоТипу(Элемент.ТекущиеДанные.Значение);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоОставшихсяОбъектовПередНачаломИзменения(Элемент, Отказ)
	
	Отказ = Истина;
	
	Если Элемент.ТекущиеДанные <> Неопределено Тогда
		ОткрытьЗначениеПоТипу(Элемент.ТекущиеДанные.Значение);
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура КомандаСписокПомеченныхУстановитьВсе()
	
	ЭлементыСписка = СписокПомеченныхНаУдаление.ПолучитьЭлементы();
	Для Каждого Элемент Из ЭлементыСписка Цикл
		УстановитьПометкуВСписке(Элемент, Истина, Истина);
		Родитель = Элемент.ПолучитьРодителя();
		Если Родитель = Неопределено Тогда
			ПроверитьРодителя(Элемент)
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаСписокПомеченныхСнятьВсе()
	
	ЭлементыСписка = СписокПомеченныхНаУдаление.ПолучитьЭлементы();
	Для Каждого Элемент Из ЭлементыСписка Цикл
		УстановитьПометкуВСписке(Элемент, Ложь, Истина);
		Родитель = Элемент.ПолучитьРодителя();
		Если Родитель = Неопределено Тогда
			ПроверитьРодителя(Элемент)
		КонецЕсли;	
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьОбъект(Команда)
	
	Если ТекущийЭлемент = Неопределено Тогда
		Возврат;	
	КонецЕсли;
		
	Если ТекущийЭлемент <> Элементы.СписокПомеченныхНаУдаление И ТекущийЭлемент <> Элементы.ДеревоОставшихсяОбъектов Тогда
		Возврат;	
	КонецЕсли;
	
	Если ТекущийЭлемент.ТекущиеДанные <> Неопределено Тогда
		ОткрытьЗначениеПоТипу(ТекущийЭлемент.ТекущиеДанные.Значение);
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Процедура РедактироватьОбъект(Команда)
	Если ТекущийЭлемент = Неопределено Тогда
		Возврат;	
	КонецЕсли;
		
	Если ТекущийЭлемент <> Элементы.СписокПомеченныхНаУдаление И ТекущийЭлемент <> Элементы.ДеревоОставшихсяОбъектов Тогда
		Возврат;	
	КонецЕсли;
	
	Если ТекущийЭлемент.ТекущиеДанные <> Неопределено Тогда
		УИ_ОбщегоНазначенияКлиент.РедактироватьОбъект(ТекущийЭлемент.ТекущиеДанные.Значение);
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура ВыполнитьДалее()
	
	ТекущаяСтраница = Элементы.СтраницыФормы.ТекущаяСтраница;
	
	Если ТекущаяСтраница = Элементы.ВыборРежимаУдаления Тогда
		
		ОбновитьСписокПомеченныхНаУдаление(Неопределено);
		
		Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.ПомеченныеНаУдаление;
		ОбновитьДоступностьКнопок();
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьНазад()
	
	ТекущаяСтраница = Элементы.СтраницыФормы.ТекущаяСтраница;
	Если ТекущаяСтраница = Элементы.ПомеченныеНаУдаление Тогда
		Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.ВыборРежимаУдаления;
		ОбновитьДоступностьКнопок();
	ИначеЕсли ТекущаяСтраница = Элементы.ПричиныНевозможностиУдаления Тогда
		Если РежимУдаления = "Полный" Тогда
			Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.ВыборРежимаУдаления;
		Иначе
			Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.ПомеченныеНаУдаление;
		КонецЕсли;
		ОбновитьДоступностьКнопок();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьУдаление()
	
	Перем ТипыУдаленныхОбъектов;
	
	Если РежимУдаления = "Полный" Тогда
		Состояние(НСтр("ru = 'Выполняется поиск и удаление помеченных объектов'"));
	Иначе
		Состояние(НСтр("ru = 'Выполняется удаление выбранных объектов'"));
	КонецЕсли;
	
	Результат = УдалениеВыбранныхНаСервере(ТипыУдаленныхОбъектов);
	Если НЕ Результат.ЗаданиеВыполнено Тогда
		ИдентификаторЗадания = Результат.ИдентификаторЗадания;
		АдресХранилища       = Результат.АдресХранилища;
		
		УИ_ДлительныеОперацииКлиент.ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", 1, Истина);
		Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.ДлительнаяОперация; 
	Иначе
		ОбновитьСодержание(Результат.РезультатУдаления, Результат.СообщениеОбОшибке,
			Результат.РезультатУдаления.ТипыУдаленныхОбъектов);
		ПодключитьОбработчикОжидания("ПереключитьСтраницу", 0.1, Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСписокПомеченныхНаУдаление(Команда)
	
	Состояние(НСтр("ru = 'Выполняется поиск помеченных на удаление объектов'"));
	
	ЗаполнениеДереваПомеченныхНаУдаление();
	
	Если КоличествоУровнейПомеченныхНаУдаление = 1 Тогда
		Для Каждого Элемент Из СписокПомеченныхНаУдаление.ПолучитьЭлементы() Цикл
			Идентификатор = Элемент.ПолучитьИдентификатор();
			Элементы.СписокПомеченныхНаУдаление.Развернуть(Идентификатор, Ложь);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_НастроитьПараметрыЗаписи(Команда)
	УИ_ОбщегоНазначенияКлиент.РедактироватьПараметрыЗаписи(ЭтотОбъект);
КонецПроцедуры



////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаСервере
Функция ЗначениеПоТипу(Значение)
	
	ОбъектМетаданных = Метаданные.НайтиПоТипу(ТипЗнч(Значение));
	
	Если ОбъектМетаданных <> Неопределено
	   И УИ_ОбщегоНазначения.ЭтоРегистр(ОбъектМетаданных) Тогда
		
		Список = Новый СписокЗначений;
		Список.Добавить(Значение, ОбъектМетаданных.ПолноеИмя());
		Возврат Список;
	КонецЕсли;
	
	Возврат Значение;
	
КонецФункции

&НаКлиенте
Процедура ОткрытьЗначениеПоТипу(Значение)
	
	Если ТипЗнч(Значение) = Тип("СписокЗначений") Тогда
		ОписаниеЗначения = Значение.Получить(0);
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Ключ", ОписаниеЗначения.Значение);
		
		ОткрытьФорму(ОписаниеЗначения.Представление + ".ФормаЗаписи", ПараметрыФормы, ЭтаФорма);
	Иначе
		ПоказатьЗначение(Неопределено, Значение);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСодержание(Результат, СообщениеОбОшибке, ТипыУдаленныхОбъектов)
	
	Если Результат.Статус Тогда
		Для Каждого ТипУдаленногоОбъекта Из ТипыУдаленныхОбъектов Цикл
			ОповеститьОбИзменении(ТипУдаленногоОбъекта);
		КонецЦикла;
	Иначе
		ИмяСтраницы = "ВыборРежимаУдаления";
		ПоказатьПредупреждение(,СообщениеОбОшибке);
		Возврат;
	КонецЕсли;
	
	ОбновитьДеревоПомеченных = Истина;
	Если КоличествоНеУдаленныхОбъектов = 0 Тогда
		Если УдаленныхОбъектов = 0 Тогда
			Текст = НСтр("ru = 'Не помечено на удаление ни одного объекта. Удаление объектов не выполнялось.'");
			ОбновитьДеревоПомеченных = Ложь;
		Иначе
			Текст = СтрШаблон(
			             НСтр("ru = 'Удаление помеченных объектов успешно завершено.
			                        |Удалено объектов: %1.'"),
			             УдаленныхОбъектов);
		КонецЕсли;
		ИмяСтраницы = "ВыборРежимаУдаления";
		ПоказатьПредупреждение(,Текст);
	Иначе
		ИмяСтраницы = "ПричиныНевозможностиУдаления";
		Для Каждого Элемент Из ДеревоОставшихсяОбъектов.ПолучитьЭлементы() Цикл
			Идентификатор = Элемент.ПолучитьИдентификатор();
			Элементы.ДеревоОставшихсяОбъектов.Развернуть(Идентификатор, Ложь);
		КонецЦикла;
		ПоказатьПредупреждение(,СтрокаРезультатов);
	КонецЕсли;
	
	Если ОбновитьДеревоПомеченных Тогда
		ОбновитьСписокПомеченныхНаУдаление(Неопределено);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПереключитьСтраницу()
	Если ИмяСтраницы <> "" Тогда
		Страница = Элементы.Найти(ИмяСтраницы);
		Если Страница <> Неопределено Тогда
			Элементы.СтраницыФормы.ТекущаяСтраница = Страница;
			ОбновитьДоступностьКнопок();
		КонецЕсли;
		ИмяСтраницы = "";
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДоступностьКнопок()
	
	ТекущаяСтраница = Элементы.СтраницыФормы.ТекущаяСтраница;
	
	Если ТекущаяСтраница = Элементы.ВыборРежимаУдаления Тогда
		Элементы.КомандаНазад.Доступность   = Ложь;
		Если РежимУдаления = "Полный" Тогда
			Элементы.КомандаДалее.Доступность   = Ложь;
			Элементы.КомандаУдалить.Доступность = Истина;
		ИначеЕсли РежимУдаления = "Выборочный" Тогда
			Элементы.КомандаДалее.Доступность 	= Истина;
			Элементы.КомандаУдалить.Доступность = Ложь;
		КонецЕсли;
	ИначеЕсли ТекущаяСтраница = Элементы.ПомеченныеНаУдаление Тогда
		Элементы.КомандаНазад.Доступность   = Истина;
		Элементы.КомандаДалее.Доступность   = Ложь;
		Элементы.КомандаУдалить.Доступность = Истина;
	ИначеЕсли ТекущаяСтраница = Элементы.ПричиныНевозможностиУдаления Тогда
		Элементы.КомандаНазад.Доступность   = Истина;
		Элементы.КомандаДалее.Доступность   = Ложь;
		Элементы.КомандаУдалить.Доступность = Ложь;
	КонецЕсли;
	
КонецПроцедуры

// Возвращает ветвь дерева в ветви СтрокиДерева по значению Значение.
// Если ветвь не найдена - создается новая.
&НаСервере
Функция НайтиИлиДобавитьВетвьДерева(СтрокиДерева, Значение, Представление, Пометка)
	
	// Попытка найти существующую ветвь в СтрокиДерева без вложенных
	Ветвь = СтрокиДерева.Найти(Значение, "Значение", Ложь);
	
	Если Ветвь = Неопределено Тогда
		// Такой ветки нет, создадим новую
		Ветвь = СтрокиДерева.Добавить();
		Ветвь.Значение      = ЗначениеПоТипу(Значение);
		Ветвь.Представление = Представление;
		Ветвь.Пометка       = Пометка;
	КонецЕсли;
	
	Возврат Ветвь;
	
КонецФункции

&НаСервере
Функция НайтиИлиДобавитьВетвьДереваСКартинкой(СтрокиДерева, Значение, Представление, НомерКартинки)
	
	// Попытка найти существующую ветвь в СтрокиДерева без вложенных
	Ветвь = СтрокиДерева.Найти(Значение, "Значение", Ложь);
	Если Ветвь = Неопределено Тогда
		// Такой ветки нет, создадим новую
		Ветвь = СтрокиДерева.Добавить();
		Ветвь.Значение      = ЗначениеПоТипу(Значение);
		Ветвь.Представление = Представление;
		Ветвь.НомерКартинки = НомерКартинки;
	КонецЕсли;

	Возврат Ветвь;
	
КонецФункции
// Возвращает помеченные на удаление объекты. Возможен отбор по фильтру.//
&НаСервере
Функция ПолучитьПомеченныеНаУдаление() 
	
	УстановитьПривилегированныйРежим(Истина);
	МассивПомеченные = НайтиПомеченныеНаУдаление();
	УстановитьПривилегированныйРежим(Ложь);
	
	Результат = Новый Массив;
	Для Каждого ЭлементПомеченный Из МассивПомеченные Цикл
		Если ПравоДоступа("ИнтерактивноеУдалениеПомеченных", ЭлементПомеченный.Метаданные()) Тогда
			Результат.Добавить(ЭлементПомеченный);
		КонецЕсли
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции
&НаСервере
Процедура ЗаполнениеДереваПомеченныхНаУдаление()
	
	// Заполнение дерева помеченных на удаление
	ДеревоПомеченных = РеквизитФормыВЗначение("СписокПомеченныхНаУдаление");
	
	ДеревоПомеченных.Строки.Очистить();
	
	// обработка помеченных
	МассивПомеченных = ПолучитьПомеченныеНаУдаление();
	
	Для Каждого МассивПомеченныхЭлемент Из МассивПомеченных Цикл
		ОбъектМетаданныхЗначение = МассивПомеченныхЭлемент.Метаданные().ПолноеИмя();
		ОбъектМетаданныхПредставление = МассивПомеченныхЭлемент.Метаданные().Представление();
		СтрокаОбъектаМетаданных = НайтиИлиДобавитьВетвьДерева(ДеревоПомеченных.Строки, ОбъектМетаданныхЗначение, ОбъектМетаданныхПредставление, Истина);
		НайтиИлиДобавитьВетвьДерева(СтрокаОбъектаМетаданных.Строки, МассивПомеченныхЭлемент, Строка(МассивПомеченныхЭлемент), Истина);
	КонецЦикла;
	
	ДеревоПомеченных.Строки.Сортировать("Значение", Истина);
	
	Для Каждого СтрокаОбъектаМетаданных Из ДеревоПомеченных.Строки Цикл
		// создать представление для строк, отображающих ветвь объекта метаданных
		СтрокаОбъектаМетаданных.Представление = СтрокаОбъектаМетаданных.Представление + " (" + СтрокаОбъектаМетаданных.Строки.Количество() + ")";
	КонецЦикла;
	
	КоличествоУровнейПомеченныхНаУдаление = ДеревоПомеченных.Строки.Количество();
	
	ЗначениеВРеквизитФормы(ДеревоПомеченных, "СписокПомеченныхНаУдаление");
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПометкуВСписке(Данные, Пометка, ПроверятьРодителя)
	
	// Устанавливаем подчиненным
	ЭлементыСтроки = Данные.ПолучитьЭлементы();
	
	Для Каждого Элемент Из ЭлементыСтроки Цикл
		Элемент.Пометка = Пометка;
		УстановитьПометкуВСписке(Элемент, Пометка, Ложь);
	КонецЦикла;
	
	// Проверяем родителя
	Родитель = Данные.ПолучитьРодителя();
	
	Если ПроверятьРодителя И Родитель <> Неопределено Тогда 
		ПроверитьРодителя(Родитель);
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьРодителя(Родитель)
	
	ПометкаРодителя = Истина;
		ЭлементыСтроки = Родитель.ПолучитьЭлементы();
		Для Каждого Элемент Из ЭлементыСтроки Цикл
			Если Не Элемент.Пометка Тогда
				ПометкаРодителя = Ложь;
				Прервать;
			КонецЕсли;
		КонецЦикла;
	Родитель.Пометка = ПометкаРодителя;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьМассивПомеченныхОбъектовНаУдаление(СписокПомеченныхНаУдаление, РежимУдаления)
	
	Удаляемые = Новый Массив;
	
	Если РежимУдаления = "Полный" Тогда
		// При полном удалении получаем весь список помеченных на удаление
		Удаляемые = ПолучитьПомеченныеНаУдаление();
	Иначе
		// Заполняем массив ссылками на выбранные элементы, помеченные на удаление
		КоллекцияСтрокМетаданных = СписокПомеченныхНаУдаление.ПолучитьЭлементы();
		Для Каждого СтрокаОбъектаМетаданных Из КоллекцияСтрокМетаданных Цикл
			КоллекцияСтрокСсылок = СтрокаОбъектаМетаданных.ПолучитьЭлементы();
			Для Каждого СтрокаСсылки Из КоллекцияСтрокСсылок Цикл
				Если СтрокаСсылки.Пометка Тогда
					Удаляемые.Добавить(СтрокаСсылки.Значение);
				КонецЕсли;
			КонецЦикла;
		КонецЦикла;
	КонецЕсли;
	
	Возврат Удаляемые;

КонецФункции	
&НаСервере
Процедура УдалитьОбъектыНМ(УдаляемыеОбъекты, РежимНМ, ПрепятствуюшиеУдалению)
	Если РежимНМ = Истина  Тогда
		ВсеСсылки = НайтиПоСсылкам(УдаляемыеОбъекты); //ПрепятствуюшиеУдалению
		ПрепятствуюшиеУдалению.Колонки.Добавить("УдаляемыйСсылка");
		ПрепятствуюшиеУдалению.Колонки.Добавить("ОбнаруженныйСсылка");
        ПрепятствуюшиеУдалению.Колонки.Добавить("ОбнаруженныйМетаданные");
 
		Для Каждого ССылка из ВсеСсылки Цикл
            УдаляемыйСсылка =ССылка[0];
			ССылкаНаобъект = ССылка[1];
            ОбъектМетаданных=ССылка[2];
			Если УдаляемыйСсылка = ССылкаНаобъект Тогда
				Продолжить;   // ссылается сам на себя
			Иначе
				Мешает=ПрепятствуюшиеУдалению.Добавить();
				Мешает.УдаляемыйСсылка=УдаляемыйСсылка;   
				Мешает.ОбнаруженныйСсылка=ССылкаНаобъект;
				Мешает.ОбнаруженныйМетаданные=ОбъектМетаданных;
			КонецЕсли;
		КонецЦикла;
		Иначе
		УдалитьОбъекты(УдаляемыеОбъекты, РежимНМ);//безусловное удаление
	КонецЕсли;	
КонецПроцедуры	
&НаСервере
Функция ВыполнитьУдалениеДок(Знач Удаляемые, ТипыУдаленныхОбъектовМассив) 
	РезультатУдаления = Новый Структура("Статус, Значение", Ложь, "");
	
	Если НЕ УИ_Пользователи.ЭтоПолноправныйПользователь() Тогда
		ВызватьИсключение НСтр("ru = 'Недостаточно прав для выполнения операции.'");
	КонецЕсли;
	
	ТипыУдаленныхОбъектов = Новый ТаблицаЗначений;
	ТипыУдаленныхОбъектов.Колонки.Добавить("Тип", Новый ОписаниеТипов("Тип"));
	Для Каждого УдаляемыйОбъект Из Удаляемые Цикл
		НовыйТип = ТипыУдаленныхОбъектов.Добавить();
		НовыйТип.Тип = ТипЗнч(УдаляемыйОбъект);
	КонецЦикла;
	ТипыУдаленныхОбъектов.Свернуть("Тип");
	
	НеУдаленные = Новый Массив;
	
	Найденные = Новый ТаблицаЗначений;
	Найденные.Колонки.Добавить("УдаляемыйСсылка");
	Найденные.Колонки.Добавить("ОбнаруженныйСсылка");
	Найденные.Колонки.Добавить("ОбнаруженныйМетаданные");
	
	УдаляемыеОбъекты = Новый Массив;
	Для Каждого СсылкаНаОбъект Из Удаляемые Цикл
		УдаляемыеОбъекты.Добавить(СсылкаНаОбъект);
	КонецЦикла;
	
	МетаданныеРегистрыСведений = Метаданные.РегистрыСведений;
	МетаданныеРегистрыНакопления = Метаданные.РегистрыНакопления;
	МетаданныеРегистрыБухгалтерии = Метаданные.РегистрыБухгалтерии;
	
	ИсключенияПоискаСсылок = УИ_ОбщегоНазначения.ИсключенияПоискаСсылок();
	
	ИсключающиеПравилаОбъектаМетаданных = Новый Соответствие;
	
	Пока УдаляемыеОбъекты.Количество() > 0 Цикл
		ПрепятствуюшиеУдалению = Новый ТаблицаЗначений;
		
		// Попытка удалить с контролем ссылочной целостности.
		Попытка
			УстановитьПривилегированныйРежим(Истина);
			УдалитьОбъектыНМ(УдаляемыеОбъекты, Истина, ПрепятствуюшиеУдалению);
			УстановитьПривилегированныйРежим(Ложь);
		Исключение
//			УстановитьМонопольныйРежим(Ложь);
			РезультатУдаления.Значение = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			Возврат РезультатУдаления;
		КонецПопытки;
		
		КоличествоУдаляемыхОбъектов = УдаляемыеОбъекты.Количество();
		
		// Назначение имен колонок для таблицы конфликтов, возникших при удалении.
		ПрепятствуюшиеУдалению.Колонки[0].Имя = "УдаляемыйСсылка";
		ПрепятствуюшиеУдалению.Колонки[1].Имя = "ОбнаруженныйСсылка";
		ПрепятствуюшиеУдалению.Колонки[2].Имя = "ОбнаруженныйМетаданные";
		
		// Перемещение удаляемых объектов в список не удаленных
		// и добавление в список найденных зависимых объектов
		// с учетом исключения поиска ссылок.
		Для Каждого СтрокаТаблицы Из ПрепятствуюшиеУдалению Цикл
			ИсключениеПоиска = ИсключенияПоискаСсылок[СтрокаТаблицы.ОбнаруженныйМетаданные];
			
			Если ИсключениеПоиска = "*" Тогда
				Продолжить; // Можно удалять (обнаруженный объект метаданных не мешает).
			КонецЕсли;
			
			// Определение исключащего правила для объекта метаданных, препятствующего удалению:
			// Для регистров (т.н. "необъектных таблиц") - массива реквизитов для поиска в записи регистра.
			// Для ссылочных типов (т.н. "объектных таблиц") - готового запроса для поиска в реквизитах.
			ИменаРеквизитовИлиЗапрос = ИсключающиеПравилаОбъектаМетаданных[СтрокаТаблицы.ОбнаруженныйМетаданные];
			Если ИменаРеквизитовИлиЗапрос = Неопределено Тогда
				
				// Формирование исключащего правила.
				ЭтоРегистрСведений = МетаданныеРегистрыСведений.Содержит(СтрокаТаблицы.ОбнаруженныйМетаданные);
				Если ЭтоРегистрСведений
					ИЛИ МетаданныеРегистрыБухгалтерии.Содержит(СтрокаТаблицы.ОбнаруженныйМетаданные) // ЭтоРегистрБухгалтерии
					ИЛИ МетаданныеРегистрыНакопления.Содержит(СтрокаТаблицы.ОбнаруженныйМетаданные) Тогда // ЭтоРегистрНакопления
					
					ИменаРеквизитовИлиЗапрос = Новый Массив;
					Если ЭтоРегистрСведений Тогда
						Для Каждого Измерение Из СтрокаТаблицы.ОбнаруженныйМетаданные.Измерения Цикл
							Если Измерение.Ведущее Тогда
								ИменаРеквизитовИлиЗапрос.Добавить(Измерение.Имя);
							КонецЕсли;
						КонецЦикла;
					Иначе
						Для Каждого Измерение Из СтрокаТаблицы.ОбнаруженныйМетаданные.Измерения Цикл
							ИменаРеквизитовИлиЗапрос.Добавить(Измерение.Имя);
						КонецЦикла;
					КонецЕсли;
					
					Если ТипЗнч(ИсключениеПоиска) = Тип("Массив") Тогда
						Для Каждого ИмяРеквизита Из ИсключениеПоиска Цикл
							Если ИменаРеквизитовИлиЗапрос.Найти(ИмяРеквизита) = Неопределено Тогда
								ИменаРеквизитовИлиЗапрос.Добавить(ИмяРеквизита);
							КонецЕсли;
						КонецЦикла;
					КонецЕсли;
					
				ИначеЕсли ТипЗнч(ИсключениеПоиска) = Тип("Массив") Тогда
					
					ТекстыЗапросов = Новый Соответствие;
					ИмяКорневойТаблицы = СтрокаТаблицы.ОбнаруженныйМетаданные.ПолноеИмя();
					
					Для Каждого ПутьКРеквизиту Из ИсключениеПоиска Цикл
						ПозицияТочки = Найти(ПутьКРеквизиту, ".");
						Если ПозицияТочки = 0 Тогда
							ПолноеИмяТаблицы = ИмяКорневойТаблицы;
							ИмяРеквизита = ПутьКРеквизиту;
						Иначе
							ПолноеИмяТаблицы = ИмяКорневойТаблицы + "." + Лев(ПутьКРеквизиту, ПозицияТочки - 1);
							ИмяРеквизита = Сред(ПутьКРеквизиту, ПозицияТочки + 1);
						КонецЕсли;
						
						ТекстВложенногоЗапроса = ТекстыЗапросов.Получить(ПолноеИмяТаблицы);
						Если ТекстВложенногоЗапроса = Неопределено Тогда
							ТекстВложенногоЗапроса = 
							"ВЫБРАТЬ ПЕРВЫЕ 1
							|	1
							|ИЗ
							|	"+ ПолноеИмяТаблицы +" КАК Таблица
							|ГДЕ
							|	Таблица.Ссылка = &ОбнаруженныйСсылка
							|	И (";
						Иначе
							ТекстВложенногоЗапроса = ТекстВложенногоЗапроса + Символы.ПС + Символы.Таб + Символы.Таб + "ИЛИ ";
						КонецЕсли;
						ТекстВложенногоЗапроса = ТекстВложенногоЗапроса + "Таблица." + ИмяРеквизита + " = &УдаляемыйСсылка";
						
						ТекстыЗапросов.Вставить(ПолноеИмяТаблицы, ТекстВложенногоЗапроса);
					КонецЦикла;
					
					ТекстЗапроса = "";
					Для Каждого КлючИЗначение Из ТекстыЗапросов Цикл
						Если ТекстЗапроса <> "" Тогда
							ТекстЗапроса = ТекстЗапроса + Символы.ПС + Символы.ПС + "ОБЪЕДИНИТЬ ВСЕ" + Символы.ПС + Символы.ПС;
						КонецЕсли;
						ТекстЗапроса = ТекстЗапроса + КлючИЗначение.Значение + ")";
					КонецЦикла;
					
					ИменаРеквизитовИлиЗапрос = Новый Запрос;
					ИменаРеквизитовИлиЗапрос.Текст = ТекстЗапроса;
					
				Иначе
					
					ИменаРеквизитовИлиЗапрос = "";
					
				КонецЕсли;
				
				ИсключающиеПравилаОбъектаМетаданных.Вставить(СтрокаТаблицы.ОбнаруженныйМетаданные, ИменаРеквизитовИлиЗапрос);
				
			КонецЕсли;
			
			// Проверка исключащего правила.
			Если ТипЗнч(ИменаРеквизитовИлиЗапрос) = Тип("Массив") Тогда
				УдаляемаяСсылкаВИсключаемомРеквизите = Ложь;
				
				Для Каждого ИмяРеквизита Из ИменаРеквизитовИлиЗапрос Цикл
					Если СтрокаТаблицы.ОбнаруженныйСсылка[ИмяРеквизита] = СтрокаТаблицы.УдаляемыйСсылка Тогда
						УдаляемаяСсылкаВИсключаемомРеквизите = Истина;
						Прервать;
					КонецЕсли;
				КонецЦикла;
				
				Если УдаляемаяСсылкаВИсключаемомРеквизите Тогда
					Продолжить; // Можно удалять (обнаруженная запись регистра не мешает).
				КонецЕсли;
			ИначеЕсли ТипЗнч(ИменаРеквизитовИлиЗапрос) = Тип("Запрос") Тогда
				ИменаРеквизитовИлиЗапрос.УстановитьПараметр("УдаляемыйСсылка", СтрокаТаблицы.УдаляемыйСсылка);
				ИменаРеквизитовИлиЗапрос.УстановитьПараметр("ОбнаруженныйСсылка", СтрокаТаблицы.ОбнаруженныйСсылка);
				Если НЕ ИменаРеквизитовИлиЗапрос.Выполнить().Пустой() Тогда
					Продолжить; // Можно удалять (обнаруженная ссылка не мешает).
				КонецЕсли;
			КонецЕсли;
			
			// Все исключающие правила пройдены.
			// Невозможно удалить объект (мешает обнаруженная ссылка или запись регистра).
			// Сокращение удаляемых объектов.
			Индекс = УдаляемыеОбъекты.Найти(СтрокаТаблицы.УдаляемыйСсылка);
			Если Индекс <> Неопределено Тогда
				УдаляемыеОбъекты.Удалить(Индекс);
			КонецЕсли;
			
			// Добавление не удаленных объектов.
			Если НеУдаленные.Найти(СтрокаТаблицы.УдаляемыйСсылка) = Неопределено Тогда
				НеУдаленные.Добавить(СтрокаТаблицы.УдаляемыйСсылка);
			КонецЕсли;
			
			// Добавление найденных зависимых объектов.
			НоваяСтрока = Найденные.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаТаблицы);
			
		КонецЦикла;
		
		// Удаление без контроля, если состав удаляемых объектов не был изменён на этом шаге цикла.
		Если КоличествоУдаляемыхОбъектов = УдаляемыеОбъекты.Количество() Тогда
			Попытка
				// Удаление без контроля ссылочной целостности.
				УстановитьПривилегированныйРежим(Истина);
				УдалитьОбъекты(УдаляемыеОбъекты, Ложь);
				УстановитьПривилегированныйРежим(Ложь);
			Исключение
				УстановитьМонопольныйРежим(Ложь);;
				РезультатУдаления.Значение = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
				Возврат РезультатУдаления;
			КонецПопытки;
			
			// Удаление всего, что возможно, завершено - выход из цикла.
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого НеУдаленныйОбъект Из НеУдаленные Цикл
		НайденныеСтроки = ТипыУдаленныхОбъектов.НайтиСтроки(Новый Структура("Тип", ТипЗнч(НеУдаленныйОбъект)));
		Если НайденныеСтроки.Количество() > 0 Тогда
			ТипыУдаленныхОбъектов.Удалить(НайденныеСтроки[0]);
		КонецЕсли;
	КонецЦикла;
	
	ТипыУдаленныхОбъектовМассив = ТипыУдаленныхОбъектов.ВыгрузитьКолонку("Тип");
	
	УстановитьМонопольныйРежим(Ложь);
	
	Найденные.Колонки.УдаляемыйСсылка.Имя        = "Ссылка";
	Найденные.Колонки.ОбнаруженныйСсылка.Имя     = "Данные";
	Найденные.Колонки.ОбнаруженныйМетаданные.Имя = "Метаданные";
	
	РезультатУдаления.Статус = Истина;
	РезультатУдаления.Значение = Новый Структура("Найденные, НеУдаленные", Найденные, НеУдаленные);
	
	Возврат РезультатУдаления;
КонецФункции
&НаСервере
Процедура УдалитьПомеченныеОбъекты(ПараметрыУдаления, АдресХранилища) 
	
	// Извлекаем параметры
	СписокПомеченныхНаУдал	= ПараметрыУдаления.СписокПомеченныхНаУдаление;
	РежимУдаления				= ПараметрыУдаления.РежимУдаления;
	ТипыУдаленныхОбъектов		= ПараметрыУдаления.ТипыУдаленныхОбъектов;
	
	Удаляемые = ПолучитьМассивПомеченныхОбъектовНаУдаление(СписокПомеченныхНаУдал, РежимУдаления);
	КоличествоУдаляемых = Удаляемые.Количество();
	
	// Выполняем удаление
	Результат = ВыполнитьУдалениеДок(Удаляемые, ТипыУдаленныхОбъектов);
	
	// Добавляем параметры 
	Если ТипЗнч(Результат.Значение) = Тип("Структура") Тогда 
		КоличествоНеУдаленныхОбъектов = Результат.Значение.НеУдаленные.Количество();
	Иначе	
		КоличествоНеУдаленныхОбъектов = 0;
	КонецЕсли;	
	Результат.Вставить("КоличествоНеУдаленныхОбъектов", КоличествоНеУдаленныхОбъектов);
	Результат.Вставить("КоличествоУдаляемых",			КоличествоУдаляемых);
	Результат.Вставить("ТипыУдаленныхОбъектов",			ТипыУдаленныхОбъектов);
	
	ПоместитьВоВременноеХранилище(Результат, АдресХранилища);

КонецПроцедуры
// Производит попытку удаления выбранных объектов.
// Объекты, которые не были удалены показываются в отдельной таблице.
&НаСервере
Функция УдалениеВыбранныхНаСервере(ТипыУдаленныхОбъектов)
	
	ПараметрыУдаления = Новый Структура("СписокПомеченныхНаУдаление, РежимУдаления, ТипыУдаленныхОбъектов, ", 
		СписокПомеченныхНаУдаление, РежимУдаления, ТипыУдаленныхОбъектов);
											
	АдресХранилища = ПоместитьВоВременноеХранилище(Неопределено, УникальныйИдентификатор);
	УдалитьПомеченныеОбъекты(ПараметрыУдаления, АдресХранилища);
	Результат = Новый Структура("ЗаданиеВыполнено", Истина);		
	
	Если Результат.ЗаданиеВыполнено Тогда
		Результат = ЗаполнитьРезультаты(АдресХранилища, Результат);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция ЗаполнитьРезультаты(АдресХранилища, Результат)
	
	РезультатУдаления = ПолучитьИзВременногоХранилища(АдресХранилища);
	Если Не РезультатУдаления.Статус Тогда 
		Результат.Вставить("РезультатУдаления", РезультатУдаления);
		Результат.Вставить("СообщениеОбОшибке", РезультатУдаления.Значение);
		Возврат Результат;
	КонецЕсли;
	
	Дерево = ЗаполнитьДеревоОставшихсяОбъектов(РезультатУдаления);
	ЗначениеВРеквизитФормы(Дерево, "ДеревоОставшихсяОбъектов");
	
	КоличествоУдаляемых 			= РезультатУдаления.КоличествоУдаляемых;
	КоличествоНеУдаленныхОбъектов 	= РезультатУдаления.КоличествоНеУдаленныхОбъектов;
	ЗаполнитьСтрокуРезультатов(КоличествоУдаляемых);
	
	Если ТипЗнч(РезультатУдаления.Значение) = Тип("Структура") Тогда
		РезультатУдаления.Удалить("Значение");
	КонецЕсли;	
	
	Результат.Вставить("РезультатУдаления", РезультатУдаления);
	Результат.Вставить("СообщениеОбОшибке", "");
    Возврат Результат;
	
КонецФункции

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ПроверитьВыполнениеЗадания()
	
	Попытка
		Если Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.ДлительнаяОперация Тогда
			Если ЗаданиеВыполнено(ИдентификаторЗадания) Тогда
				Результат = ЗаполнитьРезультаты(АдресХранилища, Новый Структура);
				//@skip-warning
				ТипыУдаленныхОбъектов = Неопределено;
				ОбновитьСодержание(Результат.РезультатУдаления, Результат.РезультатУдаления.Значение, Результат.РезультатУдаления.ТипыУдаленныхОбъектов);
			Иначе
				УИ_ДлительныеОперацииКлиент.ОбновитьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
				ПодключитьОбработчикОжидания(
					"Подключаемый_ПроверитьВыполнениеЗадания", 
					ПараметрыОбработчикаОжидания.ТекущийИнтервал, 
					Истина);
			КонецЕсли;
		КонецЕсли;
	Исключение
		ВызватьИсключение;
	КонецПопытки;

КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаданиеВыполнено(ИдентификаторЗадания)
	
	Возврат УИ_ДлительныеОперации.ЗаданиеВыполнено(ИдентификаторЗадания);
	
КонецФункции

&НаСервере
Функция ЗаполнитьДеревоОставшихсяОбъектов(Результат)
	
	Найденные   = Результат.Значение.Найденные;
	НеУдаленные = Результат.Значение.НеУдаленные;
	
	КоличествоНеУдаленныхОбъектов = НеУдаленные.Количество();
	
	// Создадим таблицу оставшихся (не удаленных) объектов
	ДеревоОставшихсяОбъектов.ПолучитьЭлементы().Очистить();
	
	Дерево = РеквизитФормыВЗначение("ДеревоОставшихсяОбъектов");
	
	Для Каждого Найденный Из Найденные Цикл
		НеУдаленный = Найденный[0];
		Ссылающийся = Найденный[1];
		ОбъектМетаданныхСсылающегося = Найденный[2].Представление();
		ОбъектМетаданныхНеУдаленногоЗначение = НеУдаленный.Метаданные().ПолноеИмя();
		ОбъектМетаданныхНеУдаленногоПредставление = НеУдаленный.Метаданные().Представление();
		//ветвь метаданного
		СтрокаОбъектаМетаданных = НайтиИлиДобавитьВетвьДереваСКартинкой(Дерево.Строки, ОбъектМетаданныхНеУдаленногоЗначение, ОбъектМетаданныхНеУдаленногоПредставление, 0);
		//ветвь не удаленного объекта
		СтрокаСсылкиНаНеУдаленныйОбъектБД = НайтиИлиДобавитьВетвьДереваСКартинкой(СтрокаОбъектаМетаданных.Строки, НеУдаленный, Строка(НеУдаленный), 2);
		//ветвь ссылки на не удаленный объект
		НайтиИлиДобавитьВетвьДереваСКартинкой(СтрокаСсылкиНаНеУдаленныйОбъектБД.Строки, Ссылающийся, Строка(Ссылающийся) + " - " + ОбъектМетаданныхСсылающегося, 1);
	КонецЦикла;
	
	Дерево.Строки.Сортировать("Значение", Истина);
	
	Возврат Дерево;

КонецФункции

&НаСервере
Процедура ЗаполнитьСтрокуРезультатов(КоличествоУдаляемых)
	
	УдаленныхОбъектов = КоличествоУдаляемых - КоличествоНеУдаленныхОбъектов;
	
	Если УдаленныхОбъектов = 0 Тогда
		СтрокаРезультатов = НСтр("ru = 'Не удален ни один из объектов, так как в информационной базе существуют ссылки на удаляемые объекты'");
	Иначе
		СтрокаРезультатов = 
			СтрШаблон(
				НСтр("ru = 'Удаление помеченных объектов завершено.
							|Удалено объектов: %1.'"),
							Строка(УдаленныхОбъектов));
	КонецЕсли;
	
	Если КоличествоНеУдаленныхОбъектов > 0 Тогда
		СтрокаРезультатов = СтрокаРезультатов + Символы.ПС +
			СтрШаблон(
				НСтр("ru = 'Не удалено объектов: %1.
							|Объекты не удалены для сохранения целостности информационной базы, т.к. на них еще имеются ссылки.
							|Нажмите ОК для просмотра списка оставшихся (не удаленных) объектов.'"),
				Строка(КоличествоНеУдаленныхОбъектов));
	КонецЕсли;

КонецПроцедуры
