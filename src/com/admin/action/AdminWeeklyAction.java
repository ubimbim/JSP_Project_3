package com.admin.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.SalesDAO;

public class AdminWeeklyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// Dateset for weeksales research
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String[] week = new String[7];
		cal.add(Calendar.DAY_OF_MONTH, 0);
		week[6]=format.format(cal.getTime());
		for(int i=5; i>=0; i--) {
			cal.add(Calendar.DAY_OF_MONTH, -1);
			week[i] = format.format(cal.getTime());
		} // week[6]=today, week[0] = a week before;
		request.setAttribute("week", week);
		System.out.println(week[0]);
		System.out.println(week[6]);
		SalesDAO dao = SalesDAO.getInstance();
		
		// select all store's sales list
		HashMap<String, Integer> sales = dao.shopsalesweek(week[0], week[6]);
		System.out.println(sales);
		String[] stores = {"garosu", "gimpo", "hongdae", "incheon", "yeouido"};
		int[] shopsales =  new int[5];
		for(int i=0; i<=4; i++) {
			if(sales.get(stores[i])!=null) {
				shopsales[i] = sales.get(stores[i]);
			}else {
				shopsales[i] = 0;
			}
		}
		System.out.println(shopsales[0]+shopsales[1]+shopsales[2]+shopsales[3]+shopsales[4]);
		// select all store's productsales list
		int[] prodsales = dao.prodsalesweek(week[0], week[6]);
		
		request.setAttribute("shopsales", shopsales);
		request.setAttribute("prodsales", prodsales);
		
		// Store name order
		// garosu / gimpo / hongdae / incheon / yeouido
		// Get Hashmap data<date, salesincome> in last week.
		HashMap<String, Integer> garosuweek = dao.allSales(week[0], week[6], "garosu");
		HashMap<String, Integer> gimpoweek = dao.allSales(week[0], week[6], "gimpo");
		HashMap<String, Integer> hongdaeweek = dao.allSales(week[0], week[6], "hongdae");
		HashMap<String, Integer> incheonweek = dao.allSales(week[0], week[6], "incheon");
		HashMap<String, Integer> yeouidoweek = dao.allSales(week[0], week[6], "yeouido");
		int[] garosu = new int[7];
		int[] gimpo = new int[7];
		int[] hongdae = new int[7];
		int[] incheon = new int[7];
		int[] yeouido = new int[7];
		
		for(int i=0; i<=6; i++) {
			if(garosuweek.get(week[i])!=null) {
				garosu[i] = garosuweek.get(week[i]);
			}else {
				garosu[i] = 0;
			}
			if(gimpoweek.get(week[i])!=null) {
				gimpo[i] = gimpoweek.get(week[i]);
			}else {
				gimpo[i] = 0;
			}
		
			if(hongdaeweek.get(week[i])!=null) {
				hongdae[i] = hongdaeweek.get(week[i]);
			}else {
				hongdae[i] = 0;
			}
		
			if(incheonweek.get(week[i])!=null) {
				incheon[i] = incheonweek.get(week[i]);
			}else {
				incheon[i] = 0;
			}
		
			if(yeouidoweek.get(week[i])!=null) {
				yeouido[i] = yeouidoweek.get(week[i]);
			}else {
				yeouido[i] = 0;
			}
		}
		request.setAttribute("garosu", garosu);
		request.setAttribute("gimpo", gimpo);
		request.setAttribute("hongdae", hongdae);
		request.setAttribute("incheon", incheon);
		request.setAttribute("yeouido", yeouido);
		System.out.println(garosu[0]+","+garosu[2]+","+garosu[3]+","+garosu[4]+","+garosu[5]+garosu[1]);
		System.out.println(hongdae);
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("admin/admin_weekly.jsp");
		
		
		return forward;
	}

}
