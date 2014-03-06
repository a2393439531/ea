package com.examples.aop;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.examples.aop.advice.hello.InfHello;


public class RunAop {
	protected static ApplicationContext applicationContext;

	/**
	 * Spring的Pointcut分为 
	 * 1.静态Pointcut(其中静态Pointcut只是需要考虑类名、方法名；) 
	 * 2.动态Pointcut (动态Pointcut除此之外，还要考虑方法的参数，以便在运行时可以动态的确定切入点的位置。)
	 * 3.用户自定义Pointcut三种，
	 Spring中切入点的粒度是方法级，因此在Spring AOP中Pointcut的作用是配置哪些类中哪些方法在我们定义的且入点之内、哪些方法应该被过滤排除
	 */
	public static void main(String[] args) {
		String configFile = "spring-test-aop.xml";
		applicationContext = new ClassPathXmlApplicationContext(configFile);

		 InfHello infHello=(InfHello) applicationContext.getBean("infHello");
		 infHello.getHelloString();

	}

}
