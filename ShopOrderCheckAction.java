package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shop.controller.Action;
import com.shop.controller.ActionForward;
import com.shop.model.OrderDAO;
import com.shop.model.OrderDTO;

public class ShopOrderCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		OrderDAO dao = OrderDAO.getInstance();
		String shopid = "garosu";

		HttpSession session = request.getSession();
		session.setAttribute("shopid", shopid);

		String field = request.getParameter("search_field");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		System.out.println(date2);
		List<OrderDTO> orderlist = dao.getOrderSetList(shopid, field, date1, date2);

		request.setAttribute("orderlist", orderlist);
		request.setAttribute("shopid", shopid);
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("shop/shop_order_check.jsp");
		
		return forward;
	}
}
