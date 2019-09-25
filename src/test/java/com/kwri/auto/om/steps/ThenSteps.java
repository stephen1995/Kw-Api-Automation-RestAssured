package com.kwri.auto.om.steps;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import com.kwri.auto.core.facade.MathFacade;
import com.kwri.auto.core.internal.context.InflateContext;
import com.kwri.auto.core.internal.resources.ResourceFileReader;
import com.kwri.auto.http.facade.HttpAssertionFacade;

import cucumber.api.java.en.Then;

@Singleton
@InflateContext
public class ThenSteps {

	@Inject
	private HttpAssertionFacade assertionFacade;

	@Inject
	private ResourceFileReader fileReader;
	
	@Inject
	private MathFacade mathFacade;

	@Then("^let variable \"(.+)\" equal to header \"(.+)\" value$")
	public void var_assigned_from_header(String varName, String headerName) {
		this.assertionFacade.varAssignedFromHeader(varName, headerName);
	}

	@Then("^let variable \"(.+)\" equal to property \"(.+)\" value$")
	public void var_assigned_fromProperty(String varName, String property) {
		this.assertionFacade.varAssignedFromProperty(varName, property);
	}

	@Then("^let variable \"(.+)\" equal to response body")
	public void var_assigned_fromBody(String varName) {
		this.assertionFacade.varAssignedFromBody(varName);
	}

	@Then("^response is empty$")
	public void response_Body_Is_Empty() {
		this.assertionFacade.bodyEqualTo("");
	}

	@Then("^response is not empty$")
	public void response_Body_Is_Not_Empty() {
		this.assertionFacade.bodyNotEmpty();
	}

	@Then("^response equals to \"(.*)\"$")
	public void response_Body_Equal_To(String body) {
		this.assertionFacade.bodyEqualTo(body);
	}

	@Then("^response body not equal to \"(.*)\"$")
	public void response_Body_Not_Equal_To(String body) {
		this.assertionFacade.bodyNotEqualTo(body);
	}

	@Then("^response contains \"(.+)\"$")
	public void response_Body_Contains(String body) {
		this.assertionFacade.bodyContains(body);
	}

	@Then("^response body does not contain \"(.+)\"$")
	public void response_Body_Does_Not_Contain(String body) {
		this.assertionFacade.bodyDoesNotContain(body);
	}

	@Then("^response contains property \"(.+)\" containing phrase \"(.*)\"$")
	public void response_Body_Contains_Property_With_Phrase(String jsonPath, String phrase) {
		this.assertionFacade.bodyContainsJsonPathValueContainingPhrase(jsonPath, phrase);
	}

	@Then("^response contains property \"(.+)\" with value \"(.*)\"$")
	public void response_Body_Contains_Property(String path, String value) {
		this.assertionFacade.bodyContainsPathWithValue(path, value);
	}

	@Then("^response contains property \"(.+)\" with value:$")
	public void response_Body_Contains_Property_Multiline(String path, String value) {
		this.assertionFacade.bodyContainsPathWithValue(path, value);
	}

	@Then("^response contains property \"(.+)\" with value other than \"(.*)\"$")
	public void response_Body_Contains_Property_Other_Value(String path, String value) {
		this.assertionFacade.bodyContainsPathWithOtherValue(path, value);
	}

	@Then("^response contains property \"(.+)\" of type \"(.+)\"$")
	public void response_Body_Contains_Property_Of_Type(String path, String type) {
		this.assertionFacade.bodyContainsPathOfType(path, type);
	}

	@Then("^response contains an array \"(.+)\" of size (>=|>|<=|<|<>) (\\d+)$")
	public void response_Body_Contains_Array_With_Operator_Size(String path, String operator, Integer size) {
		this.assertionFacade.bodyContainsArrayWithSize(path, operator + size);
	}

	@Then("^response contains an array \"(.+)\" of size (\\d+)$")
	public void response_Body_Contains_Array_With_Size(String path, Integer size) {
		this.assertionFacade.bodyContainsArrayWithSize(path, size.toString());
	}

	@Then("^response contains an array \"([^\"]+)\" with value \"(.*)\"$")
	public void response_Body_Contains_Array_With_Property(String path, String value) {
		this.assertionFacade.bodyContainsArrayWithEntryHavingValue(path, value);
	}

	@Then("^response does not contain property \"(.+)\"")
	public void response_Body_Does_Not_Contain_Property(String path) {
		this.assertionFacade.bodyDoesNotContainPath(path);
	}

	@Then("^response contains property \"(.+)\" matching pattern \"(.+)\"$")
	public void response_Body_Contains_Property_Matching_Pattern(String path, String pattern) {
		this.assertionFacade.bodyContainsPathMatchingPattern(path, pattern);
	}

	@Then("^response contains property \"(.+)\" not matching pattern \"(.+)\"$")
	public void response_Body_Contains_Property_Not_Matching_Pattern(String path, String pattern) {
		this.assertionFacade.bodyContainsPathNotMatchingPattern(path, pattern);
	}

	@Then("^response contains properties from file \"(.+)\"$")
	public void response_Body_Contains_Properties_From_File(String path) {
		this.assertionFacade.bodyContainsPropertiesFromJson(this.fileReader.read(path));
	}

	@Then("^response contains properties from json:$")
	public void response_Body_Contains_Properties_From(String str) {
		this.assertionFacade.bodyContainsPropertiesFromJson(str);
	}

	@Then("^status code is (.+)$")
	public void response_Status_Code_Is(int statusCode) {
		this.assertionFacade.statusCodeIs(statusCode);
	}

	@Then("^status code is not (\\d+)$")
	public void response_Status_Code_Is_Not(int statusCode) {
		this.assertionFacade.statusCodeIsNot(statusCode);
	}

	@Then("^header \"(.+)\" is empty$")
	public void header_Is_Empty(String headerName) {
		this.assertionFacade.headerIsEmpty(headerName);
	}

	@Then("^header \"(.+)\" is not empty$")
	public void header_Is_Not_Empty(String headerName) {
		this.assertionFacade.headerIsNotEmpty(headerName);
	}

	@Then("^header \"(.+)\" equal to \"(.+)\"$")
	public void header_Equal_To(String headerName, String value) {
		this.assertionFacade.headerEqualTo(headerName, value);
	}

	@Then("^header \"(.+)\" not equal to \"(.+)\"$")
	public void header_Not_Equal_To(String headerName, String value) {
		this.assertionFacade.headerNotEqualTo(headerName, value);
	}

	@Then("^header \"(.+)\" contains \"(.+)\"$")
	public void header_Contains(String headerName, String text) {
		this.assertionFacade.headerContains(headerName, text);
	}

	@Then("^header \"(.+)\" does not contain \"(.+)\"$")
	public void header_Does_Not_Contain(String headerName, String text) {
		this.assertionFacade.headerDoesNotContain(headerName, text);
	}

	@Then("^header \"(.+)\" ends with pattern \"(.+)\"$")
	public void header_Ends_With(String headerName, String suffix) {
		this.assertionFacade.headerEndsWith(headerName, suffix);
	}

	@Then("a failure is expected")
	public void a_failure_is_expected() {
		this.assertionFacade.failureIsExpected();
	}

	@Then("^it fails with \"(.+)\"$")
	public void it_fails(String exceptionClass) {
		this.assertionFacade.failureOccurs(exceptionClass);
	}

	@Then("^response contains an array \"([^\"]+)\" with object having property \"(.+)\" with value \"(.+)\"$")
	public void responseBodyContainsArrayWithObjectHavingProperty(String path, String property, String value) {
		this.assertionFacade.bodyContainsArrayWithObjectHavingProperty(path, property, value);
	}

	@Then("^variable \"(.+)\" is set to \"(.+)\"$")
	public void variableIsSet(String variableName, String variableValue) {
		System.out.println(variableName + "=" + variableValue);
	}

	@Then("^variable \"(.+)\" equal to math operation (.+) of \"(.+)\" and \"(.+)\"$")
	public void var_equals_to_math_operation(String expected, String operator, String firstValue, String secondValue) {
		double doubleExpected = Double.valueOf(expected);
		double actual = mathFacade.calculation(operator, firstValue, secondValue);
		org.junit.Assert.assertEquals(doubleExpected, actual, 0.1);
	}
	
	@Then("^variable \"(.+)\" equal to new average of \"(.+)\" old count \"(.+)\" operator (.+) new value \"(.+)\" and new count \"(.+)\"$")
	public void var_equal_to_new_average(String expAvg, String oldAvg, String oldCount, String operator, String newValue, String newCount) {
		String oldSum = String.valueOf(mathFacade.calculation("*", oldAvg, oldCount));
		String newSum = String.valueOf(mathFacade.calculation("*", newValue, newCount));
		
		if (operator.equals("-") && oldCount.equals(newCount))
			oldCount = String.valueOf(Integer.valueOf(oldCount) + 1);
		
		double result = mathFacade.calculation(operator, oldSum, newSum)/mathFacade.calculation(operator, oldCount, newCount);
		result = Math.ceil(result * 10)/10;
		org.junit.Assert.assertEquals(Double.valueOf(expAvg), result, 0.9);
	}
	
	@Then("^variable \"(.+)\" equal to ratio of \"(.+)\" \"(.+)\" \"(.+)\" and \"(.+)\" \"(.+)\" \"(.+)\"$")
	public void variable_equal_to_ratio_of_and(String exp, String appNum, String activeNum, String contractNum, String appDenom, String activeDenom, String contractDenom) {
		double numTotal = Double.valueOf(appNum) + Double.valueOf(activeNum) + Double.valueOf(contractNum);
		double denomTotal = Double.valueOf(appDenom) + Double.valueOf(activeDenom) + Double.valueOf(contractDenom);
		double ratio = (numTotal * 100) / (numTotal + denomTotal);
		ratio = Math.round(ratio);
		ratio = ratio / 100;
		org.junit.Assert.assertEquals(Double.valueOf(exp), ratio, 0);
	}
}
