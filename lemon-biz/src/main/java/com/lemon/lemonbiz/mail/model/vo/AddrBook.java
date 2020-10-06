package com.lemon.lemonbiz.mail.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AddrBook {
	private int key;
	private String memId;
	private String name;
	private String address;
	private String memo;
}
