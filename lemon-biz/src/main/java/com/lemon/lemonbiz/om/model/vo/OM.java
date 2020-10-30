package com.lemon.lemonbiz.om.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

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
public class OM implements Serializable{
	
	private  int key;
	private String memId;
	private int categKey;
	private String title;
	private String content;
	private Date omDate;
	private int isStarred;
	private int isDeleted;
	private int deptKey;
	private String name;
	private int readCount;
	private String omrId;
	
	private int fileCount;
	private List<Attachment> attachList;
	private List<String> omrList;

}
