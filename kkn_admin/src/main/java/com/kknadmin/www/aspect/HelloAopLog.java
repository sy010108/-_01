package com.kknadmin.www.aspect;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class HelloAopLog {
    @Before("within(com.kknadmin.www.controller.*)")
    public void write1() {
        System.out.println("start");
    }
 
    @After("within(com.kknadmin.www.controller.*)")
    public void write2() {
        System.out.println("end");
    }
}