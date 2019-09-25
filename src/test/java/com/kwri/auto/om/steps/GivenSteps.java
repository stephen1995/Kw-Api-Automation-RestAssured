package com.kwri.auto.om.steps;

import java.util.List;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import com.kwri.auto.core.CukesDocs;
import com.kwri.auto.core.CukesOptions;
import com.kwri.auto.core.facade.MathFacade;
import com.kwri.auto.core.facade.RandomGeneratorFacade;
import com.kwri.auto.core.facade.VariableFacade;
import com.kwri.auto.core.internal.context.GlobalWorldFacade;
import com.kwri.auto.core.internal.resources.ResourceFileReader;
import com.kwri.auto.http.facade.HttpRequestFacade;
import com.kwri.auto.rest.facade.RestRequestFacade;

import cucumber.api.DataTable;
import cucumber.api.java.en.Given;
import io.restassured.http.ContentType;

@Singleton
public class GivenSteps {

    @Inject
    HttpRequestFacade httpFacade;
    
    @Inject
    RestRequestFacade restFacade;

    @Inject
    ResourceFileReader reader;
    
    @Inject
    VariableFacade variableFacade;
    
    @Inject
    RandomGeneratorFacade randomGeneratorFacade;

	@Inject
	MathFacade mathFacade;

    @Inject
    GlobalWorldFacade world;

    @Given("^baseUri is \"(.+)\"$")
    public void base_Uri_Is(String url) {
        this.httpFacade.baseUri(url);
    }

	@Given("^proxy settings are \"(http|https)://([^:]+)(?::(\\d+))?\"$")
	public void proxy(String scheme, String host, Integer port) {
		this.httpFacade.proxy(scheme, host, port);
	}

	@Given("^param \"(.+)\" \"(.+)\"$")
	public void param(String key, String value) {
		this.httpFacade.param(key, value);
	}

	@Given("^accept \"(.+)\" mediaTypes$")
	public void accept(String mediaTypes) {
		this.httpFacade.accept(mediaTypes);
	}

	@Given("^accept mediaType is JSON$")
	public void acceptJson() {
		this.httpFacade.accept(ContentType.JSON.toString());
	}

	@Given("^content type is JSON$")
	public void content_Type_Json() {
		this.httpFacade.contentType(ContentType.JSON.toString());
	}

	@Given("^content type is \"(.+)\"$")
	public void content_Type(String contentType) {
		this.httpFacade.contentType(contentType);
	}

	@Given("^queryParam \"(.+)\" is \"(.+)\"$")
	public void query_Param(String key, String value) {
		this.httpFacade.queryParam(key, value);
	}

	@Given("^session ID is \"(.+)\"$")
	public void session_ID(String sessionId) {
		this.httpFacade.sessionId(sessionId);
	}

	@Given("^session ID \"(.+)\" with value \"(.+)\"$")
	public void session_ID_With_Value(String sessionId, String value) {
		this.httpFacade.sessionId(sessionId, value);
	}

	@Given("^cookie \"(.+)\" with value \"(.+)\"$")
	public void cookie_With_Value(String cookie, String value) {
		this.httpFacade.cookie(cookie, value);
	}

//	@Given("^header ([^\"]+) with value \"(.+)\"$")
//	public void header_With_Value(String name, String value) {
//		this.httpFacade.header(name, value);
//	}
	
	@Given("^header \"(.+)\" with value \"(.+)\"$")
	public void header_With_Value(String name, String value) {
		this.httpFacade.header(name, value);
	}

	@Given("^overwrite header ([^\"]+) with value \"(.+)\"$")
	public void overwrite_header_With_Value(String name, String value) {
		this.httpFacade.overwriteHeader(name, value);
	}

	@Given("^username \"(.+)\" and password \"(.+)\"$")
	public void authentication(String username, String password) {
		this.httpFacade.authentication(username, password);
	}

	@Given("^authentication type is \"(.+)\"$")
	public void authentication(String authenticationType) {
		this.httpFacade.authenticationType(authenticationType);
	}

	@Given("^formParam \"(.+)\" is \"(.+)\"$")
	public void form_Param(String key, String value) {
		this.restFacade.formParam(key, value);
	}

	@Given("^request body \"(.+)\"$")
	public void request_Body(String body) {
		this.restFacade.setRequestBody(body);
	}

	@Given("^request body:$")
	public void request_Body_From_Object(String body) {
		this.restFacade.setRequestBody(body);
	}

	@Given("^request body from static file \"(.+)\"$")
	public void request_Body_From_File(String path) {
		this.restFacade.setRequestBody(this.reader.read(path));
	}

	@Given("^request body from file \"([^\"]*)\" with values \"([^\"]*)\"$")
	public void request_body_from_file_with_values(String path, String values, DataTable data) throws Throwable {
		List<List<String>> fields = data.raw();
		this.restFacade.setRequestBody(this.reader.readFileAndReplace(path, values, fields));
	}

	@Given("^request body from binary file \"(.+)\"$")
	public void request_Body_From_Binary_File(String path) {
		this.restFacade.body(this.reader.readBytes(path));
	}

	@Given("^request body is a multipart file \"(.+)\"$")
	public void request_Body_Is_A_Multipart_File(String path) {
		this.restFacade.multiPart(this.reader.readBytes(path), "file", "application/octet-stream");
	}

	@Given("^request body is a multipart with control \"(.+)\" from file \"(.+)\"$")
	public void request_Body_Is_A_Multipart_File_With_Control(String control, String path) {
		this.restFacade.multiPart(this.reader.readBytes(path), control);
	}

	@Given("^request body is a multipart with mime-type \"(.+)\" and control \"(.+)\" from file \"(.+)\"$")
	public void request_Body_Is_A_Multipart_File_With_Control_Of_Type(String mimeType, String control, String path) {
		this.restFacade.multiPart(this.reader.readBytes(path), control, mimeType);
	}

	@Given("^request body is a multipart string \"(.+)\" with control \"(.+)\"$")
	public void request_Body_Is_A_Multipart_String_With_Control(String contentBody, String control) {
		this.restFacade.multiPart(contentBody, control);
	}

	@Given("^request body is a multipart string \"(.+)\" with mime-type \"(.+)\" and control \"(.+)\"$")
	public void request_Body_Is_A_Multipart_String_With_Control_Of_Type(String contentBody, String mimeType,
			String control) {
		this.restFacade.multiPart(contentBody, control, mimeType);
	}

	@Given("^let variable \"(.+)\" to be random UUID$")
	@CukesDocs("Generates random UUID and assigns it to a variable")
	public void var_random_UUID(String varName) {
		this.variableFacade.setUUIDToVariable(varName);
	}

	@Given("^let variable \"(\\S+)\" to be random password by matching pattern \"([Aa0]+)\"$")
	@CukesDocs("Generates random password by given pattern. Pattern may contain symbils a,A,0. "
			+ "So A is replaced with random capital letter, a - with random letter and 0 - with random number")
	public void var_random_password_by_pattern(String variableName, String pattern) {
		this.variableFacade.setVariable(variableName, this.randomGeneratorFacade.byPattern(pattern));
	}

	@Given("^let variable \"(\\S+)\" to be random password with length (\\d+)$")
	@CukesDocs("Generates random password with given length")
	public void var_randomPassword_by_length(String variableName, int length) {
		this.variableFacade.setVariable(variableName, this.randomGeneratorFacade.withLength(length));
	}

    @Given("^let variable \"(.+)\" equal to \"(.+)\"$")
    public void var_assigned(String varName, String value) {
        this.variableFacade.setVariable(varName, value);
    }

    @Given("^let variable \"([^\"]*)\" equal to current timestamp$")
    public void letVariableBeEqualToCurrentTimestamp(String varName) {
        this.variableFacade.setCurrentTimestampToVariable(varName);
    }

	@Given("^let variable \"([^\"]*)\" equal to index of current month$")
	public void let_variable_equal_to_index_of_current_month(String varName) {
		this.variableFacade.setCurrentMonthIndexToVariable(varName);
	}

	@Given("^let variable \"(.+)\" equal to math operation (.+) of \"(.+)\" and \"(.+)\"$")
	public void let_var_equals_to_math_operation(String varName, String operator, String firstValue, String secondValue) {
		String value = String.valueOf(mathFacade.calculation(operator, firstValue, secondValue));
		this.variableFacade.setVariable(varName, value);
	}

    @Given("^value assertions are case-insensitive$")
    public void val_caseInsensitive() {
        this.world.put("case-insensitive", "true");
    }

    @Given("^resources root is \"(.+)\"$")
    public void resources_Root_Is(String url) {
        var_assigned(CukesOptions.RESOURCES_ROOT, url);
    }
}
