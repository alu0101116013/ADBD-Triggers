# ADBD
Asignatura de Administración y Diseño de Base de Datos ULL

## ADBD-Triggers

### Autor
- Kabir Chetwani Kaknani --> <alu0101116013@ull.edu.es>


### Descripción
Este repositorio contiene los **Triggers** realizados acerca de las BBDD de **Viveros** y **Catastro**.

___

### Índice

1. [Procedimiento de Creación de Email y su correspondiente Trigger](#id1)
2. [Trigger de verificación de una persona por vivienda](#id2)
3. [Trigger de actualización de stock](#id3)
___


### Procedimiento de Creación de Email y su correspondiente Trigger <a name="id1"></a>
- Este [script](https://github.com/alu0101116013/ADBD-Triggers/blob/main/Scripts%20SQL/viveros.sql) contiene la creación del procedimiento de **email** sobre la BBDD de **Viveros**, que devuelve la dirección de correo electrónico con el formato establecido que se observa a continuación **(DNI+@+Dominio)**.

	![Imagen](https://github.com/alu0101116013/ADBD-Triggers/blob/main/Screenshots/procedure_email.png)

- Una vez creado dicha tabla, aplicamos un **trigger** sobre la tabla de Clientes, siempre ejecutada antes de una operación de inserción y se asigna un valor por defecto en caso de que el campo sea NULL o el establecido por el usuario.

	![Imagen](https://github.com/alu0101116013/ADBD-Triggers/blob/main/Screenshots/trigger_email.png)


### Trigger de verificación de una persona por vivienda <a name="id2"></a>
- Este [script](https://github.com/alu0101116013/ADBD-Triggers/blob/main/Scripts%20SQL/catastro.sql) contiene la creación del **trigger** sobre la BBDD de **Catastro**, que permite verificar que las personas pertenecientes al catastro de un municipio, no puedan estar habitando en dos viviendas distintas. En caso de que habiten en ambos, se lanzará un código de error SQL junto a un mensaje informativo.

	![Imagen](https://github.com/alu0101116013/ADBD-Triggers/blob/main/Screenshots/trigger_catastro.png)


### Trigger de actualización de stock <a name="id2"></a>
-  Este [script](https://github.com/alu0101116013/ADBD-Triggers/blob/main/Scripts%20SQL/viveros.sql) contiene la creación del **trigger** sobre la BBDD de **Viveros**, que permite mantener actualizado el stock de los productos existentes, y proporcionar cierta información a los clientes a la hora de realizar el pedido. En caso de que el stock este por debajo del umbral, se lanzará un código de error SQL junto a un mensaje informativo.

	![Imagen](https://github.com/alu0101116013/ADBD-Triggers/blob/main/Screenshots/trigger_stock.png)


___

## Institución
* Centro docente: Universidad de La Laguna
* Escuela Superior de Informática y Tecnología ULL
* Carrera universitaria: Grado en Ingeniería Informática
