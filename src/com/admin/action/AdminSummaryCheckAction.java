package com.admin.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.SalesDAO;

public class AdminSummaryCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String shopname = null;
		String shopid = request.getParameter("shopname");
		String sdate = request.getParameter("sdate").trim();
		String edate = request.getParameter("edate").trim();
		SalesDAO dao = SalesDAO.getInstance();
		int[] proddata = dao.shopprodsales(sdate, edate, shopid);
		request.setAttribute("proddata", proddata);
		System.out.println(sdate);
		System.out.println(edate);
		HashMap<String, Integer> saleslist = dao.allSales(sdate, edate, shopid);
		System.out.println(saleslist);
		request.setAttribute("perioddata", saleslist);

		if(shopid.equals("garosu")) {
			shopname="Apple 가로수길";
		}else if(shopid.equals("yeouido")) {
			shopname="Apple 여의도점";
		}else if(shopid.equals("hongdae")) {
			shopname="프리스비 홍대점";
		}else if(shopid.equals("gimpo")) {
			shopname="윌리스 김포공항";
		}else if(shopid.equals("incheon")) {
			shopname="윌리스 인천터미널점";
		}
		
		// for submitted data
		String[] submitdata = {shopname, sdate, edate};
		request.setAttribute("submitdata", submitdata);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("admin/admin_summary.jsp");
		
		
		return forward;
	}
}
