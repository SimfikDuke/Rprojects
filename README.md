В данном репозитории содержатся работы <b>Дудко Александра</b> по предмету "Системы и методы принятия решений".  

# <center><b>Метрические алгоритмы</b></center>
<details> 
<summary>Метрические алгоритмы </summary>

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
</details> 


# <center><b>Байесовские классификаторы</b></center>  

<center>
<table>
  <tbody>
    <tr>
      <th>Задание</th>
      <th>Shiny</th>
    </tr>
    <tr>
      <td><a href="#level-lines">Линии уровня</a></td>
      <td><a href="https://simfikduke.shinyapps.io/level-lines/">Реализация</a></td>
    </tr>
    <tr>
      <td><a href="#Bayes">Наивный байес</a></td>
      <td><a href="https://simfikduke.shinyapps.io/Bayes/">Реализация</a></td>
    </tr>
    <tr>
      <td><a href="#plug-in">Подстановочный алгоритм</a></td>
      <td><a href="https://simfikduke.shinyapps.io/plug-in/">Реализация</a></td>
    </tr>
      <td><a href="#ldf">Линейный дискриминант Фишера</a></td>
      <td><a href="https://simfikduke.shinyapps.io/ldf-plugin/">Реализация</a></td>
    </tr>
  </tbody>
   </table>
</center>

# <center><b>Линейные алгоритмы</b></center>  

<center>
<table>
  <tbody>
    <tr>
      <th>Задание</th>
      <th>Shiny</th>
    </tr>
    <tr>
      <td><a href="#adaline">Adaline</a></td>
      <td><a href="https://simfikduke.shinyapps.io/adaline/">Реализация</a></td>
    </tr>
  </tbody>
   </table>
</center>

<center><h1>Байесовские классификаторы</h1></center>

Байесовский подход является классическим в теории распознавания образов и лежит в основе многих методов. Он опирается на теорему о том, что если плотности распределения классов известны, то алгоритм классификации, имеющий минимальную вероятность ошибок, можно выписать в явном виде. Для оценивания плотностей классов по выборке применяются различные подходы. В этом курсе лекций рассматривается три: параметрический, непараметрический и оценивание смесей распределений.  
### <a name="level-lines"></a>**1. Линии	уровня	нормального	распределения**  
Случайная величина x ∈ R имеет нормальное (гауссовское) распределение с параметрами µ и σ^2, если ее плотность задается выражением:  
![f](http://simfik.ru/i/f.png)  
Параметры µ и σ^2 определяют, соответственно, мат.ожидание и дисперсию нормальной случайной величины. По центральной предельной теореме среднее арифметическое независимых случайных величин с ограниченными мат.ожиданием и дисперсией стремится к нормальному распределению. Поэтому это распределение часто используется в качестве модели шума, который определяется суммой большого количества независимых друг от друга случайных факторов.  
Реализация задания по ссылке: <a href="https://simfikduke.shinyapps.io/level-lines/">click</a>  
Скриншот задания:  
![screenshot](http://simfik.ru/i/ws.png)  
### <a name="Bayes"></a>**2. Наивный байесовский классификатор**  
(Naive Bayes)  
Наивный байесовский классификатор – это семейство алгоритмов классификации, которые принимают одно допущение: Каждый параметр классифицируемых данных рассматривается независимо от других параметров класса.  
Почему метод называется наивным? Предположение, что все параметры набора данных независимы – это довольно наивное предположение. Обычно так не бывает.  
**Упрощенное** уравнение для классификации выглядит так:
![f_naive](https://pp.userapi.com/c637717/v637717210/6838f/h_T-iT7wqbc.jpg)  
Реализация алгоритма по ссылке: <a href="https://simfikduke.shinyapps.io/Bayes/">click</a> 

### <a name="plug-in"></a>**3. Подстановочный алгоритм (plug-in)**  

В качестве модели восстанавливаемой плотности рассматривается **многомерная нормальная**:

![](https://latex.codecogs.com/gif.latex?N%28x%2C%20%5Cmu%2C%20%5CSigma%29%20%3D%20%5Cfrac%7B1%7D%7B%5Csqrt%7B%282%5Cpi%29%5En%7C%5CSigma%7C%7D%7Dexp%28%5Cfrac%7B-1%7D%7B2%7D%28x%20-%20%5Cmu%29%5ET%20%5CSigma%5E%7B-1%7D%28x%20-%20%5Cmu%29%29%2C%20x%20%5Cepsilon%20%5Cmathbb%7BR%7D%5E%7Bn%7D) ,

где ![](https://latex.codecogs.com/gif.latex?%5Cmu%20%5Cepsilon%20%5Cmathbb%7BR%7D%5E%7Bn%7D) -- математическое ожидание (центр), а ![](https://latex.codecogs.com/gif.latex?%5CSigma%20%5Cepsilon%20%5Cmathbb%7BR%7D%5E%7Bn%5Ctimes%20n%7D) -- ковариационная матрица (симметричная, невырожденная, положительно определённая).

Алгоритм заключается в восстановлении параметров нормального распределения ![](https://latex.codecogs.com/gif.latex?%5Cmu_y), ![](https://latex.codecogs.com/gif.latex?%5CSigma_y) для каждого класса ![](https://latex.codecogs.com/gif.latex?y%20%5Cepsilon%20Y) и подстановке их в формулу оптимального байесовского классификатора. Предполагается, что ковариационные матрицы классов не равны.

Оценка параметров нормального распределения производится на основе *принципа максимума правдоподобия*:

![](https://latex.codecogs.com/gif.latex?%5Cmu_y%20%3D%20%5Cfrac%7B1%7D%7Bl_y%7D%5Csum_%7Bx_i%3Ay_i%20%3D%20y%7D%20x_i) ,

![](https://latex.codecogs.com/gif.latex?%5CSigma_y%20%3D%20%5Cfrac%7B1%7D%7Bl_y%20-%201%7D%5Csum_%7Bx_i%3Ay_i%20%3D%20y%7D%28x_i%20-%20%5Cmu_y%29%28x_i%20-%20%5Cmu_y%29%5ET).

Разделяющая поверхность между двумя классами *s* и *t* задаётся следующим образом:

![](https://latex.codecogs.com/gif.latex?%5Clambda_sP_s%5Crho_s%28x%29%20%3D%20%5Clambda_tP_t%5Crho_t%28x%29)

Прологарифмируем и выразим константу:

![](https://latex.codecogs.com/gif.latex?%5Cln%7Bp_s%28x%29%7D%20-%20%5Cln%7Bp_t%28x%29%7D%20%3D%20C%2C%20C%20%3D%20%5Cln%28%5Cfrac%7B%5Clambda_tP_t%7D%7B%5Clambda_sP_s%7D%29)

Как известно:

![](https://latex.codecogs.com/gif.latex?%5Crho_y%28x%29%20%3D%20N%28x%2C%20%5Cmu_y%2C%20%5CSigma_y%29%2C%20y%20%5Cepsilon%20Y)

Логарифмируя плотности каждого класса и подставив в выражение с разностью логарифмов, получим коэффициенты разделяющей кривой:

![](https://latex.codecogs.com/gif.latex?%5Cln%7Bp_y%28x%29%7D%20%3D%20-%5Cfrac%7Bn%7D%7B2%7D%20%5Cln%7B2%5Cpi%7D%20-%20%5Cfrac%7B1%7D%7B2%7D%5Cln%7B%5Cleft%20%7C%20%5CSigma_y%20%5Cright%20%7C%7D%20-%20%5Cfrac%7B1%7D%7B2%7D%28x%20-%20%5Cmu_y%29%5ET%20%5CSigma%5E%7B-1%7D_y%20%28x%20-%20%5Cmu_y%29)
  
<b>Реализованную программу можно увидеть по <a href="https://simfikduke.shinyapps.io/plug-in/">ссылке</a>.</b>  

<b>Скриншоты программы:</b>  
Разделяющая поверхность может принимать различные формы в зависимости от параметров классов. Рассматривается двухмерный случай:  
  
1. Линейная:  

![p1](https://raw.githubusercontent.com/SimfikDuke/Rprojects/master/BayesAlgorithms/plug-in/img/p1.png)  
  
2. Элипсоид:  
  
![p2](https://raw.githubusercontent.com/SimfikDuke/Rprojects/master/BayesAlgorithms/plug-in/img/p2.png) 
   
3. Гиперболоид:  
  
![p3](https://raw.githubusercontent.com/SimfikDuke/Rprojects/master/BayesAlgorithms/plug-in/img/p3.png)  

### <a name="ldf"></a>**4. Линейный дискриминант Фишера **  
  
Линейный дискриминант Фишера является модификацией подстановочного алгоритма. Главная идея линейного дискриминанта Фишера - равенство ковариационных матриц.  
Соответственно, считается "общая" ковариационная матрица иначе:  
![p1](https://raw.githubusercontent.com/SimfikDuke/Rprojects/master/BayesAlgorithms/ldf/img/ldf.png)  
Таким образом квадратичный дискриминант обращается в линейный, другими словами, разделяющая поверхность обращается в линейную.  
В остальном алгоритм ничем не отличается от подстановочного. В функцию подсчета коэфициентов разделяющей поверхности теперь передаются две одинаковых ковариационных матрицы.  
К **преимуществам** метода можно отнести:  
- Алгоритм проще в реализации, относительно подстановочного алгоритма;  
- Алгоритм менее склонен к переобучению.  
<b>Реализованную программу можно увидеть по <a href="https://simfikduke.shinyapps.io/ldf-plugin/">ссылке</a>.</b>  

<b>Скриншоты программы:</b>  
На следующих картинках наглядно представленны различия алгоритмов ЛДФ (зеленым цветом) и Подстановочного (бордовым):  
  
1. Ковариационные матрицы равны, разделяющие поверхности похожи:  

![p1](https://raw.githubusercontent.com/SimfikDuke/Rprojects/master/BayesAlgorithms/ldf/img/ldf1.png)  

2. Ковариационные матрицы равны, разделяющие поверхности отличаются:  
  
![p2](https://raw.githubusercontent.com/SimfikDuke/Rprojects/master/BayesAlgorithms/ldf/img/ldf2.png)  
   
3. Ковариационные матрицы различные, разделяющие поверхности имеют существенные различия:  
  
![p3](https://raw.githubusercontent.com/SimfikDuke/Rprojects/master/BayesAlgorithms/ldf/img/ldf3.png)  

<center><h1>Линейные алгоритмы</h1></center>  
**Случай двух классов**  

Положим ![p](http://www.machinelearning.ru/mimetex/?Y=\{-1,+1\})  

Линейным классификатором называется алгоритм классификации
![q](http://www.machinelearning.ru/mimetex/?a:\;%20X\to%20Y) вида:  
![v](http://www.machinelearning.ru/mimetex/?a(x,w)%20=%20\mathrm{arg}\max_{y\in%20Y}\,%20\sum_{j=0}^n%20w_{yj}%20f_j(x)%20=%20\mathrm{arg}\max_{y\in%20Y}\,%20\langle%20x,w_y%20\rangle,)  

где ![s](http://www.machinelearning.ru/mimetex/?w_j) вес j-го признака, ![q](http://www.machinelearning.ru/mimetex/?w_0) — порог принятия решения, ![s](http://www.machinelearning.ru/mimetex/?w=(w_0,w_1,\ldots,w_n)) — вектор весов,— вектор весов, ![r](http://www.machinelearning.ru/mimetex/?\langle%20x,w%20\rangle) — скалярное произведение признакового описания объекта на вектор весов.  

Предполагается, что искусственно введён «константный» нулевой признак: ![sf](http://www.machinelearning.ru/mimetex/?f_{0}(x)=-1)  
**Понятие отступа**  

Удобно определить для произвольного обучающего объекта ![cx](http://www.machinelearning.ru/mimetex/?x_i\in%20X^m) величину отступа (margin): ![m](http://www.machinelearning.ru/mimetex/?M(x_i)%20=%20y_i%20\langle%20x_i,w%20\rangle.)
