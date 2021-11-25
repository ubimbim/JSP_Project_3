package com.shop.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.OrderContDTO;
import com.shops.model.OrderDAO;
import com.shops.model.OrderDTO;

public class ShopOrderListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 재고요청 테이블 목록을 가져와서 출력하는 비지니스 로직
		response.setContentType("UTF-8");
		
		HttpSession session = request.getSession();
		String shop_id = (String)session.getAttribute("shopId");
		
		OrderDAO dao = OrderDAO.getInstance();
		
		List<OrderDTO> list = dao.getOrderShopList(shop_id);
		request.setAttribute("List", list);
		
		if(request.getParameter("code") != null) {
			
			String order_code = request.getParameter("code");
			
			OrderContDTO cont = dao.getOrderCont(order_code);
			request.setAttribute("Cont", cont);
			
		}
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("shop/order_confirm.jsp");
		
		return forward;
	}

}
