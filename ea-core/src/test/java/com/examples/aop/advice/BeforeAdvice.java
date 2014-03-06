package com.examples.aop.advice;

import java.lang.reflect.Method;

import org.springframework.aop.MethodBeforeAdvice;


import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class BeforeAdvice implements MethodBeforeAdvice {

	public void before(Method method, Object[] args, Object target)
			throws Throwable {

		System.out.println(" 这是BeforeAdvice类的before方法. "+method.getName());

	}
}
