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
![v](https://camo.githubusercontent.com/935eed331b66e377298913a8eb902f341a120e27/687474703a2f2f6c617465782e636f6465636f67732e636f6d2f7376672e6c617465783f612532387825324377253239253344253230253543746578742537427369676e253744662532387825324377253239253344253543746578742537427369676e2537442532302532382535436c616e676c65253230772532437825323025354372616e676c652d775f3025323925324377253230253543696e2532302535436d6174686262253742522537442535456e)  

где ![s](http://www.machinelearning.ru/mimetex/?w_j) вес j-го признака, ![q](http://www.machinelearning.ru/mimetex/?w_0) — порог принятия решения, ![s](http://www.machinelearning.ru/mimetex/?w=(w_0,w_1,\ldots,w_n)) — вектор весов,— вектор весов, ![r](http://www.machinelearning.ru/mimetex/?\langle%20x,w%20\rangle) — скалярное произведение признакового описания объекта на вектор весов.  

Предполагается, что искусственно введён «константный» нулевой признак: ![sf](http://www.machinelearning.ru/mimetex/?f_{0}(x)=-1)  


Параметр ![](http://latex.codecogs.com/svg.latex?w_0) иногда опускают. Однако в таком
случае разделяющая поверхность (в нашем случае с 2мя признаками – прямая),
соответствующая уравнению
![](http://latex.codecogs.com/svg.latex?%5Clangle%20w%2Cx%20%5Crangle%3D0),
будет всегда проходить через начало координат. Чтобы избежать такого обобщения,
будем полагать, что среди признаков _x_ есть константа
![](http://latex.codecogs.com/svg.latex?f_j%28x%29%20%5Cequiv%20-1),
тогда роль свобоного коэффициента ![](http://latex.codecogs.com/svg.latex?w_0)
играет параметр ![](http://latex.codecogs.com/svg.latex?w_j).
Тогда разделяющая поверхность имеет вид
![](http://latex.codecogs.com/svg.latex?%5Clangle%20w%2Cx%20%5Crangle=w_j).

Величина
![](http://latex.codecogs.com/svg.latex?M_i%28w%29%3Dy_i%5Clangle%20x_i%2Cw%20%5Crangle)
называется __отступом__ объекта относительно алгоритма классификации. Если
![](http://latex.codecogs.com/svg.latex?M_i%28w%29%3C0),
алгоритм совершает на объекте
![](http://latex.codecogs.com/svg.latex?x_i)
ошибку.

![](http://latex.codecogs.com/svg.latex?%5Cmathcal%7BL%7D%28M%29)
– монотонно невозрастающая __функция потерь__, мажорирует пороговую функцию
![](http://latex.codecogs.com/svg.latex?%5BM%3C0%5D%20%5Cleq%20%5Cmathcal%7BL%7D%28M%29).
Тогда __минимизацю суммарных потерь__ можно рассматривать как функцию вида
![](http://latex.codecogs.com/svg.latex?%5Ctilde%7BQ%7D%28w%2CX%5E%5Cell%29%20%3D%20%5Csum_%7Bi%3D1%7D%5E%7B%5Cell%7D%5Cmathcal%28M_i%28w%29%29%5Crightarrow%20%5Cmin_w)  
  
  
<center><b>Метод стохастического градиента</center></b>

Для минимизации
![](http://latex.codecogs.com/svg.latex?Q%28w%29)
применяется __метод градиентного спуска__.

В начале выбирается некоторое _начальное приближение вектора весов_ _w_.
Не существует единого способа инициализации весов. Хорошей практикой считается
инициализировать веса случайными малыми значениями:
![](http://latex.codecogs.com/svg.latex?w_j%3A%3D%5Ctext%7Brandom%7D%28-%5Cfrac%7B1%7D%7B2n%7D%2C&plus;%5Cfrac%7B1%7D%7B2n%7D%29)
, где _n_ – количество признаков _x_.

Далее высчитывается _текущая оценка функционала_
![](http://latex.codecogs.com/svg.latex?Q%3A%3D%5Csum_%7Bi%3D1%7D%5E%7B%5Cell%7D%5Cmathcal%7BL%7D%28%5Clangle%20w%2Cx_i%20%5Crangle%20y_i%29)

Затем запускается итерационный процесс, на каждом шаге которого вектор _w_
изменяется в сторону наиболее быстрого убывания _Q_. Это направление противоположно
вектору градиента
![](http://latex.codecogs.com/svg.latex?Q%27%28w%29). Соответственно веса меняются по
правилу:

![](http://latex.codecogs.com/svg.latex?w%3A%3Dw-%5Ceta%20Q%27%28w%29)

или

![](http://latex.codecogs.com/svg.latex?w%3A%3Dw-%5Ceta%5Csum_%7Bi%3D1%7D%5E%7B%5Cell%7D%5Cmathcal%7BL%7D%27%28%5Clangle%20w%2Cx_i%20%5Crangle%20y_i%29x_iy_i),

где
![](http://latex.codecogs.com/svg.latex?%5Ceta%3E0)
– __темп обучения__. Чтобы не проскочить локальный минимум темп обучания принято
полагать небольшим. Однако, при слишком маленьком его значении алгоритм будет
медленно сходится.

### <a name="adaline"></a>  
<center><b>1.Адаптивный линейный элемент</center></b>  

Имеет _квадратичную функцию потерь_
![](http://latex.codecogs.com/svg.latex?%5Cmathcal%7BL%7D%28M%29%3D%28M-1%29%5E2%3D%28%5Clangle%20w%2Cx_i%20%5Crangle%20y_i-1%29%5E2)
и _дельта-правило_ правило обновления весов
![](http://latex.codecogs.com/svg.latex?w%3Dw-%5Ceta%28%5Clangle%20w%2Cx_i%20%5Crangle-y_i%29x_i).  
  

<center><b> 2.Правило Хебба</center></b>  
  
Имеет _кусочно-линейную функцию потерь_
![](http://latex.codecogs.com/svg.latex?%5Cmathcal%7BL%7D%3D%28-M%29_&plus;%3D%5Cmax%28-M%2C0%29)
и _правило Хебба_ для обновления весов
![](http://latex.codecogs.com/svg.latex?%5Ctext%7Bif%20%7D%5Clangle%20w%2Cx_i%20%5Crangle%20y_i%3C0%20%5Ctext%7B%20then%20%7D%20w%3A%3Dw&plus;%5Ceta%20x_iy_i).

<b>Реализованную программу можно увидеть по <a href="https://simfikduke.shinyapps.io/adaline/">ссылке</a>.</b>  

