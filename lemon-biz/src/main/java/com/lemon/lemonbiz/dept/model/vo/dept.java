package com.lemon.lemonbiz.dept.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class dept {

	private int key;
	private int ref;
	private String name;
	private int deptLevel;
}
