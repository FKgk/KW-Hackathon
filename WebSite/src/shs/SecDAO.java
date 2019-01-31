package shs;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.DriverManager;


public class SecDAO {
	
	private Connection conn; /*데이터베이스에 접근하게 해주는 객체래*/
	private PreparedStatement pstmt;
	private ResultSet rs; /*어떠한 정보를 담을 수 있는 객체*/

	/*여기서부터는 생성자*/
	public SecDAO() {
	      try {
				String dbURL="jdbc:mysql://localhost:3306/bbs";
		         String dbID="root";
		         String dbPassword="0000";
	         Class.forName("com.mysql.jdbc.Driver");
	         conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
	               
	      }catch(Exception e) {
	         e.printStackTrace();
	      }
	   }
	
	 public ArrayList<Sec> getSec(String userID) { 
		  String SQL ="SELECT * FROM Section WHERE secName IN(SELECT shsSecName FROM Section_has_Student where shsUserID =?)";
		  ArrayList<Sec> list = new ArrayList<Sec>();
		  try {
		  pstmt = conn.prepareStatement(SQL); //prepared statement 의 어떤 준비된 문장을
		  pstmt.setString(1, userID); // 가장 중요한데, 기본적으로
		  rs =pstmt.executeQuery(); // result set 에 쿼리 실행 결과를 넣어주느 ㄴ거야 if (rs.next()) {
		  while (rs.next()) {
				Sec sec = new Sec();
				sec.setSecName(rs.getString(1));
				sec.setSecDaysTime(rs.getString(2));
				sec.setSecCoCode(rs.getString(3));
				sec.setSecUserName(rs.getString(4));
				list.add(sec);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	  }
	 
	 public ArrayList<Sec> getproSec(String userID) { 
		  String SQL ="SELECT * FROM Section WHERE secUserName IN(SELECT userName FROM User where userID =?)";
		  ArrayList<Sec> list = new ArrayList<Sec>();
		  try {
		  pstmt = conn.prepareStatement(SQL); //prepared statement 의 어떤 준비된 문장을
		  pstmt.setString(1, userID); // 가장 중요한데, 기본적으로
		  rs =pstmt.executeQuery(); // result set 에 쿼리 실행 결과를 넣어주느 ㄴ거야 if (rs.next()) {
		  while (rs.next()) {
				Sec sec = new Sec();
				sec.setSecName(rs.getString(1));
				sec.setSecDaysTime(rs.getString(2));
				sec.setSecCoCode(rs.getString(3));
				sec.setSecUserName(rs.getString(4));
				list.add(sec);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	  }
	 public ArrayList<Sec> getstuSec(String userID) { 
		  String SQL ="SELECT * FROM Section WHERE secName IN(SELECT shsSecName From Section_Has_Student WHERE shsUserID =?)";
		  ArrayList<Sec> list = new ArrayList<Sec>();
		  try {
		  pstmt = conn.prepareStatement(SQL); //prepared statement 의 어떤 준비된 문장을
		  pstmt.setString(1, userID); // 가장 중요한데, 기본적으로
		  rs =pstmt.executeQuery(); // result set 에 쿼리 실행 결과를 넣어주느 ㄴ거야 if (rs.next()) {
		  while (rs.next()) {
				Sec sec = new Sec();
				sec.setSecName(rs.getString(1));
				sec.setSecDaysTime(rs.getString(2));
				sec.setSecCoCode(rs.getString(3));
				sec.setSecUserName(rs.getString(4));
				list.add(sec);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	  }

}
