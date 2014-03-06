package com.examples.aop.advice.hello;


import org.springframework.stereotype.Component;
@Component("impHello") 
public class ImpHello implements InfHello{

	public String getHelloString() {
		String hello="hello,spring! 组件重用";
		System.out.println(hello);
		return hello;
	}

}
