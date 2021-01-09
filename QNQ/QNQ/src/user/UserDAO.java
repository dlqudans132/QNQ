package user;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.DriverManager;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	// DB ����
	public UserDAO() {
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

	// �α���
	public int login(String userID, String userPassword) { // userID = admin & userPassword = 1234
		String SQL = "SELECT userPassword FROM user WHERE userID = ?";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {
					return 1; // �α��� ����
				} else
					return 0; // ��й�ȣ ����ġ
			}
			return -1; // ���̵� �������� ����

		} catch (Exception e) {
			e.printStackTrace();
		}

		return -2; // �����ͺ��̽� ����
	}

	// ȸ������
	public int join(User user) {
		String SQL = "INSERT INTO user VALUES(?, ?, ?)";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, getDate());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}

	// ��¥ �ҷ�����
	public String getDate() { 
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
