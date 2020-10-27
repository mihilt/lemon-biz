package com.lemon.lemonbiz.om.model.vo;

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
public class OMComment implements Serializable{
	private int omCommentNo;
	private int omCommentLevel;
	private String omCommentWriter;
	private String omCommentContent;
	private int omRef;
	private int omCommentRef;
	private Date omCommentDate;
}
