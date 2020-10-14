package com.lemon.lemonbiz.mail.model.vo;

import java.sql.Date;
import java.util.List;

import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Member;

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
public class Mail {
	private int key;
	private String memId;
	private String title;
	private String content;
	private Date mailDate;
	private int isChecked;
	private int isStarred;

	private int fileCount;
	private List<Attachment> attachList;
	private String memberId;
	private String deptName;
	private String rankName;
	private List <MailReceiver> receiverList;
}
