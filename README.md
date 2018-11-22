В данном репозитории содержатся работы <b>Дудко Александра</b> по предмету "Системы и методы принятия решений".  

# <center><b>Метрические алгоритмы</b></center>
**Гипотеза компактности** - схожим объекам соответствуют схожие ответы.
Для формализации понятия **сходства** вводится функция расстояния в пространстве X.

**Метрические методы обучения** - методы, основанные на анализе сходства объектов.
Метрические алгоритмы относят к алгоритмам **ленивого** обучения.

Следующая таблица содержит сводку по реализованным методам:  

<center>
<table>
  <tbody>
    <tr>
      <th>Метод</th>
      <th>Параметры</th>
      <th>Точность</th>
    </tr>
    <tr>
      <td><a href="#KWNN">KWNN</a></td>
      <td>k=19, q=0.2</td>
      <td>0.0267</td>
    </tr>
    <tr>
      <td><a href="#KNN">KNN</a></td>
      <td>k=6</td>
      <td>0.0333</td>
    </tr>
    <tr>
      <td><a href="#ParzenR">Parzen, Rectangle kerel</a></td>
      <td>h=0.35</td>
      <td>0.04</td>
    </tr>
    <tr>
      <td><a href="#ParzenT">Parzen, Triangle kerel</a></td>
      <td>h=0.35</td>
      <td>0.04</td>
    </tr>
    <tr>
      <td><a href="#ParzenQ">Parzen, Quartic kerel</a></td>
      <td>h=0.35</td>
      <td>0.04</td>
    </tr>
    <tr>
      <td><a href="#ParzenE">Parzen, Epanechnikov kerel</a></td>
      <td>h=0.35</td>
      <td>0.04</td>
    </tr>
    <tr>
      <td><a href="#ParzenG">Parzen, Gauss kerel</a></td>
      <td>h=0.1</td>
      <td>0.04</td>
    </tr>
    <tr>
      <td><a href="#Potentials">Потенциальные функции</a></td>
      <td>h=(1х50, 0.5х100)</td>
      <td><b>Переменная</b></td>
    </tr>
    <tr>
      <td><a href="#stolp">STOLP</a></td>
      <td></td>
      <td><b></b></td>
    </tr>
  </tbody>
   </table>
</center>

# <center><b>Байесовские классификаторы</b></center>  
Байесовский подход является классическим в теории распознавания образов и лежит в основе многих методов. Он опирается на теорему о том, что если плотности распределения классов известны, то алгоритм классификации, имеющий минимальную вероятность ошибок, можно выписать в явном виде. Для оценивания плотностей классов по выборке применяются различные подходы. В этом курсе лекций рассматривается три: параметрический, непараметрический и оценивание смесей распределений.  
**1. Линии	уровня	нормального	распределения**  
Случайная величина x ∈ R имеет нормальное (гауссовское) распределение с параметрами µ и σ^2, если ее плотность задается выражением:  
![f](http://simfik.ru/i/f.png)  
Параметры µ и σ^2 определяют, соответственно, мат.ожидание и дисперсию нормальной случайной величины. По центральной предельной теореме среднее арифметическое независимых случайных величин с ограниченными мат.ожиданием и дисперсией стремится к нормальному распределению. Поэтому это распределение часто используется в качестве модели шума, который определяется суммой большого количества независимых друг от друга случайных факторов.  
Реализация задания по ссылке: <a href="https://simfikduke.shinyapps.io/level-lines/">click</a>  
Скриншот задания:  
![screenshot](http://simfik.ru/i/ws.png)  
**2. Наивный байесовский классификатор**  
(Naive Bayes)  
Наивный байесовский классификатор – это семейство алгоритмов классификации, которые принимают одно допущение: Каждый параметр классифицируемых данных рассматривается независимо от других параметров класса.  
Почему метод называется наивным? Предположение, что все параметры набора данных независимы – это довольно наивное предположение. Обычно так не бывает.  
**Упрощенное** уравнение для классификации выглядит так:
![f_naive](https://pp.userapi.com/c637717/v637717210/6838f/h_T-iT7wqbc.jpg)  
Реализация алгоритма по ссылке: <a href="https://simfikduke.shinyapps.io/Bayes/">click</a> 
