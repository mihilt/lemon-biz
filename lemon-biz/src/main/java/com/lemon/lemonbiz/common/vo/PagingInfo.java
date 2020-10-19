package com.lemon.lemonbiz.common.vo;

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
public class PagingInfo {

	private int page;
	private int totalPage;
	private int startPage;
	private int endPage;
	private int countList;
	private int startNum;
	private int endNum;
	private int totalCount;
}
