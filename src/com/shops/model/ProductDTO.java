package com.shops.model;

public class ProductDTO {
		
		private String pimage;
		private String pnum;
		private String pname;
		private int price;
		private String shop_id;
		private int now_no;
		private String pcont;
		
		public String getPcont() {
			return pcont;
		}
		public void setPcont(String pcont) {
			this.pcont = pcont;
		}
		public String getShop_id() {
			return shop_id;
		}
		public void setShop_id(String shop_id) {
			this.shop_id = shop_id;
		}
		public int getNow_no() {
			return now_no;
		}
		public void setNow_no(int now_no) {
			this.now_no = now_no;
		}
		public String getPimage() {
			return pimage;
		}
		public void setPimage(String pimage) {
			this.pimage = pimage;
		}
		public String getPnum() {
			return pnum;
		}
		public void setPnum(String pnum) {
			this.pnum = pnum;
		}
		public String getPname() {
			return pname;
		}
		public void setPname(String pname) {
			this.pname = pname;
		}
		public int getPrice() {
			return price;
		}
		public void setPrice(int price) {
			this.price = price;
		}
		
}
