# apollo-drupal-commerce-kickstart

Creates a [Docker](https://www.docker.com/) container for showcasing the popular [Commerce Kickstart](https://commerceguys.com/product/commerce-kickstart) Drupal distribution.
This is used as an example demonstrator for [Apollo](https://github.com/Capgemini/Apollo).

The image contains the following -

* PHP 5.5 + Apache
* Composer
* Drush 6
* Commerce Kickstart (7.x-2.23)

The image must be linked with a database container (e.g. mysql).

## Usage

### Building with Docker compose

- Ensure you have Docker and Docker compose installed. See [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/) to get started. If you are using Mac you will probably need to install [boot2docker](http://boot2docker.io/)
- Build the Dockerfile:

```
git clone https://github.com/Capgemini/apollo-drupal-commerce-kickstart.git
cd apollo-drupal-commerce-kickstart
docker-compose build
```

- Run the Docker image

```
docker-compose up -d
```

This should bring up 2 containers, 1 Drupal Commerce Kickstart/PHP/Apache and a second MySQL
container. Both containers should be linked and the Commerce Kickstart distribution should be installed (via Drush) on startup.

### Building the image standalone

```
docker run --rm --name commerce_kickstart --link db:mysql tayzlor/apollo-commerce-kickstart:latest
```

...where db:mysql matches the name and alias of your DB instance. The values from your linked DB instance will be used to complete the setup.

Once the container is up browse to port 80 on the container to view the site.
