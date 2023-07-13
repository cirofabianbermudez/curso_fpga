### _¿Qué es un **Flip-Flop**?:_
Circuitos con dos estados estables que se pueden utilizar para almacenar datos binarios. Los datos almacenados se pueden cambiar aplicando diferentes entradas.

##### SR Flip Flop:

En este diagrama la salida se cambia (es decir, los datos almacendos se cambian) solo cuando da una señal de reloj activa. De lo contrario, incluso si _S_ o _R_ están activos, los datos no cambiarán. 

![SR](https://www.electronicsforu.com/wp-contents/uploads/2017/08/SR-flip-flop.png)

+ Set input (_S_)
+ Reset input (_R_)

 En este sistema, cuando configura _S_ como activo, la salida _Q_ sería alta y _Q'_ sería baja. Una vez que se establecen las salidas, el cableado del circuito se mantiene hasta que _S_ o _R_ suban, o se apague la alimentación.

#### Tabla de verdad SR:

|Modo de operación|clk|_S_|_R_|_Q_|_Q'_|
|:--------:|:-:|:-:|:-:|:-:|:-:|
|Mismo estado|x|0|0|x|x|
|Reset|↑|0|1|0|1|
|Set|↑|1|0|1|0|
|Condición no válida|↑|1|1|NC|NC|

![SR](http://circuitossecuenciales.weebly.com/uploads/2/3/7/6/23768053/1612763_orig.png)


### JK Flip Flop:

El flip-flop JK es una mejora del flip-flop SR donde $S=R=1$.
![JK](https://www.electronicsforu.com/wp-contents/uploads/2017/08/JK-Flip-Flop-756x420.png)

![JK](https://grdp.co/cdn-cgi/image/width=500,height=500,quality=50,f=auto/https://gs-post-images.grdp.co/2022/7/jk-flip-flop-img1657880657870-71.png-rs-high-webp.png)

La condición de entrada de $J=K=1$ da una salida que invierte el estado de salida.
Si las entradas de datos _J_ y _K_ son diferentes (es decir, alta y baja), entonces la salida _Q_ toma el valor de _J_ en el siguiente borde del reloj. Si tanto _J_ como _K_ son bajos, entonces no ocurre ningún cambio. Si _J_ como _K_ están altos en el borde del reloj, la salida cambiará de un estado a otro. 
Puede funcionar como _Set_ o _Reset_ Flip-Flops.

#### Tabla de verdad JK:

|_J_|_K_|_Q_|_Q'_|State|
|:-:|:-:|:-:|:-:|:-:|
|0|0|0|0|Hold|
|0|0|1|1|Hold|
|0|1|0|0|Reset|
|0|1|1|0|Reset|
|1|0|0|1|Set|
|1|0|1|1|Set|
|1|1|0|1|Toggel|
|1|1|1|0|Toggel|


### D Flip Flop:

La salida solo se puede cambiar en el borde del reloj, y si la entrada cambia en otros momentos, la salida no se verá afectada.

![[Captura de Pantalla 2023-07-03 a la(s) 12.44.27.png]]

Su función es dejar pasar lo que entra por D, a la salida Q, después de un pulso del reloj.

#### Tabla de verdad D:

|_clk_|_D_|_Q_|_Q'_|
|:-:|:-:|:-:|:-:|
|0|0|NC|NC|
|0|1|NC|NC|
|1|0|0|1|
|1|1|1|0|


### T Flip Flop:

El flip-flop T es como un flip-flop JK. Estas son básicamente versiones de una sola entrada. Esta forma modificada se obtiene conectando las entradas J y K juntas. Solo tiene una entrada junto con la entrada del reloj.

![T](https://www.electronicsforu.com/wp-contents/uploads/2019/04/t-flip-flop-1-500x266.jpg)

#### Tabla de verdad D:

|_T_|_Q_|_Q'_|
|:-:|:-:|:-:|
|0|0|0|
|1|0|1|
|0|1|1|
|1|1|0|

![T](http://circuitossecuenciales.weebly.com/uploads/2/3/7/6/23768053/2276899_orig.png)


