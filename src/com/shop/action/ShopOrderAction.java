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
import com.shops.model.ShopDAO;
import com.shops.model.ShopDTO;

public class ShopOrderAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ShopDAO dao = ShopDAO.getInstance();
		OrderDAO odao = OrderDAO.getInstance();

		HttpSession session = request.getSession();
		String shopid = (String)session.getAttribute("shopId");
		
		List<ShopDTO> list = dao.getShopList(shopid);
		List<OrderDTO> orderlist = odao.getOrderShopList(shopid);
		request.setAttribute("prodList", list);
		request.setAttribute("orderlist", orderlist);
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("shop/shop_order.jsp");
		
		
		return forward;
	}

}
