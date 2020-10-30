package com.lemon.lemonbiz.cost.model.service;

import java.util.HashMap;
import java.util.List;

import com.lemon.lemonbiz.cost.model.vo.Cost;

public interface CostService {

	int enrollCost(Cost cost);

	List<Cost> selectAllCost(HashMap<Object, Object> params);

}
