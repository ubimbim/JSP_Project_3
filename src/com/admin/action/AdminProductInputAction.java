package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.ProductDAO;
import com.shops.model.ProductDTO;

public class AdminProductInputAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		ProductDAO dao = ProductDAO.getInstance();
		List<ProductDTO> list = dao.getProductList();
		request.setAttribute("productList", list);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("admin/admin_product_input.jsp");
		return forward;
	}

}
