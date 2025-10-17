#!/bin/bash
set -e

echo "🚀 Configurando entorno de Programación Funcional y Reactiva..."

# Instalar SDKMAN
echo "📦 Instalando SDKMAN..."
export SDKMAN_DIR="$HOME/.sdkman"
curl -s "https://get.sdkman.io" | bash

# Cargar SDKMAN para esta sesión
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Instalar Scala 3
echo "📦 Instalando Scala 3..."
sdk install scala 3.3.1 < /dev/null

# Instalar SBT
echo "📦 Instalando SBT..."
sdk install sbt < /dev/null

# Instalar pip para Python
echo "📦 Configurando pip..."
python3 -m pip install --upgrade pip 2>/dev/null || true

# Instalar herramientas de Python
echo "📦 Instalando herramientas de Python (IPython, Jupyter, etc)..."
pip install ipython jupyter numpy pandas matplotlib 2>/dev/null || true

# Instalar Glow para visualizar Markdown
echo "📦 Instalando Glow..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg 2>/dev/null || true
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install -y glow

# Esperar a que MySQL esté listo
echo "🔧 Esperando a que MySQL esté disponible..."
max_attempts=30
attempt=0
until mysql -h db -u pfr_user -ppassword -e "SELECT 1" >/dev/null 2>&1; do
  attempt=$((attempt + 1))
  if [ $attempt -eq $max_attempts ]; then
    echo "⚠️  MySQL no está disponible después de $max_attempts intentos"
    break
  fi
  echo "   Esperando MySQL... (intento $attempt/$max_attempts)"
  sleep 2
done

if mysql -h db -u pfr_user -ppassword -e "SELECT 1" >/dev/null 2>&1; then
  echo "✅ MySQL está listo y funcionando!"
  echo "   Host: db (o localhost)"
  echo "   Puerto: 3306"
  echo "   Usuario: pfr_user"
  echo "   Contraseña: password"
  echo "   Base de datos: pfr_db"
fi

# Agregar SDKMAN al bashrc si no está
if ! grep -q "sdkman-init.sh" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# SDKMAN" >> ~/.bashrc
    echo 'export SDKMAN_DIR="$HOME/.sdkman"' >> ~/.bashrc
    echo '[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"' >> ~/.bashrc
fi

# Verificar instalaciones
echo ""
echo "✅ Verificando instalaciones..."
echo "Java version:"
java -version
echo ""
echo "Scala version:"
scala -version
echo ""
echo "SBT version:"
sbt --version
echo ""
echo "Python version:"
python3 --version
echo ""
echo "Maven version:"
mvn --version
echo ""
echo "Glow version:"
glow --version

echo ""
echo "✨ Entorno configurado correctamente!"
echo "📚 Usa 'glow' para ver los archivos markdown con las prácticas"
echo "🗄️  MySQL disponible en: mysql -h db -u pfr_user -ppassword pfr_db"
echo "🎓 Bienvenido al entorno de Programación Funcional y Reactiva - UTPL"