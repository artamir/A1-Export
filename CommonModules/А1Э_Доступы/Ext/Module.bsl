﻿// Аналог стандартной функции ПравоДоступа, но её результат может быть переопределен механизмами.
//
// Параметры:
//  Право			 - Строка - см. стандартную функции ПравоДоступа()
//  ОбъектМетаданных - Строка,ОбъектМетаданных - 
//  ПользовательИБ	 - ПользовательИнформационнойБазы,Неопределено - если не указано, выполняется для текущего пользователя. 
// 
// Возвращаемое значение:
//   - 
//
Функция ЕстьПраво(Право, Знач ОбъектМетаданных, Знач ПользовательИБ = Неопределено) Экспорт
	ОбъектМетаданных = А1Э_Метаданные.ОбъектМетаданных(ОбъектМетаданных);
	ТекущийПользователь = ПользователиИнформационнойБазы.ТекущийПользователь();
	Если ПользовательИБ = Неопределено Тогда ПользовательИБ = ТекущийПользователь; КонецЕсли;
	Если ПользовательИБ.Имя <> ТекущийПользователь.Имя Тогда
		Если НЕ ПравоДоступа("Администрирование", Метаданные) Тогда
			А1Э_Служебный.СлужебноеИсключение("Для проверки прав другого пользователя необходимы административные права!");
		КонецЕсли;
	КонецЕсли;
	ДоступРазрешен = Неопределено;
	
	А1Э_Механизмы.ВыполнитьМеханизмыОбработчика("А1Э_ПриОпределенииПравДоступа", ДоступРазрешен, Право, ОбъектМетаданных, ПользовательИБ);
	Если ДоступРазрешен = Неопределено Тогда //СтандартнаяОбработка
		Если ПользовательИБ.Имя = ПользователиИнформационнойБазы.ТекущийПользователь().Имя Тогда
			ДоступРазрешен = ПравоДоступа(Право, ОбъектМетаданных);
		Иначе
			ДоступРазрешен = ПравоДоступа(Право, ОбъектМетаданных, ПользовательИБ);
		КонецЕсли;
	КонецЕсли;
	Возврат ДоступРазрешен;
КонецФункции

Функция ЕстьРоль(Знач Роль, Знач ПользовательИБ = Неопределено) Экспорт
	Роль = А1Э_Метаданные.Роль(Роль);
	ТекущийПользователь = ПользователиИнформационнойБазы.ТекущийПользователь();
	Если ПользовательИБ = Неопределено Тогда ПользовательИБ = ТекущийПользователь; КонецЕсли;
	Если ПользовательИБ.Имя = ТекущийПользователь.Имя Тогда
		Возврат РольДоступна(Роль);
	Иначе
		Если НЕ ПравоДоступа("Администрирование", Метаданные) Тогда
			А1Э_Служебный.СлужебноеИсключение("Для проверки прав другого пользователя необходимы административные права!");
		КонецЕсли;
		Возврат ПользовательИБ.Роли.Содержит(Роль);
	КонецЕсли;
КонецФункции 