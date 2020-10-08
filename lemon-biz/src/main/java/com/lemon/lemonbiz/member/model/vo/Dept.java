package com.lemon.lemonbiz.member.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Dept {

	private int key;
	private int ref;
	private String name;
	private int deptLevel;
	
	private String refName;
	
}
