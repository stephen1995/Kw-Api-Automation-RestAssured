package com.kwri.auto.om.run;

import com.google.inject.Inject;
import com.kwri.auto.rest.facade.RestRequestFacade;

import cucumber.api.java.After;

public class CukesRestHooks {

    @Inject
    RestRequestFacade requestFacade;

    @After
    public void afterScenario() {
        requestFacade.initNewSpecification();
    }
}
