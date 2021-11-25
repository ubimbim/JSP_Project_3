package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.controller.Action;
import com.shop.controller.ActionForward;
import com.shop.model.OrderDAO;

public class ShopOrderDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String order_code = request.getParameter("no").trim();
		
		OrderDAO dao = OrderDAO.getInstance();
		int check = dao.deleteSales(order_code);
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			forward.setRedirect(true);
			forward.setPath("shop_order.do");
		}else {
			out.println("<script>");
			out.println("alert('발주이력 삭제 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}
}
