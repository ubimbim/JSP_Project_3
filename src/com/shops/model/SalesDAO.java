package com.shops.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class SalesDAO {
	Connection con = null;             // DB 연결하는 객체.
	PreparedStatement pstmt = null;    // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;               // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                 // SQL문을 저장할 객체.
	String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    
	
	// SalesDAO 객체를 싱글톤 방식으로 만들어 보자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로
	//        기본 생성자의 접근 제어자를 private 으로 선언해야 함.
	// 2단계 : SalesDAO 객체를 정적 멤버로 선언해야 함. - static으로 선언해야 함.
	private static SalesDAO instance = null;
	
	
	private SalesDAO() {   }  // 기본생성자.
		
	// 3단계 : 기본 생성자 대신에 싱글턴 객체를 return 해 주는 getInstance() 라는
	//        메서드를 만들어서 여기에 접근하게 해야 함.
	public static SalesDAO getInstance() {
		
		if(instance == null) {
			instance = new SalesDAO();
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
	
	public int salesInsert(SalesDTO dto, String pnum, int sales_no, String shopid) {
		int result = 0, count = 0;
		
		try {
			openConn();
			
			sql = "select max(no) from sales";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql = "insert into sales values(?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setString(2, dto.getPname());
			pstmt.setString(3, dto.getShop_id());
			pstmt.setInt(4, dto.getSales_no());
			pstmt.setString(5, dto.getSales_date());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	// salesInsert() end
	
	public List<SalesDTO> salesToday(String shopid) {
		List<SalesDTO> list = new ArrayList<SalesDTO>();
		
		try {
			openConn();
			sql = "select no, sales.pname, shop_id, sales_no, sales_date, price " + 
					"from sales left join prod " + 
					"on sales.pname = prod.pname " + 
					"where sales_date = ? and shop_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, shopid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SalesDTO dto = new SalesDTO();
				dto.setNo(rs.getInt("no"));
				dto.setPname(rs.getString("pname"));
				dto.setShop_id(rs.getString("shop_id"));
				dto.setSales_no(rs.getInt("sales_no"));
				dto.setSales_date(rs.getString("sales_date"));
				dto.setTotal(rs.getInt("sales_no")*rs.getInt("price"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	}	// salesInsert() end
	
	public int totalToday(String shopid) {
		int result = 0;
		
		
		try {
			openConn();
			sql = "select sum(price*sales_no) as total " + 
				"from prod p left join sales s " + 
				"on p.pname = s.pname " + 
				"where s.sales_date = ? and "
				+ "shop_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, shopid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	//totalToday() 메서드 end
	
	public String getPnum(int no) {
		String result = null;
		try {
			openConn();
			
			sql = "select pnum from sales left join prod " + 
					"on prod.pname = sales.pname " + 
					"where no = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	// getPnum()메서드 end;
	
	public int deleteSales(int no) {
		int result = 0;
		
		try {
			openConn();
			
			sql = "delete from sales "
					+ "where no = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	// deleteSales()메서드 end;
	
	public int updateSalesNo(int no) {
		int result = 0;
		try {
			openConn();
			
			sql = "update sales set "
					+ " no = no - 1 "
					+ " where no > ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	// updateSalesNo()메서드 end;
	
	public ArrayList<Integer> shopsales() {
		ArrayList<Integer> shopsales = new ArrayList<>();
		
		try {
			openConn();
			sql = "select sum(price*s.sales_no)as total " + 
					"from prod p join sales s " + 
					"on p.pname = s.pname " + 
					"group by s.shop_id " + 
					"order by s.shop_id";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				shopsales.add(rs.getInt(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return shopsales;
	}	// shopsales() 메서드 end
	
	public int[] prodsales() {
		int[] prodsales = new int[4];
		
		try {
			openConn();
			sql = "select NVL(sum(sales.sales_no),0) from sales " + 
					"where pname like 'iPad%'";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				prodsales[0]=rs.getInt(1);
				sql = "select NVL(sum(sales.sales_no),0) from sales " + 
						"where pname like 'iPhone%'";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					prodsales[1]=rs.getInt(1);
					sql = "select NVL(sum(sales.sales_no),0) from sales " + 
							"where pname like 'AirPods%'";
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						prodsales[2]=rs.getInt(1);
						sql = "select NVL(sum(sales.sales_no),0) from sales " + 
								"where pname like 'AppleWatch%'";
						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							prodsales[3]=rs.getInt(1);}
					}
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return prodsales;
	}	// prodsales() 메서드 end
	
	public HashMap<String, Integer> weekSales(String date, String shopid) {
		HashMap<String, Integer> result = new HashMap<String, Integer>();
		
		try {
			openConn();
			
			sql = "select sales_date, NVL(sum(sales_no*price), 0) as total "
					+ "from sales join prod on sales.pname = prod.pname "
					+ "where sales_date >= ? and shop_id = ? "
					+ "group by sales.sales_date ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, shopid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				result.put(rs.getString("sales_date"), rs.getInt("total"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	public ArrayList<Integer> shopsalesweek(String sdate, String edate) {
		ArrayList<Integer> shopsales = new ArrayList<>();
		
		try {
			openConn();
			sql = "select sum(price*s.sales_no)as total " + 
					"from prod p join sales s " + 
					"on p.pname = s.pname " + 
					"where sales_date between ? and ? " + 
					"group by s.shop_id " + 
					"order by s.shop_id";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sdate);
			pstmt.setString(2, edate);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				shopsales.add(rs.getInt(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return shopsales;
	}	// shopsales() 메서드 end
	
	public int[] prodsalesweek(String sdate, String edate) {
		int[] prodsales = new int[4];
		
		try {
			openConn();
			sql = "select NVL(sum(sales.sales_no),0) from sales " + 
					"where pname like 'iPad%' "
					+ "and sales_date between ? and ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sdate);
			pstmt.setString(2, edate);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				prodsales[0]=rs.getInt(1);
				sql = "select NVL(sum(sales.sales_no),0) from sales " + 
						"where pname like 'iPhone%' "
						+ "and sales_date between ? and ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, sdate);
				pstmt.setString(2, edate);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					prodsales[1]=rs.getInt(1);
					sql = "select NVL(sum(sales.sales_no),0) from sales " + 
							"where pname like 'AirPods%' " 
							 + "and sales_date between ? and ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, sdate);
					pstmt.setString(2, edate);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						prodsales[2]=rs.getInt(1);
						sql = "select NVL(sum(sales.sales_no),0) from sales " + 
								"where pname like 'AppleWatch%' "
								+ "and sales_date between ? and ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, sdate);
						pstmt.setString(2, edate);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							prodsales[3]=rs.getInt(1);}
					}
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return prodsales;
	}	// prodsales() 메서드 end
}
