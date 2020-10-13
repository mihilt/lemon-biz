package com.lemon.lemonbiz.board.model.vo;

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
public class Board implements Serializable{
	
	private  int key;
	private String memId;
	private int categKey;
	private String title;
	private String content;
	private Date postDate;
	private int isNotice;
	private int isDeleted;
	private int readCount;
	
	private int fileCount;
	private List<Attachment> attachList; 
}
