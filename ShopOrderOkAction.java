package com.admin.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

public class ShopOrderOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		OrderDAO odao = OrderDAO.getInstance();
		ProdDAO dao = ProdDAO.getInstance();
		
		HttpSession session = request.getSession();
		String shopid = (String)session.getAttribute("shopid");
		String pnum = request.getParameter("pnum");
		int order_no = Integer.parseInt(request.getParameter("order_no"));
		
		Date today = new Date();
	    SimpleDateFormat date = new SimpleDateFormat("yyMMdd");
		String date1 = date.format(today);
		String shopid1 = shopid.substring(0, 2).toUpperCase();
		String order_code = date1+shopid1;
		System.out.println(order_code);
		odao.insertOrderList(shopid, pnum, order_no, order_code);
		
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
