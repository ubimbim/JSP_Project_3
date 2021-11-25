package com.shops.model;

public class BoardDTO {
	
	private int board_no;			// 게시물 번호
	private String board_writer;	// 게시물 작성자
	private String board_title;		// 게시물 제목
	private String board_cont;		// 게시물 내용
	private String board_code;		// 게시물 분류
	private String board_image;		// 게시물 이미지
	private String board_date;		// 게시물 작성날짜
	private String board_redate;	// 게시물 수정날짜
	
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getBoard_writer() {
		return board_writer;
	}
	public void setBoard_writer(String board_writer) {
		this.board_writer = board_writer;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_cont() {
		return board_cont;
	}
	public void setBoard_cont(String board_cont) {
		this.board_cont = board_cont;
	}
	public String getBoard_code() {
		return board_code;
	}
	public void setBoard_code(String board_code) {
		this.board_code = board_code;
	}
	public String getBoard_image() {
		return board_image;
	}
	public void setBoard_image(String board_image) {
		this.board_image = board_image;
	}
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	public String getBoard_redate() {
		return board_redate;
	}
	public void setBoard_redate(String board_redate) {
		this.board_redate = board_redate;
	}

}
