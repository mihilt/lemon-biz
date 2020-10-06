package com.lemon.lemonbiz;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

/**
 * Handles requests for the application home page.
 */
@Controller
@SessionAttributes({ "loginMember" })
public class HomeController {

	private static Logger log = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		if (model.containsAttribute("loginMember")) {
			log.debug("/요청, loginMember세션 존재");
			return "forward:/WEB-INF/views/main/main.jsp";
		} else {
			log.debug("/요청, loginMember세션 없음");
			return "redirect:/member/memberLogin.do";
		}

	}

}
