package com.shop.action;

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
import com.shops.model.BoardDAO;
import com.shops.model.BoardDTO;
import com.shops.model.OrderDAO;
import com.shops.model.SalesDAO;
import com.shops.model.UserDAO;
import com.shops.model.UserDTO;

public class Shop_Login implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
	    ActionForward forward = new ActionForward();
	    PrintWriter out = response.getWriter();
	    
	    // Dateset for this month
	 	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	 	Calendar cal = Calendar.getInstance();
	 	cal.add(Calendar.MONTH, 0);
	 	String thismonth = format.format(cal.getTime()).substring(0,7);
		
	 	// Dateset for this week
		String[] week = new String[7];
		cal.add(Calendar.DAY_OF_MONTH, 0);
		week[6]=format.format(cal.getTime());
		for(int i=5; i>=0; i--) {
			cal.add(Calendar.DAY_OF_MONTH, -1);
			week[i] = format.format(cal.getTime());
		} // week[6]=today, week[0] = a week before;
		
	    OrderDAO odao = OrderDAO.getInstance();
	    BoardDAO ndao = BoardDAO.getInstance();
	    BoardDAO bdao = BoardDAO.getInstance();
	    SalesDAO sdao = SalesDAO.getInstance();
	    
		
		if(request.getParameter("code") != null) {
			
			HttpSession session = request.getSession();
			String shop_id = (String)session.getAttribute("shopId");
			
			int odto = odao.getShopOrderCount(shop_id);
		    int sdto = odao.getShopOrderOklist(shop_id);
		    int cdto = odao.getShopCancellist(shop_id);
		    
		    List<BoardDTO> ndto = ndao.getMainNoticeList();
		    List<BoardDTO> bdto = bdao.getMainBoardList();
		    
		    HashMap<String, Integer> monthlysaleslist = 
		    		sdao.getMonthList(thismonth, shop_id);
		    int[] psales = sdao.shopprodsales(week[0], week[6], shop_id);
		    
		    request.setAttribute("ordercount", odto);
	    	request.setAttribute("okcount", sdto);
	    	request.setAttribute("cancelcount", cdto);
	    	request.setAttribute("noticelist", ndto);
	    	request.setAttribute("boardlist", bdto);
	    	request.setAttribute("monthlysaleslist", monthlysaleslist);
	    	request.setAttribute("label", thismonth.substring(5));
	    	request.setAttribute("psales", psales);
	    	
	    	// 세션에 저장된 정보를 가지고 View Page로 이동하자
	    	forward.setRedirect(false);
	    	forward.setPath("shop/shop_main.jsp");
		    
		} else {
			
			String shop_id = request.getParameter("shop_id").trim();
			String shop_pwd = request.getParameter("shop_pwd").trim();
			
			UserDAO dao = UserDAO.getInstance();
		    int check = dao.userCheck(shop_id, shop_pwd);
		    
		    int odto = odao.getShopOrderCount(shop_id);
		    int sdto = odao.getShopOrderOklist(shop_id);
		    int cdto = odao.getShopCancellist(shop_id);
		    
		    List<BoardDTO> ndto = ndao.getMainNoticeList();
		    List<BoardDTO> bdto = bdao.getMainBoardList();
		    
		    HashMap<String, Integer> monthlysaleslist = 
		    		sdao.getMonthList(thismonth, shop_id);
		    int[] psales = sdao.shopprodsales(week[0], week[6], shop_id);
		    
		    // 세션을 생성하는 방법
		    HttpSession session = request.getSession();
		    
		    if(check > 0) {
		    	
		    	UserDTO dto = dao.getMember(shop_id);
		    	
		    	session.setAttribute("shopId", dto.getShop_id());
		    	session.setAttribute("shopName", dto.getShop_name());
		    	
		    	request.setAttribute("ordercount", odto);
		    	request.setAttribute("okcount", sdto);
		    	request.setAttribute("cancelcount", cdto);
		    	request.setAttribute("noticelist", ndto);
		    	request.setAttribute("boardlist", bdto);
		    	request.setAttribute("monthlysaleslist", monthlysaleslist);
		    	request.setAttribute("label", thismonth.substring(5));
		    	request.setAttribute("psales", psales);
		    	
		    	// 세션에 저장된 정보를 가지고 View Page로 이동하자
		    	forward.setRedirect(false);
		    	
		    	forward.setPath("shop/shop_main.jsp");
		    	
		    }else if(check == -1) {
		    	// 아이디는 맞으나 비밀번호가 틀린 경우
		    	out.println("<script>");
		    	out.println("alert('매장계정 비밀번호가 틀립니다.')");
		    	out.println("history.back()");
		    	out.println("</script>");
		    }else {
		    	// 존재하지 않는 아이디
		    	out.println("<script>");
		    	out.println("alert('존재하지 않는 계정입니다.')");
		    	out.println("history.back()");
		    	out.println("</script>");
		    }
			
		}
		
		return forward;
	    
	}
}


