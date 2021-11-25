package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.AdminDAO;
import com.shops.model.AdminDTO;

public class Admin_Login implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String main_id = request.getParameter("main_id").trim();
		String main_pwd = request.getParameter("main_pwd").trim();
		
		AdminDAO dao = AdminDAO.getInstance();
	    int res = dao.adminCheck(main_id, main_pwd);
	    
	    ActionForward forward = new ActionForward();
	    
	    PrintWriter out = response.getWriter();
	    
	    // 세션을 생성하는 방법
	    HttpSession session = request.getSession();
	    
	    if(res > 0) {
	    	// 관리자인 경우 관리자의 정보를 받아오자
	    	AdminDTO dto = dao.getMain(main_id);
	    	
	    	session.setAttribute("adminId", dto.getMain_id());
	    	
	    	
	    	// 세션에 저장된 정보를 가지고 View Page로 이동하자
	    	forward.setRedirect(false);
	    	
	    	forward.setPath("admin/admin_main.jsp");
	    	
	    }else if(res == -1) {
	    	// 아이디는 맞으나 비밀번호가 틀린 경우
	    	out.println("<script>");
	    	out.println("alert('관리자 비밀번호가 틀립니다.')");
	    	out.println("history.back()");
	    	out.println("</script>");
	    }else {
	    	// 존재하지 않는 아이디
	    	out.println("<script>");
	    	out.println("alert('존재하지 않는 관리자입니다.')");
	    	out.println("history.back()");
	    	out.println("</script>");
	    }
	    
	      
	      
		return forward;
	}

}
