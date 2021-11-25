package com.shops.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.shops.model.AdminDAO;


public class AdminDAO {
	Connection con = null;             // DB 연결하는 객체.
	PreparedStatement ps = null;    // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;               // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                 // SQL문을 저장할 객체.
	
	
	// AdminDAO 객체를 싱글톤 방식으로 만들어 보자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로
	//        기본 생성자의 접근 제어자를 private 으로 선언해야 함.
	// 2단계 : ProductDAO 객체를 정적 멤버로 선언해야 함. - static으로 선언해야 함.
	private static AdminDAO instance = null;
	
	
	private AdminDAO() {   }  // 기본생성자.
		
	// 3단계 : 기본 생성자 대신에 싱글턴 객체를 return 해 주는 getInstance() 라는
	//        메서드를 만들어서 여기에 접근하게 해야 함.
	public static AdminDAO getInstance() {
		
		if(instance == null) {
			instance = new AdminDAO();
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
	
	// DB에 연결된 객체를 종료하는 메소드
	public void closeConn(ResultSet rs, PreparedStatement ps, Connection con) {
		
		try {
			if(rs != null) rs.close();
			if(ps != null) ps.close();
			if(con != null) con.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int adminCheck(String id, String pwd) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "select * from main_login where main_id = ?";
			
			ps = con.prepareStatement(sql);
			
			ps.setString(1, id);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				if(pwd.equals(rs.getString("main_pwd"))) {
					// 관리자인 경우(아이디와 비밀번호가 일치하는 관리자)
					result = 1;
				}else {
					// 비밀번호가 틀린 경우(아이디는 일치하나 비밀번호가 틀린 경우)
					result = -1;
					
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, ps, con);
		}
		
		return result;
	}	// adminCheck() 끝
	
		// 관리자에 대한 정보를 조회하는 메소드
		public AdminDTO getMain(String id) {
			AdminDTO dto = new AdminDTO();
			
			try {
				openConn();
				
				sql = "select * from main_login where main_id = ?";
				
				ps = con.prepareStatement(sql);
				
				ps.setString(1, id);
				
				rs = ps.executeQuery();
				
				if(rs.next()) {
					dto.setMain_id(rs.getString("main_id"));
					dto.setMain_pwd(rs.getString("main_pwd"));
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConn(rs, ps, con);
			}
			
			return dto;
		}	// getAdmin 끝
	
	
	
	
	
}
