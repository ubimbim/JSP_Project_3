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

public class AdminMonthlyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		SalesDAO dao = SalesDAO.getInstance();

		// Dateset for lastmonth, thismonth
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, 0);
		String thismonth = format.format(cal.getTime()).substring(0,7);
		cal.add(Calendar.MONTH, -1);
		String lastmonth = format.format(cal.getTime()).substring(0,7);
		System.out.println(thismonth);
		System.out.println(lastmonth);
		// month set for labels
		String[] month = {lastmonth.substring(5,7)+"월", thismonth.substring(5,7)+"월", thismonth.substring(0,7)};
		request.setAttribute("monthlabel", month);
		
		// garosu month date
		int galasttotal = dao.getMonthSales("garosu", lastmonth);
		int gathistotal = dao.getMonthSales("garosu", thismonth);
		HashMap<String, Integer> gamonthlysaleslist = dao.getMonthList(thismonth, "garosu");
		request.setAttribute("gamonthlysaleslist", gamonthlysaleslist);
		request.setAttribute("galasttotal", galasttotal);
		request.setAttribute("gathistotal", gathistotal);
		System.out.println(gamonthlysaleslist);
		
		// gimpo month date
		int gilasttotal = dao.getMonthSales("gimpo", lastmonth);
		int githistotal = dao.getMonthSales("gimpo", thismonth);
		HashMap<String, Integer> gimonthlysaleslist = dao.getMonthList(thismonth, "gimpo");
		request.setAttribute("gimonthlysaleslist", gimonthlysaleslist);
		request.setAttribute("gilasttotal", gilasttotal);
		request.setAttribute("githistotal", githistotal);
		
		// hongdae month date
		int holasttotal = dao.getMonthSales("hongdae", lastmonth);
		int hothistotal = dao.getMonthSales("hongdae", thismonth);
		HashMap<String, Integer> homonthlysaleslist = dao.getMonthList(thismonth, "hongdae");
		request.setAttribute("homonthlysaleslist",homonthlysaleslist);
		request.setAttribute("holasttotal", holasttotal);
		request.setAttribute("hothistotal", hothistotal);
		
		// incheon month date
		int inlasttotal = dao.getMonthSales("incheon", lastmonth);
		int inthistotal = dao.getMonthSales("incheon", thismonth);
		HashMap<String, Integer> inmonthlysaleslist = dao.getMonthList(thismonth, "incheon");
		request.setAttribute("inmonthlysaleslist", inmonthlysaleslist);
		request.setAttribute("inlasttotal", inlasttotal);
		request.setAttribute("inthistotal", inthistotal);
		
		// yeouido month date
		int yelasttotal = dao.getMonthSales("yeouido", lastmonth);
		int yethistotal = dao.getMonthSales("yeouido", thismonth);
		HashMap<String, Integer> yemonthlysaleslist = dao.getMonthList(thismonth, "yeouido");
		request.setAttribute("yemonthlysaleslist", yemonthlysaleslist);
		request.setAttribute("yelasttotal", yelasttotal);
		request.setAttribute("yethistotal", yethistotal);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("admin/admin_monthly.jsp");
		
		
		return forward;
	}
}
