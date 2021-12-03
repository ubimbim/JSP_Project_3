package com.shop.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.ProductDAO;
import com.shops.model.ProductDTO;

public class UserAppleProductAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ProductDAO dao = ProductDAO.getInstance();
		
		//List<ProductDTO> list = dao.getProductList();
		List<ProductDTO> list = dao.getProductListwch();
		List<ProductDTO> list2 = dao.getProductListpod();
		List<ProductDTO> list3 = dao.getProductListpho();
		List<ProductDTO> list4 = dao.getProductListpad();
		
		//request.setAttribute("productList", list);
		request.setAttribute("productListwch", list);
		request.setAttribute("productListpod", list2);
		request.setAttribute("productListpho", list3);
		request.setAttribute("productListpad", list4);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("shop/user_apple_product.jsp");
		
		
		return forward;
	}

}
