package file;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class FileDAO {
	
	private Connection conn;
	
	public FileDAO() {
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
	
	
	public int upload(String fileName, String fileRealName,String text,String filesort) {
		String SQL = "INSERT INTO File VALUES (?, ?, ?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fileName);
			pstmt.setString(2, fileRealName);
			pstmt.setString(3, filesort );
			pstmt.setString(4, text);
			
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int hit(String fileRealName) {
		String SQL = "UPDATE File SET downloadCount = downloadCount + 1 "
				+ "WHERE fileRealName = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fileRealName);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<FileDTO> getList(String sort) {
		String SQL = "SELECT * FROM File WHERE sort= ?";
		ArrayList<FileDTO> list = new ArrayList<FileDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, sort);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				FileDTO file = new FileDTO(rs.getString(1), rs.getString(2),rs.getString(3),rs.getString(4));
				list.add(file);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
