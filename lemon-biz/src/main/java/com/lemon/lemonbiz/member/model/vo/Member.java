package com.lemon.lemonbiz.member.model.vo;

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
public class Member implements Serializable {
	private String memberId;
	private String password;
	private int deptKey;
	private int rankKey;
	private int name;
	private String telNum;
	private String isManager;
	private String idNum;
	private String address;
	private String gender;
	private Date leaveDate;
}
