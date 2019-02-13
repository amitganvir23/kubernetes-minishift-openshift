package com.example.hello;

import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.web.bind.annotation.*;

@RestController
@EnableAutoConfiguration
public class HelloApplication {

	@RequestMapping("/")
	String home() {
		return "Hello World, This is Gradle build java application without hardcoding server port";
	}

	public static void main(String[] args) throws Exception {
		SpringApplication.run(HelloApplication.class, args);
	}

}
