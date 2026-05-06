# Learning course Learning Spring 6 with Spring Boot 3
This is the repository for the LinkedIn Learning course Learning course Learning Spring 6 with Spring Boot 3. The full course is available from [LinkedIn Learning][URL-lil-course].

![Learning course Learning Spring 6 with Spring Boot 3][URL-lil-thumbnail]

Spring is the hugely popular framework for developing Java applications in the enterprise space. In this course, discover how to leverage Spring Boot 3, which takes an opinionated view of the latest version of the platform: Spring 6.

Follow along with Frank Moley as he gives you an overview of how to use Spring Boot 3 to develop a practical, enterprise-style web application quickly and efficiently. As Frank explains how to develop the app, he helps to familiarize you more generally with the core features and extensive functionalities of the Spring 3 framework. Along the way, Frank dives into some of the basic projects of Spring that you can use, highlighting examples and best practices for building Java-based applications.

### Instructor
Frank Moley

[URL-lil-course]: https://www.linkedin.com/learning/learning-spring-6-with-spring-boot-3
[URL-lil-thumbnail]: https://media.licdn.com/dms/image/D560DAQHIALbX3heJRg/learning-public-crop_675_1200/0/1700601834997?e=2147483647&v=beta&t=eZfhZ7wgSSrsW1pW26fsca5DNZlPiND3jqKqnY3cJS4

## For local Docker image, hereare the commands and notes to think about
Note: to auto-initialize the database from a chapter's SQL, uncomment the docker-compose.yml init mounts and point them at the chapter's bin/postgresql/schema.sql and data.sql. Would you like me to add a Dockerfile and wire landon-hotel into docker-compose.yml?


# Start (PowerShell):
.\scripts\start.ps1

# Force reinitialize DB (removes volume, re-runs init scripts):
docker-compose down -v.\scripts\start.ps1

# Bash/WSL equivalents:
bash scripts/start.shdocker-compose down -vbash scripts/start.sh

# Verify Postgres logs:
docker logs lil_postgres --tail 200

# Build & start everything (one-shot):
docker-compose up -d --build
