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
import com.shop.model.ProdDAO;
import com.shop.model.ProdDTO;

public class ShopOrderAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ProdDAO dao = ProdDAO.getInstance();
		OrderDAO odao = OrderDAO.getInstance();
		String shopid = "garosu";

		HttpSession session = request.getSession();
		session.setAttribute("shopid", shopid);
		
		
		List<ProdDTO> list = dao.prodNow(shopid);
		List<OrderDTO> orderlist = odao.getOrderList(shopid);
		request.setAttribute("prodList", list);
		request.setAttribute("orderlist", orderlist);
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("shop/shop_order.jsp");
		
		
		return forward;
	}

}
