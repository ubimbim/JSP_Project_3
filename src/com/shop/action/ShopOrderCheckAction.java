package com.shop.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.OrderDAO;
import com.shops.model.OrderDTO;

public class ShopOrderCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		OrderDAO dao = OrderDAO.getInstance();

		HttpSession session = request.getSession();
		String shopid = (String)session.getAttribute("shopId");

		List<OrderDTO> orderlist = dao.getOrderList(shopid);

		request.setAttribute("orderlist", orderlist);
		request.setAttribute("shopid", shopid);
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("shop/shop_order_check.jsp");
		
		return forward;
	}
}
