<p align="center">
<a href="http://krayincrm.com"><img src="https://bagisto.com/wp-content/uploads/2021/06/bagisto-logo.png" alt="Total Downloads"></a>
</p>

<p align="center">
<a href="https://packagist.org/packages/krayin/laravel-crm"><img src="https://poser.pugx.org/krayin/laravel-crm/d/total.svg" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/krayin/laravel-crm"><img src="https://poser.pugx.org/krayin/laravel-crm/v/stable.svg" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/krayin/laravel-crm"><img src="https://poser.pugx.org/krayin/laravel-crm/license.svg" alt="License"></a>
</p>

![enter image description here](https://raw.githubusercontent.com/krayin/temp-media/master/dashboard.png)

## Topics

1. [Introduction](#introduction)
1. [Documentation](#documentation)
1. [Docker Installation & Setup](#docker-installation--setup)
1. [Installation & Configuration](#manual-installation-and-configuration)
1. [License](#license)
1. [Security Vulnerabilities](#security-vulnerabilities)

### Introduction

[Krayin CRM](https://krayincrm.com) is a hand tailored CRM framework built on some of the hottest opensource technologies
such as [Laravel](https://laravel.com) (a [PHP](https://secure.php.net/) framework) and [Vue.js](https://vuejs.org)
a progressive Javascript framework.

**Free & Opensource Laravel CRM solution for SMEs and Enterprises for complete customer lifecycle management.**

**Read our documentation: [Krayin CRM Docs](https://devdocs.krayincrm.com/)**

**We also have a forum for any type of concerns, feature requests, or discussions. Please visit: [Krayin CRM Forums](https://forums.krayincrm.com/)**

# Visit our live [Demo](https://demo.krayincrm.com)

<a href="javascript:void();">
    <img class="flag-img" src="https://raw.githubusercontent.com/krayin/temp-media/master/visit-our-live-demo.png" alt="Chinese" width="100%">
</a>

It packs in lots of features that will allow your E-Commerce business to scale in no time:

-   Descriptive and Simple Admin Panel.
-   Admin Dashboard.
-   Custom Attributes.
-   Built on Modular Approach.
-   Email parsing via Sendgrid.
-   Check out [these features and more](https://krayincrm.com/features/).

**For Developers**:
Take advantage of two of the hottest frameworks used in this project -- Laravel and Vue.js -- both of which have been used in Krayin CRM.

### Documentation

#### Krayin Documentation [https://devdocs.krayincrm.com](https://devdocs.krayincrm.com)

### Docker Installation & Setup

Krayin CRM comes with Docker support for easy development and production deployment. The setup process is automated through shell scripts that handle database creation, dependency installation, and environment configuration.

> **📚 Additional Resources:**
>
> -   [Official Krayin Docker Documentation](https://devdocs.krayincrm.com/2.0/introduction/docker.html#introduction)
> -   [Krayin Docker GitHub Repository](https://github.com/krayin/krayin-docker)

#### Environment Configuration

Before running the setup scripts, you need to configure your environment files:

1. **Copy the example file** to create your environment files:

    ```bash
    cp .env.example .configs/.env
    cp .env.example .configs/.env.testing
    ```

2. **Edit `.configs/.env`** and update the following key settings:

    - **For Local Development**: Set `APP_ENV=local`, `APP_DEBUG=true`
    - **For Production**: Set `APP_ENV=production`, `APP_DEBUG=false`, and update `APP_URL`
    - **Database**: Use `DB_HOST=krayin-mysql` for Docker setup
    - **Other settings**: Configure mail, cache, and other services as needed

#### Running with Docker

##### For Local Development:

```bash
# Run the development setup script
./setup.sh
```

This script will:

-   Install all dependencies (including development tools like Laravel Debug Bar)
-   Run `migrate:fresh --seed` to create fresh database with sample data
-   Enable development features and debugging tools
-   ⚠️ **Warning**: This will drop existing data each time it's run

##### For Production Deployment:

```bash
# Run the production setup script
./setup-production.sh
```

This script will:

-   Install only production dependencies (`--no-dev` flag)
-   Run `migrate` (safe - only applies new migrations without dropping data)
-   Enable production optimizations (config/route/view caching)
-   Put application in maintenance mode during deployment
-   ✅ **Safe**: Preserves existing data and only applies new changes

### Manual Installation and Configuration

#### Requirements

-   **SERVER**: Apache 2 or NGINX.
-   **RAM**: 3 GB or higher.
-   **PHP**: 8.1 or higher
-   **For MySQL users**: 5.7.23 or higher.
-   **For MariaDB users**: 10.2.7 or Higher.
-   **Node**: 8.11.3 LTS or higher.
-   **Composer**: 2.5 or higher

##### Execute these commands below, in order

```
composer create-project
```

-   Find **.env** file in root directory and change the **APP_URL** param to your **domain**.

-   Also, Configure the **Mail** and **Database** parameters inside **.env** file.

```
php artisan krayin-crm:install
```

**To execute Krayin**:

##### On server:

Warning: Before going into production mode we recommend you uninstall developer dependencies.
In order to do that, run the command below:

> composer install --no-dev

```
Open the specified entry point in your hosts file in your browser or make an entry in hosts file if not done.
```

##### On local:

```
php artisan route:clear
php artisan serve
```

**How to log in as admin:**

> _http(s)://example.com/admin/login_

```
email:admin@example.com
password:admin123
```

### WhatsApp CRM Integration

[Krayin CRM WhatsApp](https://krayincrm.com/extensions/krayin-crm-whatsapp-extension/) Extension enables the store administrator to generate leads via their WhatsApp number.

![enter image description here](https://raw.githubusercontent.com/krayin/temp-media/master/krayin-crm-whatsapp-integration.png)

### VoIP CRM Integration

[Krayin CRM VoIP](https://krayincrm.com/extensions/krayin-crm-voip/) extension allows the user to make Trunk calls over a broadband Internet connection and the user can also perform Inbound routes.

![enter image description here](https://raw.githubusercontent.com/krayin/temp-media/master/krayin-voip.png)

### License

Krayin CRM is a truly opensource CRM framework which will always be free under the [OSL-3.0 License](https://github.com/krayin/laravel-crm/blob/master/LICENSE).

### Security Vulnerabilities

Please don't disclose security vulnerabilities publicly. If you find any security vulnerability in Krayin CRM then please email us: sales@krayincrm.com.
