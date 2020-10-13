
  package com.lemon.lemonbiz.manager.model.dao;
  
  import java.util.List; import java.util.Map;
  
  import org.mybatis.spring.SqlSessionTemplate; import
  org.springframework.beans.factory.annotation.Autowired; import
  org.springframework.stereotype.Repository;
  
  @Repository public class ManagerDAOImpl implements ManagerDAO{
  
  @Autowired private SqlSessionTemplate sqlSession;
  
  @Override public List<Map<String, Object>> selectDeptList() { return
  sqlSession.selectList("manager.selectDeptList"); }
  
  }
 