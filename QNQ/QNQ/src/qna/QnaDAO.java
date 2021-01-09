package qna;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import quiz.Quiz;

public class QnaDAO {
	private Connection conn;
	private ResultSet rs;

	// DB 연결
	public QnaDAO() { 
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


	// 전체 QNA 번호 증가
	public int getNext() {
		String SQL = "SELECT qnaNumber FROM qna ORDER BY qnaNumber DESC";
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

	// 해당 방의 종속된 QNA 번호 증가
	public int getNextR(int roomNumber) {
		String SQL = "SELECT qnaRNumber FROM qna WHERE roomNumber = ? ORDER BY qnaRNumber DESC";
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

	// 해당 방의 질문 수
	public int qnaCnt(int roomNumber) {
		String SQL = "SELECT count(*) FROM qna WHERE roomNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}

	// 질문 글 쓰기
	public int write(int roomNumber, String anonymousID, String qnaQuestion) {
		String SQL = "INSERT INTO qna VALUES (?,?,?,?,?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, getNextR(roomNumber));
			pstmt.setInt(3, roomNumber);
			pstmt.setString(4, anonymousID);
			pstmt.setString(5, qnaQuestion);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}

	// 방과 연결된 질문 삭제
	public int removeConnectRoomQna(int roomNumber) {
		String SQL = "DELETE FROM qna WHERE roomNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNumber);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}

	// 방의 질문 목록 불러오기
	public ArrayList<Qna> getList(int pageNumber, int roomNumber) {
		String SQL = "SELECT * FROM qna WHERE qnaRNumber < ? AND roomNumber = ? ORDER BY qnaRNumber DESC LIMIT 10";
		ArrayList<Qna> list = new ArrayList<Qna>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNextR(roomNumber) - (pageNumber - 1) * 10);
			pstmt.setInt(2, roomNumber);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Qna qna = new Qna();
				qna.setQnaNumber(rs.getInt(1));
				qna.setQnaRNumber(rs.getInt(2));
				qna.setRoomNumber(rs.getInt(3));
				qna.setAnonymousID(rs.getString(4));
				qna.setQnaQuestion(rs.getString(5));
				list.add(qna);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // DB 오류
	}

	// 페이지 처리
	public int targetPage(int pageNumber, int roomNumber) {
		String SQL = "SELECT COUNT(qnaRNumber) FROM qna WHERE roomNumber = ? ORDER BY qnaRNumber DESC";
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


}
