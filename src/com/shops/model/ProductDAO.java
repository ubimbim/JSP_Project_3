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




	
	public class ProductDAO {

		Connection con = null;             // DB 연결하는 객체.
		PreparedStatement pstmt = null;    // DB에 SQL문을 전송하는 객체.
		ResultSet rs = null;               // SQL문을 실행 후 결과 값을 가지고 있는 객체.
		
		String sql = null;                 // SQL문을 저장할 객체.
		
		
		// ProductDAO 객체를 싱글톤 방식으로 만들어 보자.
		// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로
		//        기본 생성자의 접근 제어자를 private 으로 선언해야 함.
		// 2단계 : ProductDAO 객체를 정적 멤버로 선언해야 함. - static으로 선언해야 함.
		private static ProductDAO instance = null;
		
		
		private ProductDAO() {   }  // 기본생성자.
			
		// 3단계 : 기본 생성자 대신에 싱글턴 객체를 return 해 주는 getInstance() 라는
		//        메서드를 만들어서 여기에 접근하게 해야 함.
		public static ProductDAO getInstance() {
			
			if(instance == null) {
				instance = new ProductDAO();
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
		
		public int insertProduct(ProductDTO dto) {
			
			int result = 0;
			
			try {
				openConn();
				
				sql = "insert into prod values(?, ?, ?, ?)";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, dto.getPnum());
				pstmt.setString(2, dto.getPname());
				pstmt.setInt(3, dto.getPrice());
				pstmt.setString(4, dto.getPimage());
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			
			return result;
		}
	

		public List<ProductDTO> getProductList() {
		
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		
		try {
			openConn();
			
			sql = "select * from prod order by pnum desc";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();
				
				dto.setPimage(rs.getString("pimage"));
				dto.setPnum(rs.getString("pnum"));
				dto.setPname(rs.getString("pname"));				
				dto.setPrice(rs.getInt("price"));
		
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
	}
		public ProductDTO productCont(String pnum) {
			
			ProductDTO dto = new ProductDTO();
			
			try {
				openConn();
				
				sql = "select * from prod "
						+ " where pnum = ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, pnum);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					
					dto.setPimage(rs.getString("pimage"));
					dto.setPnum(rs.getString("pnum"));
					dto.setPname(rs.getString("pname"));				
					dto.setPrice(rs.getInt("price"));
					
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			
			return dto;
		}
		
		public int updateProduct(ProductDTO dto) {
			
			int result = 0;
			
			try {
				openConn();
				
				sql = "update prod set pname =?, price = ?, pimage = ? where pnum = ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, dto.getPname());
				pstmt.setInt(2, dto.getPrice());
				pstmt.setString(3, dto.getPimage());
				pstmt.setString(4, dto.getPnum());
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			
			return result;
		}
		
		public int deleteProduct(String num) {
			
			int result = 0;
			
			try {
				openConn();
				
				sql = "delete from prod where pnum = ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, num);
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			
			return result;
		}
		
		public List<ProductDTO> getProductcontrol() {
			
			List<ProductDTO> list = new ArrayList<ProductDTO>();
			
			try {
				openConn();
				
				sql = "select shop_prod.shop_id, shop_prod.pnum,prod.pname,shop_prod.now_no from shop_prod left join prod on shop_prod.pnum = prod.pnum where now_no < 11 order by shop_id desc";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ProductDTO dto = new ProductDTO();
					
					dto.setShop_id(rs.getString("shop_id"));
					dto.setPnum(rs.getString("pnum"));
					dto.setPname(rs.getString("pname"));				
					dto.setNow_no(rs.getInt("now_no"));
			
					list.add(dto);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			
			return list;
		
			}
	}
	
