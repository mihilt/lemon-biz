package com.lemon.lemonbiz.approval.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;



@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class approval {
	
	private String key;
	private int typeKey;
	private String memId;
	private String title;
	private String content;
	private Date draftDate;
	private Date writeDate;
	private String status;
	private int IsDeleted;
	
}
