# contenta
developed by drunomics GmbH, office@drunomics.com

This project is maintained using composer. Please refer to the documentation provided at https://github.com/drupal-composer/drupal-project and https://www.drupal.org/node/2471553.

## Project setup

 * Run `vagrant up` (see Vagrant section below).
 * `drush dpsetup` takes care of setting the project up automatically. In order
 to do do it manually, you need to:

   * Go into web/sites/default and link settings.vagrant.php to settings.php
   ```
   cd web/sites/default
   ln -s settings.vagrant.php settings.php
   ```

 * If you cannot use the drunomics vagrant environment, you need to customize
   the provided settings.php. Instead of linking the settings.vagrant.php, copy
   it to settings.php and customize it to your needs. Usually, you'd have to
   customize the database connection and the 'trusted_host_patterns'.  
   
## drunomics setup notes

- The vagrant setup is added in the project, thus no special setup is required.
- The drunomics drush extension is *not* added to the project. It does *not*
  work with drush 9.

## Command line tools

 * Drush
 To run drush, execute from the root repository directory:
 ```./vendor/bin/drush ```

 The more convenient alternative is to install a global launcher or a global
 drush 8. Then, drush picks up the project-local drush automatically. For docs on
 drush see http://docs.drush.org/en/master/.

## Useful commands

 Initial install (without existing config):
 ```
 cd web
 chmod +w sites/default/settings.php; drush sql-create -y && \
   drush site-install --account-name=dru_admin --account-pass=dru_admin -y minimal
 ```

Site install (with existing config):
```
drush dsi
```

Build the application and update install with upstream code/config changes:
```drush deploy```

Update install with upstream code/config changes:
```drush update```

Build the application, i.e. run composer install and build the theme assets.
```drush build```

Config export (export your config changes):
```drush cex -y```

Config import (manual import of config files):
```drush cim -y```

Cache clear/rebuild:
```drush cr```

See all the defined aliases:
```drush sha```


## Coding style

To check the coding style for the project's custom code, run PHP code sniffer:

    composer cs

To automatically fix the coding style errors (as far as possible), run the PHP
code beautifier:

    composer cbf

### Pre-commit checks

Coding style can be checked automatically via Git's pre-commit hooks. To do so, just make sure to run the script `devsetup/setup-git-config.sh` at least once.

Once configured, running pre-commit hooks can be bypassed via the Git commmit
`--no-verify` option.

### PHPstorm coding style configuration

Configure the following settings:
* Under Languages / PHP / Code Sniffer
  - Select "local" configuration and make it point to `vendor/bin/phpcs`).
* Under Editor / Inspections / PHP Code Sniffer validation:
  - Select "warning" as severity.
  - Show warnings as "warning"
  - Show sniff name "true"
  - Coding standard: "custom", make it point to the phpcs.xml.dist file in the
    vcs root.

## Vagrant

The following describes the local development using Vagrant.

### Prerequesites
 
 - Make sure latest docker and vagrant versions are installed.
 - Make sure necessary vagrant plugins are installed:
 
       vagrant plugin install vagrant-hosts-provisioner

### Using vagrant

  You can access the site http://contenta.local. The project name is
  defined in devsetup/project.yml.

 * vagrant up - Starts the container.
 * vagrant halt - Stops the container
 * vagrant reload - Restarts the container.
 * vagrant provision - Provisions the container again.
