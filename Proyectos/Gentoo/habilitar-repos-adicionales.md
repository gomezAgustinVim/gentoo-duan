# Por qué habilitar repos adicionales?

Hay algunos repositorios que contienen paquetes que no aparecen en el repo por defecto.
Por ejemplo, zsh-history-substring-search. Por eso conviene habilitarlos

El paquete ya mencionado se encuentra en el repositorio guru y este se activa de la
siguiente manera (como root):

```sh
# emerge app-portage/eselect-repository
# eselect repository enable guru
# emaint sync -r guru
```

## Cuestiones

A veces el programa no se puede instalar y figura como **MASKED**. Estos paquetes son
aquellos que gentoo considera inseguros o no testeados lo suficiente.

Se pueden desenmascarar creando un archivo con el nombre del paquete en
/etc/portage/package.unmask/{nombre-del-paquete}

Si no está creado el directorio, se crea con:

```sh
# mkdir -p /etc/portage/package.unmask
```

Ejemplo:

```sh
# echo "=x11-base/xorg-server-1.11.99.2" > /etc/portage/package.unmask/xorg-server
```

Si eso no funciona, existe un directorio generalmente ya creado llamado
/etc/portage/package.accept_keywords/{nombre-del-paquete}

Ejemplo:

```sh
# nvim /etc/portage/package.accept_keywords/zsh
```

Y se agrega:

app-shells/zsh-history-substring-search ~amd64
