Mi framework LaTex utilizado para la realización del Trabajo Fin de Grado en la universidad de Almería (ual)

##Porqué?

Por que "obviamente" (MS|Libre|...)Office son procesadores de texto y dejan bastante que desear para algo medianamente serio. Este framework está basado en [TeXis 1.0](http://gaia.fdi.ucm.es/research/texis) (el cual está basado en LaTex) lo que hace que no tengas que preocuparte por la maquetación, únicamente por escribir y el solo numera, inserta los margenes, tabla de contenidos, referencias ...

El formato que se pide ya está incluido, el tipo de letra (11pt), márgenes (2.5cm), interlineado ... ¡Solo escribir!


##INSTALACIÓN

Lo he usado en Linux pero supongo que funcionará igualmente en MacOS si se tiene instalado el entorno latex. Respecto a Windows pues quizas con Latex y cygwin tire, lo mas socorrido es tirar de VirtualBox/VmWare e instalar Linux y trabajar desde este.

Haz tus cambios (basicamente incluir el nuevo .tex en Texis.tex y si se quiere compilar unicamente ese descomentar esa linea en config.tex). 
Una vez hecho los cambios para ver el resultado (compilar):

```bash
$make

```

Si falla es porque falta algun paquete, al final (despues de una larga lista) opté por instalar todo el entorno con (Fedora 23):

```bash
$dnf install texlive-scheme-full -y
```

##Dudas

###Para incluir una imagen hay que convertirla a pdf antes:

```bash
$cd Imagenes/Vectorial
$./convertTopdf.sh /tmp/mi-imagen.png Capitulos/1/

```

Y ya despues simplemente hacer referencia a la imagen en el documento.


###Si da problemas por acentos hay que convertir los ficheros de UTF-8 a latin1

```bash
$iconv -t ISO-8859-1 -f UTF-8 04Capitulo.tex  > 04Capitulo.tex-latin1
```

###Como lo has escrito tu?

Básicamente vim + git. Te recomiendo una cuenta git para gestionar las versiones o si quieres puedes usar dropbox/drive/x.
A estas alturas no realizar backups de tus cambios online es cuanto menos poco apropiado.



###Tienes algun manual/tutorial

Si, se incluye el manual original de TeXis en [manual.PDF](./manual.PDF).
Se incluye también un "cutre" archivo de salida/ejemplo en [Tesis.pdf](./Tesis.pdf) con cual será el formato de salida real.

