package com.lemon.lemonbiz.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Dept1 {

	private int key;
	private int ref;
	private String name;
	private int deptLevel;
	
	private String refName;
	
}
