В данном репозитории содержатся работы Дудко Александра по предмету "Системы и методы принятия решений".

# <center><b>Метрические алгоритмы</b></center>

**Гипотеза компактности** - схожим объекам соответствуют схожие ответы.
Для формализации понятия **сходства** вводится функция расстояния в пространстве ![X](http://www.sciweavers.org/upload/Tex2Img_1538633950/render.png).

**Метрические методы обучения** - методы, основанные на анализе сходства объектов.
Метрические алгоритмы относят к алгоритмам **ленивого** обучения.

**1. Алгоритм классификации "1NN":**
   
Классифицируемый объект относим к тому классу, к которому принадлежит ближайший по заданной метрике "сосед" из выборки.
В реализованном методе выбрана Евклидова метрика.
В качестве выборки был взят набор "Ирисы Фишера"
Карта классификации выглядит следующим образом:

![1NN](https://github.com/SimfikDuke/Rprojects/blob/master/img/1NN_classification.png)

**2. Алгоритм классификации "KNN" k-ближайших соседей:**
   
Все объекты выборки сортируются по удаленности от классифицируемого объекта. Выбираются ![k](http://www.sciweavers.org/upload/Tex2Img_1538633578/render.png) ближайших соседей.
Классифицируемый объект относим к тому классу, экземпляров которого больше в наборе из полученных ![k](http://www.sciweavers.org/upload/Tex2Img_1538633578/render.png) соседей.
В реализованном методе выбрана Евклидова метрика.
В качестве выборки был взят набор "Ирисы Фишера".
Для составления карты классификации параметр ![k](http://www.sciweavers.org/upload/Tex2Img_1538633578/render.png) равен 6.
Карта классификации выглядит следующим образом:

![KNN](https://github.com/SimfikDuke/Rprojects/blob/master/img/KNN_classification.png)

**3. LOO (leave-one-out) для алгоритма KNN:**

Оценка скользящего контроля для различных значений ![k](http://www.sciweavers.org/upload/Tex2Img_1538633578/render.png) алгоритма KNN: 

![LOO(K)](https://github.com/SimfikDuke/Rprojects/blob/master/img/LOO(K).png)

**4. Алгоритм классификации "KWNN" k-взвешенных соседей:**
   
Все объекты выборки сортируются по удаленности от классифицируемого объекта. Выбираются ![k](http://www.sciweavers.org/upload/Tex2Img_1538633578/render.png) ближайших соседей.
Классифицируемый объект относим к тому классу, суммарный вес которого больше.
![menshe](http://www.sciweavers.org/upload/Tex2Img_1538633992/render.png)
В реализованном методе выбрана Евклидова метрика.
В качестве выборки был взят набор "Ирисы Фишера".
Для составления карты классификации параметр ![k](http://www.sciweavers.org/upload/Tex2Img_1538633578/render.png) равен 6, а ![www](http://www.sciweavers.org/upload/Tex2Img_1538633869/render.png).
Карта классификации выглядит следующим образом:

![KNN](https://github.com/SimfikDuke/Rprojects/blob/master/img/KNN_classification.png)

**5. LOO (leave-one-out) для алгоритма KWNN:**

Оценка скользящего контроля для различных значений $w$ алгоритма KWNN при ![w](http://www.sciweavers.org/upload/Tex2Img_1538633788/render.png): 

![LOO(K,W)](https://github.com/SimfikDuke/Rprojects/blob/master/img/LOO(K,W)_KWNN.png)

На данном графике можно наблюдать превосходсво алгоритма KWNN над, поскольку если в алгоритм KWNN поставить ![ww](http://www.sciweavers.org/upload/Tex2Img_1538633831/render.png), то полученный алгоритм будет подобен алгоритму KNN. 
На графике LOO(K,W) можно наблюдать, что ошибка при ![www](http://www.sciweavers.org/upload/Tex2Img_1538633869/render.png) меньше, чем при ![ww](http://www.sciweavers.org/upload/Tex2Img_1538633831/render.png)
