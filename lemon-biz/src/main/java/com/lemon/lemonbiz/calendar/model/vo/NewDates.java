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
public class NewDates implements Serializable {
	
	private int no;
	private String startDate;
	private String endDate;

}
