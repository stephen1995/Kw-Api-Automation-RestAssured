package com.kwri.auto.om.steps;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import com.kwri.auto.http.facade.HttpResponseFacade;

import cucumber.api.java.en.When;

@Singleton
public class WhenSteps {

    @Inject
    HttpResponseFacade facade;

    @When("^the client performs (.+) request on \"(.+)\"$")
    public void perform_Http_Request(String httpMethod, String url) throws Throwable {
        facade.setResponsePrefix("");
        facade.doRequest(httpMethod, url);
    }
 
}
