﻿Функция ПроверитьРаботоспособностьСистемы(Контекст) Экспорт
	Если Метаданные.Роли.Найти("ПолныеПрава") = Неопределено Тогда Возврат Неопределено; КонецЕсли;
	Если НЕ (РольДоступна("ПолныеПрава") Или А1Э_Служебный.ЭтоАдминистраторА1()) Тогда Возврат Неопределено; КонецЕсли;
	А1Э_ДопРеквизиты.ПроверитьСуществованиеСлужебныхДопРеквизитов();
	ПроверитьТипыДанных();
	А1Э_Предопределенные.ПроверитьПредопределенныеДанные();
	А1Э_ОграниченияДоступа.ПроверитьМеханизмОграниченийДоступа(Контекст);
КонецФункции

#Область ПроверкаТиповДанных

// Проверяет соответствие метаданных описаниям
// 
// Возвращаемое значение:
//   - 
//
Функция ПроверитьТипыДанных()
	ТаблицаТиповДанных = ТаблицаТиповДанных();
	МассивСообщений = Новый Массив;
	Для Каждого ПроверяемыеДанные Из ТаблицаТиповДанных Цикл
		ОбъектМетаданных = Метаданные[ПроверяемыеДанные.ТипОбъекта].Найти(ПроверяемыеДанные.ИмяОбъекта);
		Если ОбъектМетаданных = Неопределено Тогда
			МассивСообщений.Добавить("Не обнаружен объект метаданных " + ПредставлениеОбъектаМетаданных(ПроверяемыеДанные));
			Продолжить;
		КонецЕсли;
		Если ПроверяемыеДанные.ИмяРеквизитаТабличнойЧасти = "" Тогда
			ИмяРеквизита = ПроверяемыеДанные.ИмяРеквизитаИлиТабличнойЧасти;
			Реквизит = ОбъектМетаданных.Реквизиты.Найти(ИмяРеквизита);
			Если Реквизит = Неопределено Тогда
				МассивСообщений.Добавить("Не обнаружен реквизит " + ПредставлениеРеквизита(ПроверяемыеДанные));
				Продолжить;
			КонецЕсли;
		Иначе
			ИмяТабличнойЧасти = ПроверяемыеДанные.ИмяРеквизитаИлиТабличнойЧасти;
			ТабличнаяЧасть = ОбъектМетаданных.ТабличныеЧасти.Найти(ИмяТабличнойЧасти);
			Если ТабличнаяЧасть = Неопределено Тогда
				МассивСообщений.Добавить("Не обнаружена табличная часть " + ИмяТабличнойЧасти + " объекта метаданных " + ПредставлениеОбъектаМетаданных(ПроверяемыеДанные));
				Продолжить;
			КонецЕсли;
			ИмяРеквизита = ПроверяемыеДанные.ИмяРеквизитаТабличнойЧасти;
			Реквизит = ТабличнаяЧасть.Реквизиты.Найти(ИмяРеквизита);
			Если Реквизит = Неопределено Тогда
				МассивСообщений.Добавить("Не обнаружен реквизит " + ПредставлениеРеквизита(ПроверяемыеДанные));
				Продолжить;
			КонецЕсли;
			Реквизит = ОбъектМетаданных.ТабличныеЧасти[ПроверяемыеДанные.ИмяРеквизитаИлиТабличнойЧасти].Реквизиты[ПроверяемыеДанные.ИмяРеквизитаТабличнойЧасти];
		КонецЕсли;
		МассивТипов = А1Э_Массивы.Массив(ПроверяемыеДанные.ПроверяемыеТипы);
		Для Каждого Тип Из МассивТипов Цикл
			Если НЕ Реквизит.Тип.СодержитТип(Тип) Тогда
				МассивСообщений.Добавить("В типах реквизита " + ПредставлениеРеквизита(ПроверяемыеДанные) + " отсутствует тип " + Тип);
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Если МассивСообщений.Количество() <> 0 Тогда
		Сообщить("При проверке метаданных обнаружены критические ошибки! Возможна необратимая потеря данных! Список ошибок:");
		Для Каждого Сообщение Из МассивСообщений Цикл
			Сообщить(Сообщение);
		КонецЦикла;
	КонецЕсли;
КонецФункции

// Получает таблицу типов данных для проверки.
// 
// Возвращаемое значение:
//   - 
//
Функция ТаблицаТиповДанных()
	ТаблицаТиповДанных = Новый ТаблицаЗначений;
	ТаблицаТиповДанных.Колонки.Добавить("ТипОбъекта", А1Э_Строки.ОписаниеТипа(50));
	ТаблицаТиповДанных.Колонки.Добавить("ИмяОбъекта", А1Э_Строки.ОписаниеТипа(100));
	ТаблицаТиповДанных.Колонки.Добавить("ИмяРеквизитаИлиТабличнойЧасти", А1Э_Строки.ОписаниеТипа(100));
	ТаблицаТиповДанных.Колонки.Добавить("ИмяРеквизитаТабличнойЧасти", А1Э_Строки.ОписаниеТипа(100));
	ТаблицаТиповДанных.Колонки.Добавить("ПроверяемыеТипы");
	
	Если Метаданные.ОбщиеМодули.Найти("А1_ПроверкиСистемы") = Неопределено Тогда
		Возврат ТаблицаТиповДанных;
	КонецЕсли;
	
	Попытка
		Выполнить("А1_ПроверкиСистемы.ДобавитьПроверяемыеТипыДанных(ТаблицаТиповДанных)");
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
	КонецПопытки;
	
	Возврат ТаблицаТиповДанных;
КонецФункции

// Добавляет проверяемый тип данных. Используется в модуле А1_ПроверкиДанных.
//
// Параметры:
//  ТаблицаТиповДанных				 - ТаблицаЗначений - см. функцию ТаблицаТиповДанных
//  ТипОбъекта						 - Строка - например: "Документ", "Справочник" 
//  ИмяОбъекта						 - Строка - например: "РеализацияТоваровУслуг" 
//  ИмяРеквизитаИлиТабличнойЧасти	 - Строка - например: "Комментарий" (реквизит) или "Товары" (табличная часть).
//  ИмяРеквизитаТабличнойЧасти		 - Строка - например: "Номенклатура"; оставить пустым если проверяется реквизит объекта.
//  ПроверяемыеТипы					 - Тип, Массив - например Тип("СправочникСсылка.Номенклатура") 
// 
// Возвращаемое значение:
//   - 
//
Функция ДобавитьПроверяемыйТипДанных(ТаблицаТиповДанных, ТипОбъекта, ИмяОбъекта, ИмяРеквизитаИлиТабличнойЧасти, ИмяРеквизитаТабличнойЧасти = "", ПроверяемыеТипы) Экспорт
	Строка = ТаблицаТиповДанных.Добавить();
	Строка.ТипОбъекта = ТипОбъекта;
	Строка.ИмяОбъекта = ИмяОбъекта;
	Строка.ИмяРеквизитаИлиТабличнойЧасти = ИмяРеквизитаИлиТабличнойЧасти;
	Строка.ИмяРеквизитаТабличнойЧасти = ИмяРеквизитаТабличнойЧасти;
	Строка.ПроверяемыеТипы = ПроверяемыеТипы;
КонецФункции

Функция ПредставлениеОбъектаМетаданных(ПроверяемыеДанные)
	Возврат "категория: " + ПроверяемыеДанные.ТипОбъекта + ", имя: " + ПроверяемыеДанные.ИмяОбъекта;	
КонецФункции

Функция ПредставлениеРеквизита(ПроверяемыеДанные)
	Если ПроверяемыеДанные.ИмяРеквизитаТабличнойЧасти = "" Тогда
		Возврат ПроверяемыеДанные.ИмяРеквизитаИлиТабличнойЧасти + " объекта метаданных " + ПредставлениеОбъектаМетаданных(ПроверяемыеДанные);
	Иначе
		Возврат ПроверяемыеДанные.ИмяРеквизитаТабличнойЧасти + " табличной части " + ПроверяемыеДанные.ИмяРеквизитаИлиТабличнойЧасти + " объекта метаданных " + ПредставлениеОбъектаМетаданных(ПроверяемыеДанные);
	КонецЕсли;
КонецФункции

#Область А1_ПроверкиСистемы

Функция ДобавитьПроверяемыеТипыДанных(ТаблицаТиповДанных) Экспорт 
	//А1Э_ПроверкиСистемы.ДобавитьПроверяемыйТипДанных(ТаблицаТиповДанны, "Документ", "РеализацияТоваровУслуг", "Комментария", , Тип("Строка"));	
КонецФункции

#КонецОбласти

#КонецОбласти 
 
