﻿Перем А1Э_СвязиСсылокИСистемныхКодов Экспорт;
Перем А1Э_ПараметрыМеханизмов Экспорт;

&После("ПередНачаломРаботыСистемы")
Процедура А1Э_ПередНачаломРаботыСистемы(Отказ)
	А1Э_Механизмы.УстановитьПараметрыКлиента();
	А1Э_Механизмы.ПередНачаломРаботыСистемы(Отказ);
КонецПроцедуры

&После("ПриНачалеРаботыСистемы")
Процедура А1_ПриНачалеРаботыСистемы()
	А1Э_ОбщееКлиент.ПриНачалеРаботыСистемы();
	А1Э_Механизмы.ПриНачалеРаботыСистемы();
КонецПроцедуры


