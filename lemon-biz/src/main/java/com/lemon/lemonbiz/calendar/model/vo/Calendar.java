package com.lemon.lemonbiz.calendar.model.vo;

import java.io.Serializable;

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
public class Calendar implements Serializable {

	private int no;
	private String memberId;
	private String title;
	private String allDay;
	private String startDate;
	private String endDate;
	private String type;
	private String content;
	private String color;

}
