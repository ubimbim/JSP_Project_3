package com.shops.model;

public class SalesDTO {
	
	private int no;
	private String pname;
	private String shop_id;
	private int sales_no;
	private String sales_date;
	private int total;
	
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getShop_id() {
		return shop_id;
	}
	public void setShop_id(String shop_id) {
		this.shop_id = shop_id;
	}
	public int getSales_no() {
		return sales_no;
	}
	public void setSales_no(int sales_no) {
		this.sales_no = sales_no;
	}
	public String getSales_date() {
		return sales_date;
	}
	public void setSales_date(String sales_date) {
		this.sales_date = sales_date;
	}
	
	
}
