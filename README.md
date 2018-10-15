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
Недостаток kNN в том, что максимум может достигаться сразу на нескольких классах. В задачах с двумя классами этого можно избежать, если взять нечётное k. Более общая тактика, которая годится и для случая многих классов — ввести строго убывающую последовательность вещественных весов ![wi](https://latex.codecogs.com/gif.latex?w_i)
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
