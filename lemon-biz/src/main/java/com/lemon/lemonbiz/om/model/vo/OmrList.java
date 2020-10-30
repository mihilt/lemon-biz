package com.lemon.lemonbiz.om.model.vo;

import java.io.Serializable;
import java.util.List;


public class OmrList implements Serializable{

	private List<String> omrList = null;
	
	public List<String> getOmrList(){
		return omrList;
	}
	public void setOmrList(List<String> omrList) {
		this.omrList = omrList;
	}
	
}
