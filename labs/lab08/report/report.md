---
## Front matter
title: "Лабораторная работа 8"
subtitle: " Программирование цикла. Обработка аргументов командной строки"
author: "Головина Мария Игоревна"

## Generic otions
lang: ru-RU
toc-title: "Содержание"

## Bibliography
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

## Pdf output format
toc: true # Table of contents
toc-depth: 2
lof: true # List of figures
lot: true # List of tables
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
## I18n polyglossia
polyglossia-lang:
  name: russian
  options:
	- spelling=modern
	- babelshorthands=true
polyglossia-otherlangs:
  name: english
## I18n babel
babel-lang: russian
babel-otherlangs: english
## Fonts
mainfont: IBM Plex Serif
romanfont: IBM Plex Serif
sansfont: IBM Plex Sans
monofont: IBM Plex Mono
mathfont: STIX Two Math
mainfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
romanfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
sansfontoptions: Ligatures=Common,Ligatures=TeX,Scale=MatchLowercase,Scale=0.94
monofontoptions: Scale=MatchLowercase,Scale=0.94,FakeStretch=0.9
mathfontoptions:
## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
lofTitle: "Список иллюстраций"
lotTitle: "Список таблиц"
lolTitle: "Листинги"
## Misc options
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float} # keep figures where there are in the text
  - \floatplacement{figure}{H} # keep figures where there are in the text
---

# Цель работы

Приобретение навыков написания программ с использованием циклов и обработкой аргументов командной строки.


# Задание

1.	Создать каталог для программ лабораторной работы № 8, перейти в него и создать файл lab8-1.asm

2.	Ввести в файл lab8-1.asm текст программы из листинга 1 методического указания. Создать исполняемый файл и запустить его. Посмотреть результаты работы.

3.	Изменить текст программы, добавив изменение значения регистра ecx в цикле. Создать исполняемый файл и запустить его. Посмотреть результаты работы. Написать пояснение по результатам работы программы.

4.	Внести изменения в текст программы, добавив команды push и pop (добавления в стек и извлечения из стека) для сохранения значения счетчика цикла loop . Создать исполняемый файл и проверить его работу. Написать пояснение по результатам работы программы.

5.	Создать файл lab8-2.asm и ввести в него текст программы из листинга 2 методического указания. Создать исполняемый файл и запустить его, указав необходимые аргументы.

6.	Создать файл lab8-3.asm и ввести в него текст программы из листинга 3 методического указания. Создать исполняемый файл и запустить его, указав необходимые аргументы. Написать пояснение по результатам работы программы.

7.	Изменить текст Листинга 3 для вычисления произведения аргументов командной строки. Проверить результаты работы программы.


Задание для самостоятельной работы

1. Напишите программу, которая находит сумму значений функции f(x) для x= x1, x2,…xn, т.е. программа должна выводить значение f(x1)+f(x2)+…+f(xn). Значения xi передаются как аргументы. Вид функции f(x) выбрать из таблицы вариантов заданий в соответствии с вариантом, полученным при выполнении лабораторной работы № 6. Создайте исполняемый файл и проверьте его работу на нескольких наборах x=x1,x2, …xn.



# Теоретическое введение


Организация стека

Стек — это структура данных, организованная по принципу LIFO («Last In- First Out» или «последним пришёл — первым ушёл»). Стек является частью архитектуры процессора и реализован на аппаратном уровне. Для работы со стеком в процессоре есть специальные регистры (ss, bp, sp) и команды. Основной функцией стека является функция сохранения адресов возврата и передачи аргументов при вызове процедур. Кроме того, в нём выделяется память для локальных переменных и могут временно храниться значения регистров. 
Стек имеет вершину, адрес последнего добавленного элемента, который хранится в регистре esp (указатель стека). Противоположный конец стека называется дном. Значение, помещённое в стек последним, извлекается первым. При помещении значения в стек указатель стека уменьшается, а при извлечении — увеличивается. Для стека существует две основные операции: 

-добавление элемента в вершину стека (push);

-извлечение элемента из вершины стека (pop). 


Добавление элемента в стек

Команда push размещает значение в стеке, т.е. помещает значение в ячейку памяти, на которую указывает регистр esp, после этого значение регистра esp увеличивается на 4. Данная команда имеет один операнд — значение, которое необходимо поместить в стек.
Существует ещё две команды для добавления значений в стек. Это команда pusha, которая помещает в стек содержимое всех регистров общего назначения в следующем порядке: ах, сх, dx, bх, sp, bp, si, di. А также команда pushf, которая служит для перемещения в стек содержимого регистра флагов. Обе эти команды не имеют операндов. 

Извлечение элемента из стека

Команда pop извлекает значение из стека, т.е. извлекает значение из ячейки памяти, на которую указывает регистр esp, после этого уменьшает значение регистра esp на 4. У этой команды также один операнд, который может быть регистром или переменной в памяти. Нужно помнить, что извлечённый из стека элемент не стирается из памяти и остаётся как “мусор”, который будет перезаписан при записи нового значения в стек
Аналогично команде записи в стек существует команда popa, которая восстанавливает из стека все регистры общего назначения, и команда popf для перемещения значений из вершины стека в регистр флагов

Инструкции организации циклов 

Для организации циклов существуют специальные инструкции. Для всех инструкций максимальное количество проходов задаётся в регистре ecx. Наиболее простой является инструкция loop. Она позволяет организовать безусловный цикл.
Инструкция loop выполняется в два этапа. Сначала из регистра ecx вычитается единица и его значение сравнивается с нулём. Если регистр не равен нулю, то выполняется переход к указанной метке. Иначе переход не выполняется и управление передаётся команде, которая следует сразу после команды loop.


# Выполнение лабораторной работы

1. Создали каталог для программ лабораторной работы № 8, перешли в него и создали файл lab8-1.asm (рис. 4.1 Создание каталога и файла для выполнения лабораторной работы).

![Создание каталога и файла для выполнения лабораторной работы](/home/migolovina/work/study/2024-2025/Архитектура компьютера/study_2024-2025_arh-pc/labs/lab08/report/image/4.1.jpg){#fig:001 width=70%}


2. Ввели в файл lab8-1.asm текст программы из листинга 1 (рис. 4.2 Листинг 1) методического указания. Создали исполняемый файл и запустили его. Посмотрели результаты работы (рис. 4.3 Результаты работы программы из листинга 1 методического указания).

![Листинг 1](/home/migolovina/work/study/2024-2025/Архитектура компьютера/study_2024-2025_arh-pc/labs/lab08/report/image/4.2.jpg){#fig:002 width=70%}

![Результаты работы программы из листинга 1 методического указания](/home/migolovina/work/study/2024-2025/Архитектура компьютера/study_2024-2025_arh-pc/labs/lab08/report/image/4.3.jpg){#fig:003 width=70%}


3. Изменили текст программы добавив изменение значение регистра ecx в цикле (рис.4.4 Листинг 1 с внесенными изменениями согласно методическому указанию). Создали исполняемый файл и запустили его. Посмотрели результаты работы (рис. 4.5 Результаты работы программы из Листинга 1 с внесенными изменениями согласно методическому указанию).

![Листинг 1 с внесенными изменениями согласно методическому указанию](/home/migolovina/work/study/2024-2025/Архитектура компьютера/study_2024-2025_arh-pc/labs/lab08/report/image/4.4.jpg){#fig:004 width=70%}

![Результаты работы программы из Листинга 1 с внесенными изменениями согласно методическому указанию](/home/migolovina/work/study/2024-2025/Архитектура компьютера/study_2024-2025_arh-pc/labs/lab08/report/image/4.5.jpg){#fig:005 width=70%}

Цикл закольцевался и стал бесконечным.


4. Для использования регистра ecx в цикле и сохранения корректности работы программы можно использовать стек. Внесли изменения в текст программы добавив команды push и pop (добавления в стек и извлечения из стека) для сохранения значения счетчика цикла loop (рис. 4.6 Измененный Листинг 1 с внесенными командами push и pop). Создали исполняемый файл и проверили его работу (рис. 4.7 Результаты работы программы измененного Листинга 1 с внесенными командами push и pop).

![Измененный Листинг 1 с внесенными командами push и pop](/home/migolovina/work/study/2024-2025/Архитектура компьютера/study_2024-2025_arh-pc/labs/lab08/report/image/4.6.jpg){#fig:006 width=70%}

![Результаты работы программы измененного Листинга 1 с внесенными командами push и pop](/home/migolovina/work/study/2024-2025/Архитектура компьютера/study_2024-2025_arh-pc/labs/lab08/report/image/4.7.jpg){#fig:007 width=70%}

Цикл и счетчик отработал правильно. По итогу после изменения программы, число проходки циклов стал соответствовать числу введенному с клавиатуры.


5. Создали файл lab8-2.asm и ввели в него текст программы из листинга 2 методического указания (рис. 4.8 Листинг 2). Создали исполняемый файл и запустили его, указав необходимые аргументы. Программа выводит все 3 аргумента, которые ввели, но в разной вариации (рис. 4.9 Результат работы программы из Листинга 2).

![Листинг 2](/home/migolovina/work/study/2024-2025/Архитектура компьютера/study_2024-2025_arh-pc/labs/lab08/report/image/4.8.jpg){#fig:008 width=70%}

![Результат работы программы из Листинга 2](/home/migolovina/work/study/2024-2025/Архитектура компьютера/study_2024-2025_arh-pc/labs/lab08/report/image/4.9.jpg){#fig:009 width=70%}



6. Создали файл lab8-3.asm и ввели в него текст программы из листинга 3 методического указания (рис. 4.10 Листинг 3). Создали исполняемый файл и запустили его, указав необходимые аргументы. Программа вывела сумму чисел, которые мы ввели (рис. 4.11 Результат работы программы из Листинга 3).

![Листинг 3](/home/migolovina/work/study/2024-2025/Архитектура компьютера/study_2024-2025_arh-pc/labs/lab08/report/image/4.10.jpg){#fig:010 width=70%}

![Результат работы программы из Листинга 3](/home/migolovina/work/study/2024-2025/Архитектура компьютера/study_2024-2025_arh-pc/labs/lab08/report/image/4.11.jpg){#fig:011 width=70%}



Изменили текст Листинга 3 для вычисления произведения аргументов командной строки (рис. 4.12 Измененный Листинг 3 для вычисления произведения аргументов командной строки). Проверили результаты работы программы (рис. 4.13 Результаты работы программы для вычисления произведения аргументов командной строки).

![Измененный Листинг 3 для вычисления произведения аргументов командной строки](/home/migolovina/work/study/2024-2025/Архитектура компьютера/study_2024-2025_arh-pc/labs/lab08/report/image/4.12.jpg){#fig:012 width=70%}

![Результаты работы программы для вычисления произведения аргументов командной строки](/home/migolovina/work/study/2024-2025/Архитектура компьютера/study_2024-2025_arh-pc/labs/lab08/report/image/4.13.jpg){#fig:013 width=70%}



Задание для самостоятельной работы


1. Напишите программу, которая находит сумму значений функции f(x) для x= x1, x2,…xn, т.е. программа должна выводить значение f(x1)+f(x2)+…+f(xn). Значения xi передаются как аргументы. Вид функции f(x) выбрать из таблицы вариантов заданий в соответствии с вариантом, полученным при выполнении лабораторной работы № 6. Создайте исполняемый файл и проверьте его работу на нескольких наборах x=x1,x2, …xn.


При выполнении лабораторной работы №6 у меня получился вариант 11, соответственно для варианта №11 f(x) = 15x+2.



![Листинг самостоятельного задания №1](/home/migolovina/work/study/2024-2025/Архитектура компьютера/study_2024-2025_arh-pc/labs/lab08/report/image/4.14.jpg){#fig:014 width=70%}


![Результаты работы программы по самостоятельному заданию №1](/home/migolovina/work/study/2024-2025/Архитектура компьютера/study_2024-2025_arh-pc/labs/lab08/report/image/4.15.jpg){#fig:015 width=70%}



# Выводы

Приобрели навыки написания программ с использованием циклов и обработкой аргументов командной строки.

# Список литературы{.unnumbered}

1.	GDB: The GNU Project Debugger. — URL:https://www.gnu.org/software/gdb/. 
2.	GNU Bash Manual. — 2016. — URL: https://www.gnu.org/software/bash/manual/. 
3.	Midnight Commander Development Center. — 2021. — URL: https://midnight-commander. org/. 
4.	NASM Assembly Language Tutorials. — 2021. — URL: https://asmtutor.com/. 
5.	Newham C. Learning the bash Shell: Unix Shell Programming. — O’Reilly Media, 2005. — 354 с. — (In a Nutshell). — ISBN 0596009658. — URL: http://www.amazon.com/Learningbash-Shell-Programming-Nutshell/dp/0596009658.
6.	Robbins A. Bash Pocket Reference. — O’Reilly Media, 2016. — 156 с. — ISBN 978-1491941591.
7.	The NASM documentation. — 2021. — URL: https://www.nasm.us/docs.php.
8.	Zarrelli G. Mastering Bash. — Packt Publishing, 2017. — 502 с. — ISBN 9781784396879.
9.	Колдаев В. Д., Лупин С. А. Архитектура ЭВМ. — М. : Форум, 2018.
10.	Куляс О. Л., Никитин К. А. Курс программирования на ASSEMBLER. — М. : Солон-Пресс, 2017.
11.	Новожилов О. П. Архитектура ЭВМ и систем. — М. : Юрайт, 2016.
12.	Расширенный ассемблер: NASM. — 2021. — URL: https://www.opennet.ru/docs/RUS/nasm/. 
13.	Робачевский А., Немнюгин С., Стесик О. Операционная система UNIX. — 2-е изд. — БХВПетербург, 2010. — 656 с. — ISBN 978-5-94157-538-1. 
14.	Столяров А. Программирование на языке ассемблера NASM для ОС Unix. — 2-е изд. — М. : МАКС Пресс, 2011. — URL: http://www.stolyarov.info/books/asm_unix.
15.	 Таненбаум Э. Архитектура компьютера. — 6-е изд. — СПб. : Питер, 2013. — 874 с. — (Классика Computer Science).
16.	Таненбаум Э., Бос Х. Современные операционные системы. — 4-е изд. — СПб. : Питер, 2015. — 1120 с. — (Классика Computer Science).


::: {#refs}
:::
