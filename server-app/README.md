# Server application


These instructions will get you a copy of the server application up and running on 
your local machine for development and testing purposes. 

## Prerequisites

To get the application running you will need the following software installed: 
1. [Git](https://git-scm.com/)
2. [Java](https://www.java.com/en/)
3. [Maven](https://maven.apache.org/)
4. [PostgreSQL](https://www.postgresql.org/)

### Installing

Clone the Git repository on your local machine. You can do this from command line by running the following command:

    git clone https://gitlab.com/fsentin/bsc-thesis.git

Now you should have all the files you need on your local system.

Based on the desired data base configuration, also feel free to adjust your `spring.jpa.hibernate.ddl-auto` property inside `src/main/resources/application.properties` file.


To run the app from the command line position yourself in the project directory and run the following:

    mvn spring-boot:run


It starts the application on http://localhost:8080.

An interactive list of all _RESTful_ routes you can try is available at http://localhost:8080/swagger-ui.html. 


You can also test the routes regularly from your local browser or any testing tool such as [Postman](https://www.postman.com/).

For further development, import the project in IDE such as [IntelliJ IDEA](https://www.jetbrains.com/idea/) or [Eclipse](https://www.eclipse.org/downloads/packages/).

