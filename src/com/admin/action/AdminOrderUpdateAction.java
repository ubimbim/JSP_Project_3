package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.OrderContDTO;
import com.shops.model.OrderDAO;
import com.shops.model.OrderDTO;

public class AdminOrderUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 발주 수정 폼에서 입력된 데이터드를 DB 저장하는 비지니스 로직
		int nownores = 0;
		int checkres = 0;
		
		String order_code = request.getParameter("order_code");
		int order_no = Integer.parseInt(request.getParameter("order_no"));
		String order_comment = request.getParameter("order_comment");
		String order_check = request.getParameter("order_check");
		int now_no = Integer.parseInt(request.getParameter("now_no"));
		String shop_id = request.getParameter("shop_id");
		String pnum = request.getParameter("pnum");
		
		OrderDTO dto = new OrderDTO();
		dto.setOrder_code(order_code);
		dto.setOrder_comment(order_comment);
		
		OrderContDTO contdto = new OrderContDTO();
		contdto.setOrder_no(order_no);
		contdto.setNow_no(now_no);
		contdto.setShop_id(shop_id);
		contdto.setPnum(pnum);

		OrderDAO dao = OrderDAO.getInstance();
		
		if(order_check.equals("confirm")) {
			
			order_check = "발주승인";
			dto.setOrder_check(order_check);
			
			nownores = dao.updateOrderNowno(contdto);
			checkres = dao.updateOrderCheck(dto);
			
			System.out.println("now no res >>> " + nownores);
			System.out.println("check res >>> " + checkres);
			
		} else if(order_check.equals("cancel")) {
			
			order_check = "발주취소";
			dto.setOrder_check(order_check);
			
			checkres = dao.updateOrderCheck(dto);
			
		}
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(nownores>0) {
			
			// if(nownores>0) { // 발주승인 클릭, 현재재고 수량 수정이 성공했을 때
				
			// }
			
			// else { // 발주취소 클릭, 현재재고 수량 수정 필요없을 때
				List<OrderDTO> list = dao.getOrderList();
				request.setAttribute("List", list);
				
				OrderContDTO cont = dao.getOrderCont(order_code);
				request.setAttribute("Cont", cont);
				
				forward.setRedirect(false);
				forward.setPath("admin/order_confirm.jsp");
			// }
			
		} else if(checkres>0) {
			
			List<OrderDTO> list = dao.getOrderList();
			request.setAttribute("List", list);
			
			OrderContDTO cont = dao.getOrderCont(order_code);
			request.setAttribute("Cont", cont);
			
			forward.setRedirect(false);
			forward.setPath("admin/order_confirm.jsp");
			
		} else { // 발주 상태 수정 실패, 현재재고 수량 수정 실패했을 때
			out.println("<script>");
			out.println("alert('수정 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		// forward.setPath("admin_order.do");
		return forward;
		
	}

}
