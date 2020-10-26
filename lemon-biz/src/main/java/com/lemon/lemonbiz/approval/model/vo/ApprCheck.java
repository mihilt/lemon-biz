package com.lemon.lemonbiz.approval.model.vo;

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
public class ApprCheck {
	
	private int key;
	private String approvalKey;
	private String memId;
	private int seqNum;
	private Date checkDate;
	private String status;
	private String opinion;

	private String ckName;
	private String rankName;
}
