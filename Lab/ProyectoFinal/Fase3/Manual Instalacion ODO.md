
#  Guía de Instalación de Odoo 17 en Ubuntu 24.04 ARM

> ⚙️ Esta guía describe cómo instalar Odoo 17 CE (Community Edition) en Ubuntu 24.04 ARM, ideal para entornos como Mac con chip M1/M2/M3/M4 usando VirtualBox o nativamente.

---

##  Prerrequisitos

Actualiza tu sistema y luego instala los paquetes necesarios:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install git python3-pip build-essential wget python3-dev libxml2-dev libxslt1-dev \
     zlib1g-dev libsasl2-dev libldap2-dev libjpeg-dev libpq-dev libffi-dev libtiff-dev \
     libjpeg8-dev libopenjp2-7-dev libfreetype6-dev liblcms2-dev libwebp-dev libharfbuzz-dev \
     libfribidi-dev libxcb1-dev libpq-dev libssl-dev libjpeg-dev libjpeg-turbo8-dev \
     libxrender1 libxext6 xfonts-base xfonts-75dpi libx11-dev libxtst6 -y
```

---

##  Instalación de PostgreSQL

```bash
sudo apt install postgresql -y
sudo -u postgres createuser --createdb --username postgres --no-createrole --no-superuser --pwprompt odoo
```

---

##  Crear entorno virtual de Python

```bash
sudo apt install python3-venv -y
python3 -m venv ~/odoo-venv
source ~/odoo-venv/bin/activate
```

---

##  Descargar Odoo

```bash
cd ~
git clone https://www.github.com/odoo/odoo --depth 1 --branch 17.0 --single-branch odoo
cd odoo
pip install wheel setuptools
pip install -r requirements.txt
```

---

##  Instalar wkhtmltopdf

```bash
sudo apt install wkhtmltopdf -y
```

> Verifica que wkhtmltopdf esté correctamente instalado:

```bash
wkhtmltopdf --version
```

---

## 🛠 Crear archivo de configuración

```bash
cp debian/odoo.conf ./odoo.conf
```

Edita `odoo.conf` con tu editor preferido y personaliza los valores:

```ini
[options]
addons_path = addons
admin_passwd = admin123
db_host = False
db_port = False
db_user = odoo
db_password = tu_contraseña
logfile = /var/log/odoo/odoo.log
```

Editar el archivo pg_hba.conf


```bash
sudo nano /etc/postgresql/16/main/pg_hba.conf

```

Cambiar

```text
<local>   all             odoo                                     peer
```

por 

```text
<local>   all             odoo                                     md5
```


---

## Ejecutar Odoo

```bash
./odoo-bin -c odoo.conf
```

Luego, abre tu navegador y entra a: [http://localhost:8069](http://localhost:8069)

---

## 📌 Consejos Finales

- Considera crear un servicio systemd para que Odoo se inicie automáticamente al arrancar el sistema.
- Usa `addons_path` para incluir tus módulos personalizados.
- Guarda la contraseña del administrador (`admin_passwd`) en un lugar seguro.

---

© 2025 - Instalación de Odoo 17 CE en Ubuntu 24.04 ARM
