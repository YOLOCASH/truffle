# Localización

Tu archivo de configuración se llama `truffle.js`, y está localizado en la raíz del directorio de tu proyecto. Este archivo es de tipo Javascript y puede ejecutar el código necesario para crear tu configuración. Este debe exportar un objeto representando la configuración de tu proyecto tal cual el ejemplo abajo.

# Ejemplo

```javascript
module.exports = {
  build: {
    "index.html": "index.html",
    "app.js": [
      "javascripts/app.js"
    ],
    "app.css": [
      "stylesheets/app.css"
    ],
    "images/": "images/"
  },
  deploy: [
    "MetaCoin",
    "ConvertLib"
  ],
  rpc: {
    host: "localhost",
    port: 8545
  }
};
```

La configuración por defecto viene con tres opciones especificadas: `build`, `deploy` y `rpc`. Estas opciones, así como las opciones que no vienen por defcto, son detalladas abajo.

# Options

### build

La configuración de _armado_ de tu frontend. Por defecto esta configuración invoca el armador por defecto, decrito en la sección [Armado](/getting_started/build), sin embargo, tu puedes usar tus propios procesos de armado. Consulta la sección [Procesos de armado avanzados](/advanced/build_processes) para detalles.

**Ejemplo:**

```javascript
build: {
  "index.html": "index.html",
  "app.js": [
    "javascripts/app.js"
  ],
  "app.css": [
    "stylesheets/app.css"
  ],
  "images/": "images/"
}
```

### deploy

Un array que reprensenta los contratos que tu quieres _desplegar_ cuando `truffle deploy` es ejecutado. Este tema es discutido en detalle en la sección [desplegando a la red](/getting_started/deploy).

**Ejemplo:**

```javascript
deploy: [
  "MetaCoin",
  "ConvertLib"
]
```

### after_deploy

Un array de scripts pensado para ser ejecutado despues de un despliegue exitoso. Estos scripts son ejecutados en orden, usando la funcionalidad `truffle exec` descrita en la sección [scripts externos](/getting_started/scripts). Estos scripts tienen acceso a los contratos definidos dentro de tu ambiente actual, y pueden ser usados para escribir pasos de despliegue personalidados como si tú estuvieses escribiendo tests desde tu frontend. Cada ruta es relativa al directorio raíz de tu proyecto.

**Ejemplo:**

```javascript
after_deploy: [
  "./register_contracts.js",
  "./demo_data.js"
]
```

### rpc

Detalles de como conectarte a tu cliente de ethereum. Los valores de `host` y `port` (puerto) son obligatorios. Ahora, hay disponibles otras opciones además:

* `host`: Hostname apuntando a la localización de tu cliente Ethereum (usualmente `localhost` para desarrollo).
* `port`: Número de puerto apuntando donde tu cliente Ethereum acepta requests. El puerto por defecto es `8545`.
* `gas`: El límite de Gasolina usado para despliegues. El valor por defecto es `3141592`.
* `gasPrice`: El precio de la gasolina usado para los despliegues. El valor por defecto es `100000000000` (100 Shannon).
* `from`: La dirección `desde` (`from`) usada en los despliegues. Si no está especificada, esta se ajusta por defecto a la primera cuenta disponible proveída por tu cliente de Ethereum.

**Ejemplo:**

```javascript
rpc: {
  host: "localhost",
  port: 8545
}
```

### mocha

Opciones de configuración para el framework de testing [MochaJS](http://mochajs.org). Esta configuración espera un objeto según el detalle en la [documentación](https://github.com/mochajs/mocha/wiki/Using-mocha-programmatically#set-options) de Mocha (en inglés).

**Ejemplo:**

```javascript
mocha: {
  useColors: true
}
```

# Consideraciones

Tu puedes sobrescribir cualquiera de las configuraciones especificadas en `truffle.js` para cada uno de tus ambientes. Para más detalles, consulta en la sección [ambientes](/advanced/environments).
