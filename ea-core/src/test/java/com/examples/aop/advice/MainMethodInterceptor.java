package com.examples.aop.advice;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
@Aspect
@Component("mainMethodInterceptor")
public class MainMethodInterceptor implements MethodInterceptor {
	public Object invoke(MethodInvocation invocation) throws Throwable {
		Object result = null;
		//String stu_name = invocation.getArguments()[0].toString();
		
		/*
		if (stu_name.equals("dragon")) {
			result = invocation.proceed();

		} else {
			System.out.println("拦截参数" + stu_name + "");
		}
		*/
		result = invocation.proceed();
        System.out.println("方法拦截器");
		return result;
	}
}
