package quiz;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import quiz.Quiz;

public class QuizDAO {
	private Connection conn;
	private ResultSet rs;

	// DB 연결
	public QuizDAO() { 
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

	// 해당 방과 연결된 퀴즈 삭제
	public void removeConnectRoomQuiz(int roomNumber) {
		String SQL = "delete from quiz where roomNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNumber);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 날짜 가져오기
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

	// 전체 퀴즈 번호 증가
	public int getNext() {
		String SQL = "SELECT quizNumber FROM quiz ORDER BY quizNumber DESC";
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
		return -1; // DB 오류
	}

	// 해당 방의 퀴즈 번호 증가
	public int getNextR(int roomNumber) {
		String SQL = "SELECT quizRNumber FROM quiz WHERE roomNumber = ? ORDER BY quizRNumber DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}

	// 퀴즈 참가 수 증가
	public void quizHitCntUp(int quizNumber) {
		String SQL = "update quiz set quizHitCount=quizHitCount+1 where quizNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quizNumber);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 퀴즈 생성
	public int write(String quizTitle, String quizForm, String userID, String quizSelect1, String quizSelect2,
			String quizSelect3, String quizSelect4, String quizSelect5, int roomNumber) {
		String SQL = "INSERT INTO quiz VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, getNextR(roomNumber));
			pstmt.setString(3, quizTitle);
			pstmt.setString(4, quizForm);
			pstmt.setString(5, userID);
			pstmt.setString(6, getDate());
			pstmt.setString(7, quizSelect1);
			pstmt.setString(8, quizSelect2);
			pstmt.setString(9, quizSelect3);
			pstmt.setString(10, quizSelect4);
			pstmt.setString(11, quizSelect5);
			pstmt.setInt(12, 0);
			pstmt.setInt(13, roomNumber);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}

	// 퀴즈 목록
	public ArrayList<Quiz> getList(int pageNumber, int roomNumber) {
		String SQL = "SELECT * FROM quiz WHERE quizRNumber < ? AND roomNumber = ? ORDER BY quizRNumber DESC LIMIT 10";
		ArrayList<Quiz> list = new ArrayList<Quiz>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNextR(roomNumber) - (pageNumber - 1) * 10);
			pstmt.setInt(2, roomNumber);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Quiz quiz = new Quiz();
				quiz.setQuizNumber(rs.getInt(1));
				quiz.setQuizRNumber(rs.getInt(2));
				quiz.setQuizTitle(rs.getString(3));
				quiz.setQuizForm(rs.getString(4));
				quiz.setUserID(rs.getString(5));
				quiz.setQuizDate(rs.getString(6));
				quiz.setQuizSelect1(rs.getString(7));
				quiz.setQuizSelect2(rs.getString(8));
				quiz.setQuizSelect3(rs.getString(9));
				quiz.setQuizSelect4(rs.getString(10));
				quiz.setQuizSelect5(rs.getString(11));
				quiz.setQuizHitCnt(rs.getInt(12));
				quiz.setRoomNumber(rs.getInt(13));
				list.add(quiz);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // DB 오류
	}

	// 페이지 처리
	public int targetPage(int pageNumber, int roomNumber) {
		String SQL = "SELECT COUNT(quizRNumber) FROM quiz WHERE roomNumber = ? ORDER BY quizRNumber DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// pstmt.setInt(1, (pageNumber - 1) * 10);
			pstmt.setInt(1, roomNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getInt(1) % 10 == 0) {
					return rs.getInt(1) / 10 - (pageNumber - 1);
				} else {
					return (rs.getInt(1) / 10) + 1 - (pageNumber - 1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0; // DB 오류
	}

	// 퀴즈 삭제
	public int removeQuiz(int quizNumber) {
		String SQL = "DELETE FROM quiz WHERE quizNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quizNumber);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}

	// 퀴즈 가져오기
	public Quiz getQuiz(int quizNumber) {
		String SQL = "SELECT * FROM quiz WHERE quizNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quizNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Quiz quiz = new Quiz();
				quiz.setQuizNumber(rs.getInt(1));
				quiz.setQuizRNumber(rs.getInt(2));
				quiz.setQuizTitle(rs.getString(3));
				quiz.setQuizForm(rs.getString(4));
				quiz.setUserID(rs.getString(5));
				quiz.setQuizDate(rs.getString(6));
				quiz.setQuizSelect1(rs.getString(7));
				quiz.setQuizSelect2(rs.getString(8));
				quiz.setQuizSelect3(rs.getString(9));
				quiz.setQuizSelect4(rs.getString(10));
				quiz.setQuizSelect5(rs.getString(11));
				quiz.setQuizRNumber(rs.getInt(12));
				quiz.setRoomNumber(rs.getInt(13));
				return quiz;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // DB 오류
	}
}
