package com.lemon.lemonbiz.notice.model.vo;

import java.util.Date;

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
public class Notice {

	private int key;
	private String memId;
	private String content;
	private Date noticeDate;
	private int isChecked;
	private String address;
	private String icon;
	private String color;
	
}
