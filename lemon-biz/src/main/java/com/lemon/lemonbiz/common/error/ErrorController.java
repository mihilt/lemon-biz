package com.lemon.lemonbiz.common.error;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorController {
    @RequestMapping(value="/error.do")
    public String error() {
    	return "forward:/WEB-INF/views/error/error.jsp";
    }
}
