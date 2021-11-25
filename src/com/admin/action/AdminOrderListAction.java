package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.OrderContDTO;
import com.shops.model.OrderDAO;
import com.shops.model.OrderDTO;

public class AdminOrderListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 재고요청 테이블 목록을 가져와서 출력하는 비지니스 로직
		// String order_code = "";
		
		// String code = request.getParameter("code");
		response.setContentType("UTF-8");
		
		OrderDAO dao = OrderDAO.getInstance();
		
		List<OrderDTO> list = dao.getOrderList();
		request.setAttribute("List", list);
		
		if(request.getParameter("code") != null) {
			
			String order_code = request.getParameter("code");
			
			OrderContDTO cont = dao.getOrderCont(order_code);
			request.setAttribute("Cont", cont);
			
		}
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin/order_confirm.jsp");
		
		return forward;
	}

}
