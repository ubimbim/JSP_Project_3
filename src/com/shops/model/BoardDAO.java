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

import com.shops.model.BoardDAO;

public class BoardDAO {
	
	Connection con = null;             // DB 연결하는 객체.
	PreparedStatement pstmt = null;    // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;               // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                 // SQL문을 저장할 객체.
	
	
	// BoardDAO 객체를 싱글톤 방식으로 만들어 보자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로
	//        기본 생성자의 접근 제어자를 private 으로 선언해야 함.
	// 2단계 : BoardDAO 객체를 정적 멤버로 선언해야 함. - static으로 선언해야 함.
	private static BoardDAO instance = null;
	
	
	private BoardDAO() {   }  // 기본생성자.
		
	// 3단계 : 기본 생성자 대신에 싱글턴 객체를 return 해 주는 getInstance() 라는
	//        메서드를 만들어서 여기에 접근하게 해야 함.
	public static BoardDAO getInstance() {
		
		if(instance == null) {
			instance = new BoardDAO();
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
	
	// getBoardCount() 메소드
	// board 테이블의 전체 게시물의 수를 조회하는 메소드
	public int getBoardCount() {
		
		int count = 0;
		
		try {
			
			openConn();
			
			sql = "select count(*) from board";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			rs.close(); pstmt.close(); con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return count;
		
	} // getBoardCount() 메소드 end
	
	// getBoardList() 메소드
	// 게시글 전체 목록을 나타내는 메소드
	public List<BoardDTO> getBoardList(int page, int rowsize) {
		
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		
		// 해당 페이지에서의 시작 번호
		int startNo = (page*rowsize)-(rowsize-1);
		
		// 해당 페이지에서의 마지막 번호
		int endNo = (page*rowsize);
		
		try {
			
			openConn();
			
			sql = "select * from (select row_number() over(order by board_no desc) rnum, b.* from shop_board b) "
					+ "where rnum >= ? and rnum <= ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();
				
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setBoard_writer(rs.getString("board_writer"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_cont(rs.getString("board_cont"));
				dto.setBoard_code(rs.getString("board_code"));
				dto.setBoard_image(rs.getString("board_image"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_redate(rs.getString("board_redate"));
				
				list.add(dto);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
		
	} // getBoardList() 메소드 end
	
	// insertBoard() 메소드
	// 입력된 정보를 DB에 저장하는 메소드
	public int insertBoard(BoardDTO dto) {
		
		int result=0, count=0;
		
		try {
			
			openConn();
			
			sql = "select max(board_no) from shop_board";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1)+1;
			}
			
			sql = "insert into shop_board values(?, ?, ?, ?, ?, ?, sysdate, '')";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setString(2, dto.getBoard_writer());
			pstmt.setString(3, dto.getBoard_title());
			pstmt.setString(4, dto.getBoard_cont());
			pstmt.setString(5, dto.getBoard_code());
			pstmt.setString(6, dto.getBoard_image());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
	} // insertBoard() 메소드 end
	
	// getBoardCont() 메소드
	// 게시물 번호에 해당하는 게시물 상세내역 조회 메소드
	public BoardDTO getBoardCont(int no) {
		
		BoardDTO dto = new BoardDTO();
		
		try {
			
			openConn();
			
			sql = "select * from shop_board where board_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setBoard_writer(rs.getString("board_writer"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_cont(rs.getString("board_cont"));
				dto.setBoard_code(rs.getString("board_code"));
				dto.setBoard_image(rs.getString("board_image"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_redate(rs.getString("board_redate"));
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
		
	} // getBoardCont() 메소드 end
	
	// updateBoard() 메소드
	public int updateBoard(BoardDTO dto) {
		
		int result = 0;
		
		try {
			
			openConn();
			
			sql = "select * from shop_board where board_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getBoard_no());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				sql = "update shop_board set board_writer = ?, board_title = ?, board_cont = ?, board_code = ?, board_image = ?, board_redate = sysdate "
						+ "where board_no = ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, dto.getBoard_writer());
				pstmt.setString(2, dto.getBoard_title());
				pstmt.setString(3, dto.getBoard_cont());
				pstmt.setString(4, dto.getBoard_code());
				pstmt.setString(5, dto.getBoard_image());
				pstmt.setInt(6, dto.getBoard_no());
				
				result = pstmt.executeUpdate();
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
	} // updateBoard() 메소드 end
	
	// deleteBoard() 메소드
	public int deleteBoard(int no) {
		
		int result = 0;
		
		try {
			
			openConn();
			
			sql = "select * from shop_board where board_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				sql = "delete from shop_board where board_no = ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, no);
				
				result = pstmt.executeUpdate();
				
				sql = "update shop_board set board_no=board_no-1 where board_no > ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, no);
				
				pstmt.executeUpdate();
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
	} // deleteBoard() 메소드 end

}
