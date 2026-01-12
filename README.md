# Inception

A Docker Compose project that sets up a complete web infrastructure with NGINX, WordPress, and MariaDB using custom Docker images.

## Project Structure

```
inception/
├── Makefile                              # Build automation
├── README.md                            # Project documentation
└── srcs/
    ├── docker-compose.yml              # Main compose configuration
    └── requirements/
        ├── mariadb/                    # MariaDB database service
        │   ├── Dockerfile
        │   └── tools/
        │       └── script.sh
        ├── nginx/                      # NGINX web server
        │   ├── Dockerfile
        │   └── conf/
        │       └── nginx.conf
        └── wordpress/                  # WordPress CMS
            ├── Dockerfile
            └── tools/
                └── script.sh
```

## Services

### NGINX
- **Port**: 443 (HTTPS only)
- **SSL**: Self-signed certificate with TLSv1.3
- **Function**: Reverse proxy and web server
- **Config**: Custom nginx.conf with PHP-FPM integration

### WordPress
- **Base**: Debian Bullseye
- **PHP**: PHP 7.4 with FPM
- **Features**: 
  - WP-CLI for automated setup
  - Admin and regular user creation
  - Database integration with MariaDB

### MariaDB
- **Port**: 3306
- **Features**:
  - Custom database and user creation
  - Root password configuration
  - Health checks for service dependencies

## Prerequisites

- Docker and Docker Compose installed
- Environment file (`.env`) in the `srcs/` directory
- Host directories for persistent data:
  - `/home/souaouri/data/mariadb`
  - `/home/souaouri/data/wordpress`

## Environment Variables

Create a `.env` file in the `srcs/` directory with the following variables:

```env
# Database Configuration
db_name=your_database_name
db_user=your_db_user
db_pwd=your_db_password
root_pwd=your_root_password

# WordPress Configuration
domain_name=your_domain.com
wp_admin_name=admin_username
wp_admin_pwd=admin_password
wp_admin_email=admin@example.com
wp_user_name=regular_user
wp_user_email=user@example.com
wp_user_role=author
wp_user_pwd=user_password
```

## Usage

### Start the services
```bash
make up
```

### Stop the services
```bash
make down
```

### Clean rebuild (removes all data and images)
```bash
make fclean
```

### Restart from scratch
```bash
make re
```

## Network Architecture

- **Network**: Custom bridge network named `inception`
- **Communication**: 
  - NGINX ↔ WordPress: HTTP on port 9000 (PHP-FPM)
  - WordPress ↔ MariaDB: MySQL on port 3306
- **External Access**: HTTPS on port 443 only

## Volumes

- **MariaDB Data**: Persistent storage at `/home/souaouri/data/mariadb`
- **WordPress Files**: Persistent storage at `/home/souaouri/data/wordpress`
- Both volumes use bind mounts for data persistence

## Security Features

- HTTPS only (no HTTP)
- Self-signed SSL certificates
- TLSv1.3 protocol
- Custom user creation for database access
- Proper file permissions for WordPress

## Troubleshooting

### Service won't start
Check the health status and logs:
```bash
docker compose -f ./srcs/docker-compose.yml ps
docker compose -f ./srcs/docker-compose.yml logs [service_name]
```

### Permission issues
Ensure the data directories exist and have proper permissions:
```bash
sudo mkdir -p /home/souaouri/data/{mariadb,wordpress}
sudo chown -R $(whoami):$(whoami) /home/souaouri/data
```

### Database connection issues
Verify the MariaDB service is healthy and environment variables are correct in the `.env` file.

## Development

Each service is built from a custom Dockerfile with specific configurations for the Inception project requirements. The setup ensures:

- No use of pre-built images (except base Debian)
- Proper service dependencies with health checks
- Automated WordPress installation and configuration
- Secure HTTPS-only communication