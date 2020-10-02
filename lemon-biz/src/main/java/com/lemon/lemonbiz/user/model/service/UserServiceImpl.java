package com.lemon.lemonbiz.user.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.user.model.dao.UserDAO;


@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDAO userDAO;

	@Override
	public String test() {
		return userDAO.test();
	}
	
}
