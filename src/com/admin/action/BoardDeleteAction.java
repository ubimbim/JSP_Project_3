package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.BoardDAO;

public class BoardDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 게시물 번호에 해당하는 게시글 삭제하는 비지니스 로직
		int board_no = Integer.parseInt(request.getParameter("num"));
		int board_page = Integer.parseInt(request.getParameter("page"));
		
		BoardDAO dao = BoardDAO.getInstance();
		int res = dao.deleteBoard(board_no);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if(res>0) {
			forward.setRedirect(true);
			forward.setPath("admin_board_list.do?page="+board_page);
		} else {
			out.println("<script>");
			out.println("alert('게시글 삭제 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
