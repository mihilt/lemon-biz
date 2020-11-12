package com.lemon.lemonbiz.attend.model.vo;

import java.io.Serializable;
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
public class AttendInfo implements Serializable{

	//총시간
	private int totalDay;
	private int totalTime;
	private int totalAvg;
}
