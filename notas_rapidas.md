### Ejemplos

- Ejemplo 1 **(Ruby y JRuby)**. Mostrar y ver que los resultados no son los mismos en Jruby y ruby. Explicar porque...empezamos a explicar un poco la diferencia entre la JVM y MRI


- Ejemplo 2 **en MRI**... Mostrar de que el puts ahora nos interrumpe la ejecucion normal de un thread, porque se produce el context switch... Explicar un poco sobre esto...

- Ejemplo 3 **en MRI**... lo extraemos en una variable a ver que pasa... no deberia cambiar nada... aun tenemos el puts... 

- Ejemplo 4 **solo en MRI**.... no tenemos nada de E/S, pero con la version que tenemos... esto fallaria ... porque???

**Los ejemplos hay que correrlos con MRI 2.3.6 y 2.7.1**

```bash
/iasc/concurrencia-ruby(proposal_changes)$ ruby -v
ruby 2.3.6p384 (2017-12-14 revision 61254) [x86_64-linux]
altair.λ:~/iasc/concurrencia-ruby(proposal_changes)$ ruby 04_publicacion_tramposa.rb 
800000
altair.λ:~/iasc/concurrencia-ruby(proposal_changes)$ ruby 04_publicacion_tramposa.rb 
6460940
altair.λ:~/iasc/concurrencia-ruby(proposal_changes)$ ruby 04_publicacion_tramposa.rb 
9330662
altair.λ:~/iasc/concurrencia-ruby(proposal_changes)$ ruby 04_publicacion_tramposa.rb 
9289521
```

Simple vemos que el unless hace un context switch debido a un ref que hace una instruccion del bytecode de MRI... => https://github.com/ruby/ruby/commit/1403dfbf317ad796d92518bf5a7cbc40f2912dff

:facepalm:

moraleja... incluso si no tenemos E/S nuestro codigo puede no ser thread safe debido a que implementaciones de 3eros puede que tampoco sea thread safe.


- Ejemplo 5 **(Ruby y JRuby)**...En MRI parece que va todo bien pero en JRuby....

```
ConcurrencyError: Detected invalid array contents due to unsynchronized modifications with concurrent users
              << at org/jruby/RubyArray.java:1278
            push at org/jruby/RubyArray.java:1293
  05_gil_push.rb at 05_gil_push.rb:6
  05_gil_push.rb at 05_gil_push.rb:5

```

Nos tira un error ya directamente de que hay un error de concurrencia.... empieza a surgir ya la necesidad fuerte e imperiosa de sincronizar nuestro codigo...


- Ejemplo 6 **(Ruby y JRuby)**... Mutex a la fuerza.... mostrar una manera de manejar posibles casos de concurrencia

- Ejemplo 7 **(Solo JRUBY)**.... muestra de que si no manejamos bien la sincronizacion de un estado compartido entre threads... esto se puede ir muy rapido de las manos


```bash
...
3
3
3
3
33
3
3
....
1
3
3
```
