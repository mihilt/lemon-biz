package com.lemon.lemonbiz.cost.model.vo;

import java.io.Serializable;

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
public class Cost implements Serializable {
	
	private String memberId;
	private int transportationCosts;
	private int fitment;
	private int businessCosts;
	private int mealCosts;
	private int gasCosts;
	private String expenditureDate;
}
