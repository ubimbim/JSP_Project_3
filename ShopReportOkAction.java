package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shop.controller.Action;
import com.shop.controller.ActionForward;
import com.shop.model.SalesDAO;
import com.shop.model.SalesDTO;
import com.shop.model.ShopprodDAO;

public class ShopReportOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub

		String shopid = request.getParameter("shopid");
		String date = request.getParameter("date");
		String pnumname = request.getParameter("pnumname");
		String pname = pnumname.substring(6);
		String pnum = pnumname.substring(0,6);
		int sales_no = Integer.parseInt(request.getParameter("sales_no"));

		SalesDTO dto = new SalesDTO();
		dto.setShop_id(shopid);
		dto.setSales_date(date);
		dto.setPname(pname);
		dto.setSales_no(sales_no);
		
		SalesDAO dao = SalesDAO.getInstance();
		int check = dao.salesInsert(dto, pnum, sales_no, shopid);
		
		if(check>0) {
			ShopprodDAO shopdao = ShopprodDAO.getInstance();
			shopdao.plusNo(shopid, pnum, sales_no);
		}
		
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
