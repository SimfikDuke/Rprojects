В данном репозитории содержатся работы Дудко Александра по предмету "Системы и методы принятия решений".

# <b>Метрические алгоритмы</b></center>
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
   
**1. Алгоритм классификации "1NN":**
   
Классифицируемый объект относим к тому классу, к которому принадлежит ближайший по заданной метрике "сосед" из выборки:

![w](https://latex.codecogs.com/gif.latex?w%28i%2C%20u%29%20%3D%20%5Bi%20%3D%201%5D%3B)

В реализованном методе выбрана евклидова метрика.  
В качестве выборки был взят набор "Ирисы Фишера"  
Карта классификации выглядит следующим образом:  

![1NN](https://github.com/SimfikDuke/Rprojects/blob/master/img/1NN.png)

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
![KNN](https://github.com/SimfikDuke/Rprojects/blob/master/img/LOO_KNN.png)

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
![KWNN](https://github.com/SimfikDuke/Rprojects/blob/master/img/LOO_KWNN.png)

На следующем графике наглядно продемонстрированно превосходство алгоритма классификации kwNN над алгоритмом kNN:
![KNN_KWNN](https://github.com/SimfikDuke/Rprojects/blob/master/img/KNN_KWNN.png)

На следующем графике показанно, что для выборки ирисов фишера, алгоритм k-ближайших соседей имеет минимальную оценку LOO=0.0333, а алгоритм k-взвешенных соседей, при k=19 и q=0.2 имеет минимальную оценку LOO=0.0267. Следовательно, качество классификации алгоритма kwNN лучше, чем kNN.
![LOO_LOO](https://github.com/SimfikDuke/Rprojects/blob/master/img/LOO_LOO.png)

**4. Алгоритм классификации "Парзеновское окно":**  
В данном алгоритме выбирается следующий способ задать веса соседям : определить ![w_i](https://latex.codecogs.com/gif.latex?w_i) как функцию от расстояния ![rho](https://latex.codecogs.com/gif.latex?%24%5Crho%28u%2Cx_u%5E%7B%28i%29%7D%29%24), а не от ранга соседа i. Введём функцию ядра K(z), весовую функцию следующим образом:  
![w_for_parzen](https://latex.codecogs.com/gif.latex?%24%24w%28u%2Ci%29%20%3D%20K%5Cleft%20%28%5Cfrac%7B1%7D%7Bh%7D%5Crho%28u%2Cx_u%5E%7B%28i%29%7D%29%20%5Cright%20%29%24%24),
где параметр h - ширина окна.  
Данный параметр будем подбирать по оценке скользящего контроля LOO и для различных ядер оптимальное значение ширины окна будет отличаться:

### <a name="ParzenR"></a>**Прямоугольное ядро**  
Имеет следующий вид:  
![R](https://latex.codecogs.com/gif.latex?R%28Z%29%20%3D%20%5Cfrac%7B1%7D%7B2%7D%5Cleft%20%5B%20%5Cleft%20%7C%20z%20%5Cleq%201%20%5Cright%20%7C%20%5Cright%20%5D)  
Оптимальный параметр ширины окна h=0.35, оценка LOO=0.04. Карта классификации выглядит следующим образом:
![LOO_parzen_R](https://github.com/SimfikDuke/Rprojects/blob/master/img/parzen_R.png)
### <a name="ParzenT"></a>**Треугольное ядро**  
Имеет следующий вид:  
![T](https://latex.codecogs.com/gif.latex?T%28Z%29%20%3D%20%281%20-%20%7Cz%7C%29%5Ccdot%20%5Cleft%20%5B%20%5Cleft%20%7C%20z%20%5Cleq%201%20%5Cright%20%7C%20%5Cright%20%5D)  
Оптимальный параметр ширины окна h=0.35, оценка LOO=0.04. Карта классификации выглядит следующим образом:
![LOO_parzen_T](https://github.com/SimfikDuke/Rprojects/blob/master/img/parzen_T.png)
### <a name="ParzenQ"></a>**Квартическое ядро**  
Имеет следующий вид:  
![Q](https://latex.codecogs.com/gif.latex?Q%28Z%29%20%3D%20%5Cfrac%7B15%7D%7B16%7D%281%20-%20z%5E2%29%5E2%5Ccdot%20%5Cleft%20%5B%20%5Cleft%20%7C%20z%20%5Cleq%201%20%5Cright%20%7C%20%5Cright%20%5D)  
Оптимальный параметр ширины окна h=0.35, оценка LOO=0.04. Карта классификации выглядит следующим образом:
![LOO_parzen_Q](https://github.com/SimfikDuke/Rprojects/blob/master/img/parzen_Q.png)
### <a name="ParzenE"></a>**Ядро Епанечникова**  
Имеет следующий вид:  
![E](https://latex.codecogs.com/gif.latex?E%28Z%29%20%3D%20%5Cfrac%7B3%7D%7B4%7D%281%20-%20z%5E2%29%5Ccdot%20%5Cleft%20%5B%20%5Cleft%20%7C%20z%20%5Cleq%201%20%5Cright%20%7C%20%5Cright%20%5D)  
Оптимальный параметр ширины окна h=0.35, оценка LOO=0.04. Карта классификации выглядит следующим образом:
![LOO_parzen_E](https://github.com/SimfikDuke/Rprojects/blob/master/img/parzen_E.png)
### <a name="ParzenG"></a>**Гауссовское ядро**  
Имеет следующий вид:  
![G](https://latex.codecogs.com/gif.latex?%24%24G%28Z%29%20%3D%20dnorm%28z%29%24%24)  
Оптимальный параметр ширины окна h=0.1, оценка LOO=0.04. Карта классификации выглядит следующим образом:
![LOO_parsen_G](https://github.com/SimfikDuke/Rprojects/blob/master/img/parzen_G.png)

Применение гауссовского ядра в алгоритме парзеновского окна решает проблему, когда классифицируемая точка не попадает в окно из за малой ширины. Следовательно, можно классифицировать любые точки, не зависимо от их удаленности от выборки, чего нельзя сделать, использую другие функции ядер.  

<center><b>Сравнение алгоритмов</b></center>  

Метрические алгоритмы ближайших соседей и парзеновского окна могут одинаково хорошо справляться с задачей классификации.  
На следующей картинке, для наибольшей наглядности, представленны карты классификации для алгоритма взвешенных ближайщих соседей и парзеновского окна:  
![KWNN_parzen](https://github.com/SimfikDuke/Rprojects/blob/master/img/KWNN_parzen.png)

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

Ниже представлено графическое представления распределения потенциалов, а также карта классификации для ядра Епанечникова.  
Объекты, потенциалы которых являются ненулевыми выделены звездочкой, объекты, на которых алгоритм ошибыется - квадратом. 
![potentialsE](https://github.com/SimfikDuke/Rprojects/blob/master/img/potentialsE.png)  

Ниже представлено графическое представления распределения потенциалов, а также карта классификации для Гауссовского ядра.  
Объекты, потенциалы которых являются ненулевыми выделены звездочкой, объекты, на которых алгоритм ошибыется - квадратом. 
![potentialsE](https://github.com/SimfikDuke/Rprojects/blob/master/img/potentialsG.png)

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
![margins](https://github.com/SimfikDuke/Rprojects/blob/master/img/margin.png)

В программной реализации использован метрический классификатор kwNN.  
Сам алгоритм STOLP формулируется следующим образом:  
- Отбросить выбросы (объекты ![x](http://www.machinelearning.ru/mimetex/?X^l) с W>δ)  
- Сформировать начальное приближение ![o](http://www.machinelearning.ru/mimetex/?\Omega) — из объектов выборки ![x](http://www.machinelearning.ru/mimetex/?X^l) выбрать по одному объекту каждого класса, обладающему среди объектов данного класса максимальной величиной риска либо минимальной величиной риска  
- Наращивание множества эталонов (пока число объектов выборки ![x](http://www.machinelearning.ru/mimetex/?X^l), распознаваемых неправильно, не станет меньше ![l_0](http://www.machinelearning.ru/mimetex/?l_0)):  
   * Классифицировать объекты ![x](http://www.machinelearning.ru/mimetex/?X^l), используя в качестве обучающей выборки ![o](http://www.machinelearning.ru/mimetex/?\Omega)  
   * Пересчитать величины риска для всех объектов ![xx](http://www.machinelearning.ru/mimetex/?X^l%20\setminus%20\Omega) с учетом изменения обучающей выборки  
   * Среди объектов каждого класса, распознанных неправильно, выбрать объекты с максимальной величиной риска и добавить их к ![o](http://www.machinelearning.ru/mimetex/?\Omega)

Первый проход:  
![s1](https://github.com/SimfikDuke/Rprojects/blob/master/img/stolp_s1.png)

Второй проход:  
![s2](https://github.com/SimfikDuke/Rprojects/blob/master/img/stolp_s2.png)

Одинадцатый проход:  
![s11](https://github.com/SimfikDuke/Rprojects/blob/master/img/stolp_s11.png)