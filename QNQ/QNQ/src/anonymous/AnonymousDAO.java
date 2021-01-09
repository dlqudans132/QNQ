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

	// DB ����
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

	// �͸� ���� DB ���
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
		return -1; // DB ����
	}

	// �͸� ���� �г��� ���
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

	// Ư�� ���� �͸����� ����
	public int removeConnectRoomAnonymous(int roomNumber) {
		String SQL = "DELETE FROM anonymous WHERE roomCode = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNumber);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}

	// �͸����� �г��� ��������
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
		return ""; // ����
	}

	// �͸����� ���
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
		return list; // DB ����
	}

	// �͸����� ��
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
		return -1; // ����
	}

	// �͸����� �ڵ� ��������
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

	
	public String getDate() { // ��¥
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
		return ""; // DB ����
	}
}
