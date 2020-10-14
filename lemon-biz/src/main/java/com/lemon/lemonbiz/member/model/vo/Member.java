package com.lemon.lemonbiz.member.model.vo;

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
public class Member implements Serializable {
	private String memberId;
	private String password;
	private int deptKey;
	private int rankKey;
	private String name;
	private String telNum;
	private String address;
	private String email;
	private String emailPwd;
	private int isManager;

	private String deptName;
	private String rankName;
}
