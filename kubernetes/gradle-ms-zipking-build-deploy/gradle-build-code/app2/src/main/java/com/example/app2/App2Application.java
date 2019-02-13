package com.example.app2;

import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.web.bind.annotation.*;

@RestController
@EnableAutoConfiguration
public class App2Application {

	@RequestMapping("/")
	String home() {
		return "Hello World, This is Gradle build java application without zipkin";
	}

	public static void main(String[] args) throws Exception {
		SpringApplication.run(App2Application.class, args);
	}

}

