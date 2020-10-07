package com.lemon.lemonbiz.board.model.vo;

import java.io.Serializable;

import java.util.Date;
import java.util.List;



import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import oracle.sql.DATE;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Board implements Serializable{
	
	private  int key;
	private String memID;
	private int categKey;
	private String title;
	private String content;
	private DATE postDate;
	private int isNotice;
	private int isDeleted;
	private int readCount;
	
	private int fileCount;
	/* private List<Attachment> attachList; */
}
