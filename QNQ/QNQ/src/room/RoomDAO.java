package room;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import room.Room;

public class RoomDAO {
	private Connection conn;
	private ResultSet rs;
	private PreparedStatement pstmt;

	// DB 연결
	public RoomDAO() { 
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

	// 페이지 처리
	public int targetPage(int pageNumber, String userID) {
		String SQL = "SELECT COUNT(*) FROM room WHERE userID = ? ORDER BY roomNumber DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// pstmt.setInt(1, (pageNumber - 1) * 10);
			pstmt.setString(1, userID);
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

	// 방 닫기
	public int roomClose(int roomCode) {
		String SQL = "UPDATE room SET roomAvailable = 0 WHERE roomNumber = ";
		SQL += "'" + roomCode + "'";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 방 삭제
	public int roomDelete(int roomCode) {
		String SQL = "UPDATE room SET roomAvailable = 2 WHERE roomNumber = ";
		SQL += "'" + roomCode + "'";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 다음 방 번호 지정
	public int getNextRoomNumber(String userID) {
		String SQL = "SELECT COUNT(*) FROM room WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
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

	// 방 제목 가져오기
	public String getRoomTitle(int roomNumber) { 
		String SQL = "SELECT * FROM room WHERE roomNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(3);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; 
	}

	// 방 생성자 가져오기
	public String getRoomMaker(int roomNumber) {
		String SQL = "SELECT * FROM room WHERE roomNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(2);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; 
	}

	// 방 번호 가져오기
	public int getRoomNumber(String userID, int roomCode) { 
		String SQL = "SELECT * FROM room WHERE userID = ? AND roomCode = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, roomCode);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 날짜 가져오기
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
		return "";
	}

	// 해당 유저의 생성한 방의 개수 불러오기
	public int getRoomCnt(String userID) {
		String SQL = "SELECT COUNT(*) FROM room WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 모든 방의 수 불러오기
	public int getRoomCntAll() {
		String SQL = "SELECT COUNT(*) FROM room";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 참가 코드 만들기
	public String createJoinCode(String userID, int roomNumber) {

		try {
			String code;
			String date = getDate();
			String cutDate = date.substring(5, 7) + date.substring(8, 10);
			String s = String.format("%06d", roomNumber);
			code = userID + s + cutDate;
			return code;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";

	}

	// 참가 코드 불러오기
	public String getRoomJoinCode(int roomNumber) { 
		String SQL = "SELECT * FROM room WHERE roomNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(6);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; 
	}

	// 전체 방의 번호 증가
	public int getNext() {
		String SQL = "SELECT roomNumber FROM room ORDER BY roomNumber DESC";
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
		return -1;
	}

	// 방 생성
	public int write(String userID, String roomTitle, String roomPassword, int roomCode) {

		String SQL2 = "SELECT * from room WHERE userID = ? AND roomCode = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL2);
			pstmt.setString(1, userID);
			pstmt.setInt(2, roomCode);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return 2;
			} else {
				String SQL = "INSERT INTO room VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
				PreparedStatement pstmt2 = conn.prepareStatement(SQL);
				pstmt2.setInt(1, getNext());
				pstmt2.setString(2, userID);
				pstmt2.setString(3, roomTitle);
				pstmt2.setString(4, roomPassword);
				pstmt2.setInt(5, roomCode);
				pstmt2.setString(6, createJoinCode(userID, roomCode));
				pstmt2.setInt(7, 1);
				pstmt2.setString(8, getDate());
				return pstmt2.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}

	// 방 목록 불러오기
	public ArrayList<Room> getList(int pageNumber, String userID) {
		String SQL = "SELECT * FROM room WHERE roomCode < ? AND userID = ? ORDER BY roomCode DESC LIMIT 10";
		ArrayList<Room> list = new ArrayList<Room>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNextR(userID) - (pageNumber - 1) * 10);
			pstmt.setString(2, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Room room = new Room();
				room.setRoomNumber(rs.getInt(1));
				room.setUserID(rs.getString(2));
				room.setRoomTitle(rs.getString(3));
				room.setRoomPassword(rs.getString(4));
				room.setRoomCode(rs.getInt(5));
				room.setRoomJoinCode(rs.getString(6));
				room.setRoomAvailable(rs.getInt(7));
				room.setRoomDate(rs.getString(8));
				list.add(room);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}

	// 어드민을 위한 방 불러오기
	public ArrayList<Room> getListAdmin(int pageNumber) {
		String SQL = "SELECT * FROM room WHERE roomNumber < ? ORDER BY roomNumber DESC LIMIT 10";
		ArrayList<Room> list = new ArrayList<Room>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Room room = new Room();
				room.setRoomNumber(rs.getInt(1));
				room.setUserID(rs.getString(2));
				room.setRoomTitle(rs.getString(3));
				room.setRoomPassword(rs.getString(4));
				room.setRoomCode(rs.getInt(5));
				room.setRoomJoinCode(rs.getString(6));
				room.setRoomAvailable(rs.getInt(7));
				room.setRoomDate(rs.getString(8));
				list.add(room);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}

	// 특정 방의 방 번호 증가
	public int getNextR(String userID) {
		String SQL = "SELECT roomCode FROM room WHERE userID = ? ORDER BY roomCode DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 다음 페이지 처리
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM room WHERE roomNumber < ? AND roomAvailable = 0";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// 페이지 처리
	public int targetPage(int pageNumber) {
		String SQL = "SELECT COUNT(roomNumber) FROM room WHERE roomNumber > ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) / 10;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0; 
	}

	// 방 번호 일치 여부 확인
	public int checkRoomNumber(String roomJoinCode) {
		String SQL = "SELECT * FROM room WHERE roomJoinCode = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, roomJoinCode);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Room room = new Room();
				room.setRoomCode(rs.getInt(1));
				int number = room.getRoomCode();
				return number;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 

	}

	// 방 진행여부 확인
	public int checkRunning(int roomCode) {
		String SQL = "SELECT roomAvailable FROM room WHERE roomNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomCode);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 2; 
	}

	// 방 참가 확인
	public int checkJoin(String roomJoinCode, String roomPassword) {
		String SQL = "SELECT roomJoinCode FROM room WHERE roomJoinCode = ? AND roomPassword = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, roomJoinCode);
			pstmt.setString(2, roomPassword);
			rs = pstmt.executeQuery();
			if (rs.next()) {

				String SQL2 = "SELECT roomJoinCode FROM room WHERE roomJoinCode = ? AND roomPassword = ? AND roomAvailable = 1";
				PreparedStatement pstmt2 = conn.prepareStatement(SQL2);
				pstmt2.setString(1, roomJoinCode);
				pstmt2.setString(2, roomPassword);
				rs = pstmt2.executeQuery();

				if (rs.next()) {
					return 1; // 활성화 된 방
				} else {
					return 0; // 비활성화 된 방
				}

			} else {
				return 3;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 2; // 오류
	}

	// 방 정보 가져오기
	public Room getRoom(int roomNumber) {
		String SQL = "SELECT * FROM room WHERE roomNumber = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roomNumber);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Room room = new Room();
				room.setRoomNumber(rs.getInt(1));
				room.setUserID(rs.getString(2));
				room.setRoomTitle(rs.getString(3));
				room.setRoomPassword(rs.getString(4));
				room.setRoomCode(rs.getInt(5));
				room.setRoomJoinCode(rs.getString(6));
				room.setRoomAvailable(rs.getInt(7));
				room.setRoomDate(rs.getString(8));
				return room;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
