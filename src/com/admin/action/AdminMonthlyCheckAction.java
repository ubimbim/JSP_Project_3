package com.admin.action;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.SalesDAO;

public class AdminMonthlyCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String month = request.getParameter("month");
		SalesDAO dao = SalesDAO.getInstance();
		int year = Integer.parseInt(month.substring(0,4));
		int monthcheck = Integer.parseInt(month.substring(5,7));
		String lastmonth;
		if(monthcheck == 1) {
			lastmonth = (year-1) + "-" + "12";
		}else if(monthcheck >=11){
			lastmonth = year + "-" + (monthcheck-1);
		}else {
			lastmonth = year + "-" + "0"+ (monthcheck-1);
		}

		String thismonth = month;
		// month set for labels
		String[] months = {lastmonth.substring(5,7)+"월", thismonth.substring(5,7)+"월"};
		request.setAttribute("monthlabel", months);
		
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
