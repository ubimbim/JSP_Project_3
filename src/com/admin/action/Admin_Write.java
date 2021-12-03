package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.UserDAO;
import com.shops.model.UserDTO;

public class Admin_Write implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		UserDTO dto = new UserDTO();
		
		String shop_id = request.getParameter("shop_id").trim();
		String shop_pwd = request.getParameter("shop_pwd").trim();
		String shop_name = request.getParameter("shop_name").trim();
		
		dto.setShop_id(shop_id);
		dto.setShop_pwd(shop_pwd);
		dto.setShop_name(shop_name);
		
		UserDAO dao = UserDAO.getInstance();
		
		int res = dao.updatewrite(dto);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if(res > 0) {
			forward.setRedirect(true);
			forward.setPath("admin_main.do");
		}else {
			out.println("<script>");
			out.println("alert('회원가입 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		
		return forward;
	}

}
