package com.admin.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.BoardDAO;
import com.shops.model.BoardDTO;

public class BoardInsertAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 입력 폼 페이지에서 입력받은 데이터를 DB에 저장하는 비지니스 로직
		// 첨부파일이 저장될 위치(경로)를 성정
		String saveFolder = "C:\\NCS\\workspace(jsp)\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\Project\\upload";
		
		// 첨부파일 용량(크기) 제한 - 파일 업로드 최대 크기
		int fileSize = 5*1024*1024;	// 5MB
		
		// 이진 파일 업로드를 위한 객체 생성
		MultipartRequest multi = new MultipartRequest(
				request, 								// 일반적인 request 객체
				saveFolder,								// 첨부파일이 저장될 경로 
				fileSize,								// 업로드 할 파일의 최대 크기 
				"UTF-8",								// 문자 인코딩 방식
				new DefaultFileRenamePolicy()			// 파일명이 같은 경우 중복이 안되게 설정
		);
		
		String board_code = multi.getParameter("board_code").trim();
		String board_writer = multi.getParameter("board_writer").trim();
		String board_title = multi.getParameter("board_title").trim();
		String board_content = multi.getParameter("board_content").trim();
		
		String board_image = multi.getFilesystemName("board_image");
		
		BoardDTO dto = new BoardDTO();

		dto.setBoard_code(board_code);
		dto.setBoard_writer(board_writer);
		dto.setBoard_title(board_title);
		dto.setBoard_cont(board_content);
		dto.setBoard_image(board_image);
		
		BoardDAO dao = BoardDAO.getInstance();
		int res = dao.insertBoard(dto);
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(res>0) {
			forward.setRedirect(true);
			forward.setPath("admin_board_list.do");
		} else {
			out.println("<script>");
			out.println("alert('공지사항 등록 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
