package com.shops.model;

public class OrderDTO {

	private String shop_id;
	private String pnum;
	private int order_no;
	private String order_date;
	private String order_check;
	private String order_code;
	private String order_comment;
	private String orderok_date;
	
	public String getShop_id() {
		return shop_id;
	}
	public void setShop_id(String shop_id) {
		this.shop_id = shop_id;
	}
	public String getPnum() {
		return pnum;
	}
	public void setPnum(String pnum) {
		this.pnum = pnum;
	}
	public int getOrder_no() {
		return order_no;
	}
	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getOrder_check() {
		return order_check;
	}
	public void setOrder_check(String order_check) {
		this.order_check = order_check;
	}
	public String getOrder_code() {
		return order_code;
	}
	public void setOrder_code(String order_code) {
		this.order_code = order_code;
	}
	public String getOrder_comment() {
		return order_comment;
	}
	public void setOrder_comment(String order_comment) {
		this.order_comment = order_comment;
	}
	public String getOrderok_date() {
		return orderok_date;
	}
	public void setOrderok_date(String orderok_date) {
		this.orderok_date = orderok_date;
	}

}
