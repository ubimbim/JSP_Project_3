package com.shop.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shops.controller.Action;
import com.shops.controller.ActionForward;
import com.shops.model.ShopDTO;
import com.shops.model.ShopDAO;

public class UserProductListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		HttpSession session = request.getSession();
		
		String shop_id = (String)session.getAttribute("shopId");
		
		ShopDAO dao = ShopDAO.getInstance();
		
		List<ShopDTO> list = dao.getShopList(shop_id);
		
		request.setAttribute("shoplist", list);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("shop/user_product_list.jsp");
		
		
		return forward;
		
	}
}


