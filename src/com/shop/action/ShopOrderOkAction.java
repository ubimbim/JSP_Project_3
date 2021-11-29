package com.shop.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

public class ShopOrderOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		OrderDAO odao = OrderDAO.getInstance();
		ShopDAO dao = ShopDAO.getInstance();
		
		HttpSession session = request.getSession();
		String shopid = (String)session.getAttribute("shopId");
		System.out.println(shopid);
		String pnum = request.getParameter("pnum");
		int order_no = Integer.parseInt(request.getParameter("order_no"));
		
		/*
		 * Date today = new Date(); SimpleDateFormat date = new
		 * SimpleDateFormat("yyMMdd"); String date1 = date.format(today); String shopid1
		 * = shopid.substring(0, 2).toUpperCase(); String order_code = date1+shopid1;
		 * System.out.println(order_code);
		 */
		odao.insertOrderList(shopid, pnum, order_no);
		
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
