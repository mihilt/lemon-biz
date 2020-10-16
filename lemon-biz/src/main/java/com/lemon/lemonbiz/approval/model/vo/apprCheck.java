package com.lemon.lemonbiz.approval.model.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class apprCheck {
	
	private int key;
	private String approvalKey;
	private String memId;
	private int seqNum;
	private Date checkDate;
	private String status;
	private String opinion;

}
