
  package com.lemon.lemonbiz.manager.model.service;
  
  import java.util.List; import java.util.Map;
  
  import org.springframework.beans.factory.annotation.Autowired; import
  org.springframework.stereotype.Service;
  
  import com.lemon.lemonbiz.manager.model.dao.ManagerDAO;
  
  @Service public class ManagerServiceImpl implements ManagerService{
  
  @Autowired private ManagerDAO managerDAO;
  
  @Override public List<Map<String, Object>> selectDeptList() { return
  managerDAO.selectDeptList(); }
  
  }
 
