#----------------------------------------------------------
#
# Fichero MAKEFILE del documento. Para ver las opciones
# disponibles puedes utilizar
#
# $ make help
#
#----------------------------------------------------------
#
# Copyright 2009 Pedro Pablo Gomez-Martin,
#                Marco Antonio Gomez-Martin
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#----------------------------------------------------------

NOMBRE_LATEX = Tesis
#
# Genera el documento utilizando pdflatex
# 
pdflatex:
	pdflatex $(NOMBRE_LATEX)
	makeglossaries $(NOMBRE_LATEX)
	-bibtex8 $(NOMBRE_LATEX)
	-makeindex $(NOMBRE_LATEX).gxs -o $(NOMBRE_LATEX).glx -s glosstex.ist
#	-makeindex $(NOMBRE_LATEX)   Si tuvieras índice de palabras (mira preambulo.tex)
	pdflatex $(NOMBRE_LATEX)
	pdflatex $(NOMBRE_LATEX)
	mupdf-x11 $(NOMBRE_LATEX).pdf

# El guión en cualquier comando indica que si dicho comando falla
# (termina con una salida diferente de 0) la construcción del Make no
# debe detenerse. Eso podría ocurrir en el makeindex si se está
# generando el PDF en modo "depuración" en la que no se muestra el
# índice para ahorrar tiempo.  También se puso en bibtex porque al
# principio del todo no había referencias, bibtex se quejaba, y paraba
# toda la construcción.

#
# Genera el documento utilizando latex
#
latex: imagenesbitmap imagenesvectoriales
	latex $(NOMBRE_LATEX)
	makeglossaries $(NOMBRE_LATEX)
	-bibtex $(NOMBRE_LATEX)
	-makeindex $(NOMBRE_LATEX).gxs -o $(NOMBRE_LATEX).glx -s glosstex.ist
	#	-makeindex $(NOMBRE_LATEX)   Si tuvieras índice de palabras (mira preambulo.tex)
	#	-makeindex -o $(NOMBRE_LATEX).cnd -t $(NOMBRE_LATEX).clg $(NOMBRE_LATEX).cdx
	latex $(NOMBRE_LATEX)
	latex $(NOMBRE_LATEX)
	dvips $(NOMBRE_LATEX).dvi
	ps2pdf $(NOMBRE_LATEX).ps

#
# Prepara todas las imágenes del documento.
# Para eso, convierte tanto las imágenes de
# mapas de bits (.png y .jpg) como las
# vectoriales (.pdf) a .eps para que LaTeX
# las pueda usar.
#
imagenes: imagenesvectoriales imagenesbitmap

#
# Prepara las imágenes vectoriales del documento.
# Es decir, coge las imágenes en pdf y las convierte
# a eps para que LaTeX pueda utilizarlas.
#
imagenesvectoriales:
	cd Imagenes/Vectorial; make convert

#
# Prepara las imágenes de mapa de bits. Es decir,
# coge las imágenes de mapa de bits y las convierte a
# eps para que LaTeX pueda utilizarlas.
#
imagenesbitmap:
	cd Imagenes/Bitmap; make convert


#
# Genera el documento de manera rápida, sin invocar a bibtex, ni al
# índice, ni a la conversión de imágenes.
# Es útil para recompilar el documento "de manera incremental",
# cuando no hay cambios en la bibliografía o en el índice (o no nos
# preocupa no verlos en el pdf final).
# Al no invocar a bibtex, además no se repite múltiples veces
# la compilación del documento.
# Utiliza pdflatex.
#
fast:
	pdflatex $(NOMBRE_LATEX)

# 
# Equivalente a fast, pero usando LaTeX
#
fastlatex:
	latex $(NOMBRE_LATEX)
	dvips $(NOMBRE_LATEX).dvi
	ps2pdf $(NOMBRE_LATEX).ps


#
# Borra todos los ficheros intermedios y el .zip con el posible estado actual.
# No borra las imagenes convertidas.
#
clean:
	@echo Borrando los ficheros de log...
	@rm -f *.log
	@echo Borrando los ficheros auxiliares...
	@rm -f *.aux
	@rm -f *.out
	@rm -f *.exa
	@echo Borrando los ficheros de generación de índices de palabras...
	@rm -f *.idx
	@rm -f *.ilg
	@rm -f *.ind
	@echo Borrando los ficheros de generación de tablas de contenidos...
	@rm -f *.toc
	@rm -f *.lof
	@rm -f *.lot
	@echo Borrando los ficheros de generación de acrónimos...
	@rm -f $(NOMBRE_LATEX).g*
	@echo Borrando los ficheros de salida...
	@rm -f *.dvi
	@rm -f *.ps
	@echo Borrando los ficheros intermedios de BibTeX...
	@rm -f *.bbl
	@rm -f *.blg
	@echo Borrado recursivo de la infraestructura TeXiS...
	@if [ -d TeXiS ]; then cd TeXiS; make clean; fi
	@cd Cascaras; make clean
	@echo Borrado recursivo de los capítulos...
	@if [ -d Capitulos ]; then cd Capitulos; make clean; fi
	@echo Borrado recursivo de los apéndices...
	@if [ -d Apendices ]; then cd Apendices; make clean; fi
	@echo Borrado recursivo de las imágenes...
	@if [ -d Imagenes/Bitmap ]; then cd Imagenes/Bitmap; make clean; fi
	@cd Imagenes/Vectorial; make clean
	@echo Borrando el fichero .zip con el estado actual
	@rm -f $(NOMBRE_LATEX).zip


#
# Borra todos los ficheros intermedios, las copias de seguridad
# y los ficheros generados
#
distclean: clean
	@echo Borrando los ficheros de salida...
	@rm -f *.pdf
	@echo Borrando las copias de seguridad de los editores...
	@rm -f *~
	@rm -f *.backup
	@echo Borrando los ficheros de distribución...
	@rm -f *.tar.gz
	@echo Borrado recursivo de la infraestructura TeXiS...
	@if [ -d TeXiS ]; then cd TeXiS; make distclean; fi
	@cd Cascaras; make distclean
	@echo Borrado recursivo en los capítulos...
	@if [ -d Capitulos ]; then cd Capitulos; make distclean; fi
	@echo Borrado recursivo en los apéndices...
	@if [ -d Apendices ]; then cd Apendices; make distclean; fi
	@echo Limpiando las imágenes en formatos adicionales...
	@if [ -d Imagenes/Bitmap ]; then cd Imagenes/Bitmap; make distclean; fi
	@cd Imagenes/Vectorial; make distclean



help:
	@echo 
@echo Objetivos disponibles:
	@echo 
	@echo "   pdflatex [predefinido] : Genera el pdf usando pdflatex"
	@echo "   latex : Genera el pdf usando latex"
	@echo "   fast : Genera el pdf usando pdflatex de una manera rápida"
	@echo "          (y quizá incompleta). En concreto NO invoca a bibtex"
	@echo "          ni regenera el índice o convierte las imágenes,"
	@echo "          por lo que el resultado podría no ser perfecto."
	@echo "          Es útil para compilación 'incremental' cuando sólo"
	@echo "          se ha tocado texto (sin nueva bibliografía o cambios en"
	@echo "          el índice, pues además evita ejecuciones de pdflatex."
	@echo "   fastlatex : semejante a la anterior, pero usando latex".
	@echo "   imagenes : convierte los pdf, jpg y png a eps (útil para LaTeX)"
	@echo "   imagenesvectoriales : convierte los pdf a eps"
	@echo "   imagenesbitmap : convierte los jpg y png a eps"
	@echo "   clean : borra ficheros temporales y .zip con estado actual"
	@echo "   distclean : borra ficheros temporales, .zip con estado actual,"
	@echo "               copias de seguridad de ficheros .tex, conversiones de"
	@echo "               las imágenes y ficheros generados (pdf)"
	@echo 

ayuda: help
