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

public class AdminSummaryAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String shopid = "garosu";
		
		// Dateset (one month before ~ today)
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, 0);
		String today = format.format(cal.getTime());
		cal.add(Calendar.MONTH, -1);
		String onebefore = format.format(cal.getTime());
		
		SalesDAO dao = SalesDAO.getInstance();
		int[] proddata = dao.shopprodsales(onebefore, today, shopid);
		request.setAttribute("proddata", proddata);
		System.out.println(today);
		System.out.println(onebefore);
		HashMap<String, Integer> saleslist = dao.allSales(onebefore, today, shopid);
		System.out.println(saleslist);
		request.setAttribute("perioddata", saleslist);
		
		// for submitted data
		String[] submitdata = {"Apple 가로수길", onebefore, today};
		request.setAttribute("submitdata", submitdata);
				
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("admin/admin_summary.jsp");
		
		
		return forward;
	}
}
