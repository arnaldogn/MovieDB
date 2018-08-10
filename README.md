# MovieDB
Capas de la aplicación
- Model: modelar los objetos del negocio
- Views: la parte visible de la app
- Controllers: encargados de las transiciones y de mostrar las vistas
- Managers: encargados de la logica particular de una operacion
- Services: se comunican con la API 
- Data Persistance: protocolos para la creacion de objects Realm

Se implemento un patrón de diseño MVVM. Además se utilizo inyección de dependencias a través de Swinject

Principio de responsabilidad única
==============================================================
- Una clase debería tener sólo una razón para cambiar
- Cada responsabilidad es el eje del cambio
- Para contener la propagación del cambio, debemos separar las responsabilidades.
- Si una clase asume más de una responsabilidad, será más sensible al cambio.
- Si una clase asume más de una responsabilidad, las responsabilidades se acoplan.

Características de un buen código
==============================================================
- Correcto, es decir no genera warnings ni errores
- Simple
- Facil de reutlizar y entender
- Seguro
- Testeable
