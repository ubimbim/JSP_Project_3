package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.ProductDAO;

public class AdminProductDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String product_num = request.getParameter("pnum").trim();
		ProductDAO dao = ProductDAO.getInstance();
		int check = dao.deleteProduct(product_num);
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			forward.setRedirect(true);
			forward.setPath("admin_product_list.do");
		}else {
			out.println("<script>");
			out.println("alert('상품 삭제 실패~~~')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}

}
