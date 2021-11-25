package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.BoardDAO;
import com.shops.model.BoardDTO;

public class BoardUpdateOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 수정 폼 페이지에서 입력받은 데이터를 DB에 저장하는 비지니스 로직
		// 첨부파일 저장될 위치
		String saveFolder = "C:\\NCS\\workspace(jsp)\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Project\\upload";
		
		// 첨부파일 사이즈
		int fileSize = 5*1024*1024;
		
		// 이진파일 업로드를 위한 객체 생성
		MultipartRequest multi = new MultipartRequest(request, saveFolder, fileSize, "UTF-8", new DefaultFileRenamePolicy());
		
		// hidden 데이터
		int board_no = Integer.parseInt(multi.getParameter("board_no"));
		int board_page = Integer.parseInt(multi.getParameter("board_page"));
		
		String board_code = multi.getParameter("board_code").trim();
		String board_writer = multi.getParameter("board_writer").trim();
		String board_title = multi.getParameter("board_title").trim();
		String board_content = multi.getParameter("board_content").trim();
		String board_img_new = multi.getFilesystemName("board_image_New");
		
		if(board_img_new == null) {
			board_img_new = multi.getParameter("board_image_Old");
		}
		
		BoardDTO dto = new BoardDTO();
		dto.setBoard_no(board_no);
		dto.setBoard_code(board_code);
		dto.setBoard_writer(board_writer);
		dto.setBoard_title(board_title);
		dto.setBoard_cont(board_content);
		dto.setBoard_image(board_img_new);
		
		BoardDAO dao = BoardDAO.getInstance();
		int res = dao.updateBoard(dto);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if(res>0) {
			forward.setRedirect(true);
			forward.setPath("admin_board_content.do?num=" + board_no + "&page=" + board_page);
		} else {
			out.println("<script>");
			out.println("alert('게시글 수정 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
