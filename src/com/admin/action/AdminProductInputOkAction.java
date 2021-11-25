package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.ProductDAO;
import com.shops.model.ProductDTO;

public class AdminProductInputOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String saveFolder = "C:\\NCS\\workspace(jsp)\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Project\\upload";
		int fileSize = 5 * 1024 * 1024;
		MultipartRequest multi = new MultipartRequest(
				request, 
				saveFolder, 
				fileSize,
				"UTF-8",
				new DefaultFileRenamePolicy()
	);
		String pimage = multi.getFilesystemName("pimage");
		String pnum = multi.getParameter("pnum").trim();
		String pname = multi.getParameter("pname").trim();
		int price = Integer.parseInt(multi.getParameter("price").trim());
		
		ProductDTO dto = new ProductDTO();
		dto.setPimage(pimage);
		dto.setPnum(pnum);
		dto.setPname(pname);
		dto.setPrice(price);
		
		ProductDAO dao = ProductDAO.getInstance();
		int res = dao.insertProduct(dto);
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(res > 0) {
			forward.setRedirect(true);
			forward.setPath("admin_product_list.do");   // 상품 목록 컨트롤러로 이동
		}else {
			out.println("<script>");
			out.println("alert('제품 등록 실패~~~')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
