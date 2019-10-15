package com.kwri.auto.om.run;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

import org.junit.BeforeClass;
import org.junit.runner.RunWith;


@RunWith(Cucumber.class)
@CucumberOptions(
		plugin = { "pretty", "json:target/cucumber.json" },
		features = { "classpath:features/" },
		glue = "com.kwri.auto",
		tags = "@testing1",
		strict = true, 
		monochrome = true
	)


public class RunCukesTest {

    @BeforeClass
    public static void setUp() throws Exception {

    }
}
