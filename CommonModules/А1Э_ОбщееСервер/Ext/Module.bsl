﻿Функция ПроверитьРаботоспособностьСистемы() Экспорт
	А1Э_ДопРеквизиты.ПроверитьСуществованиеСлужебныхДопРеквизитов();	
КонецФункции

Функция ИмяСистемногоПользователя() Экспорт
	Возврат ПользователиИнформационнойБазы.ТекущийПользователь().Имя;	
КонецФункции

//Экспорт - Используется для принудительного серверного вызова
Функция РезультатФункции(ПолноеИмяФункции, П1 = Null, П2 = Null, П3 = Null, П4 = Null, П5 = Null, П6 = Null, П7 = Null, П8 = Null, П9 = Null, П10 = Null) Экспорт 
	Возврат А1Э_Общее.РезультатФункции(ПолноеИмяФункции, П1, П2, П3, П4, П5, П6, П7, П8, П9, П10);
КонецФункции

//Экспорт - Используется для принудительного серверного вызова
Процедура РезультатПроцедуры(ПолноеИмяФункции, П1 = Null, П2 = Null, П3 = Null, П4 = Null, П5 = Null, П6 = Null, П7 = Null, П8 = Null, П9 = Null, П10 = Null) Экспорт
	А1Э_Общее.РезультатПроцедуры(ПолноеИмяФункции, П1, П2, П3, П4, П5, П6, П7, П8, П9, П10);
КонецПроцедуры

#Область Устарело

//Устарело - использовать РезультатПроцедуры() 
// Осуществляет вызов процедуры или функции на сервере. Используется для того чтобы гарантировать выполнение на сервере в клиент-серверных модулях
// Не возвращает значений.
// Параметры:
//  ПолноеИмяФункции - Строка - в формате "ИмяОбщегоМодуля.ИмяФункции" или "Справочники.ИмяСправочника.ИмяФункции".
//  Параметры		 - Массив - массив параметров, в порядке соответствующем порядку параметров вызываемой функции
// 
// Возвращаемое значение:
//   - 
//
Функция ВыполнитьПроцедуру(ПолноеИмяФункции, Параметры) Экспорт
	Возврат А1Э_Общее.ВыполнитьПроцедуру(ПолноеИмяФункции, Параметры);
КонецФункции

//Устарело - использовать РезультатФункции()
// Осуществляет вызов функции на сервере. Используется для того чтобы гарантировать выполнение на сервере в клиент-серверных модулях
// Возвращает значение в соответствии со значением возвращаемым процедурой
// Параметры:
//  ПолноеИмяФункции - Строка - в формате "ИмяОбщегоМодуля.ИмяФункции" или "Справочники.ИмяСправочника.ИмяФункции".
//  Параметры		 - Массив - массив параметров, в порядке соответствующем порядку параметров вызываемой функции
// 
// Возвращаемое значение:
//   - 
//
Функция ВычислитьФункцию(ПолноеИмяФункции, Параметры) Экспорт
	Возврат А1Э_Общее.ВычислитьФункцию(ПолноеИмяФункции, Параметры);
КонецФункции 

#КонецОбласти 

Функция СсылкаПоУИД(ИмяОбъекта, ТипОбъекта = Неопределено, Знач УИД) Экспорт
	УникальныйИдентификатор = А1Э_СтандартныеТипы.УИДПолучить(УИД);
	Возврат А1Э_Метаданные.МенеджерОбъекта(ИмяОбъекта, ТипОбъекта).ПолучитьСсылку(УникальныйИдентификатор);
КонецФункции

Функция ПометитьНаУдаление(Ссылка) Экспорт
	Если НЕ ЗначениеЗаполнено(Ссылка) Тогда Возврат Неопределено; КонецЕсли;
	
	Объект = Ссылка.ПолучитьОбъект();
	Объект.ПометкаУдаления = Истина;
	Объект.Записать();
КонецФункции

Функция Реквизит(Ссылка, ИмяРеквизита) Экспорт
	Возврат Ссылка[ИмяРеквизита];	
КонецФункции

Функция ЭтоФоновоеЗадание(ПовтИсп = Истина) Экспорт 
	Если ПовтИсп = Истина Тогда Возврат А1Э_ПовторноеИспользование.РезультатФункции(ИмяМодуля() + ".ЭтоФоновоеЗадание", Ложь); КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	НомерСеанса = НомерСеансаИнформационнойБазы();
	Сеансы = ПолучитьСеансыИнформационнойБазы();
	Результат = Ложь;
	Для Каждого Сеанс Из Сеансы Цикл
        Если Сеанс.НомерСеанса = НомерСеанса Тогда
            Результат = НРег(Сеанс.ИмяПриложения) = НРег("BackgroundJob");
            Прервать;
        КонецЕсли; 
	КонецЦикла;
	УстановитьПривилегированныйРежим(Ложь);
	
    Возврат Результат;
КонецФункции

Функция ИмяМодуля() Экспорт
	Возврат "А1Э_ОбщееСервер";	
КонецФункции 