package com.shops.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
	
	//salesInsert메서드
	//매출 보고 내용 DB에 추가하는 메서드
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
	}	// salesInsert()메서드 end
	
	// 당일 보고된 매출 내역을 불러오는 메서드
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
	}	// salesToday()메서드 end
	
	// 당일 매출 총 금액을 불러오는 메서드
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
	
	// 제품 번호를 확인하는 메서드
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
	
	// 보고된 매출을 매출번호로 삭제하는 메서드
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
	
	// 매출을 삭제 후 매출번호를 갱신하는 메서드
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
	
	// 매장별  총 매출액을 불러오는 메서드
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
		}finally {
			closeConn(rs, pstmt, con);
		}
		return shopsales;
	}	// shopsales() 메서드 end
	
	// 제품별 총 매출을 불러오는 메서드
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
		}finally {
			closeConn(rs, pstmt, con);
		}
		return prodsales;
	}	// prodsales() 메서드 end
	
	// 해당 매장의 날자별 주간 매출을 불러오는 메서드
	public HashMap<String, Integer> allSales(String sdate, String edate, String shopid) {
		HashMap<String, Integer> result = new LinkedHashMap<String, Integer>();
		
		try {
			openConn();
			
			sql = "select sales_date, NVL(sum(sales_no*price), 0) as total " + 
					"from sales join prod on sales.pname = prod.pname " + 
					"where sales_date between to_date(? , 'YYYY/MM/DD') " + 
					"and to_date(? || ' 23:59:59', 'YYYY/MM/DD HH24:MI:SS') " + 
					"and shop_id = ? " + 
					"group by sales.sales_date " + 
					"order by sales_date";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sdate);
			pstmt.setString(2, edate);
			pstmt.setString(3, shopid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				result.put(rs.getString("sales_date"), rs.getInt("total"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	} // weekSales()메서드 end
	
	// 매장별 주간 매출 기록을 불러오는 메서드
	public HashMap<String, Integer> shopsalesweek(String sdate, String edate) {
		HashMap<String, Integer> shopsales = new HashMap<String, Integer>();
		
		try {
			openConn();
			sql = "select shop_id, NVL(sum(price*s.sales_no),0) as total " + 
					"from prod p join sales s " + 
					"on p.pname = s.pname " + 
					"where sales_date between to_date(? , 'YYYY/MM/DD') " + 
					"and to_date(? || ' 23:59:59', 'YYYY/MM/DD HH24:MI:SS') " + 
					"group by s.shop_id " + 
					"order by s.shop_id";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sdate);
			pstmt.setString(2, edate);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				shopsales.put(rs.getString("shop_id"), rs.getInt("total"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return shopsales;
	}	// shopsales() 메서드 end
	
	// 제품별 일정기간 매출을 불러오는 메서드
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
		}finally {
			closeConn(rs, pstmt, con);
		}
		return prodsales;
	}	// prodsales() 메서드 end
	
	// 특정 매장의 제품별 일정기간 매출을 불러오는 메서드
	public int[] shopprodsales(String sdate, String edate, String shopid) {
		int[] prodsales = new int[4];
		
		try {
			openConn();
			sql = "select NVL(sum(sales.sales_no),0) from sales " + 
					"where pname like 'iPad%' "
					+ "and sales_date between to_date(? , 'YYYY/MM/DD') and "
					+ "to_date(? || ' 23:59:59', 'YYYY/MM/DD HH24:MI:SS') "
					+ "and shop_id = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sdate);
			pstmt.setString(2, edate);
			pstmt.setString(3, shopid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				prodsales[0]=rs.getInt(1);
				sql = "select NVL(sum(sales.sales_no),0) from sales " + 
						"where pname like 'iPhone%' "
						+ "and sales_date between to_date(? , 'YYYY/MM/DD') and "
						+ "to_date(? || ' 23:59:59', 'YYYY/MM/DD HH24:MI:SS') "
						+ "and shop_id = ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, sdate);
				pstmt.setString(2, edate);
				pstmt.setString(3, shopid);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					prodsales[1]=rs.getInt(1);
					sql = "select NVL(sum(sales.sales_no),0) from sales " + 
							"where pname like 'AirPods%' " 
							+ "and sales_date between to_date(? , 'YYYY/MM/DD') and "
							+ "to_date(? || ' 23:59:59', 'YYYY/MM/DD HH24:MI:SS') "
							+ "and shop_id = ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, sdate);
					pstmt.setString(2, edate);
					pstmt.setString(3, shopid);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						prodsales[2]=rs.getInt(1);
						sql = "select NVL(sum(sales.sales_no),0) from sales " + 
								"where pname like 'AppleWatch%' "
								+ "and sales_date between to_date(? , 'YYYY/MM/DD') and "
								+ "to_date(? || ' 23:59:59', 'YYYY/MM/DD HH24:MI:SS') "
								+ "and shop_id = ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, sdate);
						pstmt.setString(2, edate);
						pstmt.setString(3, shopid);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							prodsales[3]=rs.getInt(1);}
					}
				}
			}
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return prodsales;
	}	// hopprodsales() 메서드 end
		
	// 월 매출 총 합계를 불러오는 메서드
	public int getMonthSales(String shopid, String month) {
		int total = 0;
		
		try {
			openConn();
			sql = "select sum(price*sales_no)  " + 
					"from sales left join prod " + 
					"on sales.pname = prod.pname  " + 
					"where shop_id = ? and " + 
					"sales_date like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, shopid);
			pstmt.setString(2, month+"%");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return total;
	} // getMonthSales()메서드 end;
	
	// 월간 매출 리스트를 불러오는 메서드
	public HashMap<String, Integer> getMonthList(String month, String shopid) {
		HashMap<String, Integer> result = new LinkedHashMap<String, Integer>();
		
		try {
			openConn();
			
			sql = "select sales_date, NVL(sum(sales_no*price), 0) as total " + 
					"from sales join prod on sales.pname = prod.pname " + 
					"where sales_date like ? " + 
					"and shop_id = ? " + 
					"group by sales.sales_date " + 
					"order by sales_date";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, month+"%");
			pstmt.setString(2, shopid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				result.put(rs.getString("sales_date"), rs.getInt("total"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	} // weekSales()메서드 end
}
