В данном репозитории содержатся работы <b>Дудко Александра</b> по предмету "Системы и методы принятия решений".  

# <center><b>Метрические алгоритмы</b></center>
  
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
    <tr>
      <td><a href="#logistic">Логистическая регрессия</a></td>
      <td><a href="https://simfikduke.shinyapps.io/logistic/">Реализация</a></td>
    </tr>
  </tbody>
   </table>
</center>
  
<center><h1>Метрические алгоритмы</h1></center>
  

**Гипотеза компактности** - схожим объекам соответствуют схожие ответы.
Для формализации понятия **сходства** вводится функция расстояния в пространстве X.

**Метрические методы обучения** - методы, основанные на анализе сходства объектов.
Метрические алгоритмы относят к алгоритмам **ленивого** обучения.

**1. Алгоритм классификации "1NN":**
   
Классифицируемый объект относим к тому классу, к которому принадлежит ближайший по заданной метрике "сосед" из выборки:

![w](https://latex.codecogs.com/gif.latex?w%28i%2C%20u%29%20%3D%20%5Bi%20%3D%201%5D%3B)

В реализованном методе выбрана евклидова метрика.  
В качестве выборки был взят набор "Ирисы Фишера"  
Карта классификации выглядит следующим образом:  

![1NN](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/1NN.png)

Недостатки:

- Неустойчивость к погрешностям. Если среди обучающих объектов есть выброс — объект, находящийся в окружении объектов чужого класса, то не только он сам будет классифицирован неверно, но и т.е. окружающие его объекты, для которых он окажется ближайшим.
- Отсутствие параметров, которые можно было бы настраивать по выборке. Алгоритм полностью зависит от того, насколько удачно выбрана метрика ρ.
- В результате — низкое качество классификации.

### <a name="KNN"></a>**2. Алгоритм классификации "kNN" k-ближайших соседей:**

Все объекты выборки сортируются по удаленности от классифицируемого объекта. Выбираются k ближайших соседей.
Классифицируемый объект относим к тому классу, экземпляров которого больше в наборе из полученных k соседей:
![w](https://latex.codecogs.com/gif.latex?w%28i%2C%20u%29%20%3D%20%5Bi%20%5Cleq%20k%5D%3B)

В реализованном методе выбрана евклидова метрика.  
В качестве выборки был взят набор "Ирисы Фишера".  
Оптимальное значение параметра k определяют по критерию скользящего контроля с исключением объектов по одному (leave-one-out, LOO). Для каждого объекта ![xi ∈ Xℓ](https://latex.codecogs.com/gif.latex?%24x_i%20%5Cin%20X%5El%24) проверяется, правильно ли он классифицируется по своим k ближайшим соседям.  
![LOO(k, X^l )= \sum_{i=1}^{l} \left [ a(x_i; X^l\setminus \lbrace x_i \rbrace , k) \neq y_i \right ] \rightarrow \min_k .](https://latex.codecogs.com/gif.latex?LOO%28k%2C%20X%5El%20%29%3D%20%5Csum_%7Bi%3D1%7D%5E%7Bl%7D%20%5Cleft%20%5B%20a%28x_i%20%3B%20X%5El%5Csetminus%20%5Clbrace%20x_i%20%5Crbrace%20%2C%20k%29%20%5Cneq%20y_i%20%5Cright%20%5D%20%5Crightarrow%20%5Cmin_k%20.)  
Оценка скользящего контроля LOO алгоритма k-ближайших соседей для данного набора показала, что классификация более точна при k=6.  
График оценки скользящего контроля, а также карта классификации выглядят следующим образом:
![KNN](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/LOO_KNN.png)

### <a name="KWNN"></a>**3. Алгоритм классификации "kwNN" k-взвешенных соседей:**  
Недостаток kNN в том, что максимум может достигаться сразу на нескольких классах. В задачах с двумя классами этого можно избежать, если взять нечётное k. Более общая тактика, которая годится и для случая многих классов — ввести строго убывающую последовательность вещественных весов ![w_i](https://latex.codecogs.com/gif.latex?w_i)
, задающих вклад i-го соседа в классификацию.  
Все объекты выборки сортируются по удаленности от классифицируемого объекта. Выбираются k ближайших соседей.
Классифицируемый объект относим к тому классу, суммарный вес которого больше.
![kw](https://latex.codecogs.com/gif.latex?w%28i%2Cx%29%20%3D%20%5Bi%20%5Cleq%20k%5Dw_i)
В реализованном методе выбрана евклидова метрика.  
В качестве выборки был взят набор "Ирисы Фишера".  
В качестве последовательности весов взята нелинейно убывающую последовательность - геометрическая прогрессия: ![w_i = q^i](https://latex.codecogs.com/gif.latex?w_i%20%3D%20q%5Ei), где знаменатель прогрессии ![q ∈ (0, 1)](https://latex.codecogs.com/gif.latex?q%20%5Cin%20%280%2C%201%29%24) является параметром алгоритма. Его можно подбирать по критерию LOO, аналогично числу соседей k.  

Для составления карты классификации параметр k равен 6, а параметр веса q равен 0.5:
![KWNN](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/LOO_KWNN.png)

На следующем графике наглядно продемонстрированно превосходство алгоритма классификации kwNN над алгоритмом kNN:
![KNN_KWNN](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/KNN_KWNN.png)

На следующем графике показанно, что для выборки ирисов фишера, алгоритм k-ближайших соседей имеет минимальную оценку LOO=0.0333, а алгоритм k-взвешенных соседей, при k=19 и q=0.2 имеет минимальную оценку LOO=0.0267. Следовательно, качество классификации алгоритма kwNN лучше, чем kNN.
![LOO_LOO](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/LOO_LOO.png)

**4. Алгоритм классификации "Парзеновское окно":**  
В данном алгоритме выбирается следующий способ задать веса соседям : определить ![w_i](https://latex.codecogs.com/gif.latex?w_i) как функцию от расстояния ![rho](https://latex.codecogs.com/gif.latex?%24%5Crho%28u%2Cx_u%5E%7B%28i%29%7D%29%24), а не от ранга соседа i. Введём функцию ядра K(z), весовую функцию следующим образом:  
![w_for_parzen](https://latex.codecogs.com/gif.latex?%24%24w%28u%2Ci%29%20%3D%20K%5Cleft%20%28%5Cfrac%7B1%7D%7Bh%7D%5Crho%28u%2Cx_u%5E%7B%28i%29%7D%29%20%5Cright%20%29%24%24),
где параметр h - ширина окна.  
Данный параметр будем подбирать по оценке скользящего контроля LOO и для различных ядер оптимальное значение ширины окна будет отличаться:

### <a name="ParzenR"></a>**Прямоугольное ядро**  
Имеет следующий вид:  
![R](https://latex.codecogs.com/gif.latex?R%28Z%29%20%3D%20%5Cfrac%7B1%7D%7B2%7D%5Cleft%20%5B%20%5Cleft%20%7C%20z%20%5Cleq%201%20%5Cright%20%7C%20%5Cright%20%5D)  
Оптимальный параметр ширины окна h=0.35, оценка LOO=0.04. Карта классификации выглядит следующим образом:
![LOO_parzen_R](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/parzen_R.png)
### <a name="ParzenT"></a>**Треугольное ядро**  
Имеет следующий вид:  
![T](https://latex.codecogs.com/gif.latex?T%28Z%29%20%3D%20%281%20-%20%7Cz%7C%29%5Ccdot%20%5Cleft%20%5B%20%5Cleft%20%7C%20z%20%5Cleq%201%20%5Cright%20%7C%20%5Cright%20%5D)  
Оптимальный параметр ширины окна h=0.35, оценка LOO=0.04. Карта классификации выглядит следующим образом:
![LOO_parzen_T](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/parzen_T.png)
### <a name="ParzenQ"></a>**Квартическое ядро**  
Имеет следующий вид:  
![Q](https://latex.codecogs.com/gif.latex?Q%28Z%29%20%3D%20%5Cfrac%7B15%7D%7B16%7D%281%20-%20z%5E2%29%5E2%5Ccdot%20%5Cleft%20%5B%20%5Cleft%20%7C%20z%20%5Cleq%201%20%5Cright%20%7C%20%5Cright%20%5D)  
Оптимальный параметр ширины окна h=0.35, оценка LOO=0.04. Карта классификации выглядит следующим образом:
![LOO_parzen_Q](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/parzen_Q.png)
### <a name="ParzenE"></a>**Ядро Епанечникова**  
Имеет следующий вид:  
![E](https://latex.codecogs.com/gif.latex?E%28Z%29%20%3D%20%5Cfrac%7B3%7D%7B4%7D%281%20-%20z%5E2%29%5Ccdot%20%5Cleft%20%5B%20%5Cleft%20%7C%20z%20%5Cleq%201%20%5Cright%20%7C%20%5Cright%20%5D)  
Оптимальный параметр ширины окна h=0.35, оценка LOO=0.04. Карта классификации выглядит следующим образом:
![LOO_parzen_E](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/parzen_E.png)
### <a name="ParzenG"></a>**Гауссовское ядро**  
Имеет следующий вид:  
![G](https://latex.codecogs.com/gif.latex?%24%24G%28Z%29%20%3D%20dnorm%28z%29%24%24)  
Оптимальный параметр ширины окна h=0.1, оценка LOO=0.04. Карта классификации выглядит следующим образом:
![LOO_parsen_G](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/parzen_G.png)

Применение гауссовского ядра в алгоритме парзеновского окна решает проблему, когда классифицируемая точка не попадает в окно из за малой ширины. Следовательно, можно классифицировать любые точки, не зависимо от их удаленности от выборки, чего нельзя сделать, использую другие функции ядер.  

<center><b>Сравнение алгоритмов</b></center>  

Метрические алгоритмы ближайших соседей и парзеновского окна могут одинаково хорошо справляться с задачей классификации.  
На следующей картинке, для наибольшей наглядности, представленны карты классификации для алгоритма взвешенных ближайщих соседей и парзеновского окна:  
![KWNN_parzen](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/KWNN_parzen.png)

В итоге можно сделать выводы о плюсах и минусах алгоритма **парзеновского окна**:  

**Плюсы**  
+ При правильно выбраном h алгоритм способен классифицировать объект с хорошим качеством;  
+ Алгоритм прост в реализации;  
+ Учитывются все точки с одинаковым расстоянием;  
+ Классификация происходит за O(N).  

**Минусы**  
- Параметр ширины окна требуется подбирать под конкретную обучающую выборку;  
- Крайне малый набор параметров;  
- Требуется хранить выборку целиком;  
- Для всех ядер, кроме гауссовского, есть вероятность того, что точка не будет классифицированна из-за того, что она не попадает в окно. 

### <a name="Potentials"></a>**5. Метод потенциальных функций:**
   
Для оценки близости объекта u к классу y алгоритм использует следующую функцию:
![potentials_w](https://camo.githubusercontent.com/bad4b9cb4003539f1bd1816947cc5015976bdf81/687474703a2f2f6c617465782e636f6465636f67732e636f6d2f7376672e6c617465783f575f79253238692532432532307525323925323025334425323025354367616d6d615f6925323025354363646f742532304b2532382535436672616325374225354372686f25323875253243253230785f7525354569253239253744253742685f6925374425323925324325323025354367616d6d615f6925323025354367657125323030253243253230685f6925323025334525323030), где K(z) — функция ядра.

В реализуемом методе используется фиксированная ширина окна. Для первых 50 объектов (class=setosa) h=1, так как объекты данного класса достаточно удалены от объектов других. Для остальных объектов h=100.  

Изачально потенциалы заполняются нулями. Далее, пока количество ошибок классификации не достигнет нужного предела, выбираем случайно точку x из выборки. Если для нее классификация выполняется неверно, увеличиваем потенциал на 1 и пересчитываем общее количество ошибок.  

<!-- Ниже представлено графическое представления распределения потенциалов, а также карта классификации для ядра Епанечникова.  
Объекты, потенциалы которых являются ненулевыми выделены звездочкой, объекты, на которых алгоритм ошибыется - квадратом. 
![potentialsE](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/potentialsE.png)   -->

Ниже представлено графическое представления распределения потенциалов, а также карта классификации для Гауссовского ядра.  
Объекты, потенциалы которых являются ненулевыми выделены звездочкой, объекты, на которых алгоритм ошибыется - квадратом. Радиус круга - сила потенциала. 
![potentialsE](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/potentials.png)

**Плюсом** данного метода безусловно является богатый набор из 2l параметров, с помощью которых можно настроить алгоритм для классификации с высокой точностью.  
К **минусам** можно отнести сложность реализации, а также достаточно долгий процесс подбора параметров.  
  
Как **итог** мы можем классифицировать объекты с максимальной возможной точностью, которую мы моем задать вручную при подборе параметров.

### <a name="stolp"></a>**6. STOLP:**

Выделяют несколько видов объектов обучения:

- **Эталонные** — типичные представители классов. Если классифицируемый объект близок к эталону, то, скорее всего, он принадлежит тому же классу.  
- **Неинформативные** — плотно окружены другими объектами того же класса. Если их удалить из выборки, это практически не отразится на качестве классификации.  
- **Выбросы** — находятся в окружении объектов чужого класса. Как правило, их удаление только улучшает качество классификации.  
Алгорим STOLP исключает из выборки выбросы и неинформативные объекты, оставляя лишь нужное количество эталонных. Таким образом улучшается качество классификации, сокращается объем данных и уменьшается время классификации объектов. Другими словами STOLP — алгоритм **сжатия** данных.

Используется функция отступа:
![margin](https://camo.githubusercontent.com/c8bddb8a997db6324c19e1f4b28b4bffd86f666f/687474703a2f2f6c617465782e636f6465636f67732e636f6d2f7376672e6c617465783f4d253238785f69253239253230253344253230575f253742795f69253744253238785f692532392532302d253230253543756e64657273657425374279253230253543696e253230592532302535437365746d696e7573253230795f692537442537426d6178253744575f79253238785f69253239253239253239)

 где ![W](https://camo.githubusercontent.com/6b7709629eecb9d52e0928c4b41ec76271043f89/687474703a2f2f6c617465782e636f6465636f67732e636f6d2f7376672e6c617465783f575f79253238785f69253239) - весовая функция и зависит от выбранного алгоритма классификации.

На картинке ниже представлен график отступов относительно метрического классификатора kwNN:
![margins](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/margins.png)

В программной реализации использован метрический классификатор kwNN.  
Сам алгоритм STOLP формулируется следующим образом:  
- Отбросить выбросы (объекты ![x](http://www.machinelearning.ru/mimetex/?X^l) с W>δ)  
- Сформировать начальное приближение ![o](http://www.machinelearning.ru/mimetex/?\Omega) — из объектов выборки ![x](http://www.machinelearning.ru/mimetex/?X^l) выбрать по одному объекту каждого класса, обладающему среди объектов данного класса максимальной величиной риска либо минимальной величиной риска  
- Наращивание множества эталонов (пока число объектов выборки ![x](http://www.machinelearning.ru/mimetex/?X^l), распознаваемых неправильно, не станет меньше ![l_0](http://www.machinelearning.ru/mimetex/?l_0)):  
   * Классифицировать объекты ![x](http://www.machinelearning.ru/mimetex/?X^l), используя в качестве обучающей выборки ![o](http://www.machinelearning.ru/mimetex/?\Omega)  
   * Пересчитать величины риска для всех объектов ![xx](http://www.machinelearning.ru/mimetex/?X^l%20\setminus%20\Omega) с учетом изменения обучающей выборки  
   * Среди объектов каждого класса, распознанных неправильно, выбрать объекты с максимальной величиной риска и добавить их к ![o](http://www.machinelearning.ru/mimetex/?\Omega)

Первый проход:  
![s1](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/stolp_s1.png)

Второй проход:  
![s2](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/stolp_s2.png)

<!-- Одинадцатый проход:  
![s11](https://github.com/SimfikDuke/Rprojects/blob/master/img/stolp_s11.png) -->

В следующей таблице видна скорость работы (на примере составления карты классификации) до и после отбора объектов с помощью алгоритма STOLP:  
<table>
  <tr>
  <td></td>
  <td><b>Время</b></td>
  <td><b>Качество</b></td>
  </tr>
  <tr>
  <td>All irises</td>
  <td>8.74 mins</td>
  <td>0.96</td>
  </tr>
  <tr>
  <td>STOLP irises</td>
  <td>20.75 secs</td>
  <td>0.953</td>
  </tr>
</table>
Как мы видим, скорость работы алгоритма улучшилась в 25 раз, при этом, качество классификации осталось практически на прежнем уровне.

Сами карты классификации:  

![c_map](https://github.com/SimfikDuke/Rprojects/blob/master/MetricalAlgorithms/img/stolp_classification.png)

  
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

### <a name="ldf"></a>**4. Линейный дискриминант Фишера**  
  
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

### <a name="adaline"></a>**1.Адаптивный линейный элемент**  

Имеет _квадратичную функцию потерь_
![](http://latex.codecogs.com/svg.latex?%5Cmathcal%7BL%7D%28M%29%3D%28M-1%29%5E2%3D%28%5Clangle%20w%2Cx_i%20%5Crangle%20y_i-1%29%5E2)
и _дельта-правило_ правило обновления весов
![](http://latex.codecogs.com/svg.latex?w%3Dw-%5Ceta%28%5Clangle%20w%2Cx_i%20%5Crangle-y_i%29x_i).  

**Правило Хебба**
Имеет _кусочно-линейную функцию потерь_
![](http://latex.codecogs.com/svg.latex?%5Cmathcal%7BL%7D%3D%28-M%29_&plus;%3D%5Cmax%28-M%2C0%29)
и _правило Хебба_ для обновления весов
![](http://latex.codecogs.com/svg.latex?%5Ctext%7Bif%20%7D%5Clangle%20w%2Cx_i%20%5Crangle%20y_i%3C0%20%5Ctext%7B%20then%20%7D%20w%3A%3Dw&plus;%5Ceta%20x_iy_i).

<b>Реализованную программу можно увидеть по <a href="https://simfikduke.shinyapps.io/adaline/">ссылке</a>.</b>  

### <a name="logistic"></a>**2.Логистическая регрессия**  
Метод основан на довольно сильных вероятностных предположениях, которые имеют довольно интересные последствия:  
1) Линейный классификатор оказывается оптимальным байесовским.  
2) Функция потерь определяется однозначно.  
3) Можно не только получить класс объекта, но и вычислить вероятность его принадлежности к классу.  
   Функция потерь для логистическое регрессии выглядит следующим образом: ![L](http://latex.codecogs.com/gif.latex?L%28M%29%20%3D%20%5Clog_%7B2%7D%28%7B1&plus;e%5E%7B-M%7D%7D%29)  
   А правило обновления весов: ![W](http://latex.codecogs.com/gif.latex?w%20%3D%20w%20&plus;%20%5Ceta%20x_i%20y_i%20%5Csigma%28-%3Cw%2Cx_i%3E%20y_i%29), где ![sigma](http://latex.codecogs.com/gif.latex?%5Csigma%20%28z%29%20%3D%20%5Cfrac%7B1%7D%7B1&plus;e%5E%7B-z%7D%7D)
Реализованную программу можно по <a href="https://simfikduke.shinyapps.io/logistic/">ссылке</a>.  
Скриншот 1:  
"Разделение классов"  
![s1](https://github.com/SimfikDuke/Rprojects/blob/master/LinearAlgorithms/img/log_1.png)  
Скриншот 2:  
"Сравнение линейных алгоритмов"  
Красный - логистическая регрессия  
Зеленый - Правило Хэбба  
Бордовый - Адаптивный линейный элемент  
![s2](https://github.com/SimfikDuke/Rprojects/blob/master/LinearAlgorithms/img/log_all.png)  
Скриншот 3:  
"Непрозрачность объекта соответствует его вероятности принадлежности к данному классу."  
![s3](https://github.com/SimfikDuke/Rprojects/blob/master/LinearAlgorithms/img/log_grad.png)  
Скриншот 4:  
"Непрозрачность объекта соответствует его вероятности принадлежности к данному классу."  
![s4](https://github.com/SimfikDuke/Rprojects/blob/master/LinearAlgorithms/img/log_grad2.png)  
