package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.AdminDAO;
import com.shops.model.AdminDTO;
import com.shops.model.BoardDAO;
import com.shops.model.BoardDTO;
import com.shops.model.OrderDAO;
import com.shops.model.OrderDTO;
import com.shops.model.SalesDAO;

public class Admin_Login implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String main_id = request.getParameter("main_id").trim();
		String main_pwd = request.getParameter("main_pwd").trim();
		
		AdminDAO dao = AdminDAO.getInstance();
	    int res = dao.adminCheck(main_id, main_pwd);
	    
	    // 발주 데이터
	    OrderDAO odao = OrderDAO.getInstance();
	    int odto = odao.getMainOrderCount();
	    
	    // Board 데이터
	    BoardDAO ndao = BoardDAO.getInstance();
	    List<BoardDTO> ndto = ndao.getMainNoticeList();
	    
	    BoardDAO bdao = BoardDAO.getInstance();
	    List<BoardDTO> bdto = bdao.getMainBoardList();
	    
	 // 주간매출 데이터
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

	 	// Dateset for lastmonth, thismonth
	 	cal.add(Calendar.MONTH, 1);
	 	String thismonth = format.format(cal.getTime()).substring(0,7);
	 	
	 	System.out.println(thismonth);
	 	SalesDAO sdao = SalesDAO.getInstance();
	 	int gathistotal = sdao.getMonthSales("garosu", thismonth);
		int githistotal = sdao.getMonthSales("gimpo", thismonth);
		int hothistotal = sdao.getMonthSales("hongdae", thismonth);
		int inthistotal = sdao.getMonthSales("incheon", thismonth);
		int yethistotal = sdao.getMonthSales("yeouido", thismonth);

		// 주간 Hashmap data<date, salesincome>
		HashMap<String, Integer> garosuweek = sdao.allSales(week[0], week[6], "garosu");
		HashMap<String, Integer> gimpoweek = sdao.allSales(week[0], week[6], "gimpo");
		HashMap<String, Integer> hongdaeweek = sdao.allSales(week[0], week[6], "hongdae");
		HashMap<String, Integer> incheonweek = sdao.allSales(week[0], week[6], "incheon");
		HashMap<String, Integer> yeouidoweek = sdao.allSales(week[0], week[6], "yeouido");
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
		
	    ActionForward forward = new ActionForward();
	    
	    PrintWriter out = response.getWriter();
	    
	    // 세션을 생성하는 방법
	    HttpSession session = request.getSession();
	    
	    if(res > 0) {
	    	// 관리자인 경우 관리자의 정보를 받아오자
	    	AdminDTO dto = dao.getMain(main_id);
	    	
	    	session.setAttribute("adminId", dto.getMain_id());
	    	
	    	request.setAttribute("ordercount", odto);
	    	request.setAttribute("noticelist", ndto);
	    	request.setAttribute("boardlist", bdto);
	    	
	    	request.setAttribute("garosu", garosu);
			request.setAttribute("gimpo", gimpo);
			request.setAttribute("hongdae", hongdae);
			request.setAttribute("incheon", incheon);
			request.setAttribute("yeouido", yeouido);
			request.setAttribute("week", week);
			 
			request.setAttribute("gathistotal", gathistotal);
			request.setAttribute("githistotal", githistotal);
			request.setAttribute("hothistotal", hothistotal);
			request.setAttribute("inthistotal", inthistotal);
			request.setAttribute("yethistotal", yethistotal); 
	    	
	    	// 세션에 저장된 정보를 가지고 View Page로 이동하자
	    	forward.setRedirect(false);
	    	
	    	forward.setPath("admin/admin_main.jsp");
	    	
	    } else if(res == -1) {
	    	// 아이디는 맞으나 비밀번호가 틀린 경우
	    	out.println("<script>");
	    	out.println("alert('관리자 비밀번호가 틀립니다.')");
	    	out.println("history.back()");
	    	out.println("</script>");
	    }else {
	    	// 존재하지 않는 아이디
	    	out.println("<script>");
	    	out.println("alert('존재하지 않는 관리자입니다.')");
	    	out.println("history.back()");
	    	out.println("</script>");
	    }
	    
		return forward;
	}

}