
  package com.lemon.lemonbiz.manager.controller;
  
  import java.util.List; import java.util.Map;
  
  import org.springframework.beans.factory.annotation.Autowired; import
  org.springframework.stereotype.Controller; import
  org.springframework.ui.Model; import
  org.springframework.web.bind.annotation.RequestMapping; import
  org.springframework.web.bind.annotation.RequestMethod;
  
  import com.lemon.lemonbiz.manager.model.service.ManagerService;
  
  import lombok.extern.slf4j.Slf4j;
  
  @Slf4j
  
  @Controller
  
  @RequestMapping("/manager") public class ManagerController {
  
  @Autowired private ManagerService managerService;
  
  
  @RequestMapping(value = "/insertMember.do", method = RequestMethod.GET)
  public String insertMember() {
  
  
  return "manager/insertMember"; }
  
  @RequestMapping(value = "/manageDept.do", method = RequestMethod.GET) public
  void manageDept(Model model) { List<Map<String, Object>> deptList =
  managerService.selectDeptList(); model.addAttribute("deptList", deptList); }
  
  }
 
 