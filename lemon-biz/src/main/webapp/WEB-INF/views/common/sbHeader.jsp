<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8"/>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-warning sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="far fa-lemon"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Lemon biz</div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item">
        <a class="nav-link" href="index.html">
          <i class="fas fa-fw fa-exclamation"></i>
          <span>공지사항</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- 전자결재 -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#approval" aria-expanded="false" aria-controls="collapsePages">
          <i class="fas fa-fw fa-file"></i>
          <span>전자결재</span>
        </a>
        <div id="approval" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">

          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Approval</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/approval/writeForm.html">일반결재</a>
            <a class="collapse-item" href="">근태/휴가결재</a>
            <a class="collapse-item" href="">지출결재</a>
            <a class="collapse-item" href="">임시저장함</a>
            <div class="collapse-divider"></div>
            <h6 class="collapse-header">My Approval</h6>
            <a class="collapse-item" href="">내문서함</a>
            <a class="collapse-item" href="">미결재문서</a>
            <a class="collapse-item" href="">결재완료문서</a>
          </div>
        </div>
      </li>
      
      <!-- 메일 관련 항목입니다 -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#mail" aria-expanded="false" aria-controls="collapsePages">
          <i class="fas fa-fw fa-envelope"></i>
          <span>업무 메일</span>
        </a>
        <div id="mail" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Mail</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/mail/mailSend">메일 작성</a>
            <a class="collapse-item" href="">전체 메일</a>
            <a class="collapse-item" href="">받은 메일함</a>
            <a class="collapse-item" href="">보낸 메일함</a>
            <a class="collapse-item" href="">임시 보관함</a>
            <div class="collapse-divider"></div>
            <h6 class="collapse-header">My Mail</h6>
            <a class="collapse-item" href="">첨부 메일함</a>
            <a class="collapse-item" href="">내게 쓴 메일함</a>
          </div>
        </div>
      </li>
      
      <!-- 일정 관리 -->
      <li class="nav-item">
        <a class="nav-link" href="일정관리">
          <i class="fas fa-fw fa-calendar-alt"></i>
          <span>일정관리</span></a>
      </li>
      
      <!-- 근태 관리 -->
      <li class="nav-item">
        <a class="nav-link" href="근태관리">
          <i class="fas fa-fw fa-building"></i>
          <span>근태관리</span></a>
      </li>
      
      <!-- 게시판 -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#board" aria-expanded="false" aria-controls="collapsePages">
          <i class="fas fa-fw fa-folder"></i>
          <span>게시판</span>
        </a>
        <div id="board" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <a class="collapse-item" href="${pageContext.request.contextPath}/board/boardList.do">전사 게시판</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/board/boardTeamList.do">부서 게시판</a>
          </div>
        </div>
      </li>
		
      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- 관리자 + 톱니바퀴 -->
      <div class="sidebar-heading text-white">
      <i class="fas fa-fw fa-cog"></i>
        	관리자
      </div>

      <!-- 사원 관리 -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#manager" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-fw fa-user"></i>
          <span>사원 관리</span>
        </a>
        <div id="manager" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">사원 관리</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/manager/insertMember.do">사원 등록</a>
            <a class="collapse-item" href="cards.html">사원 정보</a>
          </div>
        </div>
      </li>
      
      <!-- 부서 관리 -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/manager/manageDept.do">
          <i class="fas fa-fw fa-users"></i>
          <span>부서 관리</span></a>
      </li>
      
      <!-- 직급 관리 -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#position" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-fw fa-user-tie"></i>
          <span>직급 관리</span>
        </a>
        <div id="position" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">직급 관리</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/manager/insertMember.do">직급 생성</a>
            <a class="collapse-item" href="cards.html">직급 정보</a>
          </div>
        </div>
      </li>
      
      <!-- 전자결재 관리 -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#approval-manage" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-fw fa-file"></i>
          <span>전자결재 관리</span>
        </a>
        <div id="approval-manage" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">전자결재 관리</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/manager/insertMember.do">무튼 관리</a>
            <a class="collapse-item" href="cards.html">문서 생성</a>
            <a class="collapse-item" href="cards.html">문서 ㅁㄴㅇ</a>
          </div>
        </div>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">
	
      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>
      
    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">

            <!-- Nav Item - Search Dropdown (Visible Only XS) -->
            <li class="nav-item dropdown no-arrow d-sm-none">
              <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-search fa-fw"></i>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
                <form class="form-inline mr-auto w-100 navbar-search">
                  <div class="input-group">
                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                      <button class="btn btn-primary" type="button">
                        <i class="fas fa-search fa-sm"></i>
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </li>

            <!-- Nav Item - Alerts -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-bell fa-fw"></i>
                <!-- Counter - Alerts -->
                <span class="badge badge-danger badge-counter">3+</span>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                <h6 class="dropdown-header">
                  Alerts Center
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-primary">
                      <i class="fas fa-file-alt text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 12, 2019</div>
                    <span class="font-weight-bold">A new monthly report is ready to download!</span>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-success">
                      <i class="fas fa-donate text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 7, 2019</div>
                    $290.29 has been deposited into your account!
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-warning">
                      <i class="fas fa-exclamation-triangle text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 2, 2019</div>
                    Spending Alert: We've noticed unusually high spending for your account.
                  </div>
                </a>
                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
              </div>
            </li>

            <!-- Nav Item - Messages -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-envelope fa-fw"></i>
                <!-- Counter - Messages -->
                <span class="badge badge-danger badge-counter">7</span>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown">
                <h6 class="dropdown-header">
                  Message Center
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/fn_BT9fwg_E/60x60" alt="">
                    <div class="status-indicator bg-success"></div>
                  </div>
                  <div class="font-weight-bold">
                    <div class="text-truncate">Hi there! I am wondering if you can help me with a problem I've been having.</div>
                    <div class="small text-gray-500">Emily Fowler · 58m</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/AU4VPcFN4LE/60x60" alt="">
                    <div class="status-indicator"></div>
                  </div>
                  <div>
                    <div class="text-truncate">I have the photos that you ordered last month, how would you like them sent to you?</div>
                    <div class="small text-gray-500">Jae Chun · 1d</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/CS2uCrpNzJY/60x60" alt="">
                    <div class="status-indicator bg-warning"></div>
                  </div>
                  <div>
                    <div class="text-truncate">Last month's report looks great, I am very happy with the progress so far, keep up the good work!</div>
                    <div class="small text-gray-500">Morgan Alvarez · 2d</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="">
                    <div class="status-indicator bg-success"></div>
                  </div>
                  <div>
                    <div class="text-truncate">Am I a good boy? The reason I ask is because someone told me that people say this to all dogs, even if they aren't good...</div>
                    <div class="small text-gray-500">Chicken the Dog · 2w</div>
                  </div>
                </a>
                <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
              </div>
            </li>

            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${ loginMember.memberId }번 사원이긴 한데 나중에 이름으로</span>
                <img class="img-profile rounded-circle" src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="${pageContext.request.contextPath}/member/myPage.do">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  	내 정보 보기
                </a>
                <a class="dropdown-item" href="#">
                  <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                	메뉴 예시
                </a>
                <a class="dropdown-item" href="#">
                  <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                  	메뉴 예시
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  	로그아웃
                </a>
              </div>
            </li>

          </ul>

        </nav>
        
        <!-- Core plugin JavaScript-->
		<script src="${pageContext.request.contextPath }/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
		
		<!-- Custom scripts for all pages-->
		<script src="${pageContext.request.contextPath }/resources/js/sb-admin-2.min.js"></script>

        <!-- End of Topbar -->

        <!-- Begin Page Content -->
        <div class="container-fluid">

