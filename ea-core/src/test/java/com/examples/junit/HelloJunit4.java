package com.examples.junit;

import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.lessThan;
import static org.hamcrest.Matchers.not;
import static org.junit.Assert.assertThat;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.Test;


public class HelloJunit4 {
	/*@Test	*/

	@Ignore
	public void testApp1() {
		System.out.println("用JUnit4 Annotation屏蔽");

	}

	@Test
	public void testApp2() {
		assertThat("必须相等", "xx", is("xx"));
		assertThat("yy", is(not("xx")));
		assertThat("i like cheese", containsString("cheese"));
		//assertThat(z, is(8));
		//assertThat(z, allOf(greaterThan(5), lessThan(10)));
	}

	@BeforeClass
	public static void beforeClass() {
		System.out.println("beforeClass");
	}

	@AfterClass
	public static void afterClass() {
		System.out.println("afterClass");
	}

	@Before
	public void before() {
		System.out.println("before");
	}



	@After
	public void after() {
		System.out.println("after");

	}
}
