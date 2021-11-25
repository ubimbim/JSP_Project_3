package com.shop.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.SalesDAO;
import com.shops.model.SalesDTO;

public class ShopReportAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub

		SalesDAO dao = SalesDAO.getInstance();
		
		HttpSession session = request.getSession();
		String shopid = (String)session.getAttribute("shopId");
		
		List<SalesDTO> list = dao.salesToday(shopid);
		
		int total = dao.totalToday(shopid);
		
		
		request.setAttribute("salesList", list);
		request.setAttribute("total", total);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("shop/shop_report.jsp");
		
		
		return forward;
	}
}
