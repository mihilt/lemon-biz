package com.lemon.lemonbiz.mail.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Mail {
	private int key;
	private String memId;
	private Date mailDate;
	private String title;
	private String content;
	private boolean isChecked;
}
