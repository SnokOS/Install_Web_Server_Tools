# 🚀 Snok Web Server - Professional Installer

<div align="center">

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Platform](https://img.shields.io/badge/platform-Debian%20%7C%20Ubuntu-orange.svg)
![Shell](https://img.shields.io/badge/shell-bash-brightgreen.svg)
![Developer](https://img.shields.io/badge/developer-Mahrez%20Ben%20Mohammed-purple.svg)
![Company](https://img.shields.io/badge/company-SnokOS-red.svg)

**Professional all-in-one web server installation script for Debian/Ubuntu based distributions**

**Developed by [Mahrez Ben Mohammed](https://github.com/SnokOS) | [SnokOS](https://snokos.github.io/SnokOS/)**

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Languages](#-languages) • [Contact](#-contact)

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Supported Distributions](#-supported-distributions)
- [What Gets Installed](#-what-gets-installed)
- [Installation](#-installation)
- [Usage](#-usage)
- [Languages](#-languages)
- [Uninstallation](#-uninstallation)
- [Configuration](#-configuration)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🌟 Overview

**Snok Web Server** is a comprehensive, production-ready installation script that automates the setup of a complete web server stack on Debian and Ubuntu-based Linux distributions. With multi-language support and intelligent configuration, it's perfect for developers, system administrators, and DevOps professionals.

---

## ✨ Features

### 🎯 Core Features

- **🌍 Multi-Language Support**: English, Français, العربية
- **⚡ Interactive Installation**: User-friendly menu-driven interface
- **🎨 Beautiful UI**: Colorful output with icons and progress indicators
- **📦 Complete Stack**: Full LAMP/LEMP stack installation
- **🔒 Security First**: Automatic firewall configuration and database hardening
- **🗑️ Smart Uninstall**: Complete or selective component removal
- **📝 Detailed Logging**: Comprehensive installation logs
- **✅ Error Handling**: Robust error detection and recovery

### 🛠️ Flexible Configuration

#### Web Server Options:
- 🌐 **Apache2** - The world's most popular web server
- ⚡ **Nginx** - High-performance web server

#### Database Options:
- 🐬 **MariaDB** - Enhanced MySQL fork
- 🐬 **MySQL** - Industry-standard relational database

### 📦 Additional Components

- **PHP 8.2** - Latest stable PHP with all major extensions
- **phpMyAdmin** - Web-based database management
- **UFW Firewall** - Automatically configured for security

---

## 💻 Supported Distributions

Snok Web Server works on all Debian and Ubuntu-based distributions:

### Ubuntu Family:
- ✅ Ubuntu (20.04, 22.04, 24.04+)
- ✅ Linux Mint
- ✅ Pop!_OS
- ✅ Elementary OS
- ✅ Zorin OS
- ✅ KDE Neon
- ✅ Lubuntu / Kubuntu / Xubuntu
- ✅ Ubuntu MATE
- ✅ Bodhi Linux

### Debian Family:
- ✅ Debian (10, 11, 12+)
- ✅ Kali Linux
- ✅ Parrot OS
- ✅ MX Linux
- ✅ Raspbian (Raspberry Pi)
- ✅ Deepin
- ✅ Peppermint OS

---

## 📦 What Gets Installed

### Web Server Stack:

| Component | Version | Purpose |
|-----------|---------|---------|
| Apache2 / Nginx | Latest | Web Server |
| PHP | 8.2 | Server-side scripting |
| MariaDB / MySQL | Latest | Database Server |
| phpMyAdmin | 5.2+ | Database Management |
| UFW | Latest | Firewall |

### PHP Extensions Included:

```
php8.2-fpm        php8.2-common     php8.2-mysql
php8.2-xml        php8.2-curl       php8.2-gd
php8.2-cli        php8.2-mbstring   php8.2-opcache
php8.2-zip        php8.2-intl       php8.2-bcmath
```

---

## 🚀 Installation

### Prerequisites

- Debian or Ubuntu-based Linux distribution
- Root or sudo access
- Active internet connection
- At least 1GB free disk space

### Quick Install

```bash
# Download the script
wget https://raw.githubusercontent.com/SnokOS/Install_Web_Server_Tools/main/snok.sh

# Make it executable
chmod +x snok.sh

# Run with sudo
sudo ./snok.sh
```

Or use curl:

```bash
# Download and run in one command
curl -fsSL https://raw.githubusercontent.com/SnokOS/Install_Web_Server_Tools/main/snok.sh -o snok.sh && chmod +x snok.sh && sudo ./snok.sh
```

### Manual Installation

```bash
# Create the script file
nano snok.sh

# Paste the script content
# Save and exit (Ctrl+X, Y, Enter)

# Make executable
chmod +x snok.sh

# Run
sudo ./snok.sh
```

---

## 📖 Usage

### Basic Workflow

1. **Run the Script**
   ```bash
   sudo ./snok.sh
   ```

2. **Select Language**
   - 🇬🇧 English
   - 🇫🇷 Français
   - 🇸🇦 العربية

3. **Choose Action**
   - 📦 Install
   - 🗑️ Uninstall
   - 🚪 Exit

4. **Configure Installation**
   - Select Web Server (Apache2 / Nginx)
   - Select Database (MariaDB / MySQL)
   - Confirm settings

5. **Wait for Completion**
   - Automatic installation and configuration
   - View progress in real-time

6. **Access Your Server**
   ```
   Main Site:    http://YOUR_IP/
   PHP Info:     http://YOUR_IP/info.php
   phpMyAdmin:   http://YOUR_IP/phpmyadmin
   ```

### Advanced Usage

#### Installation with Specific Components

```bash
# Example: Nginx + MariaDB
# 1. Run script
# 2. Choose Install
# 3. Select Nginx
# 4. Select MariaDB
# 5. Confirm
```

#### Logging

All operations are logged to:
```bash
/var/log/snok_webserver.log
```

View logs:
```bash
sudo tail -f /var/log/snok_webserver.log
```

---

## 🌍 Languages

Snok Web Server supports three languages with full translation:

### English (EN) 🇬🇧
- Default interface language
- Complete documentation
- All menus and messages

### Français (FR) 🇫🇷
- Interface complète en français
- Tous les menus traduits
- Messages d'erreur en français

### العربية (AR) 🇸🇦
- واجهة كاملة بالعربية
- جميع القوائم مترجمة
- رسائل الخطأ بالعربية

---

## 🗑️ Uninstallation

### Two Uninstall Modes:

#### 1. Complete Uninstall
Removes everything installed by Snok:
- All web servers
- All databases
- PHP and extensions
- phpMyAdmin
- Configuration files

```bash
sudo ./snok.sh
→ Choose "Uninstall & Clean"
→ Choose "Complete Uninstall"
→ Type "yes" to confirm
```

#### 2. Selective Uninstall ⭐

Remove only specific components:

**Web Server Selection:**
- Remove Apache2 only
- Remove Nginx only
- Remove both
- Keep web server

**Database Selection:**
- Remove MariaDB only
- Remove MySQL only
- Remove both
- Keep database

**Additional Options:**
- Remove/Keep PHP
- Remove/Keep phpMyAdmin

**Example Workflow:**
```bash
sudo ./snok.sh
→ Uninstall & Clean
→ Selective Uninstall
→ Select Apache2 to remove
→ Select MariaDB to remove
→ Keep PHP
→ Remove phpMyAdmin
→ Confirm
```

---

## ⚙️ Configuration

### Default Configurations

#### Apache2
```
Document Root: /var/www/html
Port: 80
Modules: rewrite, php8.2
```

#### Nginx
```
Document Root: /var/www/html
Port: 80
PHP-FPM: unix socket
```

#### PHP
```
Version: 8.2
FPM Pool: www-data
Extensions: All major extensions
```

#### Firewall (UFW)
```
SSH:   Port 22  ✅ Allowed
HTTP:  Port 80  ✅ Allowed
HTTPS: Port 443 ✅ Allowed
```

### Post-Installation Security

#### Secure MariaDB/MySQL
```bash
sudo mysql_secure_installation
```

#### Set Database Root Password
```bash
sudo mysql
MariaDB> ALTER USER 'root'@'localhost' IDENTIFIED BY 'your_password';
MariaDB> FLUSH PRIVILEGES;
MariaDB> EXIT;
```

#### Secure phpMyAdmin
Create `.htaccess` protection:
```bash
sudo nano /usr/share/phpmyadmin/.htaccess
```

Add:
```apache
AuthType Basic
AuthName "Restricted Access"
AuthUserFile /etc/phpmyadmin/.htpasswd
Require valid-user
```

Create password file:
```bash
sudo htpasswd -c /etc/phpmyadmin/.htpasswd admin
```

---

## 🔧 Troubleshooting

### Common Issues

#### 1. phpMyAdmin 404 Error

**Problem:** `/phpmyadmin` returns 404

**Solution:**
```bash
# For Apache
sudo a2enconf phpmyadmin
sudo systemctl reload apache2

# For Nginx
sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
sudo systemctl reload nginx
```

#### 2. PHP Not Working

**Problem:** PHP files download instead of executing

**Solution:**
```bash
# Check PHP-FPM status
sudo systemctl status php8.2-fpm

# For Apache
sudo a2enmod php8.2
sudo systemctl restart apache2

# For Nginx - check config
sudo nginx -t
sudo systemctl restart nginx php8.2-fpm
```

#### 3. Database Connection Error

**Problem:** Can't connect to database

**Solution:**
```bash
# Check service status
sudo systemctl status mariadb  # or mysql

# Restart service
sudo systemctl restart mariadb

# Check logs
sudo tail -f /var/log/mysql/error.log
```

#### 4. Port 80 Already in Use

**Problem:** Another service using port 80

**Solution:**
```bash
# Check what's using port 80
sudo lsof -i :80

# Stop conflicting service
sudo systemctl stop <service-name>
```

#### 5. Firewall Blocking Access

**Problem:** Can't access from external network

**Solution:**
```bash
# Check UFW status
sudo ufw status

# Ensure ports are open
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw reload
```

### View Logs

```bash
# Installation log
sudo cat /var/log/snok_webserver.log

# Apache logs
sudo tail -f /var/log/apache2/error.log

# Nginx logs
sudo tail -f /var/log/nginx/error.log

# PHP-FPM logs
sudo tail -f /var/log/php8.2-fpm.log

# Database logs
sudo tail -f /var/log/mysql/error.log
```

---

## 🎨 Screenshots

### Main Menu
```
   _____ _   _  ____  _  __  
  / ____| \ | |/ __ \| |/ /  
 | (___ |  \| | |  | | ' /   
  \___ \| . ` | |  | |  <    
  ____) | |\  | |__| | . \   
 |_____/|_| \_|\____/|_|\_\  
  Web Server Pro Installer
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

╔════════════════════════════════════════╗
║  Welcome to Snok Web Server            ║
╚════════════════════════════════════════╝

  1) 📦 Install
  2) 🗑️  Uninstall & Clean
  3) 🚪 Exit
```

### Installation Progress
```
[▶] Checking root privileges...
[✓] Success
[▶] Detecting operating system...
[✓] Detected: Ubuntu 22.04.3 LTS
[▶] Installing Nginx...
[✓] Nginx installed successfully
```

### Completion Screen
```
╔════════════════════════════════════════╗
║  Installation Complete! 🎉             ║
╚════════════════════════════════════════╝

[✓] Web Server: NGINX
[✓] Database: MARIADB
[✓] PHP: 8.2

Access:
  🌐 http://192.168.1.106
  📊 http://192.168.1.106/info.php
  🗄️  http://192.168.1.106/phpmyadmin
```

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the Repository**
   - Visit: https://github.com/SnokOS/Install_Web_Server_Tools
   
2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **Commit Your Changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. **Push to the Branch**
   ```bash
   git push origin feature/AmazingFeature
   ```
5. **Open a Pull Request**
   - Go to: https://github.com/SnokOS/Install_Web_Server_Tools/pulls

### Areas for Contribution

- 🌍 Additional language translations
- 🔧 New features and improvements
- 🐛 Bug fixes
- 📝 Documentation improvements
- 🎨 UI/UX enhancements

---

## 📄 License

This project is licensed under the MIT License - see below for details:

```
MIT License

Copyright (c) 2024 SnokOS - Mahrez Ben Mohammed

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🙏 Acknowledgments

- **Apache Software Foundation** - Apache HTTP Server
- **NGINX Inc.** - NGINX Web Server
- **MariaDB Foundation** - MariaDB Database
- **Oracle Corporation** - MySQL Database
- **PHP Development Team** - PHP Language
- **phpMyAdmin Team** - phpMyAdmin Tool

---

## 📞 Support

Need help? Here are some resources:

- 📖 **Documentation**: This README
- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/SnokOS/Install_Web_Server_Tools/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/SnokOS/Install_Web_Server_Tools/discussions)
- 📧 **Email**: SnokSoft@gmail.com
- 📱 **Phone**: +216 26 360 802
- 🌐 **Website**: [https://snokos.github.io/SnokOS/](https://snokos.github.io/SnokOS/)

---

## 👨‍💻 About the Developer

<div align="center">

### Mahrez Ben Mohammed

**Founder & Lead Developer at SnokOS**

[![GitHub](https://img.shields.io/badge/GitHub-SnokOS-181717?style=for-the-badge&logo=github)](https://github.com/SnokOS)
[![Website](https://img.shields.io/badge/Website-SnokOS-0066CC?style=for-the-badge&logo=google-chrome)](https://snokos.github.io/SnokOS/)
[![Email](https://img.shields.io/badge/Email-SnokSoft-D14836?style=for-the-badge&logo=gmail)](mailto:SnokSoft@gmail.com)

</div>

**Contact Information:**
* 📧 Email: **SnokSoft@gmail.com**
* 📱 Tel: **+216 26 360 802**
* 🏢 Company: **SnokOS**
* 🌐 Website: **https://snokos.github.io/SnokOS/**
* 💻 GitHub: **https://github.com/SnokOS**

---

## 🏢 About SnokOS

**SnokOS** is dedicated to creating professional, open-source tools and solutions for system administrators, developers, and DevOps professionals. Our mission is to simplify complex infrastructure tasks through automation and intelligent scripting.

### Our Projects:
- 🚀 **Snok Web Server** - Professional web server installer
- 🛠️ **System Automation Tools** - Various Linux automation scripts
- 📦 **Development Utilities** - Tools for developers

Visit our website: [https://snokos.github.io/SnokOS/](https://snokos.github.io/SnokOS/)

---

## 🔄 Changelog

### Version 1.0.0 (2024-01-22)

#### ✨ Features
- ✅ Multi-language support (EN, FR, AR)
- ✅ Interactive installation wizard
- ✅ Web server selection (Apache2/Nginx)
- ✅ Database selection (MariaDB/MySQL)
- ✅ Complete and selective uninstall
- ✅ Automatic firewall configuration
- ✅ Beautiful UI with colors and icons
- ✅ Comprehensive error handling
- ✅ Detailed logging system
- ✅ Support for all Debian/Ubuntu distros
- ✅ PHP 8.2 with all extensions
- ✅ phpMyAdmin integration
- ✅ Responsive welcome page

---

## 🚀 Roadmap

### Planned Features

- [ ] SSL/TLS certificate setup (Let's Encrypt)
- [ ] Docker support
- [ ] Multiple PHP versions
- [ ] Redis/Memcached installation
- [ ] Git integration
- [ ] Composer installation
- [ ] Node.js installation
- [ ] WordPress quick install
- [ ] Laravel quick install
- [ ] Database backup automation
- [ ] Performance optimization presets
- [ ] Additional language support
- [ ] Web-based control panel

---

<div align="center">

### ⭐ Star this project if you find it useful!

**Made with ❤️ by [Mahrez Ben Mohammed](https://github.com/SnokOS) - SnokOS Team**

[Report Bug](https://github.com/SnokOS/Install_Web_Server_Tools/issues) • [Request Feature](https://github.com/SnokOS/Install_Web_Server_Tools/issues) • [Documentation](https://github.com/SnokOS/Install_Web_Server_Tools/wiki)

---

### Connect with SnokOS

[![GitHub](https://img.shields.io/github/followers/SnokOS?label=Follow&style=social)](https://github.com/SnokOS)
[![Website](https://img.shields.io/badge/Visit-Website-blue)](https://snokos.github.io/SnokOS/)
[![Email](https://img.shields.io/badge/Contact-Email-red)](mailto:SnokSoft@gmail.com)

**© 2024 SnokOS. All rights reserved.**

</div>
