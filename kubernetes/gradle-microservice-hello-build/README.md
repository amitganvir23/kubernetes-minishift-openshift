##Java build gradle/maven creation for hello world

## micro service name: hello

Use spring framework library for making java application.

Step1: Download following URL for spring boot library.
https://start.spring.io/
Group: com.example
Artifact: hello
select: web

Step2: Extract your file:

Step3: Download and install JDK instead of JRE to compile and run the java application.

Step4: Make Global Environment Variable for JAVA_HOME in Windows.

Step5:  Ad following java code to run web application and print hello world.
$ cd hello/src/main/java/com/example/hello

-------------------------------- [filename: LedApplication.java]
$ cat ed\src\main\java\com\example\hello\HelloApplication.java  
package com.example.hello;

import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.web.bind.annotation.*;

@RestController
@EnableAutoConfiguration
public class HelloApplication {

	@RequestMapping("/")
	String home() {
		return "Hello World!";
	}

	public static void main(String[] args) throws Exception {
		SpringApplication.run(HelloApplication.class, args);
	}

}

Step6: Expose your application port number in application.properties file.

 $ cat src/main/resources/application.properties
  server.port=8081
$


Step7: Run Gradle build command and skip all tests from the test directory. It will build a jar file.
$ ls
  build.gradle  gradle/  gradlew*  gradlew.bat  settings.gradle  src/
$ gradle clean build -x test

Step8: Check your jar file of hello Micro service.
$ ls build/libs/
  hello-0.0.1-SNAPSHOT.jar
amit.ganvir@NAG1-LHP-N06546 MINGW64 /c/github-mine/gradle-project/hello
$

Step9: If you want to test your application then try to run below command to an application on your local machine.
Note: if dont specify server port in application.properties then it will take 8080 port or you can pass the paramter "-Dserver.port=<PORT>" to run app forcefully to another port even if we specified port in appication.properites file.

$ java -jar build/libs/hello-0.0.1-SNAPSHOT.jar
OR
$ java -Dserver.port=8082 -jar build/libs/hello-0.0.1-SNAPSHOT.jar

Step10: Now you can verify your application.
http://127.0.0.1:8081