package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Vo.MembersVo;
import Vo.TicketingCheckVo;
import movie.OracleConnectionUtil;

public class TicketingCheckDao {
	public static TicketingCheckDao tdao = new TicketingCheckDao();
	
	private TicketingCheckDao() {}
	
	public static TicketingCheckDao getInstance() {
		return tdao;
	}
	
	
	// 이름 및 아이디로 예매여부 확인
	public boolean login_Check(MembersVo mvo) {
		String sql = "SELECT * FROM members WHERE name = ? AND id = ?";
		
		Connection conn = OracleConnectionUtil.connect();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mvo.getName());
			pstmt.setString(2, mvo.getId());
			
			rs = pstmt.executeQuery();
			
			if (rs.next())
				return false;
			else
				return true;
			
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				pstmt.close();
				rs.close();
				OracleConnectionUtil.close(conn);
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
			
		}	// finally -end
		return false;
		
	}	// nameCheck -end
	
	
	// 이름 및 아이디로 예매내역 조회
	public List<TicketingCheckVo> name_Lookup(String name, String id) {
		String sql = "SELECT t.movie_name, t.movie_date, t.movie_time, t.movie_theater,\r"
				+ "s.movie_seat, p.pay_num, p.movie_price, p.pay_price\r"
				+ "	FROM TICKETINFO t , SEAT s , PAYMENT p\r"
				+ "WHERE t.MOVIE_CODE = (SELECT movie_code FROM payment\r"
				+ "WHERE mem_code = (SELECT mem_code FROM members WHERE name = ? AND id = ?))\r"
				+ "	AND p.mem_code = (SELECT mem_code FROM members WHERE name = ? AND id = ?)";
		
		Connection conn = OracleConnectionUtil.connect();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TicketingCheckVo> list = new ArrayList<TicketingCheckVo>();
		TicketingCheckVo tvo;
		
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, id);
			pstmt.setString(3, name);
			pstmt.setString(4, id);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				tvo = new TicketingCheckVo(rs.getString(1), rs.getDate(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getInt(6),
						rs.getInt(7), rs.getInt(8));
				list.add(tvo);
			}
			return list;
			
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				pstmt.close();
				rs.close();
				OracleConnectionUtil.close(conn);
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
			
		}	// finally -end
		return null;
		
	}	// name_Lookup -end
	
	
	
	
	// 아이디 및 패스워드로 예매내역 조회
	public List<TicketingCheckVo> id_Lookup(String id, String password) {
		String sql = "SELECT t.movie_name, t.movie_date, t.movie_time, t.movie_theater,"
				+ "s.movie_seat, p.pay_num, p.movie_price, p.movie_price\r\n"
				+ "	FROM TICKETINFO t , SEAT s , PAYMENT p\r\n"
				+ "WHERE t.MOVIE_CODE = (SELECT movie_code FROM payment\r\n"
				+ "	WHERE mem_code = (SELECT mem_code FROM members WHERE id = ? AND password = ?))\r"
				+ "	AND p.mem_code = (SELECT mem_code FROM members WHERE id = ? AND password = ?)";
		
		
		Connection conn = OracleConnectionUtil.connect();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TicketingCheckVo> list = new ArrayList<TicketingCheckVo>();
		TicketingCheckVo tvo;
		
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			pstmt.setString(3, id);
			pstmt.setString(4, password);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				tvo = new TicketingCheckVo(rs.getString(1), rs.getDate(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getInt(6),
						rs.getInt(7), rs.getInt(8));
				list.add(tvo);
			}
			return list;
			
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				pstmt.close();
				rs.close();
				OracleConnectionUtil.close(conn);
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
			
		}	// finally -end
		return null;
		
	}	// id_Lookup -end
	
	
	
	
	
	
	// 전화번호로 예매내역 조회
	public List<TicketingCheckVo> tel_Lookup(String tel) {
		String sql = "SELECT t.movie_name, t.movie_date, t.movie_time, t.movie_theater,"
				+ "s.movie_seat, p.pay_num, p.movie_price, p.movie_price\r\n"
				+ "	FROM TICKETINFO t , SEAT s , PAYMENT p\r\n"
				+ "WHERE t.MOVIE_CODE = (SELECT movie_code FROM payment\r\n"
				+ "	WHERE mem_code = (SELECT mem_code FROM members WHERE tel = ?))\r"
				+ "	AND p.mem_code = (SELECT mem_code FROM members WHERE tel = ?)";
		
		Connection conn = OracleConnectionUtil.connect();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TicketingCheckVo> list = new ArrayList<TicketingCheckVo>();
		TicketingCheckVo tvo;	// 질문하기(while 안에 들어가야 하는지)
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tel);
			pstmt.setString(2, tel);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				tvo = new TicketingCheckVo(rs.getString(1), rs.getDate(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getInt(6),
						rs.getInt(7), rs.getInt(8));
				list.add(tvo);
			}
			return list;
			
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				pstmt.close();
				rs.close();
				OracleConnectionUtil.close(conn);
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
			
		}	// finally -end
		return null;
		
	}	// tel_Lookup -end
	
	
	// 결제코드로 예매내역 조회
	public List<TicketingCheckVo> code_Lookup(String pay_code) {
		String sql = "SELECT t.movie_name, t.movie_date, t.movie_time, t.movie_theater,"
				+ "s.movie_seat, p.pay_num, p.movie_price, p.movie_price\r\n"
				+ "	FROM TICKETINFO t , SEAT s , PAYMENT p\r\n"
				+ "WHERE t.MOVIE_CODE = (SELECT movie_code FROM payment WHERE pay_code = ?)\r"
				+ "	AND p.pay_code = ?";
		
		Connection conn = OracleConnectionUtil.connect();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TicketingCheckVo> list = new ArrayList<TicketingCheckVo>();
		TicketingCheckVo tvo;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pay_code);
			pstmt.setString(2, pay_code);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				tvo = new TicketingCheckVo(rs.getString(1), rs.getDate(2), rs.getString(3),
						rs.getString(4), rs.getString(5), rs.getInt(6),
						rs.getInt(7), rs.getInt(8));
				list.add(tvo);
			}
			return list;
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				pstmt.close();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
			
			OracleConnectionUtil.close(conn);
		}	// finally -end
		return null;
		
	}	// code_Lookup -end

	
}	// class -end
