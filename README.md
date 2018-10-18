В данном репозитории содержатся работы Дудко Александра по предмету "Системы и методы принятия решений".

# <center><b>Метрические алгоритмы</b></center>

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

![1NN](https://github.com/SimfikDuke/Rprojects/blob/master/img/1NN.png)

Недостатки:

- Неустойчивость к погрешностям. Если среди обучающих объектов есть выброс — объект, находящийся в окружении объектов чужого класса, то не только он сам будет классифицирован неверно, но и т.е. окружающие его объекты, для которых он окажется ближайшим.
- Отсутствие параметров, которые можно было бы настраивать по выборке. Алгоритм полностью зависит от того, насколько удачно выбрана метрика ρ.
- В результате — низкое качество классификации.

**2. Алгоритм классификации "kNN" k-ближайших соседей:**

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

**3. Алгоритм классификации "kwNN" k-взвешенных соседей:**  
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

**Прямоугольное ядро**  
Имеет следующий вид:  
![R](https://latex.codecogs.com/gif.latex?R%28Z%29%20%3D%20%5Cfrac%7B1%7D%7B2%7D%5Cleft%20%5B%20%5Cleft%20%7C%20z%20%5Cleq%201%20%5Cright%20%7C%20%5Cright%20%5D)  
Оптимальный параметр ширины окна h=0.35, оценка LOO=0.04. Карта классификации выглядит следующим образом:
![LOO_parzen_R](https://github.com/SimfikDuke/Rprojects/blob/master/img/parzen_R.png)
**Треугольное ядро**  
Имеет следующий вид:  
![T](https://latex.codecogs.com/gif.latex?T%28Z%29%20%3D%20%281%20-%20%7Cz%7C%29%5Ccdot%20%5Cleft%20%5B%20%5Cleft%20%7C%20z%20%5Cleq%201%20%5Cright%20%7C%20%5Cright%20%5D)  
Оптимальный параметр ширины окна h=0.35, оценка LOO=0.04. Карта классификации выглядит следующим образом:
![LOO_parzen_T](https://github.com/SimfikDuke/Rprojects/blob/master/img/parzen_T.png)
**Квартическое ядро**  
Имеет следующий вид:  
![Q](https://latex.codecogs.com/gif.latex?Q%28Z%29%20%3D%20%5Cfrac%7B15%7D%7B16%7D%281%20-%20z%5E2%29%5E2%5Ccdot%20%5Cleft%20%5B%20%5Cleft%20%7C%20z%20%5Cleq%201%20%5Cright%20%7C%20%5Cright%20%5D)  
Оптимальный параметр ширины окна h=0.35, оценка LOO=0.04. Карта классификации выглядит следующим образом:
![LOO_parzen_Q](https://github.com/SimfikDuke/Rprojects/blob/master/img/parzen_Q.png)
**Ядро Епанечникова**  
Имеет следующий вид:  
![E](https://latex.codecogs.com/gif.latex?E%28Z%29%20%3D%20%5Cfrac%7B3%7D%7B4%7D%281%20-%20z%5E2%29%5Ccdot%20%5Cleft%20%5B%20%5Cleft%20%7C%20z%20%5Cleq%201%20%5Cright%20%7C%20%5Cright%20%5D)  
Оптимальный параметр ширины окна h=0.35, оценка LOO=0.04. Карта классификации выглядит следующим образом:
![LOO_parzen_E](https://github.com/SimfikDuke/Rprojects/blob/master/img/parzen_E.png)
**Гауссовское ядро**  
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

Следующая таблица содержит сводку по реализованным методам:  

<center><h3>
<table>
  <tbody>
    <tr>
      <th>Метод</th>
      <th>Параметры</th>
      <th>Точность</th>
    </tr>
    <tr>
      <td>KNN</td>
      <td>k=6</td>
      <td>0.0333</td>
    </tr>
    <tr>
      <td>KWNN</td>
      <td>k=19, w=0.2^i</td>
      <td>0.0267</td>
    </tr>
    <tr>
      <td>Parzen, Rectangel kerel</td>
      <td>h=0.35</td>
      <td>0.04</td>
    </tr>
    <tr>
      <td>Parzen, Triangle kerel</td>
      <td>h=0.35</td>
      <td>0.04</td>
    </tr>
    <tr>
      <td>Parzen, Quartic kerel</td>
      <td>h=0.35</td>
      <td>0.04</td>
    </tr>
    <tr>
      <td>Parzen, Epanechnikov kerel</td>
      <td>h=0.35</td>
      <td>0.04</td>
    </tr>
    <tr>
      <td>Parzen, Gauss kerel</td>
      <td>h=0.1</td>
      <td>0.04</td>
    </tr>
  </tbody>
   </table></h3>
</center>
