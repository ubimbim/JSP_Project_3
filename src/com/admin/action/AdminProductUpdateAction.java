package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.ProductDAO;
import com.shops.model.ProductDTO;

public class AdminProductUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String product_num = request.getParameter("pnum");
		
		ProductDAO dao = ProductDAO.getInstance();
		
		ProductDTO dto = dao.productCont(product_num);
		
		request.setAttribute("productDto", dto);
	
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("admin/admin_product_update.jsp");
		
		
		return forward;
	}

}
