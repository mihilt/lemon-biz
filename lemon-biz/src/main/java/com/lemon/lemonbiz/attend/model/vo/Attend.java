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
public class Attend implements Serializable {
	//사용될 db값
	private int key;
	private String memId;
	private Date arrive;
	private Date leave;
	private float time;

	private String lastArrive;
	private int lastTime;
	private String name;
	private String yyyymm;
}
