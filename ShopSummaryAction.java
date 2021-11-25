package com.admin.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.controller.Action;
import com.shop.controller.ActionForward;
import com.shop.model.SalesDAO;

public class ShopSummaryAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// Dateset for weeksales research
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String[] week = new String[7];
		for(int i=6; i>=0; i--) {
			cal.add(Calendar.DAY_OF_MONTH, -1);
			week[i] = format.format(cal.getTime());
		} // week[6]=yesterday, week[0] = a week before;
		request.setAttribute("week", week);
		
		SalesDAO dao = SalesDAO.getInstance();
		
		// select all store's sales list
		ArrayList<Integer> shopsales = dao.shopsalesweek(week[0], week[6]);
		
		// select all store's productsales list
		int[] prodsales = dao.prodsalesweek(week[0], week[6]);
		
		request.setAttribute("shopsales", shopsales);
		request.setAttribute("prodsales", prodsales);
		
		// Store name order
		// garosu / gimpo / hongdae / incheon / yeouido
		// Get Hashmap data<date, salesincome> in last week.
		HashMap<String, Integer> garosuweek = dao.weekSales(week[0], "garosu");
		HashMap<String, Integer> gimpoweek = dao.weekSales(week[0], "gimpo");
		HashMap<String, Integer> hongdaeweek = dao.weekSales(week[0], "hongdae");
		HashMap<String, Integer> incheonweek = dao.weekSales(week[0], "incheon");
		HashMap<String, Integer> yeouidoweek = dao.weekSales(week[0], "yeouido");
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
				garosu[i] = 0;
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
		
		forward.setPath("shop/shop_summary.jsp");
		
		
		return forward;
	}

}
