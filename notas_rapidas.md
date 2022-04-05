### Ejemplos

- Ejemplo 1 **(Ruby y JRuby)**: mostrar que los resultados no son los mismos en Jruby y ruby. Empezamos a explicar un poco la diferencia entre la JVM y MRI

- Ejemplo 2 **(MRI)**: agregar un `puts` y mostrar que eso nos interrumpe la ejecución normal de un thread, porque se produce un context switch

- Ejemplo 3 **(MRI)**: lo extraemos en una variable a ver qué pasa... no deberia cambiar nada, pero vemos que la llamada al getter produce un cambio de contexto 

- Ejemplo 4 **(MRI)**: correr este ejemplo con MRI 2.7.5 y con 2.3.6. En 2.3.6, por más que no tenemos nada de E/S, esto falla. ¿Por qué?
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

Simple: vemos que el unless hace un context switch debido a un ref que hace una instruccion del bytecode de MRI... => https://github.com/ruby/ruby/commit/1403dfbf317ad796d92518bf5a7cbc40f2912dff

:facepalm:

Si cambiamos el `unless false` por un `if true`, vamos que todo funciona sin problemas.

Moraleja: incluso si no tenemos E/S nuestro codigo puede no ser thread safe debido a que implementaciones de 3eros puede que tampoco sean thread safe.

- Ejemplo 5 **(Ruby y JRuby)**: vemos como resolver este problema de concurrencia agregando un mutex. Vemos que no alcanza con hacer atómica la lectura y la escritura, tenemos que hacer que todo el proceso sea atómico. Discutimos ventajas y desventajas de este enfoque

- Ejemplo 6 **(Ruby y JRuby)**: en MRI parece que va todo bien, pero en JRuby...

```
ConcurrencyError: Detected invalid array contents due to unsynchronized modifications with concurrent users
              << at org/jruby/RubyArray.java:1278
            push at org/jruby/RubyArray.java:1293
  05_gil_push.rb at 05_gil_push.rb:6
  05_gil_push.rb at 05_gil_push.rb:5

```

Directamente nos tira un error indicando que hay un problema de concurrencia. Esto se debe a la implementación de listas que usa Jruby (ver http://javadox.com/org.jruby/jruby-complete/1.7.13/org/jruby/RubyArray.html). Empieza a surgir ya la necesidad fuerte e imperiosa de sincronizar nuestro codigo.

- Ejemplo 7 **(JRuby)**: no todas las estructuras detectan los problemas de concurrencia y nos fuerzan a sincronizar. Aún así, si en este caso no manejamos bien la sincronizacion de un estado compartido entre threads, esto se puede ir muy rapido de las manos:
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

Nota: El HashMap no esta sincronizado ver en https://docs.oracle.com/javase/8/docs/api/java/util/HashMap.html

> Note that this implementation is not synchronized. If multiple threads access a hash map concurrently, and at least one of the threads modifies the map structurally, it must be synchronized externally. (A structural modification is any operation that adds or deletes one or more mappings; merely changing the value associated with a key that an instance already contains is not a structural modification.) This is typically accomplished by synchronizing on some object that naturally encapsulates the map. If no such object exists, the map should be "wrapped" using the Collections.synchronizedMap method. This is best done at creation time, to prevent accidental unsynchronized access to the map:

```java
   Map m = Collections.synchronizedMap(new HashMap(...));
```

> The iterators returned by all of this class's "collection view methods" are fail-fast: if the map is structurally modified at any time after the iterator is created, in any way except through the iterator's own remove method, the iterator will throw a ConcurrentModificationException. Thus, in the face of concurrent modification, the iterator fails quickly and cleanly, rather than risking arbitrary, non-deterministic behavior at an undetermined time in the future.