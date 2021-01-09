package anonymous;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import room.Room;

import java.sql.Connection;
import java.sql.DriverManager;

public class AnonymousDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	// DB 연결
	public AnonymousDAO() {
		try {

			String dbURL = "jdbc:mysql://localhost:3306/qnq?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "jwlee2021";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 익명 유저 DB 등록
	public int join(int roomCode, int anonyCnt) {
		String SQL = "INSERT INTO anonymous VALUES (?, ?, ?, ?, ?)";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, anonymousCode(roomCode, anonyCnt));
			pstmt.setString(2, getDate());
			pstmt.setInt(3, roomCode);
			pstmt.setInt(4, anonyCnt);
			pstmt.setString(5, null);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}

	// 익명 유저 닉네임 등록
	public void setNickname(String anonymousID, String anonymousNickname) {
		String SQL = "UPDATE anonymous SET anonymousNickname = ? WHERE anonymousID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, anonymousNickname);
			pstmt.setString(2, anonymousID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 특정 방의 익명유저 삭제
	public int removeConnectRoomAnonymous(int roomNumber) {
		String SQL = "DELETE FROM anonymous WHERE roomCode = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNumber);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}

	// 익명유저 닉네임 가져오기
	public String getNickname(String anonymousID) {
		String SQL = "SELECT anonymousNickname FROM anonymous WHERE anonymousID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, anonymousID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1) != null) {
					return rs.getString(1);
				} else {
					return anonymousID;
				}
			}

		} catch (Exception e) {

		}
		return ""; // 오류
	}

	// 익명유저 목록
	public ArrayList<Anonymous> getList(int roomNumber) {
		String SQL = "SELECT * FROM anonymous WHERE roomNumber = ?";
		ArrayList<Anonymous> list = new ArrayList<Anonymous>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNumber);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Anonymous anonymous = new Anonymous();
				anonymous.setAnonymousID(rs.getString(1));
				anonymous.setAnonymousDate(rs.getString(2));
				anonymous.setRoomCode(rs.getInt(3));
				anonymous.setAnonymousCnt(rs.getInt(4));
				anonymous.setAnonymousNickname(rs.getString(5));
				list.add(anonymous);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // DB 占쏙옙占쏙옙
	}

	// 익명유저 수
	public int anonymousCount() {
		String SQL = "SELECT anonymousCnt FROM anonymous ORDER BY anonymousCnt DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {

		}
		return -1; // 오류
	}

	// 익명유저 코드 가져오기
	public String anonymousCode(int roomCode, int anonyCnt) {
		try {
			String s;
			s = getDate().substring(0, 4) + String.format("%02d", roomCode) + String.format("%06d", anonyCnt);
			return s;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	
	public String getDate() { // 날짜
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // DB 오류
	}
}
