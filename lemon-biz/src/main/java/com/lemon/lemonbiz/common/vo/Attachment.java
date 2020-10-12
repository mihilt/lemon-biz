package com.lemon.lemonbiz.common.vo;

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
public class Attachment {
	private int key;
	private int postKey;
	private String approvalkey;
	private String memId;
	private int mailKey;
	private String originName;
	private String reName;
	
	
}
