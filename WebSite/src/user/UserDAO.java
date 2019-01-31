/*DAO는 회원정보를 불러오거나 데이터베이스에 회원정보를 넣고 싶을 때 만드는 거래*/
package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserDAO {

	private Connection conn; /* 데이터베이스에 접근하게 해주는 객체래 */
	private PreparedStatement pstmt;
	private ResultSet rs; /* 어떠한 정보를 담을 수 있는 객체 */

	/* 여기서부터는 생성자 */
	public UserDAO() {
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

	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM User WHERE userID = ?"; /* 내가 넣게 될 sql 문장 */
		try {
			pstmt = conn.prepareStatement(SQL); // prepared statement 의 어떤 준비된 문장을 데이터베이스에 삽입하는 형식으로 인스턴스를 가져온다
			pstmt.setString(1, userID); // 가장 중요한데, 기본적으로 sql injection 을 위한 해킹 수단을 방어하는 거래. ? 에 해당하는 거에 userID 를 넣는 거래
			rs = pstmt.executeQuery(); // result set 에 쿼리 실행 결과를 넣어주느 ㄴ거야
			
			if (rs.next()) { // 결과가 존재한다면 이프 문 안에가 실행되고 아니라면 나머지 결과
				System.out.println("로그인 비번"+userPassword+"가져오는 비밀번호 : "+rs.getString(1));	
				if (rs.getString(1).equals(userPassword)) // 결과로 나온 userPassword 가 내가 넣은 userPassword 랑 같다면! 그렇다면 뒤가 내가
				{									// 넣은 값이구나
					return 1;// 로그인 성공을 하게 되는 것
				}
				else
					return 0;// 비밀번호 불일치
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace(); /* 여기도 역시 예외처리를 위한 문장 try 에서부터 catch가 그런 건 가봐 원래 */
			System.out.println("데ㅔㅂ오류");
		}
		return -2; // 데이터베이스 오류
	}

	public int join(User user) {
		String SQL = "INSERT INTO User VALUES (?, ?, ?, ?, ?, ?)";
		try {

			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getDeName());
			pstmt.setInt(6, 0);
			pstmt.executeUpdate();

			if (user.getSec1() != null) {
				SQL = "INSERT INTO Section_Has_Student VALUES (?,?)";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, user.getSec1());
				pstmt.setString(2, user.getUserID());
				pstmt.executeUpdate();
			}
			if (user.getSec2() != null) {
				SQL = "INSERT INTO Section_Has_Student VALUES (?,?)";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, user.getSec2());
				pstmt.setString(2, user.getUserID());
				pstmt.executeUpdate();
			}
			if (user.getSec3() != null) {
				SQL = "INSERT INTO Section_Has_Student VALUES (?,?)";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, user.getSec3());
				pstmt.setString(2, user.getUserID());
				pstmt.executeUpdate();
			}
			if (user.getSec4() != null) {
				SQL = "INSERT INTO Section_Has_Student VALUES (?,?)";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, user.getSec4());
				pstmt.setString(2, user.getUserID());
				pstmt.executeUpdate();
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("데베오류");
		}
		return -1;
	}

	public User getList(String userID) {
		String SQL = "SELECT * FROM User WHERE userID = ?";
		User user=new User(); ;
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserEmail(rs.getString(4));
				user.setUserdeName(rs.getString(5));
				user.setUserIf(rs.getInt(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	   public ArrayList<User> getEmailList(String userID){
	      String SQL = "SELECT * FROM User WHERE userID IN (SELECT shsUserID FROM Section_Has_Student WHERE shsSecName IN(SELECT secName FROM Section WHERE secUserName IN(SELECT userName FROM User Where userID=?)))";
	      ArrayList<User> list = new ArrayList<User>();
	      try {
	         PreparedStatement pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, userID);
	         rs = pstmt.executeQuery();
	      
	         while (rs.next()) {

		        System.out.println("아이디"+userID);
	            User user = new User();
	            user.setUserID(rs.getString(1));
	            user.setUserPassword(rs.getString(2));
	            user.setUserName(rs.getString(3));
	            user.setUserEmail(rs.getString(4));
	            user.setDeName(rs.getString(5));
	            user.setUserIf(rs.getInt(6));
	            System.out.println("이메일"+rs.getString(4));
	            list.add(user);
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      return list;   
	   }
	   
	   public ArrayList<User> get(String userID){
		      String SQL = "SELECT * FROM User WHERE userID IN (SELECT shsUserID FROM Section_Has_Student WHERE shsSecName IN(SELECT secName FROM Section WHERE secUserName IN(SELECT userName FROM User Where userID=?)))";
		      ArrayList<User> list = new ArrayList<User>();
		      try {
		         PreparedStatement pstmt = conn.prepareStatement(SQL);
		         pstmt.setString(1, userID);
		         rs = pstmt.executeQuery();
		      
		         while (rs.next()) {

			        System.out.println("아이디"+userID);
		            User user = new User();
		            user.setUserID(rs.getString(1));
		            user.setUserPassword(rs.getString(2));
		            user.setUserName(rs.getString(3));
		            user.setUserEmail(rs.getString(4));
		            user.setDeName(rs.getString(5));
		            user.setUserIf(rs.getInt(6));
		            System.out.println("이메일"+rs.getString(4));
		            list.add(user);
		         }
		      } catch (Exception e) {
		         e.printStackTrace();
		      }
		      return list;   
		   }
	   
	   public ArrayList<User> getstudysec (String secName){
		      String SQL = "SELECT * from User where userID IN(select shsUserID from Section_Has_Student where shsSecName=?)";
		      ArrayList<User> list = new ArrayList<User>();
		      try {
		         PreparedStatement pstmt = conn.prepareStatement(SQL);
		         pstmt.setString(1, secName);
		         rs = pstmt.executeQuery();
		      
		         while (rs.next()) {

			        System.out.println("수업"+secName);
		            User user = new User();
		            user.setUserID(rs.getString(1));
		            user.setUserPassword(rs.getString(2));
		            user.setUserName(rs.getString(3));
		            user.setUserEmail(rs.getString(4));
		            user.setDeName(rs.getString(5));
		            user.setUserIf(rs.getInt(6));
		            System.out.println("이메일"+rs.getString(4));
		            list.add(user);
		         }
		      } catch (Exception e) {
		         e.printStackTrace();
		      }
		      return list;   
		   }	  

}


