package quizstat;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import quiz.Quiz;

public class QuizStatDAO {
	private Connection conn;
	private ResultSet rs;
	
	// DB ����
	public QuizStatDAO() { 
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

	// �ش� ��� ����� ���� ��� ����
	public void removeConnectRoomQuizStat(int roomNumber) {
		String SQL = "delete from quizstat where roomNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNumber);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
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
		String SQL = "SELECT quizStatNumber FROM quizstat ORDER BY quizStatNumber DESC";
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

	// ���� 1 ī��Ʈ
	public int cntSelect1(int quizNumber) {
		String SQL = "SELECT count(*) FROM quizresult WHERE quizNumber = ? AND quizSelect1 = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quizNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}
 
	// ���� 2 ī��Ʈ
	public int cntSelect2(int quizNumber) {
		String SQL = "SELECT count(*) FROM quizresult WHERE quizNumber = ? AND quizSelect2 = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quizNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}

	// ���� 3 ī��Ʈ
	public int cntSelect3(int quizNumber) {
		String SQL = "SELECT count(*) FROM quizresult WHERE quizNumber = ? AND quizSelect3 = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quizNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}

	// ���� 4  ī��Ʈ
	public int cntSelect4(int quizNumber) {
		String SQL = "SELECT count(*) FROM quizresult WHERE quizNumber = ? AND quizSelect4 = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quizNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}

	// ���� 5 ī��Ʈ
	public int cntSelect5(int quizNumber) {
		String SQL = "SELECT count(*) FROM quizresult WHERE quizNumber = ? AND quizSelect5 = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quizNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}

	// ���� O ī��Ʈ
	public int cntSelectO(int quizNumber) {
		String SQL = "SELECT count(*) FROM quizresult WHERE quizNumber = ? AND quizSelectO = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quizNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}

	// ���� X ī��Ʈ
	public int cntSelectX(int quizNumber) {
		String SQL = "SELECT count(*) FROM quizresult WHERE quizNumber = ? AND quizSelectX = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quizNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}

	// ������ ���� ��������
	public String getQuizForm(int quizNumber) {
		String SQL = "SELECT quizForm FROM quiz WHERE quizNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quizNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
			return "";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "NULL"; // DB ����
	}

	// ���� ��� ������Ʈ
	public int updateStat(int quizNumber, int roomNumber) {

		try {
			String SQL2 = "SELECT * FROM quizstat where quizNumber = ? AND roomNumber = ?";
			PreparedStatement pstmt2 = conn.prepareStatement(SQL2);
			pstmt2.setInt(1, quizNumber);
			pstmt2.setInt(2, roomNumber);
			rs = pstmt2.executeQuery();
			if (rs.next()) {
				String SQL3 = "UPDATE quizstat SET quizM1 = ?, quizM2 = ?,quizM3 = ?,quizM4 = ?,quizM5 = ?,quizO = ?, quizX = ? WHERE quizNumber = ? AND roomNumber = ?";
				PreparedStatement pstmt3 = conn.prepareStatement(SQL3);
				pstmt3.setInt(1, cntSelect1(quizNumber));
				pstmt3.setInt(2, cntSelect2(quizNumber));
				pstmt3.setInt(3, cntSelect3(quizNumber));
				pstmt3.setInt(4, cntSelect4(quizNumber));
				pstmt3.setInt(5, cntSelect5(quizNumber));
				pstmt3.setInt(6, cntSelectO(quizNumber));
				pstmt3.setInt(7, cntSelectX(quizNumber));
				pstmt3.setInt(8, quizNumber);
				pstmt3.setInt(9, roomNumber);
				return pstmt3.executeUpdate();
			} else {

				String SQL = "INSERT INTO quizstat VALUES (?,?,?,?,?,?,?,?,?,?,?)";

				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext());
				pstmt.setInt(2, quizNumber);
				pstmt.setString(3, getQuizForm(quizNumber));
				pstmt.setInt(4, cntSelect1(quizNumber));
				pstmt.setInt(5, cntSelect2(quizNumber));
				pstmt.setInt(6, cntSelect3(quizNumber));
				pstmt.setInt(7, cntSelect4(quizNumber));
				pstmt.setInt(8, cntSelect5(quizNumber));
				pstmt.setInt(9, cntSelectO(quizNumber));
				pstmt.setInt(10, cntSelectX(quizNumber));
				pstmt.setInt(11, roomNumber);
				return pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}

	// ���� ��� ����
	public int removeQuizstat(int quizNumber) {
		String SQL = "DELETE FROM quizstat WHERE quizNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quizNumber);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}

	// ���� ��� ��������
	public QuizStat getQuizStat(int quizNumber, int roomNumber) {
		String SQL = "SELECT * FROM quizstat WHERE quizNumber = ? AND roomNumber = ? ORDER BY quizStatNumber DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quizNumber);
			pstmt.setInt(2, roomNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				QuizStat quizstat = new QuizStat();
				quizstat.setQuizStatNumber(rs.getInt(1));
				quizstat.setQuizNumber(rs.getInt(2));
				quizstat.setQuizForm(rs.getString(3));
				quizstat.setQuizM1(rs.getInt(4));
				quizstat.setQuizM2(rs.getInt(5));
				quizstat.setQuizM3(rs.getInt(6));
				quizstat.setQuizM4(rs.getInt(7));
				quizstat.setQuizM5(rs.getInt(8));
				quizstat.setQuizO(rs.getInt(9));
				quizstat.setQuizX(rs.getInt(10));
				quizstat.setRoomNumber(rs.getInt(11));
				return quizstat;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // DB ����
	}
}
