
**Diferencia entre isKindOfClass: e isMemberOfClass:**
- isKindOfClass: Devuelve SI, en caso que el objeto a analizar sea una instancia de la misma clase o una instancia de cualquier clase que hereda de la especificada.
- isMemberOfClass: solo devuelve SI, en caso que el receptor (objeto) sea una instancia directa de la clase especificada.

**¿Donde guardarías las imágenes y pdfs?**
Las imágenes y pdf's las guardaría en la carpeta caché o temp, ya que ambas son zonas temporales y en caso de necesitar liberar memoria no habría problemas.

** Persistir el (isFavorite) **
Usaría el NSUserDefault, los datos que vamos a tratar son pocos y suele ser lo más recomentable. A parte de ello otra ventaja es su facilidad de uso.
**¿Otras formas de hacerlo?**
 - Exportando un JSON con relación libro y una marca de favorito o no.
 - Base de datos tipo CoreData.
 - En un Archivo PLIST, con un Array de diccionarios {"title":"YES/NO"}
 - En un simple fichero de texto, pero para eso mejor el JSON.

**Informar a la tabla**
La forma en que realizo el envio del mensaje es mediante las notificaciones. Cuando se ejecuta un cambio envio notificación y todos aquellos que están dados de alta a esa notificación harán los cambios necesarios.
Lo ideal sería utilizando KVO, al cambiar la propiedad, el observer registrado a los cambios de esa propiedad, actuaría de la forma que sea necesaria.

**Reloadata , ¿es una aberración?**
 Recargar los datos de la tabla si es una averración, puede ser viable bien cuando las celdas a renderizar son pocas y cuando exista alguna dependencia entre celdas.
 Existe reload por section y por row, lo cual minimiza mucho el coste computacional.
 Para que AGTSimplePDFViewController se entere del cambio de libro, desde la tabla mandaría una notificación en el método de delegado "DidSelect", y recibiría el nuevo modelo a mostrar.


 **Extras**

 **¿Que funcionalidades añadiría?**
 - Un buscador de libros, mediante texto directo o lector de QR.
 - Exportación de libros al iBook
 - Exportador de citas, para compartir en redes sociales, correos, web, etc.
 - Añadir notas o comentarios.



 **¿Que otras versiones se me ocurren?**
 - Catalogo de cualquier tema, clasificado igualmente por temática. Por poner un ejemplo: un catálogo de ropa, separado por tipos, diseño, etc.
 - Guia de especies, dividido por varias categorías.
 - Cualquier tipo de wikipedia, sobre todo para juegos, donde existe una gran variedad de elementos, personajes, habilidades...
 - La app de AGBO, para visualizar los vídeos desde la tableta, recursos...
 - Compraventa de cualquier tipo, libros, ropa,etc.
 Por nombrar unos pocos, pero en realidad es el formato básico para realizar miles de aplicaciones con temáticas diferentes pero apoyados en un diseño o plantilla similar.


**¿monetizar?**
Dependiendo mucho de lo anterior, podemos actuar haciendo que la versión FREE mouestre solo algunos recursos limitados y la PRO acceso a todos.
Muestra de 5 páginas al azar y para ver el resto, tienes que comprar el libro o ser un usaario registrado.
Si aumentamos las prestaciones de esta "plantilla", podemos crear un sistema de gestión y organización de documentos, informes, recursos ... para cualquier empresa, de forma interna.
Con un ejemplo como este, podemos limitar el acceso a N Grupos , N Categorías, Tamaño de almacenamiento, notificaciones, etc. Bueno esto... me ha venido porque mi cabeza le hizo un 360 jajaja.

Me tomo la libertad de no solo cuestionarme la forma de monetizar la app, una de las cosas que mas es necesaria es la permanencia del usuario. Y eso la garantizamos no solo por una buena app,
con buenos recursos, habeces no basta solo con eso y es necesario pues el poder compartir recursos, o tener mas interacción con la misma. 
Otra forma que está muy de moda es la gamificación, encontrar el modo en que un usario gane o pierda puntos, exp, como se llame, los cuales les permita acceder, comprar o utilizar recursos de la app. Obviamente esos puntos se pueden comprar :D





