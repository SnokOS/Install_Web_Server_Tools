#!/bin/bash
set -e

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'
PURPLE='\033[0;35m'; CYAN='\033[0;36m'; WHITE='\033[1;37m'; NC='\033[0m'

# Variables
WEBSERVER=""; DATABASE=""; LANGUAGE=""; LOG_FILE="/var/log/snok_webserver.log"
declare -A STRINGS

# Load Language
load_language() {
    case $LANGUAGE in
        "en") STRINGS=([welcome]="Welcome to Snok Web Server" [select_lang]="Select Language" [select_web]="Select Web Server" [select_db]="Select Database" [install]="Install" [uninstall]="Uninstall & Clean" [exit]="Exit" [checking_root]="Checking root" [detecting_os]="Detecting OS" [detected]="Detected" [internet_check]="Checking internet" [internet_ok]="Internet OK" [updating]="Updating" [upgrading]="Upgrading" [installing]="Installing" [installed]="installed" [configuring]="Configuring" [configured]="configured" [install_complete]="Installation Complete" [access_web]="Access website" [access_php]="PHP Info" [access_pma]="phpMyAdmin" [uninstall_confirm]="Uninstall all?" [uninstalling]="Uninstalling" [cleaning]="Cleaning" [uninstall_complete]="Uninstall complete" [press_enter]="Press Enter" [yes]="Yes" [no]="No" [error]="Error" [success]="Success") ;;
        "fr") STRINGS=([welcome]="Bienvenue à Snok Web Server" [select_lang]="Sélectionner langue" [select_web]="Serveur Web" [select_db]="Base de données" [install]="Installer" [uninstall]="Désinstaller" [exit]="Quitter" [checking_root]="Vérif root" [detecting_os]="Détection OS" [detected]="Détecté" [internet_check]="Vérif Internet" [internet_ok]="Internet OK" [updating]="Mise à jour" [upgrading]="Upgrade" [installing]="Installation" [installed]="installé" [configuring]="Configuration" [configured]="configuré" [install_complete]="Installation OK" [access_web]="Site web" [access_php]="Info PHP" [access_pma]="phpMyAdmin" [uninstall_confirm]="Tout désinstaller?" [uninstalling]="Suppression" [cleaning]="Nettoyage" [uninstall_complete]="Suppression OK" [press_enter]="Entrée" [yes]="Oui" [no]="Non" [error]="Erreur" [success]="Succès") ;;
        "ar") STRINGS=([welcome]="مرحباً بك في Snok Web Server" [select_lang]="اختر اللغة" [select_web]="اختر الخادم" [select_db]="اختر قاعدة البيانات" [install]="تثبيت" [uninstall]="إزالة وتنظيف" [exit]="خروج" [checking_root]="فحص الصلاحيات" [detecting_os]="كشف النظام" [detected]="تم الكشف" [internet_check]="فحص الإنترنت" [internet_ok]="الإنترنت متوفر" [updating]="التحديث" [upgrading]="الترقية" [installing]="التثبيت" [installed]="تم التثبيت" [configuring]="الإعداد" [configured]="تم الإعداد" [install_complete]="اكتمل التثبيت" [access_web]="الموقع" [access_php]="معلومات PHP" [access_pma]="phpMyAdmin" [uninstall_confirm]="إزالة الكل؟" [uninstalling]="الإزالة" [cleaning]="التنظيف" [uninstall_complete]="اكتملت الإزالة" [press_enter]="Enter" [yes]="نعم" [no]="لا" [error]="خطأ" [success]="نجح") ;;
    esac
}

# Print Functions
print_msg() { echo -e "${GREEN}[✓]${NC} $1"; }
print_error() { echo -e "${RED}[✗]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[⚠]${NC} $1"; }
print_info() { echo -e "${CYAN}[ℹ]${NC} $1"; }
print_step() { echo -e "${PURPLE}[▶]${NC} $1"; }

# Logo
show_logo() {
    clear
    echo -e "${CYAN}"
    cat << "EOF"
   _____ _   _  ____  _  __  
  / ____| \ | |/ __ \| |/ /  
 | (___ |  \| | |  | | ' /   
  \___ \| . ` | |  | |  <    
  ____) | |\  | |__| | . \   
 |_____/|_| \_|\____/|_|\_\  
  Web Server Pro Installer
EOF
    echo -e "${NC}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Language Menu
select_language() {
    show_logo
    echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC}  Select Language / Langue / اللغة     ${BLUE}║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════╝${NC}\n"
    echo -e "  ${CYAN}1)${NC} 🇬🇧 English\n  ${CYAN}2)${NC} 🇫🇷 Français\n  ${CYAN}3)${NC} 🇸🇦 العربية\n"
    read -p "$(echo -e ${YELLOW}▶${NC}) " lang_choice
    case $lang_choice in 1) LANGUAGE="en" ;; 2) LANGUAGE="fr" ;; 3) LANGUAGE="ar" ;; *) LANGUAGE="en" ;; esac
    load_language
}

# Main Menu
main_menu() {
    while true; do
        show_logo
        echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
        echo -e "${BLUE}║${NC}  ${STRINGS[welcome]}  ${BLUE}║${NC}"
        echo -e "${BLUE}╚════════════════════════════════════════╝${NC}\n"
        echo -e "  ${GREEN}1)${NC} 📦 ${STRINGS[install]}\n  ${RED}2)${NC} 🗑️  ${STRINGS[uninstall]}\n  ${YELLOW}3)${NC} 🚪 ${STRINGS[exit]}\n"
        read -p "$(echo -e ${YELLOW}▶${NC}) " choice
        case $choice in 1) installation_menu ;; 2) uninstall_menu ;; 3) exit 0 ;; esac
    done
}

# Installation Menu
installation_menu() {
    show_logo
    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}  ${STRINGS[select_web]}  ${GREEN}║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}\n"
    echo -e "  ${CYAN}1)${NC} 🌐 Apache2\n  ${CYAN}2)${NC} ⚡ Nginx\n"
    read -p "$(echo -e ${YELLOW}▶${NC}) " web_choice
    case $web_choice in 1) WEBSERVER="apache2" ;; *) WEBSERVER="nginx" ;; esac
    
    show_logo
    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}  ${STRINGS[select_db]}  ${GREEN}║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}\n"
    echo -e "  ${CYAN}1)${NC} 🐬 MariaDB\n  ${CYAN}2)${NC} 🐬 MySQL\n"
    read -p "$(echo -e ${YELLOW}▶${NC}) " db_choice
    case $db_choice in 2) DATABASE="mysql" ;; *) DATABASE="mariadb" ;; esac
    
    confirm_installation
}

# Confirm
confirm_installation() {
    show_logo
    echo -e "${PURPLE}╔════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC}  Configuration Summary  ${PURPLE}║${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════╝${NC}\n"
    echo -e "  ${WHITE}Language:${NC} ${LANGUAGE^^}\n  ${WHITE}Web Server:${NC} ${WEBSERVER^^}\n  ${WHITE}Database:${NC} ${DATABASE^^}\n"
    read -p "$(echo -e ${YELLOW}▶${NC}) Continue? (y/n): " confirm
    [[ $confirm == "y" ]] && start_installation || main_menu
}

# Check Root
check_root() {
    print_step "${STRINGS[checking_root]}..."
    [[ $EUID -ne 0 ]] && { print_error "Need root: sudo bash $0"; exit 1; }
    print_msg "${STRINGS[success]}"
}

# Detect OS
detect_os() {
    print_step "${STRINGS[detecting_os]}..."
    . /etc/os-release; OS=$ID; ID_LIKE=${ID_LIKE:-}
    print_msg "${STRINGS[detected]}: $PRETTY_NAME"
}

# Check Internet
check_internet() {
    print_step "${STRINGS[internet_check]}..."
    ping -c 1 8.8.8.8 &> /dev/null && print_msg "${STRINGS[internet_ok]}" || { print_error "No internet"; exit 1; }
}

# Update
update_system() {
    print_step "${STRINGS[updating]}..."
    apt-get update -y >> $LOG_FILE 2>&1 && print_msg "${STRINGS[success]}"
    print_step "${STRINGS[upgrading]}..."
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y >> $LOG_FILE 2>&1 && print_msg "${STRINGS[success]}"
}

# Install Prerequisites
install_prerequisites() {
    print_step "${STRINGS[installing]} prerequisites..."
    apt-get install -y curl wget git unzip software-properties-common apt-transport-https ca-certificates gnupg lsb-release ufw >> $LOG_FILE 2>&1
    print_msg "${STRINGS[success]}"
}

# Install Apache
install_apache() {
    print_step "${STRINGS[installing]} Apache2..."
    apt-get install -y apache2 libapache2-mod-php >> $LOG_FILE 2>&1
    systemctl start apache2; systemctl enable apache2 >> /dev/null 2>&1
    systemctl is-active --quiet apache2 && print_msg "Apache2 ${STRINGS[installed]}" || { print_error "Failed"; exit 1; }
}

# Install Nginx
install_nginx() {
    print_step "${STRINGS[installing]} Nginx..."
    apt-get install -y nginx >> $LOG_FILE 2>&1
    systemctl start nginx; systemctl enable nginx >> /dev/null 2>&1
    systemctl is-active --quiet nginx && print_msg "Nginx ${STRINGS[installed]}" || { print_error "Failed"; exit 1; }
}

# Install PHP
install_php() {
    print_step "${STRINGS[installing]} PHP 8.2..."
    if [[ "$ID_LIKE" == *"ubuntu"* || "$OS" =~ ^(ubuntu|linuxmint|pop)$ ]]; then
        add-apt-repository -y ppa:ondrej/php >> $LOG_FILE 2>&1
    else
        wget -qO /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg 2>> $LOG_FILE
        echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
    fi
    apt-get update -y >> $LOG_FILE 2>&1
    apt-get install -y php8.2-fpm php8.2-common php8.2-mysql php8.2-xml php8.2-curl php8.2-gd php8.2-cli php8.2-mbstring php8.2-opcache php8.2-zip php8.2-intl >> $LOG_FILE 2>&1
    systemctl start php8.2-fpm; systemctl enable php8.2-fpm >> /dev/null 2>&1
    print_msg "PHP ${STRINGS[installed]}"
}

# Install MariaDB
install_mariadb() {
    print_step "${STRINGS[installing]} MariaDB..."
    apt-get install -y mariadb-server >> $LOG_FILE 2>&1
    systemctl start mariadb; systemctl enable mariadb >> /dev/null 2>&1
    mysql -e "DELETE FROM mysql.user WHERE User=''; FLUSH PRIVILEGES;" >> $LOG_FILE 2>&1
    print_msg "MariaDB ${STRINGS[installed]}"
}

# Install MySQL
install_mysql() {
    print_step "${STRINGS[installing]} MySQL..."
    DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server >> $LOG_FILE 2>&1
    systemctl start mysql; systemctl enable mysql >> /dev/null 2>&1
    mysql -e "DELETE FROM mysql.user WHERE User=''; FLUSH PRIVILEGES;" >> $LOG_FILE 2>&1
    print_msg "MySQL ${STRINGS[installed]}"
}

# Install phpMyAdmin
install_phpmyadmin() {
    print_step "${STRINGS[installing]} phpMyAdmin..."
    echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
    echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
    echo "phpmyadmin phpmyadmin/app-password-confirm password " | debconf-set-selections
    echo "phpmyadmin phpmyadmin/mysql/admin-pass password " | debconf-set-selections
    echo "phpmyadmin phpmyadmin/password-confirm password " | debconf-set-selections
    echo "phpmyadmin phpmyadmin/setup-password password " | debconf-set-selections
    echo "phpmyadmin phpmyadmin/database-type select mysql" | debconf-set-selections
    echo "phpmyadmin phpmyadmin/mysql/app-pass password " | debconf-set-selections
    
    DEBIAN_FRONTEND=noninteractive apt-get install -y phpmyadmin >> $LOG_FILE 2>&1 || {
        cd /tmp; wget -q https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.tar.gz
        tar xzf phpMyAdmin-5.2.1-all-languages.tar.gz
        rm -rf /usr/share/phpmyadmin
        mv phpMyAdmin-5.2.1-all-languages /usr/share/phpmyadmin
        mkdir -p /var/lib/phpmyadmin/tmp
        chown -R www-data:www-data /usr/share/phpmyadmin /var/lib/phpmyadmin
        chmod 700 /var/lib/phpmyadmin/tmp
    }
    
    # Ensure correct permissions
    if [[ -d /usr/share/phpmyadmin ]]; then
        chown -R www-data:www-data /usr/share/phpmyadmin
        chmod -R 755 /usr/share/phpmyadmin
    fi
    
    # For Nginx, create symlink
    if [[ "$WEBSERVER" == "nginx" ]]; then
        ln -sf /usr/share/phpmyadmin /var/www/html/phpmyadmin 2>/dev/null
    fi
    
    print_msg "phpMyAdmin ${STRINGS[installed]}"
}

# Configure Apache
configure_apache() {
    print_step "${STRINGS[configuring]} Apache..."
    a2enmod rewrite php8.2 >> $LOG_FILE 2>&1
    
    # Main site config
    cat > /etc/apache2/sites-available/000-default.conf << 'EOF'
<VirtualHost *:80>
    DocumentRoot /var/www/html
    <Directory /var/www/html>
        AllowOverride All
        Require all granted
    </Directory>
    
    Alias /phpmyadmin /usr/share/phpmyadmin
    <Directory /usr/share/phpmyadmin>
        Options FollowSymLinks
        DirectoryIndex index.php
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
    
    # Create phpMyAdmin Apache config if doesn't exist
    if [[ ! -f /etc/apache2/conf-available/phpmyadmin.conf ]]; then
        cat > /etc/apache2/conf-available/phpmyadmin.conf << 'EOF'
# phpMyAdmin Apache configuration

Alias /phpmyadmin /usr/share/phpmyadmin

<Directory /usr/share/phpmyadmin>
    Options SymLinksIfOwnerMatch
    DirectoryIndex index.php
    
    <IfModule mod_php.c>
        <IfModule mod_mime.c>
            AddType application/x-httpd-php .php
        </IfModule>
        <FilesMatch ".+\.php$">
            SetHandler application/x-httpd-php
        </FilesMatch>

        php_value include_path .
        php_admin_value upload_tmp_dir /var/lib/phpmyadmin/tmp
        php_admin_value open_basedir /usr/share/phpmyadmin/:/usr/share/doc/phpmyadmin/:/etc/phpmyadmin/:/var/lib/phpmyadmin/:/usr/share/php/:/usr/share/javascript/
        php_admin_value mbstring.func_overload 0
    </IfModule>
    <IfModule mod_php.c>
        php_admin_flag allow_url_fopen Off
    </IfModule>
</Directory>

<Directory /usr/share/phpmyadmin/templates>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/libraries>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/setup/lib>
    Require all denied
</Directory>
EOF
        a2enconf phpmyadmin >> $LOG_FILE 2>&1
    fi
    
    # Ensure phpMyAdmin temp directory exists
    mkdir -p /var/lib/phpmyadmin/tmp
    chown -R www-data:www-data /var/lib/phpmyadmin/tmp
    chmod 700 /var/lib/phpmyadmin/tmp
    
    systemctl reload apache2
    print_msg "Apache ${STRINGS[configured]}"
}

# Configure Nginx
configure_nginx() {
    print_step "${STRINGS[configuring]} Nginx..."
    cat > /etc/nginx/sites-available/default << 'EOF'
server {
    listen 80;
    root /var/www/html;
    index index.php index.html;
    location / { try_files $uri $uri/ =404; }
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
    }
}
EOF
    nginx -t >> $LOG_FILE 2>&1 && systemctl reload nginx
    print_msg "Nginx ${STRINGS[configured]}"
}

# Create Pages
create_pages() {
    cat > /var/www/html/index.php << 'EOHTML'
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Snok Web Server</title>
<style>*{margin:0;padding:0;box-sizing:border-box}body{font-family:'Segoe UI',sans-serif;background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);min-height:100vh;display:flex;justify-content:center;align-items:center;padding:20px}.container{background:#fff;padding:50px;border-radius:20px;box-shadow:0 20px 60px rgba(0,0,0,.3);max-width:800px;width:100%;text-align:center}.logo{font-size:48px;font-weight:700;background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);-webkit-background-clip:text;-webkit-text-fill-color:transparent;margin-bottom:20px}.status{background:#d4edda;border:2px solid #28a745;color:#155724;padding:20px;border-radius:10px;margin:30px 0;font-size:18px;font-weight:700}.info-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:20px;margin:30px 0}.info-card{background:#f8f9fa;padding:20px;border-radius:10px;border:2px solid #e9ecef}.info-card strong{color:#667eea;display:block;margin-bottom:10px}.links{display:flex;gap:15px;justify-content:center;flex-wrap:wrap;margin-top:30px}.btn{padding:15px 30px;background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);color:#fff;text-decoration:none;border-radius:10px;font-weight:700;transition:transform .2s}.btn:hover{transform:translateY(-2px)}</style></head><body>
<div class="container"><div class="logo">🚀 SNOK</div><h1>Web Server OK!</h1>
<div class="status">✓ Server Running</div><div class="info-grid">
<div class="info-card"><strong>Server</strong><span><?php echo $_SERVER['SERVER_SOFTWARE'];?></span></div>
<div class="info-card"><strong>PHP</strong><span><?php echo phpversion();?></span></div>
<div class="info-card"><strong>IP</strong><span><?php echo $_SERVER['SERVER_ADDR'];?></span></div>
</div><div class="links"><a href="/info.php" class="btn">📊 PHP Info</a>
<a href="/phpmyadmin" class="btn">🗄️ phpMyAdmin</a></div></div></body></html>
EOHTML
    echo '<?php phpinfo();?>' > /var/www/html/info.php
    chown -R www-data:www-data /var/www/html/
}

# Firewall
configure_firewall() {
    print_step "Firewall..."
    ufw --force enable >> $LOG_FILE 2>&1
    ufw allow 22,80,443/tcp >> $LOG_FILE 2>&1
    print_msg "${STRINGS[success]}"
}

# Install
start_installation() {
    show_logo
    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}  Starting Installation...  ${GREEN}║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}\n"
    echo "=== Install: $(date) ===" > $LOG_FILE
    check_root; detect_os; check_internet; update_system; install_prerequisites
    [[ "$WEBSERVER" == "apache2" ]] && install_apache || install_nginx
    install_php
    [[ "$DATABASE" == "mariadb" ]] && install_mariadb || install_mysql
    install_phpmyadmin
    [[ "$WEBSERVER" == "apache2" ]] && configure_apache || configure_nginx
    create_pages; configure_firewall
    installation_complete
}

# Complete
installation_complete() {
    local ip=$(hostname -I | awk '{print $1}')
    show_logo
    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}  ${STRINGS[install_complete]}! 🎉  ${GREEN}║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}\n"
    print_msg "Web: ${WEBSERVER^^}"; print_msg "DB: ${DATABASE^^}"; print_msg "PHP: 8.2"
    echo -e "\n${CYAN}Access:${NC}\n  🌐 http://$ip\n  📊 http://$ip/info.php\n  🗄️  http://$ip/phpmyadmin\n"
    read -p "${STRINGS[press_enter]}" && main_menu
}

# Uninstall Menu
uninstall_menu() {
    show_logo
    echo -e "${RED}╔════════════════════════════════════════╗${NC}"
    echo -e "${RED}║${NC}  ${STRINGS[uninstall]}  ${RED}║${NC}"
    echo -e "${RED}╚════════════════════════════════════════╝${NC}\n"
    echo -e "  ${GREEN}1)${NC} 🗑️  Complete Uninstall (All)"
    echo -e "  ${YELLOW}2)${NC} ⚙️  Selective Uninstall"
    echo -e "  ${CYAN}3)${NC} ⬅️  Back to Main Menu\n"
    read -p "$(echo -e ${YELLOW}▶${NC}) " uninstall_choice
    
    case $uninstall_choice in
        1) confirm_uninstall_all ;;
        2) selective_uninstall_menu ;;
        3) main_menu ;;
        *) uninstall_menu ;;
    esac
}

# Confirm Complete Uninstall
confirm_uninstall_all() {
    show_logo
    echo -e "${RED}╔════════════════════════════════════════╗${NC}"
    echo -e "${RED}║${NC}  ⚠️  COMPLETE UNINSTALL WARNING ⚠️  ${RED}║${NC}"
    echo -e "${RED}╚════════════════════════════════════════╝${NC}\n"
    print_warning "${STRINGS[uninstall_confirm]}"
    echo -e "\n${YELLOW}This will remove:${NC}"
    echo -e "  ❌ All Web Servers (Apache2 & Nginx)"
    echo -e "  ❌ All Databases (MariaDB & MySQL)"
    echo -e "  ❌ PHP & all extensions"
    echo -e "  ❌ phpMyAdmin"
    echo -e "  ❌ All configurations\n"
    read -p "$(echo -e ${RED}▶${NC}) Type 'yes' to confirm: " confirm
    [[ "$confirm" == "yes" ]] && uninstall_all || uninstall_menu
}

# Selective Uninstall Menu
selective_uninstall_menu() {
    local remove_web="" remove_db="" remove_php="" remove_pma=""
    
    # Select Web Server
    show_logo
    echo -e "${YELLOW}╔════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║${NC}  Select Web Server to Remove  ${YELLOW}║${NC}"
    echo -e "${YELLOW}╚════════════════════════════════════════╝${NC}\n"
    echo -e "  ${CYAN}1)${NC} 🌐 Apache2"
    echo -e "  ${CYAN}2)${NC} ⚡ Nginx"
    echo -e "  ${CYAN}3)${NC} 🔄 Both"
    echo -e "  ${CYAN}4)${NC} ⏭️  Skip (Keep Web Server)\n"
    read -p "$(echo -e ${YELLOW}▶${NC}) " web_remove
    case $web_remove in
        1) remove_web="apache2" ;;
        2) remove_web="nginx" ;;
        3) remove_web="both" ;;
        4) remove_web="none" ;;
        *) remove_web="none" ;;
    esac
    
    # Select Database
    show_logo
    echo -e "${YELLOW}╔════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║${NC}  Select Database to Remove  ${YELLOW}║${NC}"
    echo -e "${YELLOW}╚════════════════════════════════════════╝${NC}\n"
    echo -e "  ${CYAN}1)${NC} 🐬 MariaDB"
    echo -e "  ${CYAN}2)${NC} 🐬 MySQL"
    echo -e "  ${CYAN}3)${NC} 🔄 Both"
    echo -e "  ${CYAN}4)${NC} ⏭️  Skip (Keep Database)\n"
    read -p "$(echo -e ${YELLOW}▶${NC}) " db_remove
    case $db_remove in
        1) remove_db="mariadb" ;;
        2) remove_db="mysql" ;;
        3) remove_db="both" ;;
        4) remove_db="none" ;;
        *) remove_db="none" ;;
    esac
    
    # Select PHP
    show_logo
    echo -e "${YELLOW}╔════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║${NC}  Remove PHP?  ${YELLOW}║${NC}"
    echo -e "${YELLOW}╚════════════════════════════════════════╝${NC}\n"
    echo -e "  ${CYAN}1)${NC} ✅ Yes, remove PHP"
    echo -e "  ${CYAN}2)${NC} ❌ No, keep PHP\n"
    read -p "$(echo -e ${YELLOW}▶${NC}) " php_remove
    [[ $php_remove == "1" ]] && remove_php="yes" || remove_php="no"
    
    # Select phpMyAdmin
    show_logo
    echo -e "${YELLOW}╔════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║${NC}  Remove phpMyAdmin?  ${YELLOW}║${NC}"
    echo -e "${YELLOW}╚════════════════════════════════════════╝${NC}\n"
    echo -e "  ${CYAN}1)${NC} ✅ Yes, remove phpMyAdmin"
    echo -e "  ${CYAN}2)${NC} ❌ No, keep phpMyAdmin\n"
    read -p "$(echo -e ${YELLOW}▶${NC}) " pma_remove
    [[ $pma_remove == "1" ]] && remove_pma="yes" || remove_pma="no"
    
    # Confirm Selective Uninstall
    confirm_selective_uninstall "$remove_web" "$remove_db" "$remove_php" "$remove_pma"
}

# Confirm Selective Uninstall
confirm_selective_uninstall() {
    local web=$1 db=$2 php=$3 pma=$4
    show_logo
    echo -e "${PURPLE}╔════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC}  Uninstall Summary  ${PURPLE}║${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════╝${NC}\n"
    
    echo -e "${WHITE}Items to remove:${NC}\n"
    [[ "$web" == "apache2" ]] && echo -e "  ❌ Apache2"
    [[ "$web" == "nginx" ]] && echo -e "  ❌ Nginx"
    [[ "$web" == "both" ]] && echo -e "  ❌ Apache2 & Nginx"
    [[ "$web" == "none" ]] && echo -e "  ✅ Web Server (Keep)"
    
    [[ "$db" == "mariadb" ]] && echo -e "  ❌ MariaDB"
    [[ "$db" == "mysql" ]] && echo -e "  ❌ MySQL"
    [[ "$db" == "both" ]] && echo -e "  ❌ MariaDB & MySQL"
    [[ "$db" == "none" ]] && echo -e "  ✅ Database (Keep)"
    
    [[ "$php" == "yes" ]] && echo -e "  ❌ PHP" || echo -e "  ✅ PHP (Keep)"
    [[ "$pma" == "yes" ]] && echo -e "  ❌ phpMyAdmin" || echo -e "  ✅ phpMyAdmin (Keep)"
    
    echo ""
    read -p "$(echo -e ${YELLOW}▶${NC}) Continue? (y/n): " confirm
    [[ $confirm == "y" ]] && selective_uninstall "$web" "$db" "$php" "$pma" || uninstall_menu
}

# Perform Selective Uninstall
selective_uninstall() {
    local web=$1 db=$2 php=$3 pma=$4
    
    show_logo
    echo -e "${RED}╔════════════════════════════════════════╗${NC}"
    echo -e "${RED}║${NC}  Removing Selected Components...  ${RED}║${NC}"
    echo -e "${RED}╚════════════════════════════════════════╝${NC}\n"
    
    # Remove Web Server
    if [[ "$web" == "apache2" || "$web" == "both" ]]; then
        print_step "${STRINGS[uninstalling]} Apache2..."
        systemctl stop apache2 2>/dev/null
        apt-get purge -y apache2* >> $LOG_FILE 2>&1
        rm -rf /etc/apache2
        print_msg "Apache2 removed"
    fi
    
    if [[ "$web" == "nginx" || "$web" == "both" ]]; then
        print_step "${STRINGS[uninstalling]} Nginx..."
        systemctl stop nginx 2>/dev/null
        apt-get purge -y nginx* >> $LOG_FILE 2>&1
        rm -rf /etc/nginx
        print_msg "Nginx removed"
    fi
    
    # Remove Database
    if [[ "$db" == "mariadb" || "$db" == "both" ]]; then
        print_step "${STRINGS[uninstalling]} MariaDB..."
        systemctl stop mariadb 2>/dev/null
        apt-get purge -y mariadb* >> $LOG_FILE 2>&1
        rm -rf /var/lib/mysql /etc/mysql
        print_msg "MariaDB removed"
    fi
    
    if [[ "$db" == "mysql" || "$db" == "both" ]]; then
        print_step "${STRINGS[uninstalling]} MySQL..."
        systemctl stop mysql 2>/dev/null
        apt-get purge -y mysql* >> $LOG_FILE 2>&1
        rm -rf /var/lib/mysql /etc/mysql
        print_msg "MySQL removed"
    fi
    
    # Remove PHP
    if [[ "$php" == "yes" ]]; then
        print_step "${STRINGS[uninstalling]} PHP..."
        systemctl stop php8.2-fpm 2>/dev/null
        apt-get purge -y php* >> $LOG_FILE 2>&1
        rm -rf /etc/php
        print_msg "PHP removed"
    fi
    
    # Remove phpMyAdmin
    if [[ "$pma" == "yes" ]]; then
        print_step "${STRINGS[uninstalling]} phpMyAdmin..."
        apt-get purge -y phpmyadmin >> $LOG_FILE 2>&1
        rm -rf /usr/share/phpmyadmin /var/lib/phpmyadmin /var/www/html/phpmyadmin
        print_msg "phpMyAdmin removed"
    fi
    
    # Clean up
    print_step "${STRINGS[cleaning]}..."
    apt-get autoremove -y >> $LOG_FILE 2>&1
    apt-get autoclean -y >> $LOG_FILE 2>&1
    print_msg "${STRINGS[uninstall_complete]}"
    
    echo ""
    read -p "${STRINGS[press_enter]}" && main_menu
}

# Uninstall
uninstall_all() {
    print_step "${STRINGS[uninstalling]}..."
    systemctl stop nginx apache2 php8.2-fpm mariadb mysql 2>/dev/null
    apt-get purge -y nginx* apache2* php* mariadb* mysql* phpmyadmin >> $LOG_FILE 2>&1
    apt-get autoremove -y >> $LOG_FILE 2>&1
    apt-get autoclean -y >> $LOG_FILE 2>&1
    rm -rf /var/www/html/* /etc/nginx /etc/apache2 /etc/php /var/lib/mysql /var/lib/mariadb
    print_msg "${STRINGS[uninstall_complete]}"
    read -p "${STRINGS[press_enter]}" && main_menu
}

# Main
select_language; main_menu
