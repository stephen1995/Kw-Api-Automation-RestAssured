package com.kwri.auto.om.run;

import com.kwri.auto.core.extension.CukesInjectableModule;
import com.kwri.auto.http.extension.AbstractCukesHttpModule;
import com.kwri.auto.rest.internal.PreprocessRestRequestBody;

@CukesInjectableModule
public class CukesRestGuiceModule extends AbstractCukesHttpModule {

    @Override
    protected void configure() {
        registerHttpPlugin(PreprocessRestRequestBody.class);
    }
}
