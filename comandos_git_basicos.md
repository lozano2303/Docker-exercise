## Cristofer David Lozano Contreras // 30 comandos de Git

## 1. git init
crea una carpeta .git (oculta) para inicializar un repositorio local

## 2. git config global user.name / user.email
sirve para configurar las credenciales en el computador actual (es recomendable 
eliminarlas del computador si no es de nosotros) esto para evitar problemas entre equipos y 
no aparecer como colaborador en un proyecto del que no formamos parte

## 3. git branch -M main
se usa para crear la primera rama de un repositorio cuando lo creamos (aparece en los pasos de 
github)

## 4. git remote add origin <url>
esta es la primera conexion que vamos a tener con nuestro nuevo repositorio

## 5. git push -u origin main
aqui subiremos la rama a github para que este disponible ya en el repositorio

## 6. git clone
copia el todo el contenido de un repositorio en github mediante la url a el directorio en el que 
se ejecute

## 7. git add
agrega los archivos especificos (colocando nombre del archivo especifico) y todos los cambios (utilizando 
un punto " . ")

## 8. git commit
guarda todos los cambios que agregaste con el add y les da un nombre (puede ser una descripcion de los cambios realizados)
cabe aclarar que los commits tienen que tener un nombre especifico con su respectiva seccion (frontend, backend, docs)

## 9. git status
muestra el estado de lo que hay actualmente en la version local, mostrando si los cambios no se han agregado (en rojo) 
y si ya se agregaron y estan listos para hacer commit (en verde)

## 10. git log
muestra el historial de commits en el repositorio

## 11. git diff
sirve para comparar los cambios que has hecho en la version actual 

## 12. git branch
se puede usar tanto para ver la rama en la que estas (en verde) y para ver las demas ramas existentes

## 13. git checkout
sirve para "navegar" entre las ramas existentes (aunque tambien existe el switch que practicamente cumple la misma funcion)

## 14. git merge
sirve para traer los cambios de otra rama a la rama actual (tambien se puede hacer un pull request en la parte grafica de github)

## 15. git pull
trae todos los cambios nuevos (commits) que hayan realizado otros colaboradores en el repositorio en github

## 16. git push
sube tu commit al repositorio en github (tienes que hacer un pull antes de realizar un push para evitar problemas y conflictos)

## 17. git reset
deshacer los commits cabe aclarar que conozco dos tipos de reset el git reset --hard HEAD~1 que borra hasta los cambios que 
realizaste y el git reset --soft HEAD~1 que solo borra el commit mas no los cambios
por ejemplo asi evitamos subir las credenciales del aws al github, cierto jhampier?

## 18. git rebase
reescribe el historial de commits, tanto en local como en repositorio y mas si se hace el git rebase --hard, cierto jhampier? 
aun recuerdo esos 10 commits de historial que borraste

## 19 git switch -c <nombre de la rama>
esto se usa para crear una rama y cambiarse a ella apenas se cree

## 20 git restore

se usa para restaurar un archivo a su ultima version (commit confirmado) por si cometiste un fallo y quieres restaurar el archivo afectado

## 21 git tag

se utiliza para darle una etiqueta a un commit y poder identificarlo de manera mucho mas sencilla, un ejemplo practico seria: "functional login module"

## 22 git config --global alias.<alias que se le va a dar> "<comando que quieres dejar de escribir completo>"
 
esta configuracion se utiliza para darle un alias a un comando especifico y en vez de escribir el comando completo simplemente escribimos el alias

## 23 git stash

este sirve para guardar los cambios sin agregarlos por asi decirlo ya que puedes hacer el git stash y cambiar de rama sin necesidad de subir tus 
cambios como commit y que asi no se pierda y el git stash pop sirve para tomar estos cambios y continuar desde lo guardado

## 24 git fetch

es como un git pull pero sin ser un git pull, es decir, no incorporta directamente los que viene del repositorio a lo local

## 25 git rm <nombre del archivo a eliminar>

se usa para eliminar algun archivo del repositorio y del directorio actual

## 26 git mv <nombre archivo antiguo> <nombre actualizado>

sirve para modificar el nombre de algun archivo, si lo nombre mal puedo volver a nombrarlo a el requerimiento correcto

## 27 git blame <nombre del archivo>

muestra quien escribio y en que commit se hizo cada linea de codigo, es como cuando uno la caga y le hecha la culpa a otro y empiezan a peliar por
una tontada, con esto se puede ver quien fue el que cometio el error, y asi hacerle buling de manera educativa

## 28 git show <id del commit del cual se quiere ver la informacion>

se usa para ver los cambios completos del commit, quien los hizo y la fecha en la que los hizo, con este tambien se pueden resolver conflictos entre 
los integrantes asi como con el git blame

## 29 git revert <id del commit que se quiere revertir>

se usa cuando se sube un commit y se sube con errores, entonces se revierten los cambios realizados en ese commit y se sube un commit nuevo con esos 
cambios revertidos es como, la regue, me tire todo pero nadie nunca se dio cuenta.... o si?

## 30 git log --oneline --graph --decorate --all

esto nos muestre el historial de commits de una forma resumida y bonita, y a comandos como este es a los que me refiero que se les puede hacer un alias
porque que pereza escribir eso tan largo, uy no.