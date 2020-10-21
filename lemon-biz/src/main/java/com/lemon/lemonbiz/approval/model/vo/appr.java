package com.lemon.lemonbiz.approval.model.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.lemon.lemonbiz.common.vo.Attachment;

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
public class appr {

	private String Key;
	private int typeKey;
	private String memId;
	private String title;
	private String content;
	private Date draftDate;
	private Date writeDate;
	private String status;
	private int isDeleted;
	
	
	private Attachment attachment;
	private apprCheck apprck1;
	private apprCheck apprck2;
	private apprCheck apprck3;
	
	private String docName;
	private String name;
	
	
}
