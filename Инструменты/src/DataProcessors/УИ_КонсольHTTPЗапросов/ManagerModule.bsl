Функция СериализованныеДанныеСохранения(Формат, ДанныеСохранения) Экспорт
	Если Формат = "xhttp" Или Формат=".xhttp"  Тогда
		
		СериализуемаяСтрока=ЗначениеВСтрокуВнутр(ДанныеСохранения);	

	Иначе
		СериализаторJSON=Обработки.УИ_ПреобразованиеДанныхJSON.Создать();

		СтруктураИстории=СериализаторJSON.ЗначениеВСтруктуру(ДанныеСохранения);
		СериализуемаяСтрока=СериализаторJSON.ЗаписатьОписаниеОбъектаВJSON(СтруктураИстории);
			
	КонецЕсли;
	
	Возврат СериализуемаяСтрока;
	
КонецФункции