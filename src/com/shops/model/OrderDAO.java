package com.shops.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class OrderDAO {
	
	Connection con = null;             // DB 연결하는 객체.
	PreparedStatement pstmt = null;    // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;               // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                 // SQL문을 저장할 객체.
	
	
	// OrderDAO 객체를 싱글톤 방식으로 만들어 보자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로
	//        기본 생성자의 접근 제어자를 private 으로 선언해야 함.
	// 2단계 : OrderDAO 객체를 정적 멤버로 선언해야 함. - static으로 선언해야 함.
	private static OrderDAO instance = null;
	
	
	private OrderDAO() {   }  // 기본생성자.
		
	// 3단계 : 기본 생성자 대신에 싱글턴 객체를 return 해 주는 getInstance() 라는
	//        메서드를 만들어서 여기에 접근하게 해야 함.
	public static OrderDAO getInstance() {
		
		if(instance == null) {
			instance = new OrderDAO();
		}
		return instance;
		
	}  // getInstance() 메서드 end
	
	
	// DB를 연동하는 작업을 진행하는 메서드
	public void openConn() {
		
		try {
			// 1단계 : JNDI 서버 객체 생성
			Context ctx = new InitialContext();
			
			// 2단계 : lookup() 메서드를 이용하여 매칭되는 커넥션을 찾는다.
			DataSource ds =
					(DataSource)ctx.lookup("java:comp/env/jdbc/myoracle");
			
			// 3단계 : DataSource 객체를 이용하여 커넥션 객체를 하나 가져온다.
			con = ds.getConnection();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
	}  // openConn() 메서드 end
	
	
	// DB에 연결된 객체를 종료하는 메서드.
	public void closeConn(ResultSet rs, 
			PreparedStatement pstmt, Connection con) {
		
		try {
			if(rs != null) {
				rs.close();
			}
			if(pstmt != null) {
				pstmt.close();
			}
			if(con != null) {
				con.close();
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
	}  // closeConn() 메서드 end
	
	// getOrderList() 메소드
	// 발주테이블 전체 내역을 조회하는 메소드
	public List<OrderDTO> getOrderList() {
		
		List<OrderDTO> list = new ArrayList<OrderDTO>();
		
		try {
			
			openConn();
			
			sql = "select * from shop_order order by order_date";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) { 
				
				OrderDTO dto = new OrderDTO();
				
				dto.setShop_id(rs.getString("shop_id"));
				dto.setPnum(rs.getString("pnum"));
				dto.setOrder_no(rs.getInt("order_no"));
				dto.setOrder_date(rs.getString("order_date"));
				dto.setOrder_check(rs.getString("order_check"));
				dto.setOrder_code(rs.getString("order_code"));
				dto.setOrder_comment(rs.getString("order_comment"));
				dto.setOrderok_date(rs.getString("orderok_date"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
		
	} // getOrderList() 메소드 end
	
	// getOrderCont() 메소드
	// 발주번호에 해당하는 상세내역을 조회하는 메소드
	public OrderContDTO getOrderCont(String code) {
		
		OrderContDTO dto = new OrderContDTO();
		
		try {
			
			openConn();
			
			sql = "select * "
					+ "from (select s.shop_name, p.pname, d.now_no, o.shop_id, o.pnum, o.order_no, o.order_date, o.order_code, o.order_comment, o.orderok_date, o.order_check "
					+ "from shop_login s, prod p, shop_order o, shop_prod d "
					+ "where s.shop_id = o.shop_id and p.pnum = o.pnum and s.shop_id = d.shop_id and p.pnum = d.pnum) "
					+ "where order_code = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, code);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto.setShop_name(rs.getString("shop_name"));
				dto.setPname(rs.getString("pname"));
				dto.setShop_id(rs.getString("shop_id"));
				dto.setPnum(rs.getString("pnum"));
				dto.setOrder_no(rs.getInt("order_no"));
				dto.setOrder_date(rs.getNString("order_date"));
				dto.setOrder_code(rs.getString("order_code"));
				dto.setNow_no(rs.getInt("now_no"));
				dto.setOrder_comment(rs.getString("order_comment"));
				dto.setOrderok_date(rs.getString("orderok_date"));
				dto.setOrder_check(rs.getString("order_check"));
				
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
		
	} // getOrderCont() 메소드 end
	
	// updateOrderCheck() 메소드
	// 요청한 발주에서 발주취소 처리 시 shop_order 테이블의 order_check를 수정하는 메소드
	public int updateOrderCheck(OrderDTO dto) {
		
		int result = 0;
		
		try {
			
			openConn();
			
			sql = "update shop_order set order_check = ?, order_comment = ?, orderok_date = sysdate where order_code = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getOrder_check());
			pstmt.setString(2, dto.getOrder_comment());
			pstmt.setString(3, dto.getOrder_code());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
	} // updateOrderCheck() 메소드 end
	
	// updateOrderNowno() 메소드
	// 요청한 발주에서 요청승인 처리 시 shop_prod 테이블의 now_no를 수정하는 메소드
	public int updateOrderNowno(OrderContDTO dto) {
		
		int result = 0;
		
		try {
			
			openConn();
			
			sql = "update shop_prod set now_no = now_no + ? where shop_id = ? and pnum = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getOrder_no());
			pstmt.setString(2, dto.getShop_id());
			pstmt.setString(3, dto.getPnum());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
	} // updateOrderNowno() 메소드 end
	
	// getOrderList() 메소드
	// 로그인한 매장에 해당하는 발주테이블 전체 내역을 조회하는 메소드
	public List<OrderDTO> getOrderShopList(String shopid) {
		
		List<OrderDTO> list = new ArrayList<OrderDTO>();
		
		try {
			
			openConn();
			
			sql = "select * from shop_order where shop_id = ? order by order_date";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, shopid);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) { 
				
				OrderDTO dto = new OrderDTO();
				
				dto.setShop_id(rs.getString("shop_id"));
				dto.setPnum(rs.getString("pnum"));
				dto.setOrder_no(rs.getInt("order_no"));
				dto.setOrder_date(rs.getString("order_date"));
				dto.setOrder_check(rs.getString("order_check"));
				dto.setOrder_code(rs.getString("order_code"));
				dto.setOrder_comment(rs.getString("order_comment"));
				dto.setOrderok_date(rs.getString("orderok_date"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
		
	} // getOrderList() 메소드 end
	
	// getOrderSetList() 메소드
	public List<OrderDTO> getOrderSetList(String shopid, String field, String date1, String date2) {
		
		List<OrderDTO> list = new ArrayList<OrderDTO>();
		
		openConn();
		
		if(field.equals("all")) {
			try {
				sql = "select * from shop_order "
						+ "where shop_id = ? "
						+ "and order_date between ? and ? "
						+ "order by order_date";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, shopid);
				pstmt.setString(2, date1);
				pstmt.setString(3, date2);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					OrderDTO dto = new OrderDTO();
					dto.setShop_id(rs.getString("shop_id"));
					dto.setPnum(rs.getString("pnum"));
					dto.setOrder_no(rs.getInt("order_no"));
					dto.setOrder_date(rs.getString("order_date"));
					dto.setOrder_check(rs.getString("order_check"));
					dto.setOrder_code(rs.getString("order_code"));
					
					list.add(dto);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(field.equals("order")) {
			try {
				sql = "select * from shop_order "
						+ "where shop_id = ? "
						+ "and order_date between ? and ?  "
						+ "and order_check = '요청' "
						+ "order by order_date";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, shopid);
				pstmt.setString(2, date1);
				pstmt.setString(3, date2);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					OrderDTO dto = new OrderDTO();
					dto.setShop_id(rs.getString("shop_id"));
					dto.setPnum(rs.getString("pnum"));
					dto.setOrder_no(rs.getInt("order_no"));
					dto.setOrder_date(rs.getString("order_date"));
					dto.setOrder_check(rs.getString("order_check"));
					dto.setOrder_code(rs.getString("order_code"));
					
					list.add(dto);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(field.equals("order_ok")) {
			try {
				sql = "select * from shop_order "
						+ "where shop_id = ? "
						+ "and order_date between ? and ?  "
						+ "and order_check = '발주승인' "
						+ "order by order_date";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, shopid);
				pstmt.setString(2, date1);
				pstmt.setString(3, date2);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					OrderDTO dto = new OrderDTO();
					dto.setShop_id(rs.getString("shop_id"));
					dto.setPnum(rs.getString("pnum"));
					dto.setOrder_no(rs.getInt("order_no"));
					dto.setOrder_date(rs.getString("order_date"));
					dto.setOrder_check(rs.getString("order_check"));
					dto.setOrder_code(rs.getString("order_code"));
					
					list.add(dto);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(field.equals("order_cancel")) {
			try {
				sql = "select * from shop_order "
						+ "where shop_id = ? "
						+ "and order_date between ? and ?  "
						+ "and order_check = '발주취소' "
						+ "order by order_date";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, shopid);
				pstmt.setString(2, date1);
				pstmt.setString(3, date2);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					OrderDTO dto = new OrderDTO();
					dto.setShop_id(rs.getString("shop_id"));
					dto.setPnum(rs.getString("pnum"));
					dto.setOrder_no(rs.getInt("order_no"));
					dto.setOrder_date(rs.getString("order_date"));
					dto.setOrder_check(rs.getString("order_check"));
					dto.setOrder_code(rs.getString("order_code"));
					
					list.add(dto);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}	// getOrderSetList 메서드 end
	
	// insertOrderList() 메소드
	public int insertOrderList(String shopid, String pnum, int order_no,String order_code) {
		int result = 0, count = 0;

			try {
				openConn();
				
				sql = "select max(order_code) from shop_order where shop_id = ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, shopid);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = Integer.parseInt(rs.getString(1).substring(8)) + 1;
				}else {
					count = 1;
				}
				
				sql = "insert into shop_order (shop_id, pnum, order_no, "
						+ "order_date, order_code) " + 
						"values (?, ?, ?, sysdate, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, shopid);
				pstmt.setString(2, pnum);
				pstmt.setInt(3, order_no);
				pstmt.setString(4, order_code+count);
				result = pstmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return result;
	}	// insertOrderList() 메서드 end;
	
	// deleteSalse() 메소드
	public int deleteSales(String order_code) {
		int result = 0;
		try {
			openConn();
			sql = "delete from shop_order "
					+ "where order_code = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, order_code);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	} // deleteSales() 메소드 end

}
