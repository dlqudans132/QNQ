package quizresult;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import anonymous.Anonymous;
import quiz.Quiz;

public class QuizResultDAO {
	private Connection conn;
	private ResultSet rs;

	// DB ����
	public QuizResultDAO() { 
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

	// �ش� ��� ����� ������ ����
	public void removeConnectRoomQuizResult(int roomNumber) {
		String SQL = "delete from quizresult where roomNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNumber);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// ���� ��� ����
	public int removeQuizresult(int quizNumber) {
		String SQL = "DELETE FROM quizresult WHERE quizNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quizNumber);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}

	// ���� ��� ��� �ҷ�����
	public ArrayList<QuizResult> getSubList(int roomNumber, int quizNumber) {
		String SQL = "SELECT * FROM quizresult WHERE roomNumber = ? AND quizNumber = ?";
		ArrayList<QuizResult> list = new ArrayList<QuizResult>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNumber);
			pstmt.setInt(2, quizNumber);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				QuizResult quizResult = new QuizResult();
				quizResult.setQuizResultNumber(rs.getInt(1));
				quizResult.setQuizNumber(rs.getInt(2));
				quizResult.setRoomNumber(rs.getInt(3));
				quizResult.setUserID(rs.getString(4));
				quizResult.setAnonymousID(rs.getString(5));
				quizResult.setQuizForm(rs.getString(6));
				quizResult.setQuizSelect1(rs.getString(7));
				quizResult.setQuizSelect2(rs.getString(8));
				quizResult.setQuizSelect3(rs.getString(9));
				quizResult.setQuizSelect4(rs.getString(10));
				quizResult.setQuizSelect5(rs.getString(11));
				quizResult.setQuizSelectO(rs.getString(12));
				quizResult.setQuizSelectX(rs.getString(13));
				quizResult.setQuizS(rs.getString(14));
				list.add(quizResult);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // DB ����
	}

	// ���� �ְ��� ��������
	public String getSub(String anonymousID, int quizNumber) {
		String SQL = "SELECT quizSelectS FROM quizresult WHERE anonymousID = ? AND quizNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, anonymousID);
			pstmt.setInt(2, quizNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	// ��¥ ��������
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

	// ��ü ���� ����� ��ȣ ����
	public int getNext() {
		String SQL = "SELECT quizResultNumber FROM quizresult ORDER BY quizResultNumber DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}

	// ���� �������� Ȯ��
	public int quizSolveCheck(int quizNumber, String anonymousCode) {
		String SQL = "SELECT * FROM quizresult WHERE quizNumber = ? AND anonymousID = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quizNumber);
			pstmt.setString(2, anonymousCode);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return 1; // ������ Ǯ��
			}
			return 0; // ���� �� Ǯ����

		} catch (Exception e) {
			e.printStackTrace();
		}

		return -2; // �����ͺ��̽� ����
	}

	// ���� ��� ����
	public int write(int quizNumber, int roomNumber, String userID, String anonymousID, String quizForm, String quiz1,
			String quiz2, String quiz3, String quiz4, String quiz5, String quizO, String quizX, String quizS) {
		String SQL = "INSERT INTO quizresult VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, quizNumber);
			pstmt.setInt(3, roomNumber);
			pstmt.setString(4, userID);
			pstmt.setString(5, anonymousID);
			pstmt.setString(6, quizForm);
			pstmt.setString(7, quiz1);
			pstmt.setString(8, quiz2);
			pstmt.setString(9, quiz3);
			pstmt.setString(10, quiz4);
			pstmt.setString(11, quiz5);
			pstmt.setString(12, quizO);
			pstmt.setString(13, quizX);
			pstmt.setString(14, quizS);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}
}

