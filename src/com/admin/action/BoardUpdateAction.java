package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.startup.SetAllPropertiesRule;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.BoardDAO;
import com.shops.model.BoardDTO;

public class BoardUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// get방식으로 넘겨받은 페이지 번호와 게시물 번호를 가지고 DB에서 상세내역을 조회하여 수정 폼 페이지로 데이터를 넘겨주는 비지니스 로직
		int board_no = Integer.parseInt(request.getParameter("num"));
		int board_page = Integer.parseInt(request.getParameter("page"));
		
		BoardDAO dao = BoardDAO.getInstance();
		BoardDTO dto = dao.getBoardCont(board_no);
		
		request.setAttribute("Cont", dto);
		request.setAttribute("Page", board_page);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin/board_update.jsp");
		
		return forward;
	}

}
